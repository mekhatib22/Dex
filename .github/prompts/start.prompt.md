---
description: "Load session context: pillars, goals, priorities, and urgent tasks"
---

# Start Session

Load your current context and display a situational summary.

## Process

### Step 1: Display Today's Date

Show: **Today is [Day], [Month] [DD], [YYYY]**

### Step 2: Read Strategic Pillars

Read `System/pillars.yaml` and display your strategic pillars:

> **Your Pillars:**
> 1. [Pillar 1] — [description]
> 2. [Pillar 2] — [description]
> 3. [Pillar 3] — [description]

### Step 3: Quarterly Goals Summary

Read `01-Quarter_Goals/Quarter_Goals.md` (if it exists).

For each goal, show:
- Goal title and pillar
- Milestone progress (e.g., "2 of 5 milestones complete")
- Status emoji (✅ on track, ⚠️ stalled, 🔴 behind)

If the file doesn't exist, note: "No quarterly goals set. Run the quarter-plan prompt to set goals."

### Step 4: Weekly Priorities

Read `02-Week_Priorities/Week_Priorities.md` (if it exists).

Show the Top 3 priorities for this week with status.

If the file doesn't exist or is for a past week, note: "Weekly priorities need updating. Run the week-plan prompt."

### Step 5: Urgent Tasks

Read `03-Tasks/Tasks.md` and surface:
- Any P0 (critical) tasks
- Tasks that are overdue
- Tasks due today

> ⚡ **Urgent:**
> - [P0 task description]
> - [Overdue task]

If no urgent tasks, say: "No urgent tasks. 👍"

### Step 6: Working Preferences & Mistake Patterns

If `06-Resources/Learnings/Working_Preferences.md` exists, read it and keep preferences in mind.

If `06-Resources/Learnings/Mistake_Patterns.md` exists, read it and avoid known patterns.

Mention briefly if relevant patterns exist:
> "Reminder: You prefer deep work in the morning and batch meetings in the afternoon."

### Step 7: Summary

End with:
> **Ready to go.** What would you like to work on?

Suggest relevant actions based on context:
- If it's Monday and no week plan exists → "Consider running week-plan"
- If quarterly goals are stale → "Quarter goals may need review"
- If there are P0 tasks → "You have [N] urgent items to address"
