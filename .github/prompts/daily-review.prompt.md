---
description: "End of day review with plan completion tracking, meeting follow-ups, and learning capture"
---

# Daily Review

Conduct an end-of-day review to capture progress, track what you accomplished vs. planned, surface meeting follow-ups, and set up tomorrow.

## Tone Calibration

Read `System/user-profile.yaml` → `communication` section and adapt accordingly.

---

## Step 1: File Discovery

Find files modified today:

```bash
TODAY=$(date +%Y-%m-%d)
find . -type f -name "*.md" -newermt "$TODAY 00:00:00" ! -newermt "$TODAY 23:59:59" 2>/dev/null
```

**Critical rules:**
1. No truncation — list all modified files
2. Today only — use date-based filtering
3. Verify with user — "These are the files I found. What did you actually work on?"

---

## Step 2: Gather Context

### From Tasks
Read `03-Tasks/Tasks.md`:
- Tasks completed today (look for `✅ YYYY-MM-DD` matching today)
- Tasks started but not finished

### From Weekly Priorities
Read `02-Week_Priorities/Week_Priorities.md`:
- This week's strategic focus
- How today's work connects to weekly priorities

### From Recent Meetings
Check `00-Inbox/Meetings/` for meeting notes from today.

---

## Step 3: Daily Plan Completion Tracking

**Compare what you planned vs. what you did.**

### 3.1 Find Today's Plan

Look for `07-Archives/Plans/YYYY-MM-DD.md` (today's date).

### 3.2 Extract Planned Focus

From the "Today's Focus" section, extract the 3 items you planned to focus on.

### 3.3 Track Completion

For each planned focus item:
- Check if it was completed (look in Tasks.md for completion timestamps)
- Check if it was started but not finished
- Check if it was blocked or deferred

**Surface this:**

> "📊 **Daily Plan Completion:**
>
> You planned 3 focus items this morning:
>
> 1. ✅ **Prep for Acme meeting** — Complete
> 2. 🔄 **Write pricing proposal** — In progress (about 60% done)
> 3. ❌ **Reply to Mike** — Didn't get to it
>
> **Completion rate today:** 1 of 3 (33%)
>
> What happened with #3? Should it carry to tomorrow?"

---

## Step 4: Meeting Follow-Up Surfacing

For each meeting today, prompt:

> "📍 **You met with Sarah Chen today** (Acme Quarterly Review)
>
> **Any follow-ups to capture?**
> - Action items you committed to?
> - Things they owe you?
> - Decisions that need documentation?
>
> (Type your follow-ups or 'none')"

For any follow-ups mentioned:
- Add to `03-Tasks/Tasks.md` with appropriate priority
- Update the relevant person page in `05-Areas/People/`
- Add due date if mentioned

---

## Step 5: Progress Assessment

With user-verified information:
- What was accomplished?
- What progress was made against weekly priorities?
- What got stuck or blocked?
- What unexpected things came up?

---

## Step 6: Week Progress Check

Read `02-Week_Priorities/Week_Priorities.md` and show how today's work moved weekly priorities:

> "**Week Progress Update:**
>
> After today, you're at:
> - Priority 1: ✅ Complete (finished today!)
> - Priority 2: 🔄 60% (moved from 40%)
> - Priority 3: ⚠️ Still not started
>
> You have 2 days left. Tomorrow should focus on Priority 3."

---

## Step 7: Auto-Extract Session Learnings

Scan today's conversation for learnings:

1. **Mistakes or corrections** — Did something not work as expected?
2. **Preferences mentioned** — Did you express how you like to work?
3. **Documentation gaps** — Were there questions about how the system works?
4. **Workflow inefficiencies** — Did any task take longer than it should?

Write to `System/Session_Learnings/YYYY-MM-DD.md`.

Then ask: "I captured [N] learnings from today's session. Anything else you'd like to add?"

---

## Step 8: Categorize Learnings (If Applicable)

Check if any learnings should be elevated to pattern files:
- **Recurring mistakes** → `06-Resources/Learnings/Mistake_Patterns.md`
- **Workflow preferences** → `06-Resources/Learnings/Working_Preferences.md`

Get user confirmation before adding.

---

## Step 9: Tomorrow's Setup

Based on:
- Incomplete items from today
- Weekly priorities (especially lagging ones)
- Tomorrow's known meetings
- Commitments due tomorrow

Suggest 3 focus items for tomorrow:

> "**Suggested focus for tomorrow (Thursday):**
>
> 1. **Priority 3** — It's been untouched all week and you have 2 days left
> 2. **Finish pricing proposal** — 40% left, should be quick to complete
> 3. **Reply to Mike** — Carried from today
>
> Does this feel right?"

---

## Step 10: Generate Review

Create `07-Archives/Reviews/Daily_Review_YYYY-MM-DD.md`:

```markdown
---
date: YYYY-MM-DD
type: daily-review
plan_completion_rate: X%
---

# Daily Review — [Day], [Month] [DD], [YYYY]

## 📊 Plan vs. Reality

**Planned focus:**
1. [x] [Planned item 1] — ✅ Complete
2. [ ] [Planned item 2] — 🔄 In progress (X%)
3. [ ] [Planned item 3] — ❌ Didn't start

**Completion rate:** X of 3 (X%)

**What happened:** [Brief explanation of deviations]

---

## ✅ Accomplished

- ✓ [Completed item 1]
- ✓ [Completed item 2]

---

## 🔄 Progress Made

| Area | Movement |
|------|----------|
| [Priority 1] | [What moved forward] |
| [Priority 2] | [What moved forward] |

---

## 📊 Weekly Priorities Progress

After today:
- **Priority 1:** [Status/progress] — [emoji]
- **Priority 2:** [Status/progress] — [emoji]
- **Priority 3:** [Status/progress] — [emoji]

**Days remaining this week:** [X]

---

## 📍 Meeting Follow-Ups

### From [Meeting Name]
- [ ] [Follow-up action] — due [date]

---

## 💡 Insights

- [Key realization or connection]
- [Important learning]

---

## 🚫 Blocked/Stuck

| Item | Blocker | Status |
|------|---------|--------|
| [Item] | [What's blocking] | [Status] |

---

## 📅 Tomorrow's Focus

Based on weekly priorities and today's carryover:

1. [Priority 1 — tied to weekly focus]
2. [Priority 2]
3. [Priority 3]

---

## 🔄 Open Loops

- [ ] [Thing to remember]
- [ ] [Person to follow up with]
- [ ] **Awaiting:** [What you're waiting on from others]

---

*Generated: [timestamp]*
*Daily completion rate: X%*
*Week progress: X/3 priorities on track*
```
