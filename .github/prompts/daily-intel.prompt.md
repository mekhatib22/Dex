---
description: "Daily intelligence sweep — Slack DMs, GitHub activity, and mentions processed into Dex"
---

# Daily Intel Sweep

Gather intelligence from Slack and GitHub to update person pages, surface commitments, and track your impact.

## Process

### Step 1: Slack Intelligence (via gh-slackdump)

Focus on **high-signal sources** — not all channels.

#### 1a. Recent DMs (highest signal)

Run in bash for each key collaborator:
```bash
# Dump last 24h of DMs with key people
gh slackdump -u --from "$(date -v-1d +%Y-%m-%d)" -o /tmp/slack-dm.json "<slack-dm-link>"
```

Parse the JSON output for:
- **Commitments made** — "I'll send you...", "Let me follow up on...", "Will do by..."
- **Asks received** — "Can you...", "Would you mind...", "Need your help with..."
- **Decisions** — "Let's go with...", "Agreed on...", "Final answer is..."
- **Key context** — project updates, status changes, blockers mentioned

#### 1b. Channel Mentions (@mark)

Search for recent mentions across channels. These are things people directed at you.

#### 1c. Process Slack Intel

For each significant finding:
1. **Commitments/asks** → Add to `03-Tasks/Tasks.md` with source attribution
2. **Person context** → Update person pages in `05-Areas/People/` with relevant context
3. **Project updates** → Link to project pages in `04-Projects/`
4. **Key threads** → Save summaries to `00-Inbox/Ideas/` if they contain insights

### Step 2: GitHub Activity

#### 2a. Your Activity (last 24h)

Run in bash:
```bash
# PRs you opened or merged
gh pr list --author @me --state all --json title,url,state,createdAt,mergedAt -L 20

# Issues you commented on
gh api graphql -f query='{ viewer { issueComments(last: 20) { nodes { issue { title url repository { nameWithOwner } } createdAt body } } } }'

# PRs you reviewed
gh api graphql -f query='{ viewer { contributionsCollection(from: "YESTERDAY_ISO") { pullRequestReviewContributions(last: 20) { nodes { pullRequest { title url repository { nameWithOwner } } } } } } }'
```

#### 2b. Repos You Care About (activity feed)

Check recent activity on key repos:
```bash
# Key repos to monitor
for repo in mekhatib22/Business-Insights mekhatib22/copilot-sre mekhatib22/CampAIR-marketing-impact-analysis; do
  gh pr list -R "$repo" --state all --json title,author,state,createdAt -L 5
done
```

#### 2c. Process GitHub Intel

For each significant item:
1. **PRs merged** → Career evidence in `05-Areas/Career/Evidence/`
2. **Issues with action items** → Extract to `03-Tasks/Tasks.md`
3. **Review requests** → Surface as P1 tasks
4. **Notable contributions** → Add to relevant project pages

### Step 3: Synthesize Daily Intel

Create `00-Inbox/Ideas/YYYY-MM-DD - Daily Intel.md`:

```markdown
# Daily Intel — YYYY-MM-DD

## Slack Highlights
- [Commitment/ask from Person] — [context]
- [Key thread summary] — [channel]

## GitHub Activity
- [PRs opened/merged/reviewed]
- [Issues engaged with]

## Action Items Surfaced
- [ ] [Task from Slack] — from [person] ^task-YYYYMMDD-XXX
- [ ] [Task from GitHub] — [repo/issue]

## Person Updates
- Updated: [list of person pages touched]

## Project Updates
- [Project] — [what changed]

---
*Auto-generated daily intel sweep on YYYY-MM-DD*
```

### Step 4: Update Dex

1. Add extracted tasks to `03-Tasks/Tasks.md`
2. Update relevant person pages with new context
3. Link findings to project pages
4. Surface urgent items immediately

## Arguments

- No arguments: Process last 24 hours
- `--week`: Process last 7 days (for weekly catch-up)
- `--slack-only`: Skip GitHub, just do Slack
- `--github-only`: Skip Slack, just do GitHub
