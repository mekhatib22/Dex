---
description: "Prepare for meetings by gathering attendee context, related projects, and talking points"
---

# Meeting Prep

Prepare for an upcoming meeting by gathering context on attendees and related topics.

## Tone Calibration

Read `System/user-profile.yaml` → `communication` section and adapt:

**Career Level Adaptations:**
- **Junior:** Provide more context about attendees, suggest preparation tips
- **Mid:** Balance context with action, suggest talking points
- **Senior/Leadership:** Strategic framing, influence opportunities, key decisions

**Directness:**
- **Very direct:** Bullet points, key facts only
- **Balanced:** Context + talking points (default)
- **Supportive:** Detailed prep, conversation strategies

---

## Input

Ask the user for:
1. **Meeting topic or title** — What's the meeting about?
2. **Attendees** — Who's attending? (comma-separated names)

**Examples:**
- "Prep me for Q1 Planning with Sarah Chen and Mike Rodriguez"
- Just run the prompt and provide details when asked

---

## Process

### Step 1: Attendee Lookup

For each attendee:

1. Search `05-Areas/People/Internal/` and `05-Areas/People/External/` for matching names
2. If found, extract:
   - Role and company
   - Last interaction date
   - Open action items involving them
   - Key context or notes
3. If not found, note: "No person page for [Name] — consider creating one after the meeting"

### Step 2: Related Projects

Search `04-Projects/` for any projects that:
- Mention the attendees
- Relate to the meeting topic

Extract:
- Project name and status
- Relevant milestones or blockers
- Recent updates

### Step 3: Recent Context

Search `00-Inbox/Meetings/` for recent meetings with these attendees:
- What was discussed?
- What was decided?
- What follow-ups were committed?

Also search `03-Tasks/Tasks.md` for any tasks involving these attendees.

### Step 4: Compile Prep Brief

---

## Output Format

```markdown
# Meeting Prep: [Meeting Topic]

**Date:** [Today's date]
**Attendees:** [Names]

---

## People Context

### [Attendee Name]
- **Role:** [Role at Company]
- **Last Interaction:** [Date] — [Topic]
- **Open Items:**
  - [ ] [Action item]
- **Notes:** [Key context about this person]

### [Next Attendee]
...

---

## Related Projects

| Project | Status | Relevance |
|---------|--------|-----------|
| [Name]  | [Status] | [Why it relates] |

---

## Recent History

Previous meetings with these attendees:

| Date | Topic | Key Outcomes |
|------|-------|--------------|
| [Date] | [Topic] | [What was decided/discussed] |

---

## Suggested Talking Points

Based on the context above:

1. **Follow up on:** [Open item from last meeting]
2. **Discuss:** [Project-related topic]
3. **Ask about:** [Something from their context]

---

## Questions to Consider

- What's your main goal for this meeting?
- What do you need from these attendees?
- What decisions need to be made?

---

## Post-Meeting

After the meeting:
1. Add notes to `00-Inbox/Meetings/YYYY-MM-DD - [Topic].md`
2. Update person pages with new context
3. Create tasks for any action items
```

---

## When to Use

- Before any meeting with multiple attendees
- When meeting someone you haven't seen in a while
- Before important meetings where you want full context

## Tips

- Run this 15-30 minutes before the meeting
- Create person pages for new contacts after meetings
- Update context regularly for accurate prep
