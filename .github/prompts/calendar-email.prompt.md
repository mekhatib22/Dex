---
description: "Pull today's calendar and email highlights via WorkIQ into Dex context"
---

# Calendar & Email Brief

Pull your calendar and email highlights to surface meetings, prep needs, and emails requiring action.

## Process

### Step 1: Today's Calendar

Use m365-copilot-copilot_chat to query:

> "What meetings does Mark Elkhatib have today? For each meeting list: time, title, attendees, and whether it has a Teams link. Also flag any meetings that were just added in the last 24 hours."

For each meeting:
1. Check if attendees have person pages in `05-Areas/People/`
2. Flag meetings with people Mark hasn't met before (no person page)
3. Note back-to-back meetings and gaps

Display as:

> **📅 Today's Calendar**
>
> | Time | Meeting | Attendees | Prep? |
> |------|---------|-----------|-------|
> | 9:00 | Release Tracker | [[David_Jarzebowski\|David J]] | Review release data |
> | 11:30 | Cory/Mudda Sync | [[Cory_Thayer\|Cory]], [[Mudda_Qureshi\|Mudda]] | Status update |
>
> **Free blocks:** 1:00–3:00 PM (2h deep work)
> **New meetings:** [any added in last 24h]

### Step 2: Email Intelligence

Use m365-copilot-copilot_chat to query:

> "Show Mark Elkhatib's email highlights for today: 1) Emails received in the last 24 hours that need a reply (not automated/newsletter). 2) Emails Mark sent that haven't gotten a reply in 48+ hours. 3) Any emails from people Mark has meetings with today. For each, show: sender/recipient, subject, and a one-line summary."

Process results:

#### Emails Needing Reply
For each:
- Check if sender has a person page → link it
- Flag if related to a project in `04-Projects/`
- If urgent, suggest adding to `03-Tasks/Tasks.md`

#### Awaiting Reply (sent >48h ago)
- Surface as potential follow-up tasks
- Link to person pages

#### Meeting-Related Emails
- Add context to today's meeting prep

Display as:

> **📧 Email Brief**
>
> **Need to reply (3):**
> - From [[Tala_Karadsheh|Tala]] — "FY27 Dashboard Review" — Asking for your input on metrics
> - From Dan Yanes — "Weekly Report Data" — Shared report, needs confirmation
> - From external@company.com — "Partnership Follow-up" — Scheduling request
>
> **Awaiting reply (1):**
> - To [[Fintan_Ryan|Fintan]] — "Cohort Analysis Methodology" — Sent Mon, no reply
>
> **Related to today's meetings:**
> - Thread with [[David_Jarzebowski|David J]] about release tracker data (meeting at 9:00)

### Step 3: Synthesize

Combine calendar + email into actionable guidance:

> **⚡ Quick actions before your first meeting:**
> 1. Reply to Tala's email about FY27 metrics (5 min)
> 2. Review release data before 9:00 David meeting
> 3. Follow up with Fintan — no reply since Monday

### Step 4: Update Dex

1. Add reply-needed emails as P1 tasks in `03-Tasks/Tasks.md` if user confirms
2. Update person pages with email context (if significant)
3. Create meeting prep notes for any meetings flagged as needing prep

## Arguments

- No arguments: Today's calendar + last 24h email
- `tomorrow`: Tomorrow's calendar + prep suggestions
- `--email-only`: Skip calendar, just email brief
- `--calendar-only`: Skip email, just calendar
