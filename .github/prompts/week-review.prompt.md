---
description: "Weekly review with concrete accomplishments, pattern detection, and goal tracking"
---

# Week Review

Create a synthesis of the week reviewing activity, progress, and what was accomplished. **Uses concrete metrics, not vague percentages.**

---

## Data Sources

Read these files to gather the week's data:

1. **Tasks:** `03-Tasks/Tasks.md` — Task completion status
2. **Priorities:** `02-Week_Priorities/Week_Priorities.md` — Weekly priorities
3. **Projects:** `04-Projects/**/*.md` — Modified this week
4. **Meetings:** `00-Inbox/Meetings/*.md` — Meeting notes from this week
5. **People:** `05-Areas/People/**/*.md` — Person pages updated
6. **Learnings:** `System/Session_Learnings/*.md` — Auto-captured session learnings
7. **Daily Reviews:** `07-Archives/Reviews/Daily_Review_YYYY-MM-DD.md` — This week's reviews

---

## Analysis Process

### 1. Weekly Priority Completion (Concrete, Not Percentages)

**Don't say:** "Goal X went from 40% to 55%"
**Do say:** "You completed 2 of 3 weekly priorities"

For each weekly priority:
- **Complete:** ✅ What was the deliverable? When did you finish?
- **In Progress:** 🔄 What specifically got done? What's left?
- **Not Started:** ❌ Why? Should it carry forward?

### 2. Task Completion Stats

Scan `03-Tasks/Tasks.md` for completion timestamps from this week:
- Count tasks completed (look for `✅ YYYY-MM-DD` in date range)
- Count tasks added mid-week
- Count tasks carried over

### 3. Quarterly Goals Progress

Read `01-Quarter_Goals/Quarter_Goals.md`:

For each goal:
- Milestones completed this week
- Total milestones done vs. total
- Weeks since last milestone
- Specific accomplishments that moved the goal

### 4. Daily Completion Rate Trend

If daily reviews exist, calculate completion trends:

| Day | Planned | Done | Rate |
|-----|---------|------|------|
| Mon | 3 | 2 | 67% |
| Tue | 3 | 3 | 100% |
| Wed | 3 | 2 | 67% |
| Thu | 3 | 1 | 33% |
| Fri | 3 | 2 | 67% |

**Week average and pattern observation**

### 5. Meeting Analysis

Review meeting notes from the week:
- Meetings held
- Key decisions
- Action items created
- Follow-ups that might have slipped

### 6. Learning Compilation & Pattern Detection

Review `System/Session_Learnings/` files from this week:

**Pattern Detection:**
- **Recurring issues:** Same mistake 2+ times? Suggest adding to `06-Resources/Learnings/Mistake_Patterns.md`
- **Consistent preferences:** User repeatedly mentioned a workflow preference?

---

## Output Format

Create `00-Inbox/Weekly_Synthesis_YYYY-MM-DD.md`:

```markdown
# Weekly Synthesis — Week of [Date]

## TL;DR

- **Weekly priorities:** [X] of 3 complete
- **Tasks:** [X] completed / [Y] planned — [Z]% completion
- **Meetings:** [N] total
- **Key wins:** [1-2 bullets]
- **Carried over:** [1-2 items]

---

## 🎯 Weekly Priorities

### 1. [Priority 1] — ✅ Complete

**Deliverable:** [What was shipped/finished]
**Completed:** [Day]
**Tasks:** 5 of 5

### 2. [Priority 2] — 🔄 In Progress (60%)

**Done this week:**
- [Specific accomplishment]
- [Specific accomplishment]

**Remaining:**
- [Specific task]

### 3. [Priority 3] — ❌ Not Started

**Why:** [Reason]
**Recommendation:** [Carry forward / Deprioritize / Defer]

---

## 📊 Task Completion

| Metric | Count |
|--------|-------|
| Tasks completed | 14 |
| Tasks added mid-week | 6 |
| Tasks carried over | 3 |
| **Completion rate** | **82%** |

**Observation:** [Any patterns]

---

## 🎯 Quarterly Goals

| Goal | Milestones | This Week | Status |
|------|------------|-----------|--------|
| [Goal 1] | X of Y | +Z | [Status] |
| [Goal 2] | X of Y | — | [Status] |

**Goals advancing:** [Which ones moved]
**Goals stalled:** [Which ones need attention]

---

## 📊 Daily Completion Trend

| Day | Planned | Done | Rate |
|-----|---------|------|------|
| Mon | 3 | 2 | 67% |
| Tue | 3 | 3 | 100% |

**Week average:** [X]%
**Observation:** [Pattern noticed]

---

## 📅 Meetings & People

### Meetings Held

| Date | Topic | Key Outcome |
|------|-------|-------------|
| [Day] | [Topic] | [Decision/insight] |

### Action Items from Meetings
- [ ] [Action] — for [who] — due [when]

---

## 💡 Learnings

### Patterns Identified
- **Recurring issue:** [Issue] (appeared X times)
- **Preference noted:** [Preference]

### Actionable Improvements
- [ ] [Specific improvement to make]

---

## 📊 Pillar Balance

| Pillar | Tasks Done | Focus |
|--------|------------|-------|
| [Pillar 1] | X tasks | Heavy |
| [Pillar 2] | X tasks | Light |
| [Pillar 3] | X tasks | None |

---

## ➡️ Next Week

### Suggested Priorities

Based on this week's progress:

1. **[Priority]** — [Why: carries over / goal needs attention / commitment]
2. **[Priority]** — [Why]
3. **[Priority]** — [Why]

### Blocked Items Needing Resolution

| Item | Blocked Since | What Would Unblock It |
|------|---------------|-----------------------|
| [Item] | [Date] | [Action needed] |

---

## 🏆 Career Evidence (If Career System Enabled)

**Significant accomplishments worth capturing:**

- [Accomplishment] — demonstrates [skill]

> "Want to save any of these as career evidence?"

---

*Generated: [timestamp]*
*Weekly completion: X of 3 priorities*
*Task completion: X%*
```

---

## Follow-up Actions

After synthesis:
1. Update `03-Tasks/Tasks.md` with new priorities
2. Archive completed items
3. Update project pages with status changes
4. Offer to run the **week-plan** prompt for next week
