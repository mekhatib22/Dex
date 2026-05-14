---
description: "Set weekly priorities with intelligent suggestions based on goals, calendar shape, and task effort"
---

# Week Plan

Set priorities and plan the week ahead with **intelligent priority suggestions** based on quarterly goals, calendar capacity, and task effort classification.

## Usage

- Run this prompt to plan the current week (or next week if run on Friday/weekend)
- Mention "next week" to explicitly plan next week
- Mention "current week" to force planning the current week

---

## When to Use

**Best times:**
- **Monday morning** — Before diving into daily work
- **Friday evening** — Set up next week while context is fresh
- **Sunday evening** — Weekend planning session

---

## Step 1: Determine Target Week

Calculate target week (current or next) based on day of week. If it's Friday–Sunday and user didn't specify, default to next week.

---

## Step 2: Context Gathering

### 2.1 Last Week's Review

Check for `00-Inbox/Weekly_Synthesis_[last-monday].md`:
- "Next Week" section → Suggested priorities
- "Carried Over" section → Unfinished tasks
- "Blocked Items" → Things that need resolution
- "Learnings" → Insights to apply

### 2.2 Quarterly Goals Status

Read `01-Quarter_Goals/Quarter_Goals.md`:

For each goal, assess:
- Current progress (concrete: "2 of 5 milestones complete")
- Weeks since last activity
- Stall warnings

**Identify goals needing attention:**
- Goals with no linked priorities (orphaned)
- Goals with no activity in 2+ weeks (stalled)
- Goals behind expected pace

### 2.3 Open Tasks and Projects

Read `03-Tasks/Tasks.md` and classify:
- Group by pillar alignment
- Identify P0/P1 items
- Find tasks that could advance stalled goals

### 2.4 Calendar Shape Analysis

Ask the user about their week's schedule, or read calendar files if available:

> "What does your week look like meeting-wise? (Paste your calendar or describe the shape)"

If provided, analyze:

| Day | Type | Largest Block | Best For |
|-----|------|---------------|----------|
| Mon | Stacked (7 meetings) | 45 min | Quick tasks only |
| Tue | Moderate (4 meetings) | 90 min | Medium tasks |
| Wed | **Open** (2 meetings) | **3 hours** | **Deep work day** ✨ |
| Thu | Stacked (6 meetings) | 30 min | Quick tasks only |
| Fri | Moderate (3 meetings) | 2 hours | Medium tasks |

### 2.5 Commitments and Follow-ups

Search `03-Tasks/Tasks.md` and recent meeting notes for commitments due this week.

---

## Step 3: Intelligent Priority Suggestions

**Don't just ask "What are your Top 3?" — Suggest priorities based on analysis.**

### 3.1 Generate Suggestions

Based on the gathered context, generate 4-5 suggested priorities:

**Goal-driven suggestions:**
- "Goal X has no activity in 3 weeks. Suggested priority: {{specific work that advances it}}"

**Commitment-driven suggestions:**
- "You committed to {{X}} with {{person}} — due this week"

**Carried-over suggestions:**
- "{{Priority}} carried over from last week — still important?"

**Calendar-aware suggestions:**
- "You have a deep work day Wednesday — good time for {{specific deep work task}}"

### 3.2 Present Suggestions

> "Based on your goals, tasks, and calendar shape, here's what I suggest for this week:
>
> **Suggested priorities:**
>
> 1. **Complete pricing proposal** — Goal 1 (Launch v2.0) needs this to hit milestone 3. You have deep work time Wednesday.
> 2. **Customer interview batch** — Goal 2 (Improve NPS) has no activity in 3 weeks.
> 3. **Follow up on Acme contract** — Committed to Sarah by Friday.
> 4. **Review team roadmap** — Carried over from last week. Still a priority?
>
> **Does this feel right?** Adjust as needed."

### 3.3 Interactive Refinement

Wait for user to confirm, adjust, or provide different priorities. For each priority confirmed, capture:
- Title
- Pillar alignment
- Connected quarterly goal (if any)
- Success criteria ("what done looks like")
- Effort classification (deep work / medium / quick)

---

## Step 4: Generate Week Priorities File

Archive old file to `07-Archives/Plans/YYYY-Wxx.md`.

Create updated `02-Week_Priorities/Week_Priorities.md`:

```markdown
# Week Priorities

**Week of:** [Monday YYYY-MM-DD]

---

## 📊 Week Shape

| Day | Type | Deep Work? | Notes |
|-----|------|------------|-------|
| Mon | Stacked | ❌ | 7 meetings |
| Tue | Moderate | ⚠️ | 90 min block PM |
| Wed | **Open** | ✅ | **Deep work day** (3h morning) |
| Thu | Stacked | ❌ | 6 meetings |
| Fri | Moderate | ⚠️ | 2h block |

**Deep work capacity:** ~5 hours this week
**Best day for focus:** Wednesday

---

## 🎯 Quarterly Goals Context

| Goal | Progress | Status |
|------|----------|--------|
| [Goal 1] | 3 of 5 milestones | On track |
| [Goal 2] | 1 of 4 milestones | ⚠️ Stalled (3 weeks) |
| [Goal 3] | 2 of 3 milestones | On track |

**This week advances:** Goals #1 and #2

---

## 🎯 Top 3 This Week

1. **[Priority 1]** — **[Pillar]**
   - Success criteria: [What done looks like]
   - Quarterly goal: [Q Goal #X]
   - **Scheduled:** [Day/time block]
   - Effort: [deep_work / medium / quick]

2. **[Priority 2]** — **[Pillar]**
   - Success criteria: [What done looks like]
   - Quarterly goal: [Q Goal #X]
   - **Scheduled:** [Day/time block]
   - Effort: [deep_work / medium / quick]

3. **[Priority 3]** — **[Pillar]**
   - Success criteria: [What done looks like]
   - Quarterly goal: [Q Goal #X] or Operational
   - **Scheduled:** [Day/time block]
   - Effort: [deep_work / medium / quick]

---

## ⚡ Commitments Due This Week

- [ ] [Commitment] — to [person] — due [day]
- [ ] [Commitment] — from [meeting] — due [day]

---

## 📋 Tasks by Priority

### Must Complete (P0)
- [ ] [Task] — Supports: Priority #X — **[Day]**

### Should Complete (P1)
- [ ] [Task] — Supports: Priority #X — **[Day]**

### If Time Permits (P2)
- [ ] [Task]

---

## 📅 Key Meetings

| Day | Time | Meeting | Prep Needed | Related Priority |
|-----|------|---------|-------------|------------------|
| Mon | [Time] | [Meeting] | [Prep] | Priority #X |

---

## 📊 Pillar Balance

| Pillar | This Week | Balance |
|--------|-----------|---------|
| [Pillar 1] | [Brief description] | 🟩 Good |
| [Pillar 2] | [Brief description] | 🟨 Light |
| [Pillar 3] | [Brief description] | 🟥 Neglected |

---

## 🔄 Carried Over

- [ ] [Task from last week] — [Why it carried over]

---

## 🏁 End of Week Review

*Fill in on Friday*

### Completed
-

### Didn't Finish
-

### Learnings
-

### Next Week Focus
-

---

*Generated: [Timestamp]*
```

---

## Step 5: Summary

After generating the file, provide a summary:

> "Week planned! Saved to `02-Week_Priorities/Week_Priorities.md`
>
> **Your Top 3 this week:**
> 1. [Priority 1] — Scheduled for [Day]
> 2. [Priority 2] — Scheduled for [Day]
> 3. [Priority 3] — Scheduled for [Day]
>
> **Heads up:**
> - [Capacity warning if applicable]
> - [Stalled goal reminder]
>
> Ready to run the **daily-plan** prompt for today?"
