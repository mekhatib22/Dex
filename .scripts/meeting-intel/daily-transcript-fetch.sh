#!/bin/bash
# Dex Meeting Transcript Processor
# Runs daily at 5pm via launchctl
# Uses Copilot CLI to pull Teams transcripts and process into Dex

set -e

VAULT_PATH="$HOME/Documents/Dex"
LOG_DIR="$VAULT_PATH/.scripts/meeting-intel"
LOG_FILE="$LOG_DIR/transcript-fetch.log"
PROCESSED_FILE="$LOG_DIR/processed-transcripts.json"
MEETINGS_DIR="$VAULT_PATH/00-Inbox/Meetings"
TODAY=$(date +%Y-%m-%d)

mkdir -p "$LOG_DIR" "$MEETINGS_DIR"

log() {
  echo "[$(date -u +%Y-%m-%dT%H:%M:%SZ)] $1" | tee -a "$LOG_FILE"
}

log "=== Daily transcript fetch started for $TODAY ==="

# Initialize processed state if needed
if [ ! -f "$PROCESSED_FILE" ]; then
  echo '{"processed":[]}' > "$PROCESSED_FILE"
fi

# Check if already processed today
if grep -q "\"$TODAY\"" "$PROCESSED_FILE" 2>/dev/null; then
  log "Already processed transcripts for $TODAY. Skipping."
  exit 0
fi

# Use Copilot CLI in non-interactive mode to process transcripts
# This sends the prompt and captures the output
PROMPT="I need you to process today's Teams meeting transcripts into Dex.

1. First, use the m365-copilot-copilot_chat tool to ask: 'List all of Mark Elkhatib's Teams meetings from $TODAY that have transcripts. For each, provide: meeting title, time, attendees, and a detailed transcript summary with key points, decisions, and action items.'

2. For each transcribed meeting found:
   a. Create a meeting note in 00-Inbox/Meetings/ using format: '$TODAY - Meeting Title.md'
   b. Include: Overview table, Key Discussion Points, Action Items (For Me + For Others), Decisions Made
   c. Add wiki-links to person pages: [[Internal/Firstname_Lastname|Name]]
   d. Link to related projects in 04-Projects/
   e. Update person pages in 05-Areas/People/Internal/ with the meeting reference
   f. Extract action items to 03-Tasks/Tasks.md

3. After processing, confirm how many meetings were processed.

Process all meetings now."

# Save the prompt for next Copilot session to pick up
cat > "$LOG_DIR/pending-process.json" << EOF
{
  "date": "$TODAY",
  "status": "pending",
  "prompt": "Process today's Teams transcripts into Dex meeting notes",
  "created": "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
}
EOF

log "Pending transcript process saved for $TODAY"

# Try to run copilot non-interactively if available
if command -v copilot &>/dev/null; then
  log "Copilot CLI found. Attempting transcript processing..."
  cd "$VAULT_PATH"
  echo "$PROMPT" | timeout 300 copilot --no-interactive 2>>"$LOG_FILE" || {
    log "Copilot non-interactive mode not available. Will process on next session."
  }
fi

# Mark today as attempted
python3 -c "
import json
with open('$PROCESSED_FILE') as f:
    state = json.load(f)
state['processed'].append('$TODAY')
state['last_run'] = '$TODAY'
with open('$PROCESSED_FILE', 'w') as f:
    json.dump(state, f, indent=2)
" 2>/dev/null

log "=== Daily transcript fetch complete for $TODAY ==="
