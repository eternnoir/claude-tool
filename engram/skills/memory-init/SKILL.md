---
name: memory-init
description: Initialize the memory system. Auto-triggered when the hook reports the memory system is not initialized.
---

# Memory Init

Initialize the Engram memory system for the current project.

## When to Use

This skill is auto-triggered by the Engram hook when no `.claude/memory-settings.json` is found. Do NOT wait for the user to ask — when the hook says "Not initialized", immediately begin this workflow.

## Workflow

### 1. Ask Preset Choice

Ask the user which preset they want:

- **personal-assistant** — Daily life, preferences, habits, personal interactions
- **project-assistant** — Codebase, architecture, tech decisions, team workflow
- **character-companion** — Persona, relationship, story progression, emotional bonds

Or offer **custom** configuration.

### 2. Ask File Name Customization

Show the default file names and ask if the user wants to change them:

```
memory_preferences.md    (User/Project/Character preferences)
memory_conversations.md  (Conversation history)
memory_longterm.md       (Long-term memories)
```

### 3. Ask Language Preference

- `en` — English instructions injected by hook (default)
- `zh` — Chinese instructions injected by hook

### 4. Create Configuration

Create `.claude/memory-settings.json` with the chosen settings:

```json
{
  "enabled": true,
  "preset": "<chosen-preset>",
  "files": {
    "preferences": "<preferences-filename>",
    "conversations": "<conversations-filename>",
    "longterm": "<longterm-filename>"
  },
  "reload_interval": 10,
  "language": "<en|zh>"
}
```

### 5. Copy Preset Templates

Copy the template files from the plugin's `templates/presets/<preset>/` directory to the project root. The plugin root is available via `${CLAUDE_PLUGIN_ROOT}` or can be found by locating the engram plugin directory.

Read each template file and write it to the project root with the configured file names.

Replace `{DATE}` placeholders with the current date (YYYY-MM-DD format).

### 6. Initialize Counter

Create `.claude/memory_counter.txt` with content `0`.

### 7. Optional Customization

Ask the user: "Would you like to add or modify any sections in the preferences template?"

If yes, guide through customization — adding new sections, renaming existing ones, or removing irrelevant ones.

### 8. Optional Initial Fill

Ask the user: "Would you like to fill in your initial preferences now?"

If yes, walk through each section and populate the preferences file with the user's answers.

### 9. Output Summary

Display a summary of what was created:

```
Engram Memory System Initialized!

Preset: <preset>
Language: <language>

Files created:
  - <preferences-file> (preferences)
  - <conversations-file> (conversation history)
  - <longterm-file> (long-term memories)
  - .claude/memory-settings.json (configuration)
  - .claude/memory_counter.txt (turn counter)

The memory system is now active. I will automatically:
  - Load your preferences on turn 1 and every N turns
  - Save new preferences and decisions as I discover them
  - Record conversation summaries
  - Search past conversations when relevant
```
