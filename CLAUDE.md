# Claude Code Development Guide

## Adding a New Plugin

When adding a new plugin, follow these steps:

### 1. Create Plugin Structure

```
<plugin-name>/
├── .claude-plugin/
│   └── plugin.json          # Plugin metadata
├── README.md                 # Plugin documentation
└── skills/
    └── <skill-name>/
        └── SKILL.md          # Skill definition and commands
```

### 2. Create plugin.json

```json
{
  "name": "<plugin-name>",
  "description": "Plugin description",
  "version": "1.0.0",
  "author": {
    "name": "Frank Wang"
  },
  "keywords": ["keyword1", "keyword2"],
  "license": "MIT"
}
```

### 3. Create SKILL.md

```markdown
---
name: <skill-name>
description: Skill description for Claude to know when to use this skill.
---

# Skill Title

## Commands
...
```

### 4. Update marketplace.json (IMPORTANT!)

**After adding a new plugin, you MUST update `.claude-plugin/marketplace.json`:**

1. Add the new plugin to the `plugins` array
2. Bump the marketplace `version` number

```json
{
  "name": "<plugin-name>",
  "source": "./<plugin-name>",
  "description": "Plugin description",
  "version": "1.0.0",
  "keywords": ["keyword1", "keyword2"]
}
```

### 5. Commit Changes

Ensure the commit includes:
- All files for the new plugin
- Updated `marketplace.json`
