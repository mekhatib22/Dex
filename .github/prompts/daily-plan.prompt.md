---
description: "Generate context-aware daily plan with calendar, tasks, priorities, and meeting intelligence"
---

# Daily Plan

Generate your daily plan with full context awareness. Gathers information from your calendar, tasks, meetings, relationships, and weekly progress to create a focused plan with genuine situational awareness.

## Usage

- Run this prompt to create today's daily plan
- For tomorrow's plan, mention "plan for tomorrow" when invoking

---

## Tone Calibration

Read `System/user-profile.yaml` → `communication` section and adapt tone accordingly.

---

## Step 1: Monday Weekly Planning Gate

If today is Monday, check if `02-Week_Priorities/Week_Priorities.md` exists and is current. If the week isn't planned, offer to run the **week-plan** prompt first.

---

## Step 2: Yesterday's Review Check

Check for yesterday's review in `07-Archives/Reviews/Daily_Review_YYYY-MM-DD.md`. If it exists, extract:
- Open loops and carryover items
- Tomorrow's suggested focus (from yesterday's review)
- Blocked items

---

## Step 3: Context Gathering

Gather context from all available sources.

### 3.1 Midweek Progress Check

Read `02-Week_Priorities/Week_Priorities.md` and determine:
- Day of week and days remaining
- Weekly priority status (complete / in_progress / not_started)
- Warnings for priorities with no activity

**Surface this prominently:**

> "It's **Wednesday**. Here's where you are on this week's priorities:
>
> 1. ✅ **Ship pricing page** — Complete (finished Monday)
> 2. 🔄 **Review proposal** — In progress (2 of 5 tasks done)
> 3. ⚠️ **Customer interviews** — Not started (no activity yet)
>
> You have 2 days left this week. Priority 3 needs attention."

### 3.2 Calendar + Email (via WorkIQ)

Use m365-copilot-copilot_chat to pull today's calendar and email:

**Calendar query:**
> "What meetings does Mark Elkhatib have today? For each: time, title, attendees. Also flag any meetings added in the last 24 hours."

**Email query:**
> "Show emails from the last 24h that Mark Elkhatib needs to reply to (not automated/newsletters). Also show any emails from people Mark has meetings with today. For each: sender, subject, one-line summary."

Analyze the calendar:
- **Day type**: stacked / moderate / open
- **Meeting count and hours**
- **Free blocks available**
- **Recommendation**: What kind of work fits today

Surface email actions:
- Emails needing reply (link to person pages)
- Meeting-related email threads (add to meeting prep)

### 3.3 Meeting Intelligence

For each meeting today, search for context:

1. Look up attendees in `05-Areas/People/` folder
2. Search `04-Projects/` for related projects
3. Check `00-Inbox/Meetings/` for previous meetings with these people
4. Note outstanding tasks or commitments with attendees from `03-Tasks/Tasks.md`

**Surface with useful context:**

> "📍 **Meeting: Acme Quarterly Review** (2pm with Sarah Chen, Mike Ross)
>
> **Related project:** Acme Implementation (Phase 2)
> - Status: On track, but pricing section still in draft
> - Outstanding: You owe Sarah the pricing proposal
>
> **Prep suggestion:** Review proposal draft, prepare pricing options."

### 3.4 Task Review

Read `03-Tasks/Tasks.md` and surface:
- P0 and P1 tasks
- Tasks started but not completed
- Overdue tasks

### 3.5 Standard Context

Also gather:
- **Week Priorities**: This week's Top 3 from `02-Week_Priorities/Week_Priorities.md`
- **Quarterly Goals**: From `01-Quarter_Goals/Quarter_Goals.md`
- **Pillars**: From `System/pillars.yaml`

---

## Step 4: Synthesis

Combine all gathered context into actionable recommendations:

### Focus Recommendation

Generate 3 recommended focus items based on:
- P0 tasks (highest weight)
- Weekly priority alignment (especially lagging priorities!)
- Meeting prep needs
- Commitments due

**Actively recommend, not just list:**

> "Based on your week progress and today's shape, I recommend focusing on:
>
> 1. **Prep for Acme meeting** — Priority 2 is lagging and this meeting is critical
> 2. **Reply to Mike** — Commitment due today
> 3. **Task X from Priority 1** — Keeps momentum on your shipped priority"

### Heads Up

Flag potential issues:
- Weekly priorities with no activity (midweek warning)
- Commitments due today
- Back-to-back meetings
- P0 items with no time blocked

---

## Step 5: Generate Daily Plan

Create `07-Archives/Plans/YYYY-MM-DD.md`:

```markdown
---
date: YYYY-MM-DD
type: daily-plan
---

# Daily Plan — {{Day}}, {{Month}} {{DD}}

## TL;DR
- {{1-2 sentence summary including week progress}}
- {{X}} meetings today, day is {{stacked/moderate/open}}
- {{Key focus area based on week priorities}}

---

## 📊 Week Progress (Midweek Check)

**Day {{X}} of 5** — {{days_remaining}} days left this week

| Priority | Status | Notes |
|----------|--------|-------|
| {{Priority 1}} | ✅ Complete | Finished {{day}} |
| {{Priority 2}} | 🔄 In progress | {{X}} of {{Y}} tasks done |
| {{Priority 3}} | ⚠️ Not started | Needs attention |

**This week's focus:** {{Recommendation based on lagging priorities}}

---

## 📅 Today's Shape

**Day type:** {{stacked/moderate/open}} ({{X}} meetings, {{Y}} hours)

**Free blocks:**
- {{Time range}}: {{Size}} — {{Recommended use}}

**Best for:** {{Quick tasks only / Medium tasks / Deep work opportunity}}

---

## 🎯 Today's Focus

**If I only do three things today:**

1. [ ] {{Focus item 1}} — {{Pillar}} *(supports Week Priority #X)*
2. [ ] {{Focus item 2}} — {{Pillar}} *(supports Week Priority #Y)*
3. [ ] {{Focus item 3}} — {{Pillar}}

---

## 📍 Meetings (with Context)

### {{Time}} — {{Meeting Title}}

**Attendees:** {{Names}}
**Related project:** {{Project name}} ({{status}})
**Outstanding with them:**
- {{Task/commitment}}

**Prep needed:** {{What to review/prepare}}

---

## 📋 Tasks

| Task | Priority | Suggested Slot |
|------|----------|----------------|
| {{Task}} | P0 | {{Day/time}} |
| {{Task}} | P1 | {{Day/time}} |
| {{Task}} | P2 | Between meetings |

---

## ⚠️ Heads Up

- {{Warning about lagging weekly priority}}
- {{Commitment due today}}
- {{Back-to-back meetings}}

---

*Generated: {{timestamp}}*
*Week progress: {{X}}/{{Y}} priorities on track*
```

---

## Graceful Degradation

The plan works at multiple levels:

### Full Context (Calendar + Tasks available)
- Complete week progress, meeting intelligence, scheduling suggestions

### Partial Context (Tasks only)
- Week progress and task prioritization
- Ask user about meetings

### Minimal Context (Fresh vault)
- Interactive flow asking about priorities
- Basic daily note
