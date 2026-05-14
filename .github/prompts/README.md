# Dex Prompt Files

Prompt files for GitHub Copilot CLI. Use them by referencing the prompt name.

---

## 🏁 System

| Prompt | Description |
|--------|-------------|
| **start** | Load session context — pillars, goals, priorities, and urgent tasks |
| **setup** | Initial Dex system setup — conversational onboarding |

---

## 📅 Daily

| Prompt | Description |
|--------|-------------|
| **daily-plan** | Generate context-aware daily plan with calendar, tasks, priorities, and meeting intelligence |
| **daily-review** | End of day review with plan completion tracking, meeting follow-ups, and learning capture |

---

## 📆 Weekly

| Prompt | Description |
|--------|-------------|
| **week-plan** | Set weekly priorities with intelligent suggestions based on goals, calendar shape, and task effort |
| **week-review** | Weekly synthesis with concrete accomplishments, pattern detection, and goal tracking |

---

## 📊 Quarterly

| Prompt | Description |
|--------|-------------|
| **quarter-plan** | Set 3-5 strategic goals for the quarter aligned to your pillars |

---

## 📍 Meetings

| Prompt | Description |
|--------|-------------|
| **meeting-prep** | Prepare for meetings with attendee context, related projects, and talking points |
| **process-meetings** | Process meeting notes to update person pages, extract tasks, and organize notes |
| **triage** | Strategically route orphaned files and extract scattered tasks from your inbox |

---

## 🎯 Career

| Prompt | Description |
|--------|-------------|
| **career-coach** | Personal career coach — weekly reports, monthly reflections, self-reviews, promotion assessments |

---

## 📂 Projects

| Prompt | Description |
|--------|-------------|
| **project-health** | Scan active projects for status, blockers, and next steps |

---

## Quick Start

1. **First time?** → Run `setup` to create your vault
2. **Starting a session?** → Run `start` to load context
3. **Planning your day?** → Run `daily-plan`
4. **End of day?** → Run `daily-review`
5. **Monday morning?** → Run `week-plan` then `daily-plan`
6. **Friday evening?** → Run `week-review`

## Typical Weekly Flow

```
Monday:    week-plan → daily-plan
Tue–Thu:   daily-plan → [work] → daily-review
Friday:    daily-plan → [work] → daily-review → week-review
```

## Quarterly Rhythm

```
Quarter start:  quarter-plan → week-plan
Quarter end:    week-review (final week summary)
```
