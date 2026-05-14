---
description: "Initial Dex system setup — conversational onboarding to create your personal knowledge vault"
---

# Set Up Your Dex

Guide the user through a friendly, conversational setup. No technical steps required.

## Process

### Step 1: Welcome

Say: "Welcome to Dex! I'm your personal knowledge assistant. Let's get you set up in about 2 minutes."

"First, what's your name?"

### Step 2: Role

Ask: "What's your role?"

Present this list:

```
**Core Functions**
1. Product Manager
2. Sales / Account Executive
3. Marketing
4. Engineering
5. Design

**Customer-Facing**
6. Customer Success
7. Solutions Engineering

**Operations**
8. Product Operations
9. RevOps / BizOps
10. Data / Analytics

**Support Functions**
11. Finance
12. People (HR)
13. Legal
14. IT Support

**Leadership**
15. Founder

**C-Suite**
16. CEO
17. CFO
18. COO
19. CMO
20. CRO
21. CTO
22. CPO

**Independent / Advisory**
23. Fractional CPO
24. Consultant
25. Coach

Type a number, or describe your role if it's not listed:
```

Accept numbers, role names, or descriptions like "I'm mostly PM but do some engineering."

### Step 3: Company Size

Ask: "What's your company size?"

```
1. 1-100 people (startup/small)
2. 100-1,000 people (scaling)
3. 1,000-10,000 people (enterprise)
4. 10,000+ people (large enterprise)
```

### Step 4: Email Domain

Ask: "What's your company email domain? (e.g., github.com)"

This is used to classify people as Internal vs External automatically.

### Step 5: Priorities

Ask: "What are your 2-3 main priorities right now? These will become your strategic pillars."

Examples to help them: "Like 'close Q1 deals', 'launch new product', 'build team', 'thought leadership'..."

### Step 6: Generate Configuration

Based on their answers:

1. **Create folder structure** (silently):
   - `04-Projects/`
   - `05-Areas/People/Internal/`
   - `05-Areas/People/External/`
   - `05-Areas/Companies/`
   - `06-Resources/Learnings/`
   - `06-Resources/Quarterly_Reviews/`
   - `System/Templates/`
   - `07-Archives/Projects/`
   - `07-Archives/Plans/`
   - `07-Archives/Reviews/`
   - `00-Inbox/Meetings/`
   - `00-Inbox/Ideas/`
   - `01-Quarter_Goals/`
   - `03-Tasks/`
   - `02-Week_Priorities/`

2. **Update `.github/copilot-instructions.md`** User Profile section with:
   - Name
   - Role
   - Company size
   - Pillars (their priorities)

3. **Update `System/pillars.yaml`** with their strategic pillars

4. **Update `System/user-profile.yaml`** with:
   - Name
   - Role
   - Company (if provided)
   - Email domain
   - Communication preferences (defaults based on role)

5. **Create `03-Tasks/Tasks.md`** with initial structure:
   ```markdown
   # Tasks

   ## P0 — Critical
   
   ## P1 — Important
   
   ## P2 — Normal
   
   ## P3 — Low Priority
   ```

### Step 7: Welcome Message

Say: "You're all set, [Name]! Here's what I created for you:"

Show a brief summary:
- Their role and pillars
- Key folders created
- 2-3 suggested first actions based on their role

End with: "What would you like to work on first?"

## For Users with Existing Notes

If user mentions they have existing notes:

Say: "Great! Just copy them into the `00-Inbox/` folder and I'll help you organize them. You can drag and drop files, or copy whole folders."

## Viewing Your Notes

Dex creates markdown files you can view with any app:
- VS Code or your preferred editor
- Obsidian (popular free option)
- Any text editor
