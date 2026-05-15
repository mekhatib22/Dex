---
description: "Analyze recent Copilot CLI sessions and transfer outcomes, decisions, and work items to Dex"
---

# Session Digest

Analyze recent Copilot CLI sessions from the session store and surface completed work, decisions, and open items into Dex.

## Process

### Step 1: Query Recent Sessions

Use the SQL tool with `database: "session_store"` to find recent sessions:

```sql
-- Last 24h sessions with details
SELECT s.id, s.cwd, s.summary, s.created_at,
       COUNT(DISTINCT sf.file_path) as files_touched
FROM sessions s
LEFT JOIN session_files sf ON sf.session_id = s.id
WHERE s.created_at >= date('now', '-1 days')
GROUP BY s.id
ORDER BY s.created_at DESC;
```

For each session with substance (files_touched > 0 or meaningful summary):

```sql
-- Get the conversation
SELECT turn_index, substr(user_message, 1, 500) as ask,
       substr(assistant_response, 1, 500) as response
FROM turns WHERE session_id = '<session_id>'
ORDER BY turn_index;

-- Get files changed
SELECT file_path, tool_name FROM session_files
WHERE session_id = '<session_id>';

-- Get any commits/PRs
SELECT ref_type, ref_value FROM session_refs
WHERE session_id = '<session_id>';
```

### Step 2: Categorize Sessions

Group sessions by type:
- **Data queries** — KQL/Trino queries, analysis work → link to Analytics pillar
- **Document creation** — Reports, presentations → link to Story Telling pillar
- **Code/tooling** — Scripts, agents, automations → link to relevant project
- **Research** — Exploration, brainstorming → capture insights
- **Administrative** — Setup, config → note what changed

### Step 3: Extract Outcomes

For each session, determine:
- **What was completed?** — Files created, queries run, PRs opened
- **What decisions were made?** — Key conclusions from analysis
- **What's still open?** — Unfinished work, next steps mentioned
- **What insights emerged?** — Data findings, patterns discovered

### Step 4: Update Dex

#### Tasks
- Completed work → Mark matching tasks done in `03-Tasks/Tasks.md`
- Open items → Add new tasks with context
- Blocked items → Flag in tasks

#### Projects
- Update relevant project pages in `04-Projects/` with progress
- Add session references for traceability

#### Career Evidence
- Significant deliverables → Add to `05-Areas/Career/Evidence/`

#### Daily Intel
Create or update `00-Inbox/Ideas/YYYY-MM-DD - Session Digest.md`:

```markdown
# Session Digest — YYYY-MM-DD

## Sessions Analyzed: X

### Completed Work
- [Session: "title"] — [What was done] → [files/PRs]
- [Session: "title"] — [What was done]

### Key Decisions
- [Decision from session] — context

### Open Items
- [ ] [Unfinished work from session] ^task-YYYYMMDD-XXX
- [ ] [Next step mentioned]

### Insights
- [Data finding or pattern]
- [Discovery worth remembering]

### Projects Advanced
| Project | Session | Progress |
|---------|---------|----------|
| [Project] | [session title] | [what moved] |

---
*Auto-generated from X Copilot CLI sessions on YYYY-MM-DD*
```

### Step 5: Full-Text Search for Themes

Use FTS5 to find cross-session patterns:

```sql
-- Find sessions about specific topics
SELECT content, session_id, source_type
FROM search_index
WHERE search_index MATCH 'copilot OR maturity OR release OR impact'
ORDER BY rank LIMIT 20;
```

Surface recurring themes that span multiple sessions.

## Arguments

- No arguments: Last 24 hours
- `--week`: Last 7 days (good for weekly review)
- `--project "name"`: Only sessions related to a specific project
- `--all`: Full historical analysis (use sparingly — 328+ sessions)
