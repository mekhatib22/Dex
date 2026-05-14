---
description: "Pull today's Teams meeting transcripts via WorkIQ and process into Dex notes"
---

# Process Teams Transcripts

Pull meeting transcripts from Microsoft Teams and process them into Dex meeting notes, person page updates, and task extraction.

## Process

### Step 1: Fetch Today's Transcribed Meetings

Use the m365-copilot-copilot_chat tool to query:

> "List all of Mark Elkhatib's Teams meetings from today that have transcripts available. For each transcribed meeting, provide: meeting title, start/end time, attendees (names), and a detailed summary of the transcript including key discussion points, decisions made, action items for Mark, and action items for others."

### Step 2: Check for Duplicates

For each meeting found, check if a note already exists in `00-Inbox/Meetings/` with a matching date and title. Skip any already-processed meetings.

### Step 3: Create Meeting Notes

For each new transcribed meeting, create `00-Inbox/Meetings/YYYY-MM-DD - Meeting Title.md`:

```markdown
# YYYY-MM-DD - Meeting Title

## Overview

| Field | Value |
|-------|-------|
| **Date** | YYYY-MM-DD |
| **Time** | Start – End |
| **Attendees** | [[Internal/Name|Name]], ... |
| **Source** | Teams transcript (auto-processed) |
| **Related Project** | [[Project_Name]] |

---

## Key Discussion Points

### 1. [Topic]
- [Details from transcript]

---

## Action Items

### For Me
- [ ] [Action] ^task-YYYYMMDD-XXX

### For Others
- [ ] [Person] — [Action]

### Decisions Made
- [Decision]

---

*Processed from Teams transcript on YYYY-MM-DD*
```

### Step 4: Update Person Pages

For each attendee, update their person page in `05-Areas/People/Internal/`:
- Add the meeting to their "Recent Interactions" section
- Include a brief note about what was discussed

### Step 5: Extract Tasks

Add action items to `03-Tasks/Tasks.md` under the appropriate priority level:
- Urgent/time-sensitive → P0
- Important follow-ups → P1
- Nice-to-have → P2

### Step 6: Summary

Report:
- How many meetings were processed
- How many person pages updated
- How many tasks extracted

## Arguments

- No arguments: Process today's transcripts
- `yesterday`: Process yesterday's meetings
- `YYYY-MM-DD`: Process a specific date
