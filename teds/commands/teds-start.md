---
description: Start a new long-term task with TEDS
---

# Start New TEDS Task

Launch the **teds-initializer** agent to create and initialize a new long-term task.

## Usage

```bash
/teds-start task-name [optional-description]
```

## Examples

```bash
# Simple task
/teds-start refactor-auth

# With description
/teds-start migrate-database "Migrate from MySQL to PostgreSQL"

# Complex project
/teds-start implement-oauth "Implement OAuth 2.0 authentication system with Google and GitHub providers"
```

## What This Does

The agent will:
1. Load TEDS configuration (from CLAUDE.md or .teds-config.yaml)
2. Generate a unique task ID (format: `YYYYMMDD-HHMM-taskname`)
3. Create complete directory structure for the task
4. Initialize all documentation files:
   - `manifest.yaml` - Task metadata
   - `plan.md` - Execution plan (will work with you to define)
   - `execution_log.md` - Action logging
   - `knowledge_base.md` - Learnings repository
   - `context.md` - Background and constraints
   - `status.yaml` - Current state
5. Set initial status to "active"
6. Begin planning with you

## Task Naming Guidelines

**Good task names**:
- `refactor-auth` - Clear and concise
- `migrate-database` - Specific action
- `implement-oauth` - Feature-focused

**Avoid**:
- `task1` - Too generic
- `fix-bug` - Not specific enough
- `update-everything` - Too broad

## After Initialization

Once the task is initialized, you'll see:
```
✅ Task initialized: 20250116-1430-refactor-auth
Location: claude_work_space/active_tasks/20250116-1430-refactor-auth/
Status: Ready to begin
```

The agent will then help you:
1. Define detailed phases in `plan.md`
2. Set success criteria
3. Document context and constraints
4. Begin execution with continuous logging

## Continuing Later

To resume this task in a future session:
```bash
/teds-continue 20250116-1430-refactor-auth
```

## Related Commands

- `/teds-status` - View all tasks
- `/teds-continue [task-id]` - Resume a task
- `/teds-checkpoint` - Save progress
- `/teds-complete [task-id]` - Finish and archive
