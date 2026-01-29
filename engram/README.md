# Engram

Persistent memory system for Claude Code with three-file separation architecture.

Engram gives Claude persistent memory across conversations by maintaining three specialized files: **preferences** (always-loaded), **conversation history** (searchable, newest-first), and **long-term memories** (append-only archive). Everything is fully automatic — a hook injects memory instructions on every prompt, and AI skills handle reading, writing, and searching without manual commands.

## Architecture: Three-File Separation

| File | Purpose | Access Strategy |
|------|---------|-----------------|
| `memory_preferences.md` | User/project preferences | Always-loaded via Read (turn 1, every N turns) |
| `memory_conversations.md` | Conversation summaries | On-demand Grep search, newest-first |
| `memory_longterm.md` | Permanent memories | On-demand Grep search, append-only |

This separation optimizes for both context window usage and retrieval accuracy:
- **Preferences** are small and frequently needed — loaded fully into context
- **Conversations** grow large over time — searched selectively by topic
- **Long-term memories** are permanent records — searched selectively, never deleted

## Installation

Install as a Claude Code plugin:

```bash
claude plugin add ./engram
```

Or add to your project's `.claude/settings.json`:

```json
{
  "plugins": ["path/to/engram"]
}
```

## Getting Started

After installation, **you must initialize the memory system before first use**. Engram's hook automatically detects whether initialization has been completed and will guide you through the setup process:

1. **Auto-detection**: On your first prompt, the hook detects that `.claude/memory-settings.json` does not exist and triggers the `memory-init` skill
2. **Choose a preset**: Select `personal-assistant`, `project-assistant`, or `character-companion` based on your use case
3. **Customize file names** (optional): Keep the defaults or rename the three memory files
4. **Choose language**: Select the language for hook-injected instructions (`en` or `zh`)
5. **Done**: The system creates your configuration, memory file templates, and turn counter

All memory features (recall, remember, status) only work after initialization is complete. If you attempt to use them beforehand, the hook will keep prompting you to run `memory-init` first.

You can also trigger initialization manually at any time:

```
/engram:memory-init
```

## Presets

Engram ships with three preset templates optimized for different use cases:

### Personal Assistant

For daily life management, personal interactions, and habit tracking.

- **Preferences**: Basic info, daily routine, communication style, interests, tools, health
- **Conversations**: Tasks completed, information lookups, daily interactions
- **Long-term**: Life events, preference evolution, important dates

### Project Assistant

For software development, architecture decisions, and team workflow.

- **Preferences**: Project overview, tech stack, coding conventions, team workflow, testing
- **Conversations**: Feature discussions, bug fixes, design decisions, code reviews
- **Long-term**: Architecture decisions (ADR), milestones, lessons learned, tech debt

### Character Companion

For persona-based interactions, relationship development, and story progression.

- **Preferences**: User info, interaction preferences, character persona, relationship framework
- **Conversations**: Emotional interactions, story progression, relationship moments
- **Long-term**: Relationship milestones, shared experiences, character development

## How It Works

### Fully Automatic Flow

1. **Hook fires** on every user prompt (`UserPromptSubmit`)
2. **Not initialized?** → Hook tells AI to run `memory-init` skill → user picks preset
3. **Initialized** → Hook injects datetime, turn counter, and memory instructions
4. **AI reads preferences** on turn 1 and every N turns (configurable)
5. **AI discovers new info** → auto-triggers `memory-remember` to save it
6. **Topic relates to past** → auto-triggers `memory-recall` to search memories
7. **Conversation ends** → auto-triggers `memory-remember` to save summary

No slash commands needed. The AI handles everything through skill instructions injected by the hook.

### Skills

| Skill | Trigger | Action |
|-------|---------|--------|
| `memory-init` | No config found | Ask preset, create files, configure |
| `memory-remember` | New preference/decision/milestone | Write to appropriate memory file |
| `memory-recall` | Topic relates to past context | Search across all memory files |
| `memory-status` | User asks about memory | Display config, stats, health check |

## Configuration

Settings are stored in `.claude/memory-settings.json`:

```json
{
  "enabled": true,
  "preset": "personal-assistant",
  "files": {
    "preferences": "memory_preferences.md",
    "conversations": "memory_conversations.md",
    "longterm": "memory_longterm.md"
  },
  "reload_interval": 10,
  "language": "en"
}
```

| Field | Description | Default |
|-------|-------------|---------|
| `enabled` | Enable/disable the memory system | `true` |
| `preset` | Active preset template | `"personal-assistant"` |
| `files.preferences` | Preferences file name | `"memory_preferences.md"` |
| `files.conversations` | Conversations file name | `"memory_conversations.md"` |
| `files.longterm` | Long-term memory file name | `"memory_longterm.md"` |
| `reload_interval` | Re-read preferences every N turns | `10` |
| `language` | Hook instruction language (`en` or `zh`) | `"en"` |

## Memory File Formats

### Preferences

Markdown with structured sections. Updated in-place when preferences change.

```markdown
## User Preferences

### Basic Information
- Name: Frank
- Location: Taipei
```

### Conversations

Reverse chronological entries. New entries prepended to top.

```markdown
### 2025-01-29 14:30 ~ 15:00 - Auth refactor discussion

Discussed migrating from session-based to JWT authentication.
Decided on refresh token rotation strategy.
Action: implement token refresh endpoint next session.
```

### Long-Term Memories

Append-only entries under categorized sections.

```markdown
### Architecture Decisions
- 2025-01-15: Migrated from MongoDB to PostgreSQL for ACID compliance
- 2025-01-29: Adopted JWT with refresh token rotation for auth

### Milestones
- 2025-01-20: v1.0 launched to production
```

## Requirements

- `jq` — JSON processing in the hook script
- `date` — datetime formatting (standard on macOS/Linux)

## License

MIT
