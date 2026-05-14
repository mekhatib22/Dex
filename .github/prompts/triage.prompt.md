---
description: "Strategically route orphaned files and extract scattered tasks from your inbox"
---

# Triage

Cleanup and routing tool that finds standalone files and scattered tasks, then suggests where they belong using your current strategic context.

## Execution Style

This skill handles quick decisions. Be concise. Don't over-analyze. Make a routing decision and move on.

## What It Does

- **Files**: Routes standalone files in `00-Inbox/` to projects, person pages, or resource folders
- **Tasks**: Finds unchecked `- [ ]` tasks scattered across notes and routes them appropriately
- **Strategic**: Uses your Week Priorities and Quarterly Goals to inform routing confidence

## Usage

- Run this prompt to process everything (files + tasks)
- Mention "files" to organize standalone files only
- Mention "tasks" to extract and route tasks only

---

## Step 0: Load Strategic Context & Structure Discovery

### Load Strategic Context

Read these files to understand current priorities:

1. **Week Priorities**: `02-Week_Priorities/Week_Priorities.md`
   - Extract this week's Top 3 focus items
   - Capture keywords and themes

2. **Quarterly Goals**: `01-Quarter_Goals/Quarter_Goals.md`
   - Extract current quarter's goals
   - Note associated projects

### Structure Discovery

1. **Scan Projects**: List all files in `04-Projects/` — extract project names
2. **Scan People**: List all files in `05-Areas/People/External/` and `Internal/` — extract names, roles, companies
3. **Read Pillars**: Parse `System/pillars.yaml` for categorization

---

## Mode: Files

Organize standalone files in the `00-Inbox/` folder.

### Process

1. **Scan `00-Inbox/`** — List all files (exclude README.md)

2. **Match Against Context**

   For each inbox file, check in this order:

   | Check | Match Criteria | Action |
   |-------|---------------|--------|
   | **Week Priority match** | Content relates to Top 3 priorities | Route to associated project, flag HIGH |
   | **Quarterly Goal match** | Content relates to goals | Route to project, flag strategic |
   | **Project match** | File mentions project name | Route to specific project |
   | **Person match** | File is about a specific person | Route to person page |
   | **Company match** | File mentions company name | Route to `05-Areas/Companies/` |
   | **Pillar keyword match** | Content matches pillar keywords | Tag with pillar |
   | **No match** | None of the above | Fall back to category routing |

3. **Category Fallback Rules**

   | Destination | Criteria |
   |-------------|----------|
   | `04-Projects/` | Has deadline, specific outcome |
   | `05-Areas/People/` | Person-specific information |
   | `06-Resources/` | Reference material, knowledge |
   | `07-Archives/` | Old/completed |
   | Delete | No value, redundant |

4. **Present Suggestions** sorted by strategic relevance

5. **Execute with Confirmation** — Show full plan, wait for approval, move files

---

## Mode: Tasks

Extract uncompleted tasks from notes and route them.

### Process

1. **Scan Sources**
   - `00-Inbox/Meetings/*.md` — Meeting action items
   - `00-Inbox/*.md` — Captured tasks
   - Any file with unchecked `- [ ]` items

2. **Extract Tasks** — Find all `- [ ]` items with source file

3. **Match Tasks to Entities** — Check against known projects, people, companies

4. **Deduplication Check** — Compare against `03-Tasks/Tasks.md` — flag items with >60% similarity

5. **Present Results**

   **Ready to Route** (clear, non-duplicate items):
   - Suggested destination with entity context
   - Pillar if detectable

   **Potential Duplicates** (>60% similarity):
   - Show the existing task it matches
   - Ask: Skip / Merge / Keep Both

   **Needs Clarification** (ambiguous, <3 words):
   - Show the issue
   - Ask clarifying questions

6. **Route with Confirmation**

---

## Example Output

```
📬 Triage Report

=== STRATEGIC CONTEXT ===
Week Priorities:
• Mobile App Launch (beta by Friday)
• Q2 Planning finalization
• Sarah's team onboarding

=== FILES (2) ===

1. "Q1_Planning_Notes.md"
   Strategic Context: ✓ Week Priority "Q2 Planning"
   Destination: 04-Projects/Q2_Planning.md
   Confidence: MEDIUM (70/100)
   Action: Merge into Q2 Planning project?

=== TASKS (3) ===

🎯 HIGH PRIORITY (1):
1. "Finalize mobile app pricing model"
   Strategic Context: ✓ Week Priority + Q1 Goal
   Action: Extract to Week Priorities?

📋 NEEDS ROUTING (1):
2. "Follow up with Sarah about timeline"
   Match: PERSON → "Sarah Chen"
   Destination: Person page action items

⚠️ DUPLICATE (1):
3. "Reach out to Sarah"
   78% match with existing task
   Action: Skip / Merge / Keep both?

---
Proceed with ready items? [y/n]
```

---

## Notes

- Never auto-route without confirmation
- Duplicates require explicit decision
- Ambiguous items block until clarified
- Entity matches show confidence level
