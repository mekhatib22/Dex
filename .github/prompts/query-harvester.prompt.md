---
description: "Scan Copilot CLI sessions for validated queries and promote to data-query skill + Dex"
---

# Query Harvester

Scan recent Copilot CLI sessions for queries the user validated ("good to go", "perfect", "looks good", "validated", etc.) and capture them to both the data-query skill and Dex.

## Process

### Step 1: Find Validated Query Sessions

Query the session store for sessions containing query validation signals:

```sql
-- Find sessions with validation signals + query content
SELECT DISTINCT s.id, s.summary, s.created_at
FROM sessions s
JOIN search_index si ON si.session_id = s.id
WHERE si.search_index MATCH 'validated OR "good to go" OR "looks good" OR "that works" OR "perfect" OR "save this" OR confirmed'
AND s.created_at >= date('now', '-7 days')
ORDER BY s.created_at DESC;
```

### Step 2: Extract Queries from Each Session

For each session found, get the full conversation:

```sql
SELECT turn_index, user_message, assistant_response
FROM turns
WHERE session_id = '<session_id>'
ORDER BY turn_index;
```

Scan assistant responses for query blocks:
- Look for code blocks tagged as `sql`, `kql`, or `trino`
- Match them to user validation messages ("good", "perfect", "validated", "that works", "looks right")
- A query is "validated" if the user's NEXT message after seeing results expresses approval

### Step 3: Classify Each Query

For each validated query determine:
- **Type**: KQL (Kusto) or SQL (Trino)
- **Domain**: Which project/pillar does it serve?
- **Tables used**: Extract table names
- **Purpose**: What question does it answer? (infer from conversation context)
- **Caveats**: Any data notes mentioned (date ranges, gotchas, filters)

### Step 4: Promote to Data-Query Skill

For each validated query, check if it already exists in `~/.copilot/skills/data-query/SKILL.md` under `## Validated Templates`. If not:

1. **Ask user**: "I found this validated query from [session]. Promote to your data-query skill?"

   ```
   ### [Descriptive Title]
   **Use case**: [What question this answers]
   
   ```kql/sql
   [the query]
   ```
   
   **Key tables**: [list]
   **Caveats**: [any notes]
   **Validated [month] [year]**: [context of what was confirmed]
   ```

2. If confirmed, append to `~/.copilot/skills/data-query/SKILL.md` under `## Validated Templates`

### Step 5: Save to Dex

Also save validated queries to Dex for reference:

Create/update `06-Resources/Validated_Queries.md`:

```markdown
# Validated Queries

Battle-tested queries from Copilot CLI sessions. Each was used in analysis and confirmed working.

## Copilot Analytics
- [Query title] — [date validated] — [brief description]

## Security / GHAS
- [Query title] — [date validated]

## Event Analysis
- [Query title] — [date validated]

...
```

Link queries to relevant project pages in `04-Projects/`.

### Step 6: Summary

Report:
- How many sessions scanned
- How many validated queries found
- How many promoted to data-query skill
- How many saved to Dex

## Arguments

- No arguments: Last 7 days
- `--all`: Full session history (328+ sessions)
- `--dry-run`: Show what would be captured without writing
- `--project "name"`: Only queries related to a specific project
