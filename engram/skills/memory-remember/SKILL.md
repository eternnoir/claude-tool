---
name: memory-remember
description: Store a memory. Auto-triggered when new preferences, decisions, or milestones are discovered, or when a conversation ends.
---

# Memory Remember

Store information into the appropriate memory file.

## When to Use

This skill is auto-triggered by the Engram hook instructions. Use it when:

- A new user preference or decision is discovered during conversation
- A milestone, architecture decision, or lesson learned is identified
- The conversation reaches a natural summary point or is ending
- The user explicitly asks to remember something

Do NOT wait for the user to ask — proactively store memories as they emerge.

## Workflow

### 1. Read Configuration

Read `.claude/memory-settings.json` to get the configured file names.

### 2. Classify Content

Determine which file the memory belongs to:

| Type | Target File | Examples |
|------|-------------|----------|
| **Preference** | preferences file | User likes, dislikes, habits, settings, personal info, project conventions |
| **Conversation Summary** | conversations file | What was discussed, tasks completed, decisions made in this session |
| **Long-Term Memory** | longterm file | Life events, milestones, architecture decisions, lessons learned, relationship changes |

### 3. Write to Appropriate File

#### Preferences File
- Read the current file
- Find the appropriate section for the new information
- Edit the existing section content (update, don't duplicate)
- Update the `Last Updated: {DATE}` header to today's date

#### Conversations File
- **Prepend** new entry to the TOP of the file (below the header, above existing entries)
- Format: `### YYYY-MM-DD HH:MM ~ HH:MM - Topic`
- Include: brief summary of what was discussed, key decisions, action items
- Keep summaries concise (3-8 lines)

#### Long-Term Memory File
- **Append** to the appropriate section within the file
- Format: `- YYYY-MM-DD: Description`
- NEVER delete existing entries — only add new ones
- Place under the correct subsection (Milestones, Decisions, Lessons Learned, etc.)

### 4. Confirmation

Briefly mention what was saved (one line), e.g.:
- "Noted your preference for TypeScript over JavaScript."
- "Saved conversation summary about the auth refactor."
- "Recorded the migration to PostgreSQL as an architecture decision."

Do NOT be verbose about the saving process — keep it natural and seamless.
