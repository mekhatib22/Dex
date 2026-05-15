---
description: "Review team documents shared via email, Teams, SharePoint, Slack — summarize, extract insights, update Dex"
---

# Review Team Documents

Surface and review documents shared by your team across all channels — email attachments, Teams messages, SharePoint, and Slack. Summarize key points, extract action items, and update Dex.

## Process

### Step 1: Discover Recent Documents

Pull from all available sources in parallel:

#### 1a. Email Attachments (via WorkIQ)

Use m365-copilot-copilot_chat to query:

> "What documents, files, or attachments were shared with Mark Elkhatib via email in the last 7 days? Include: sender, subject line, file name, file type, and a brief description of what the document is about. Focus on documents from the Insights & Product Operations team."

#### 1b. Teams Shared Files (via WorkIQ)

Use m365-copilot-copilot_chat to query:

> "What files or documents were shared in Teams chats or channels that Mark Elkhatib is part of in the last 7 days? Include: who shared it, which chat/channel, file name, and a summary of the file content if available."

#### 1c. SharePoint Documents (via SharePoint MCP)

Search SharePoint for recently modified team documents:

```
Use: sharepoint-findFileOrFolder(searchQuery="Insights Product Operations")
```

Also search for specific document types your team produces:
```
Use: sharepoint-findFileOrFolder(searchQuery="dashboard")
Use: sharepoint-findFileOrFolder(searchQuery="report")
Use: sharepoint-findFileOrFolder(searchQuery="analysis")
```

For any found files, get metadata:
```
Use: sharepoint-getFileOrFolderMetadata(documentLibraryId="...", fileOrFolderId="...")
```

For text files under 5MB, read content:
```
Use: sharepoint-readSmallTextFile(documentLibraryId="...", fileId="...")
```

#### 1d. Slack Shared Files

Check recent Slack channel dumps in `00-Inbox/Ideas/` for file share messages, or run slackdump for monitored channels and grep for file attachments.

### Step 2: Triage Documents

Present discovered documents in a review table:

> **📄 Documents Shared This Week**
>
> | # | Source | From | Document | Type | Priority |
> |---|--------|------|----------|------|----------|
> | 1 | Email | [[Tala_Karadsheh\|Tala]] | FY27 Dashboard Metrics.xlsx | Spreadsheet | 🔴 Review |
> | 2 | Teams | [[Mudda_Qureshi\|Mudda]] | Copilot Maturity Update.pptx | Deck | 🟡 Skim |
> | 3 | SharePoint | [[Cory_Thayer\|Cory]] | Weekly Report v3.docx | Report | 🟢 FYI |
> | 4 | Slack | [[David_Jarzebowski\|David]] | release_tracker_data.csv | Data | 🟡 Skim |
>
> **Which ones should I review in depth?** (Enter numbers, or "all")

Priority inference:
- 🔴 **Review** — From manager, mentions you by name, relates to P0/P1 tasks
- 🟡 **Skim** — From close collaborator, relates to active project
- 🟢 **FYI** — Team-wide share, informational

### Step 3: Deep Review

For each selected document:

#### If readable (text, markdown, small docx):
1. Read the content via SharePoint MCP or WorkIQ
2. Generate a structured summary:
   - **TL;DR** (2-3 sentences)
   - **Key findings / data points**
   - **Decisions made or proposed**
   - **Action items for Mark**
   - **Questions to raise**

#### If not directly readable (large files, binary):
1. Use WorkIQ to get a summary:
   > "Summarize the document [filename] that [person] shared with me on [date]. What are the key points, decisions, and any action items for me?"
2. Ask user if they want to download locally for manual review

### Step 4: Update Dex

For each reviewed document:

1. **Person pages** — Add to "Recent Interactions" for the sender
   > `- 2026-05-15 — Shared "FY27 Dashboard Metrics.xlsx" — [brief context]`

2. **Project pages** — Link document to relevant project in `04-Projects/`
   > Under "## Key Documents" section (create if missing)

3. **Tasks** — Extract action items to `03-Tasks/Tasks.md`
   > `- [ ] Review FY27 metrics and provide feedback to Tala ^task-YYYYMMDD-XXX #analytics`

4. **Meeting prep** — If document relates to upcoming meeting, flag for meeting-prep

### Step 5: Create Review Summary

Save to `00-Inbox/Ideas/YYYY-MM-DD - Document Review.md`:

```markdown
# Document Review — YYYY-MM-DD

## Documents Reviewed: X

### 1. [Document Title]
- **Source:** [Email/Teams/SharePoint/Slack]
- **From:** [[Person]]
- **Related Project:** [[Project]]

**Summary:**
[TL;DR]

**Key Points:**
- [Point 1]
- [Point 2]

**Action Items:**
- [ ] [Action] ^task-YYYYMMDD-XXX

---

### 2. [Next Document]
...

---

*Reviewed on YYYY-MM-DD*
```

## Arguments

- No arguments: Last 7 days across all sources
- `--today`: Only documents shared today
- `--sharepoint`: Only search SharePoint
- `--email`: Only check email attachments
- `--from "name"`: Only documents from a specific person
- `--project "name"`: Only documents related to a specific project
