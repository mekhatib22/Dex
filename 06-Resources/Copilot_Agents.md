# Copilot CLI Agents

Reference guide for all available Copilot CLI agents. Use these when working on the linked projects.

## Data Agents

| Agent | Project | Data Source | Use For |
|-------|---------|-------------|---------|
| `copilot-analytics` | [[Copilot_Usage_Analytics]], [[Paid_Media_Accelerator]] | Kusto | Copilot seats, features, trends |
| `3p-agent-canonical-staging-model` | [[Copilot_Usage_Analytics]] | Kusto/Trino | 3P agent detection, PR attribution |
| `ghas-data-analyst` | [[Security_Analytics_GHAS]] | Kusto | GHAS funnels, committers, SRA |
| `agentic-event-analysis` | [[CampAIR_Marketing_Impact]] | Kusto | Event/campaign impact analysis |
| `global-expansion` | [[Global_Expansion_Framework]] | Kusto + Gartner | Market scoring, geo analysis |
| `market-intelligence` | [[Market_Intelligence]] | Knowledge repo + Kusto | Competitive intel, trending |
| `trending-repos-report` | [[Market_Intelligence]] | Power BI + Kusto | Biweekly OSS report |
| `customer-enrollments` | General | Kusto | Seat breakdowns by product |

## Utility Agents

| Agent | Purpose | Model |
|-------|---------|-------|
| `pptx-generator` | Professional deck creation | Opus |
| `qubot-launcher` | Interactive data analyst (Kusto/Trino) | Haiku |
| `github-copilot-integration` | SDK + MCP + Playwright setup | Sonnet |

## Skills (in-conversation)

| Skill | Triggers | Purpose |
|-------|----------|---------|
| `data-query` | "kusto", "trino", "query" | 3-tier query routing + validated templates |
| `octoverse-analysis` | "octoverse", "copilot growth" | Narrative framework |
| `docx-formatting` | ".docx", "word" | Safe Word doc editing |
| `pptx-generator` | "presentation", "slides" | Deck workflow |
| `reflect` | "reflection", "review" | Performance reflection |
| `resume-builder` | "resume", "job application" | Tailored resume |
| `session-analyzer` | "workflow review" | Architecture improvement |
| `customer-enrollments` | "seat breakdown" | Enrollment queries |

---

*Auto-created from ecosystem audit on 2026-05-15*
