#!/bin/bash
# Dex Daily Intel Sweep
# Pulls Slack DMs + GitHub activity into structured intel files
# Runs daily at 5:15pm via launchctl (after transcript fetch at 5:00pm)

set -e

VAULT_PATH="$HOME/Documents/Dex"
INTEL_DIR="$VAULT_PATH/00-Inbox/Ideas"
LOG_FILE="$VAULT_PATH/.scripts/meeting-intel/intel-sweep.log"
TODAY=$(date +%Y-%m-%d)
YESTERDAY=$(date -v-1d +%Y-%m-%d)
INTEL_FILE="$INTEL_DIR/${TODAY} - Daily Intel.md"

mkdir -p "$INTEL_DIR"

log() {
  echo "[$(date -u +%Y-%m-%dT%H:%M:%SZ)] $1" | tee -a "$LOG_FILE"
}

log "=== Daily intel sweep started for $TODAY ==="

# Skip if already run today
if [ -f "$INTEL_FILE" ]; then
  log "Intel file already exists for $TODAY. Skipping."
  exit 0
fi

# ---- CALENDAR + EMAIL via WorkIQ ----
log "Fetching calendar and email via WorkIQ..."

# Save WorkIQ prompts for Copilot CLI to process
WORKIQ_DIR="$VAULT_PATH/.scripts/meeting-intel/workiq-pending"
mkdir -p "$WORKIQ_DIR"

cat > "$WORKIQ_DIR/calendar-$TODAY.json" << WEOF
{
  "type": "calendar",
  "date": "$TODAY",
  "prompt": "What meetings does Mark Elkhatib have tomorrow? For each: time, title, attendees, whether it has a Teams link. Also list any meetings added in the last 24 hours.",
  "status": "pending"
}
WEOF

cat > "$WORKIQ_DIR/email-$TODAY.json" << WEOF
{
  "type": "email",
  "date": "$TODAY",
  "prompt": "Show Mark Elkhatib's email highlights: 1) Emails from the last 24h needing reply (not automated). 2) Emails Mark sent with no reply in 48+ hours. 3) Emails from people Mark has meetings with tomorrow. For each: sender, subject, one-line summary.",
  "status": "pending"
}
WEOF

log "WorkIQ calendar/email prompts saved for processing."

# ---- SESSION STORE DIGEST ----
log "Generating session digest..."

SESSION_DIGEST="$INTEL_DIR/${TODAY} - Session Digest.md"
if [ ! -f "$SESSION_DIGEST" ]; then
  # Query the session store for today's completed sessions
  python3 << 'PYDIGEST'
import sqlite3, os, json
from datetime import datetime, timedelta

db_path = os.path.expanduser("~/.copilot/session-store.db")
if not os.path.exists(db_path):
    print("Session store not found")
    exit(0)

conn = sqlite3.connect(db_path)
conn.row_factory = sqlite3.Row
today = datetime.now().strftime("%Y-%m-%d")
yesterday = (datetime.now() - timedelta(days=1)).strftime("%Y-%m-%d")

# Get recent sessions
sessions = conn.execute("""
    SELECT s.id, s.summary, s.created_at, s.cwd,
           COUNT(DISTINCT sf.file_path) as files_touched
    FROM sessions s
    LEFT JOIN session_files sf ON sf.session_id = s.id
    WHERE s.created_at >= ?
    GROUP BY s.id
    ORDER BY s.created_at DESC
""", (yesterday + "T00:00:00Z",)).fetchall()

if not sessions:
    exit(0)

vault = os.path.expanduser("~/Documents/Dex")
out_path = os.path.join(vault, "00-Inbox", "Ideas", f"{today} - Session Digest.md")

lines = [f"# Session Digest — {today}\n"]
lines.append(f"\n## Sessions Analyzed: {len(sessions)}\n")
lines.append("\n### Work Summary\n")

for s in sessions:
    summary = (s['summary'] or 'No summary')[:120]
    files = s['files_touched']
    ts = s['created_at'][:16].replace('T', ' ')
    file_note = f" ({files} files)" if files > 0 else ""
    lines.append(f"- **{ts}** — {summary}{file_note}\n")

    # Get files touched
    if files > 0:
        file_rows = conn.execute(
            "SELECT file_path, tool_name FROM session_files WHERE session_id = ?",
            (s['id'],)
        ).fetchall()
        for f in file_rows[:5]:
            lines.append(f"  - `{os.path.basename(f['file_path'])}` ({f['tool_name']})\n")

    # Get refs (commits, PRs)
    refs = conn.execute(
        "SELECT ref_type, ref_value FROM session_refs WHERE session_id = ?",
        (s['id'],)
    ).fetchall()
    for r in refs:
        lines.append(f"  - {r['ref_type']}: {r['ref_value']}\n")

lines.append("\n---\n")

# Find validated queries in recent sessions
try:
    validated = conn.execute("""
        SELECT DISTINCT si.session_id, si.content
        FROM search_index si
        JOIN sessions s ON si.session_id = s.id
        WHERE si.search_index MATCH '"good to go" OR "looks good" OR perfect OR validated'
        AND si.source_type = 'turn'
        AND s.created_at >= ?
        LIMIT 10
    """, (yesterday + "T00:00:00Z",)).fetchall()
    if validated:
        lines.append("\n### Validated Queries Detected\n\n")
        lines.append("*Run the **query-harvester** prompt to promote these to your data-query skill.*\n\n")
        for v in validated:
            snippet = v['content'][:150].replace('\n', ' ')
            lines.append(f"- Session `{v['session_id'][:8]}...` — {snippet}\n")
        lines.append("\n")
except:
    pass

lines.append(f"\n*Auto-generated from {len(sessions)} sessions on {today}*\n")

with open(out_path, 'w') as f:
    f.writelines(lines)

print(f"Session digest: {len(sessions)} sessions → {out_path}")
PYDIGEST
  log "Session digest complete."
fi

# ---- GITHUB ACTIVITY ----
log "Fetching GitHub activity..."

GH_PRS=$(gh pr list --author @me --state all --json title,url,state,createdAt,mergedAt -L 10 2>/dev/null || echo "[]")
GH_ISSUES=$(gh api graphql -f query='{ viewer { issueComments(last: 10) { nodes { issue { title url repository { nameWithOwner } } createdAt } } } }' 2>/dev/null || echo "{}")
GH_REVIEWS=$(gh api "/user/repos?sort=pushed&per_page=5" --jq '.[].full_name' 2>/dev/null || echo "")

# Format GitHub section
GH_SECTION=""
PR_COUNT=$(echo "$GH_PRS" | python3 -c "import json,sys; d=json.load(sys.stdin); print(len([p for p in d if p.get('createdAt','')[:10]=='$TODAY' or (p.get('mergedAt') and p['mergedAt'][:10]=='$TODAY')]))" 2>/dev/null || echo "0")

if [ "$PR_COUNT" -gt 0 ]; then
  GH_SECTION=$(echo "$GH_PRS" | python3 -c "
import json,sys
prs=json.load(sys.stdin)
today='$TODAY'
for p in prs:
    created = p.get('createdAt','')[:10]
    merged = (p.get('mergedAt') or '')[:10]
    if created == today or merged == today:
        state = '✅ merged' if p.get('state')=='MERGED' else p.get('state','open')
        print(f'- [{p[\"title\"]}]({p[\"url\"]}) — {state}')
" 2>/dev/null)
fi

ISSUE_SECTION=$(echo "$GH_ISSUES" | python3 -c "
import json,sys
try:
    d=json.load(sys.stdin)
    nodes=d.get('data',{}).get('viewer',{}).get('issueComments',{}).get('nodes',[])
    today='$TODAY'
    for n in nodes:
        if n.get('createdAt','')[:10]==today:
            issue=n.get('issue',{})
            repo=issue.get('repository',{}).get('nameWithOwner','')
            print(f'- [{issue.get(\"title\",\"\")}]({issue.get(\"url\",\"\")}) ({repo})')
except: pass
" 2>/dev/null)

REPOS_ACTIVE=$(echo "$GH_REVIEWS" | head -5 | while read repo; do
  [ -n "$repo" ] && echo "- $repo"
done)

# ---- SLACK (placeholder — needs channel links) ----
log "Slack: checking for gh-slackdump..."
SLACK_SECTION=""
if command -v gh &>/dev/null && gh extension list 2>/dev/null | grep -q slackdump; then
  SLACK_SECTION="*Slack monitoring configured. Add channel links to .scripts/meeting-intel/slack-channels.txt to enable.*"
  
  # If channel list exists, dump them
  CHANNELS_FILE="$VAULT_PATH/.scripts/meeting-intel/slack-channels.txt"
  if [ -f "$CHANNELS_FILE" ]; then
    log "Processing Slack channels..."
    while IFS= read -r channel_url; do
      [ -z "$channel_url" ] && continue
      [[ "$channel_url" == \#* ]] && continue
      DUMP_FILE="/tmp/slack-dump-$(date +%s).json"
      gh slackdump -u --from "$YESTERDAY" -o "$DUMP_FILE" "$channel_url" 2>/dev/null || continue
      if [ -f "$DUMP_FILE" ] && [ -s "$DUMP_FILE" ]; then
        SLACK_SECTION="$SLACK_SECTION\n$(python3 -c "
import json
with open('$DUMP_FILE') as f:
    data = json.load(f)
msgs = data if isinstance(data, list) else data.get('messages',[])
for m in msgs[-10:]:
    user = m.get('user_profile',{}).get('real_name', m.get('user','?'))
    text = m.get('text','')[:200]
    print(f'- **{user}**: {text}')
" 2>/dev/null)"
        rm -f "$DUMP_FILE"
      fi
    done < "$CHANNELS_FILE"
  fi
else
  SLACK_SECTION="*gh-slackdump not installed. Run: gh extension install wham/gh-slackdump*"
fi

# ---- BUILD INTEL FILE ----
log "Writing intel file..."

cat > "$INTEL_FILE" << MARKDOWN
# Daily Intel — $TODAY

## 📅 Calendar & Email

*Run the **calendar-email** prompt in Copilot CLI for a full interactive brief, or check WorkIQ pending files in .scripts/meeting-intel/workiq-pending/*

---

## GitHub Activity

### PRs (Today)
${GH_SECTION:-"No PR activity today."}

### Issues Engaged
${ISSUE_SECTION:-"No issue comments today."}

### Active Repos
${REPOS_ACTIVE:-"No recent pushes."}

---

## Slack Highlights

${SLACK_SECTION}

---

## Action Items Surfaced

*Review this section and move items to 03-Tasks/Tasks.md*

- [ ] _(add items from above)_

---

*Auto-generated daily intel sweep on $TODAY*
MARKDOWN

log "Intel file written: $INTEL_FILE"
log "=== Daily intel sweep complete ==="
