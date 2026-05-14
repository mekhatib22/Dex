---
description: "Process meeting notes to update person pages, extract tasks, and organize notes"
---

# Process Meetings

Process meeting notes to update person pages, extract tasks, and organize everything. Works with meeting notes pasted directly or dropped into `00-Inbox/Meetings/`.

## How It Works

You provide meeting notes (paste them, or point to files in `00-Inbox/Meetings/`), and Dex will:
- Create/update person and company pages
- Extract action items to `03-Tasks/Tasks.md`
- Link everything together

## Usage

- Run this prompt with no arguments to process all unprocessed meeting files from the last 7 days
- Mention "today" to only process today's meetings
- Paste meeting notes directly and they'll be processed inline
- Mention "people only" to skip task extraction

---

## Process

### Step 1: Find Meeting Notes

Check `00-Inbox/Meetings/` for markdown files from the last 7 days:

```bash
find 00-Inbox/Meetings -name "*.md" -mtime -7 2>/dev/null
```

If no files found, ask the user to paste their meeting notes directly.

For each meeting file, read the content and extract:
- Participants / attendees
- Company names
- Date
- Key discussion points
- Action items

### Step 2: Update Person Pages

For each participant in the meetings:

1. **Load user profile** for email domain:
   Read `System/user-profile.yaml` → get `email_domain`

2. **Classify as Internal/External:**
   - If participant's company/domain matches user's domain → Internal
   - Otherwise → External

3. **Check if person page exists:**
   - Internal: `05-Areas/People/Internal/Firstname_Lastname.md`
   - External: `05-Areas/People/External/Firstname_Lastname.md`

4. **If page doesn't exist, create it:**

   ```markdown
   # Firstname Lastname

   ## Overview

   | Field | Value |
   |-------|-------|
   | **Company** | [company from meeting] |
   | **Role** | [if known] |
   | **First Met** | [meeting date] |

   ## Recent Interactions

   - [Meeting Title] — [date]

   ## Notes

   *Auto-created from meeting on [date]*
   ```

5. **If page exists, add meeting to Recent Interactions:**
   - Add new meeting link under "## Recent Interactions"
   - Keep max 20 entries (remove oldest if needed)

### Step 3: Update Company Pages

For each unique external company:

1. **Check if company page exists:** `05-Areas/Companies/Company_Name.md`

2. **If doesn't exist, create it:**

   ```markdown
   # Company Name

   ## Overview

   | Field | Value |
   |-------|-------|
   | **Website** | [if known] |
   | **First Contact** | [date] |

   ## Key Contacts

   - Firstname Lastname

   ## Meeting History

   - [Meeting Title] — [date]

   ## Notes

   *Auto-created from meeting on [date]*
   ```

3. **If exists, update:**
   - Add any new contacts to "Key Contacts"
   - Add meeting to "Meeting History"

### Step 4: Extract Tasks

For each meeting with action items:

1. **Find action items** — Look for:
   - Explicit checkboxes: `- [ ] task`
   - "I will...", "I need to...", "Action: ..."
   - "Follow up on...", "Send...", "Schedule..."

2. **For each task:**
   - Infer priority (P1 if "urgent" mentioned, P2 default)
   - Infer pillar from context using `System/pillars.yaml`
   - Note the source meeting and people involved

3. **Add to `03-Tasks/Tasks.md`** under the appropriate priority section

4. **Mark as extracted** in the meeting note by adding:
   ```markdown
   <!-- tasks-extracted: YYYY-MM-DDTHH:MM:SSZ -->
   ```

### Step 5: Summary Report

```
## Meeting Processing Complete ✅

**Meetings processed:** X

### Updates Made

**Person pages:**
- Created: 3 new (Alice Chen, Bob Smith, Carol Wang)
- Updated: 5 existing

**Company pages:**
- Created: 1 new (Acme Corp)
- Updated: 2 existing

**Tasks extracted:** 7 items added to 03-Tasks/Tasks.md

### Recent Meetings

| Date | Meeting | Participants |
|------|---------|--------------|
| Feb 3 | Product Review | Alice, Bob |
| Feb 2 | Strategy Call | Carol |
```

---

## Error Handling

**If no meetings found:**
> "No meeting notes found in the last 7 days. You can:
> 1. Paste meeting notes directly here
> 2. Drop markdown files into `00-Inbox/Meetings/`
> 3. Create a file manually: `00-Inbox/Meetings/YYYY-MM-DD - Meeting Topic.md`"
