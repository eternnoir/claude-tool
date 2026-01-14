---
description: Continue working on an existing TEDS task
---

# Continue TEDS Task

Launch the **teds-executor** agent to resume work on an existing long-term task.

## Usage

```bash
/teds-continue task-id
```

## Examples

```bash
# Continue specific task
/teds-continue 20250116-1430-refactor-auth

# List available tasks first
/teds-status
# Then continue one
/teds-continue 20250116-1430-migrate-database
```

## What This Does

The executor agent will:
1. Load TEDS configuration
2. Read all task documentation:
   - `manifest.yaml` - Task info
   - `plan.md` - Execution plan
   - `execution_log.md` - Recent actions (last 20 entries)
   - `knowledge_base.md` - Accumulated learnings
   - `status.yaml` - Current state
3. Identify last completed action
4. Check for any blocked status
5. Resume from `next_action` in status.yaml
6. Continue with **mandatory logging** after every action

## Task Recovery

If you're resuming after a break, the agent will:
- Show you what was accomplished previously
- Identify where work stopped
- Confirm the next action before proceeding
- Catch you up on any important context

Example output:
```
📋 Resuming Task: refactor-auth (20250116-1430-refactor-auth)

Last session: 2 hours ago
Progress: 45% (Phase 2: Implementation)
Last action: Created new AuthService class

Status: Active (not blocked)
Next: Implement OAuth flow integration

Continue with next action? [y/n]
```

## Mandatory Logging

While working, the executor agent will:
- Log EVERY action to `execution_log.md`
- Update `status.yaml` on state changes
- Add discoveries to `knowledge_base.md`
- Create checkpoints every 30+ minutes

You don't need to remind the agent to log—it's built into the system.

## Checkpoints

The agent automatically creates checkpoints:
- Every 30+ minutes of work
- At major milestones
- When you request: `/teds-checkpoint`

Checkpoints are safe pause points where you can stop and resume later.

## If Task is Blocked

If the status shows `blocked: true`, the agent will:
1. Explain what caused the block
2. Review attempted solutions
3. Propose new approaches or ask for guidance
4. Update status once unblocked

## Related Commands

- `/teds-status` - View all tasks and their status
- `/teds-checkpoint` - Create a checkpoint now
- `/teds-complete [task-id]` - Finish and archive
- `/teds-start [name]` - Start a new task
