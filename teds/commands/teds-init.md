---
description: Initialize TEDS configuration for this project
---

# TEDS Configuration Initialization

Launch the **teds-config** agent to set up TEDS (Task Execution Documentation System) for this project.

## What This Does

1. Prompts for workspace directory name
2. Checks if CLAUDE.md exists in the project
3. Offers integration options (CLAUDE.md or standalone)
4. Creates initial directory structure
5. Saves configuration

## Usage

```bash
/teds-init
```

## First Time Setup

Run this command once per project before using other TEDS commands.

You'll be asked:
- What to name your workspace directory (default: `claude_work_space`)
- Whether to integrate with CLAUDE.md (if it exists)

## What Gets Created

```
your-workspace-name/
├── active_tasks/      # Currently running tasks
├── archived_tasks/    # Completed tasks
└── knowledge_index/   # Extracted summaries
```

Plus configuration in either:
- `CLAUDE.md` (recommended if file exists)
- `.teds-config.yaml` (standalone mode)

## Next Steps

After initialization:
1. Start your first task: `/teds-start task-name "description"`
2. Check status: `/teds-status`
3. View help: `/teds-help` (if available)
