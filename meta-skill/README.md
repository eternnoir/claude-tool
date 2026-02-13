# Meta-Skill

Dynamic skill library that loads skills on-demand instead of at session startup.

## Problem

Claude Code loads all skill descriptions into context at session start. With many skills, this consumes the context budget (2% of context window, ~16K chars) and wastes context on skills that may not be needed.

## Solution

Meta-Skill introduces a two-layer system:

1. **SKILLUSE.md** (project root) — A lightweight manifest listing active skills with descriptions
2. **skill-library/** (project root) — A folder containing full skill definitions, loaded only when matched

Only one skill (meta-skill itself) is loaded natively. All other skills are matched dynamically via instructions injected into CLAUDE.md during initialization.

## How It Works

```
Session starts → CLAUDE.md instructs "check SKILLUSE.md on every request"
    ↓
User sends a message
    ↓
Claude reads SKILLUSE.md, matches user intent against descriptions
    ↓
├── Match found → Read skill-library/<name>/SKILL.md → Follow instructions
└── No match → Respond normally
```

## Setup

1. Install the meta-skill plugin
2. Ask Claude to "initialize skill library"
3. Add skills to `skill-library/` and register them in `SKILLUSE.md`

## File Structure

```
your-project/
├── SKILLUSE.md              # Active skill registry (project root)
├── CLAUDE.md                # Contains matching instructions (auto-injected)
├── skill-library/           # Skill definitions
│   ├── code-review/
│   │   └── SKILL.md
│   ├── db-migration/
│   │   ├── SKILL.md
│   │   └── templates/
│   └── api-design/
│       └── SKILL.md
```

## SKILLUSE.md Format

Natural language markdown. Each `## heading` maps to a `skill-library/<heading>/` folder:

```markdown
# Skill Library

## code-review
Code review skill. Perform quality reviews, identify potential issues, and provide improvement suggestions.

## db-migration
Database migration guide. Supports PostgreSQL and MySQL schema changes and rollbacks.
```

- Listed in SKILLUSE.md = active (will be matched)
- Not listed = inactive (files preserved, not loaded)

## skill-library/ Structure

Same structure as `.claude/skills/` for full compatibility:

```
skill-library/<skill-name>/
├── SKILL.md           # Main instructions (required)
├── templates/         # Optional templates
├── examples/          # Optional examples
└── scripts/           # Optional scripts
```

Skills can be moved between `skill-library/` and `.claude/skills/` freely.

## Management Commands

| Operation   | Example                              |
|------------|--------------------------------------|
| Initialize | "Initialize skill library"           |
| List       | "What skills are available?"         |
| Add        | "Create a skill for code review"     |
| Remove     | "Remove the code-review skill"       |
| Enable     | "Enable the db-migration skill"      |
| Edit       | "Update the code-review skill"       |

## Version

1.0.0
