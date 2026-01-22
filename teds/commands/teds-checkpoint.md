---
description: Create a checkpoint in the current TEDS task
---

# Create TEDS Checkpoint

Create an immediate checkpoint in the currently active TEDS task.

## Usage

```bash
/teds-checkpoint [optional-task-id]
```

## Examples

```bash
# Create checkpoint in current task context
/teds-checkpoint

# Create checkpoint for specific task
/teds-checkpoint 20250116-1430-refactor-auth
```

## What is a Checkpoint?

A checkpoint is a **safe pause point** that captures:
- Current phase and progress percentage
- Summary of what has been accomplished
- What remains to be done
- Timestamp for recovery reference

Think of it as a "save game" point—you can safely stop work and resume from here later.

## What This Does

The agent will:
1. Review recent work from `execution_log.md`
2. Assess current progress
3. Add checkpoint entry to `execution_log.md`:
   ```markdown
   ### [HH:MM] - CHECKPOINT
   - Phase: [current phase]
   - Progress: [X%]
   - Summary: [accomplishments]
   - Next: [what remains]
   ```
4. Update `last_checkpoint` in `status.yaml`
5. Confirm: "Checkpoint created. Safe to pause here."

## Automatic Checkpoints

The executor agent automatically creates checkpoints:
- Every 30+ minutes of active work
- At completion of major milestones
- When transitioning between phases

Manual checkpoints are useful when:
- You want to pause before the automatic interval
- You've reached a logical stopping point
- You're about to try something risky
- You're switching focus to another task

## Checkpoint Best Practices

**Good times to checkpoint**:
- ✅ Just completed a significant feature
- ✅ About to refactor or make large changes
- ✅ End of work session
- ✅ Before switching context

**Don't checkpoint**:
- ❌ In the middle of an incomplete action
- ❌ When build/tests are failing
- ❌ When blocked and unsure how to proceed (mark as blocked instead)

## Viewing Checkpoints

To see all checkpoints in a task:
```bash
# View full execution log
cat workspace/active_tasks/[task-id]/execution_log.md | grep "CHECKPOINT"
```

Or use:
```bash
/teds-status [task-id]
```
This shows the last checkpoint time.

## Recovery from Checkpoint

When you continue a task with `/teds-continue`, the agent automatically:
1. Finds the most recent checkpoint
2. Reviews what was done
3. Identifies the next action
4. Resumes from there

No special recovery command needed—it's built into the continue process.

## Related Commands

- `/teds-continue [task-id]` - Resume from checkpoint
- `/teds-status` - View last checkpoint time
- `/teds-complete [task-id]` - Finish task
