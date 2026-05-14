---
description: "Scan active projects for status, blockers, and next steps"
---

# Project Health

Quick scan of all active projects to see what's stalled, blocked, or needs attention.

## What This Does

Checks each project in `04-Projects/` for:
1. **Activity levels** — When was the project last touched?
2. **Week Priorities presence** — Does the project have active tasks?
3. **Blockers** — Anything blocking progress?
4. **Next steps clarity** — Is the next action clear?

---

## Process

### Step 1: Scan Projects

List all projects in `04-Projects/`:

```bash
ls -la 04-Projects/
```

### Step 2: Check Each Project

For each project folder or file:

**Activity Check:**
- Get last modification time
- >7 days without activity = 🟡 yellow
- >14 days without activity = 🔴 red

**Week Priorities Presence:**
- Scan `02-Week_Priorities/Week_Priorities.md` for project mentions
- No tasks for 2+ weeks = 🟡 yellow

**Blocker Check:**
- Look for "blocked", "waiting on", "stuck" in project notes
- Any logged blocker = 🔴 red

**Next Step Clarity:**
- Check if there's a clear next action
- No next step = 🟡 yellow

### Step 3: Output Dashboard

```markdown
### Project Health Dashboard

| Project | Status | Issue | Days Since Activity |
|---------|--------|-------|---------------------|
| [Project A] | 🟢 | On track | 2 |
| [Project B] | 🟡 | No active tasks | 8 |
| [Project C] | 🔴 | Blocked — waiting on [X] | 15 |

**Summary:** [N] projects ([X] 🟢 / [Y] 🟡 / [Z] 🔴)
```

---

## Status Meanings

- 🟢 **Green**: Active, clear next steps, no blockers
- 🟡 **Yellow**: Stale 7-14 days, OR no active tasks, OR unclear next step
- 🔴 **Red**: Blocked, OR stale 14+ days

---

## When to Use

- Weekly planning to check project health
- When feeling disconnected from the big picture
- Before 1:1s to surface blocked projects
- When deciding what to work on next

---

## Follow-up Actions

For 🟡 yellow projects:
- Add a task to Week Priorities
- Clarify next step in project notes

For 🔴 red projects:
- Identify what's blocking progress
- Escalate if needed
- Or decide to pause/archive the project
