---
description: "Set 3-5 strategic goals for the quarter aligned to your pillars"
---

# Quarter Plan

Set 3-5 strategic goals for the quarter. Runs at the start of each quarter (or mid-quarter if starting fresh).

## Usage

- Run this prompt to plan the current or upcoming quarter
- Mention "next quarter" to plan ahead (run in the last week of the current quarter)

---

## Step 0: Check if Quarterly Planning is Enabled

Read `System/user-profile.yaml`:

1. Check `quarterly_planning.enabled` value
2. **If `false` or missing:**
   - Ask: "Quarterly planning is currently disabled. Would you like to enable it?"
   - If yes → Run onboarding questions, then continue
   - If no → End
3. **If `true`:** Continue to Step 1

### First-Time Onboarding

> "Quarterly planning helps you set 3-5 big goals every 3 months. Your weekly plans will then tie back to these goals.
>
> **When does your Q1 start?**
> 1. January (calendar year)
> 2. February
> 3. April (common fiscal year)
> 4. Other month
> 5. I don't want quarterly planning"

Save choice to `System/user-profile.yaml`:
```yaml
quarterly_planning:
  enabled: true
  q1_start_month: 1
```

---

## Step 1: Determine Target Quarter

Calculate current quarter based on `q1_start_month` setting.

---

## Step 2: Context Gathering

### Check for Last Quarter's Review
Look for `07-Archives/Reviews/[last-quarter].md`:
- Completed / incomplete goals
- "Next Quarter Suggestions" section
- Key learnings

### Check Current Quarter Goals
If `01-Quarter_Goals/Quarter_Goals.md` exists with current quarter:
- Read current goals and progress
- Ask if updating or replacing

### Check Pillars
Read `System/pillars.yaml`:
- Strategic pillars
- Identify any neglected areas

### Scan Recent Projects
Look at `04-Projects/` for active initiatives.

### Check Career Goals (if Career system enabled)
Look for `05-Areas/Career/Growth_Goals.md`:
- Long-term vision
- Target role/level
- Development focus areas

---

## Step 3: Interactive Goal Setting

### Review Last Quarter (if available)

> "Last quarter goals were:
> 1. [Goal 1] — ✅ Completed
> 2. [Goal 2] — 🔄 In progress
> 3. [Goal 3] — ❌ Didn't finish
>
> Anything to carry forward?"

### Present Context

> "Looking at [Quarter] [Year]:
>
> **Active projects:** [list]
> **Pillars:** [list with activity levels]
>
> **Let's work backwards from impact:**
>
> Imagine it's [Quarter End Date] and you're looking back feeling incredibly happy with what you accomplished.
>
> - What outcomes would accelerate your career and impact?
> - What would you be proud to have delivered?
> - What would matter most to the people you serve?
>
> What are the 3-5 most important outcomes you want this quarter?"

### Guide Goal Definition

For each goal:
- "Which pillar does this support?"
- "How will you measure success?"
- "What does 'done' look like?"
- "Any key milestones along the way?"

If career goals exist:
- "Does this goal develop any skills you're targeting?"
- "Does this advance your career path? How?"

### Pillar Balance Check

> "Here's how your goals map to pillars:
> - [Pillar 1]: [X] goals
> - [Pillar 2]: [Y] goals
> - [Pillar 3]: [Z] goals
>
> Does this feel like the right balance?"

---

## Step 4: Archive & Generate

Archive old quarter goals to `07-Archives/Reviews/`.

Create `01-Quarter_Goals/Quarter_Goals.md`:

```markdown
---
quarter: Q1 2026
start_date: 2026-01-01
end_date: 2026-03-31
created: [timestamp]
---

# Q1 2026 Goals

**Jan 1 — Mar 31, 2026**

---

## 🎯 Quarter Objectives

### 1. [Goal Title] — **[Pillar]**

**What success looks like:**
[Specific, measurable outcome]

**Key milestones:**
- [ ] [Milestone 1] — By [timing]
- [ ] [Milestone 2] — By [timing]

**Progress:** Not started 🔴

---

### 2. [Goal Title] — **[Pillar]**

**What success looks like:**
[Specific, measurable outcome]

**Key milestones:**
- [ ] [Milestone 1]
- [ ] [Milestone 2]

**Progress:** Not started 🔴

---

### 3. [Goal Title] — **[Pillar]**

**What success looks like:**
[Specific, measurable outcome]

**Key milestones:**
- [ ] [Milestone 1]
- [ ] [Milestone 2]

**Progress:** Not started 🔴

---

## 📊 Pillar Alignment

| Pillar | Goals | Balance |
|--------|-------|---------|
| [Pillar 1] | [Goal numbers] | [count] |
| [Pillar 2] | [Goal numbers] | [count] |
| [Pillar 3] | [Goal numbers] | [count] |

---

## 🔄 Carried From Last Quarter

- [ ] [Item] — [Context]

---

## 🏁 End of Quarter

*Fill this in when running a quarter review*

### Completed
-

### Incomplete
-

### Key Wins
-

### Learnings
-

---

*Generated: [timestamp]*
```

---

## Step 5: Summary & Next Steps

> "Goals set and saved to `01-Quarter_Goals/Quarter_Goals.md`
>
> **Your focus this quarter:**
> 1. [Goal 1]
> 2. [Goal 2]
> 3. [Goal 3]
>
> **Next steps:**
> - These goals will appear in your weekly planning
> - Update milestones as you make progress
> - Run a quarter review at end of quarter
>
> Ready to plan this week? Run the **week-plan** prompt."

---

## Integration Points

- **Weekly planning** reads from `01-Quarter_Goals/Quarter_Goals.md`
- **Daily plans** reference quarterly goals for priority alignment
- **Quarter reviews** compare plan vs. actual accomplishment
