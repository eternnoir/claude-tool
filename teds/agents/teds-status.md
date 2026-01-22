---
description: Display comprehensive status of TEDS tasks
model: inherit
---

# TEDS Status Agent

You are displaying the status of TEDS tasks to help users understand their current work state.

## Load Configuration

**Determine workspace location**:

1. **Check CLAUDE.md**:
   ```bash
   if test -f "CLAUDE.md"; then
     grep -A 2 "## TEDS Configuration" CLAUDE.md | grep "Workspace Directory" | sed 's/.*`\([^`]*\)`.*/\1/'
   fi
   ```

2. **Check .teds-config.yaml**:
   ```bash
   if test -f ".teds-config.yaml"; then
     grep "path:" .teds-config.yaml | awk '{print $2}'
   fi
   ```

3. **Error if neither exists**:
   ```
   ❌ TEDS not initialized in this project.

   Please run: /teds-init
   ```

Store workspace path as `WORKSPACE`.

## Determine Mode

Command format: `/teds-status [optional-task-id]`

**Mode A**: No task-id provided → Show all tasks summary
**Mode B**: Task-id provided → Show detailed single task status

## Mode A: All Tasks Summary

### Step 1: Scan for Tasks

```bash
# List active tasks
ls -1 "${WORKSPACE}/active_tasks/" 2>/dev/null

# List archived tasks (recent ones)
ls -1t "${WORKSPACE}/archived_tasks/" 2>/dev/null | head -10
```

### Step 2: Gather Task Information

For each task directory:

```bash
TASK_ID="${dir_name}"

# Read manifest
NAME=$(grep "name:" "${WORKSPACE}/active_tasks/${TASK_ID}/manifest.yaml" | cut -d: -f2 | tr -d ' ')
CREATED=$(grep "created_at:" "${WORKSPACE}/active_tasks/${TASK_ID}/manifest.yaml" | cut -d: -f2-)

# Read status
PHASE=$(grep "current_phase:" "${WORKSPACE}/active_tasks/${TASK_ID}/status.yaml" | cut -d: -f2- | tr -d ' "')
PROGRESS=$(grep "progress_percentage:" "${WORKSPACE}/active_tasks/${TASK_ID}/status.yaml" | cut -d: -f2 | tr -d ' ')
BLOCKED=$(grep "blocked:" "${WORKSPACE}/active_tasks/${TASK_ID}/status.yaml" | cut -d: -f2 | tr -d ' ')
```

### Step 3: Present Summary Table

```markdown
# TEDS Tasks Status

**Workspace**: `{WORKSPACE}/`
**Configuration**: {CLAUDE.md | .teds-config.yaml}

## Active Tasks ({count})

{If no active tasks:}
No active tasks.

Use `/teds-start [name] "[description]"` to create your first task.

{If has active tasks:}

| ID | Name | Phase | Progress | Status |
|----|------|-------|----------|--------|
| {task-id (short)} | {name} | {phase (short)} | {X}% | {active/🔴blocked} |
| {task-id (short)} | {name} | {phase (short)} | {X}% | {active/🔴blocked} |
| ... | ... | ... | ... | ... |

{If any tasks are blocked:}
⚠️  {count} task(s) blocked. Use `/teds-status [task-id]` for details.

## Recently Archived ({count from last 10})

{If no archived tasks:}
No archived tasks yet.

{If has archived tasks:}

| ID | Name | Completed | Duration |
|----|------|-----------|----------|
| {task-id (short)} | {name} | {time ago} | {duration} |
| ... | ... | ... | ... |

## Quick Actions

- **View task details**: `/teds-status [task-id]`
- **Continue a task**: `/teds-continue [task-id]`
- **Start new task**: `/teds-start [name]`
- **Complete a task**: `/teds-complete [task-id]`

## Workspace Statistics

- **Total Active**: {count}
- **Total Archived**: {count}
- **Knowledge Entries**: {count files in knowledge_index/}
- **Disk Usage**: {du -sh workspace}

---

Run `/teds-status [task-id]` for detailed information about a specific task.
```

### Formatting Notes

**Task ID Display**:
- Show shortened version: `20250116-1430-refactor-auth` → `0116-1430-refactor`
- Or just last part: `refactor-auth`
- Include hover/full ID if possible

**Phase Display**:
- Truncate long phases: `Phase 2: Implementation` → `Implementation`
- Or show as: `P2: Implementation`

**Time Ago**:
- < 1 hour: `45 minutes ago`
- < 1 day: `5 hours ago`
- < 1 week: `3 days ago`
- < 1 month: `2 weeks ago`
- Older: `2025-01-10`

**Duration**:
- Calculate from created_at to completed_at (for archived)
- Format: `2.5 hours`, `3 days`, `1 week`

## Mode B: Single Task Detailed Status

### Step 1: Validate Task Exists

```bash
TASK_ID="${provided_id}"

if ! test -d "${WORKSPACE}/active_tasks/${TASK_ID}"; then
  # Check if it's archived
  if test -d "${WORKSPACE}/archived_tasks/${TASK_ID}"; then
    TASK_DIR="${WORKSPACE}/archived_tasks/${TASK_ID}"
    ARCHIVED=true
  else
    echo "❌ Task not found: ${TASK_ID}"
    echo ""
    echo "Available tasks:"
    ls "${WORKSPACE}/active_tasks/"
    exit 1
  fi
else
  TASK_DIR="${WORKSPACE}/active_tasks/${TASK_ID}"
  ARCHIVED=false
fi
```

### Step 2: Load Task Data

```bash
# Read all key files
MANIFEST=$(cat "${TASK_DIR}/manifest.yaml")
STATUS=$(cat "${TASK_DIR}/status.yaml")
PLAN=$(cat "${TASK_DIR}/plan.md")
LOG_RECENT=$(tail -100 "${TASK_DIR}/execution_log.md")
KNOWLEDGE=$(cat "${TASK_DIR}/knowledge_base.md")
```

Extract key information:
- Task name, description, created_at
- Current phase, progress, blocked status
- Last checkpoint, last updated
- Next action
- Recent log entries
- Knowledge entries

### Step 3: Present Detailed Status

```markdown
# Task Status: {name}

**ID**: `{TASK_ID}`
**Status**: {✅ Active | 🔴 Blocked | ✓ Completed}
**Created**: {date and time}
**Duration**: {time since creation OR total duration if archived}

---

## Current State

**Phase**: {current_phase}
**Progress**: {progress_percentage}% [▓▓▓▓▓▓▓░░░]
**Last Updated**: {time ago}
**Last Checkpoint**: {time ago}

{If blocked:}
⚠️  **BLOCKED**: {blocked_reason}

{Action required section}

{If not blocked:}
✅ Task progressing normally

## Next Action

{next_action from status.yaml}

{If has notes in status.yaml:}
**Notes**: {notes}

---

## Recent Activity

Showing last 5 actions:

### {HH:MM} - {Action Type}
- Tool: {tool}
- Target: {target}
- Result: {result}
- Status: {success/failed}

### {HH:MM} - {Action Type}
- Tool: {tool}
- Target: {target}
- Result: {result}
- Status: {success/failed}

[... 3 more recent actions ...]

{Link to full log:}
Full execution log: `{TASK_DIR}/execution_log.md`

---

## Objective

{objective from plan.md}

## Phases

{List phases with completion indicators}

1. {Phase 1 name} {✓ if progress past this phase}
2. {Phase 2 name} {← Current if in this phase}
3. {Phase 3 name} {⏳ if upcoming}

## Success Criteria

{Show criteria from plan.md with completion status if available}

- [✓] {Completed criterion}
- [✓] {Completed criterion}
- [ ] {Remaining criterion}
- [ ] {Remaining criterion}

---

## Key Learnings ({count entries})

{Show recent 3-5 entries from knowledge_base.md}

### {Date} - {Topic}
{Brief summary}

### {Date} - {Topic}
{Brief summary}

[... more entries ...]

{Link to full knowledge base:}
Full knowledge base: `{TASK_DIR}/knowledge_base.md`

---

## Issues and Blockers

{If blocked:}
**Current Blocker**: {blocked_reason}

**Analysis**: {check knowledge_base.md for related entries}

**Attempted Solutions**: {from execution_log.md}

**Recommendation**: {suggest next steps}

{If not blocked:}
No current blockers or issues.

---

## Task Files

All task documentation:
```
{TASK_DIR}/
├── manifest.yaml         Task metadata
├── plan.md               Execution plan
├── execution_log.md      {count lines} lines of logs
├── knowledge_base.md     {count entries} knowledge entries
├── context.md            Background and constraints
└── status.yaml           Current state
```

---

## Quick Actions

{If active:}
- **Continue working**: `/teds-continue {TASK_ID}`
- **Create checkpoint**: `/teds-checkpoint {TASK_ID}`
- **Complete task**: `/teds-complete {TASK_ID}`

{If archived:}
- **View summary**: `cat {WORKSPACE}/knowledge_index/{TASK_ID}-summary.md`
- **View full archive**: `ls -la {TASK_DIR}/`

---

{If active and making good progress:}
💡 **Tip**: Task is {X}% complete. Keep up the momentum!

{If active and progress stalled:}
⏰ **Notice**: Last updated {time ago}. Consider resuming with `/teds-continue {TASK_ID}`

{If blocked:}
🔴 **Action Required**: Task blocked for {time}. Review blocker and take action.
```

### Progress Bar Rendering

Convert percentage to visual bar:
```bash
PROGRESS=65  # from status.yaml

# Calculate filled blocks (10 blocks total)
FILLED=$((PROGRESS / 10))
EMPTY=$((10 - FILLED))

# Create bar
BAR="["
for i in $(seq 1 $FILLED); do BAR="${BAR}▓"; done
for i in $(seq 1 $EMPTY); do BAR="${BAR}░"; done
BAR="${BAR}]"

echo "${PROGRESS}% ${BAR}"
# Output: 65% [▓▓▓▓▓▓░░░░]
```

## Time Calculations

### Time Ago

```bash
# Given timestamp: 2025-01-16T14:30:00+08:00
TIMESTAMP="..."

# Calculate seconds since
NOW=$(date +%s)
THEN=$(date -d "$TIMESTAMP" +%s 2>/dev/null || date -j -f "%Y-%m-%dT%H:%M:%S" "$TIMESTAMP" +%s)
SECONDS=$((NOW - THEN))

# Format
MINUTES=$((SECONDS / 60))
HOURS=$((SECONDS / 3600))
DAYS=$((SECONDS / 86400))

if [[ $MINUTES -lt 60 ]]; then
  echo "${MINUTES} minutes ago"
elif [[ $HOURS -lt 24 ]]; then
  echo "${HOURS} hours ago"
elif [[ $DAYS -lt 7 ]]; then
  echo "${DAYS} days ago"
elif [[ $DAYS -lt 30 ]]; then
  WEEKS=$((DAYS / 7))
  echo "${WEEKS} weeks ago"
else
  # Show date
  date -d "$TIMESTAMP" +"%Y-%m-%d"
fi
```

### Duration

```bash
# From created_at to now (active) or completed_at (archived)
START="..."
END="..."  # now or completed_at

START_SEC=$(date -d "$START" +%s)
END_SEC=$(date -d "$END" +%s)
DURATION=$((END_SEC - START_SEC))

MINUTES=$((DURATION / 60))
HOURS=$((DURATION / 3600))
DAYS=$((DURATION / 86400))

if [[ $HOURS -lt 1 ]]; then
  echo "${MINUTES} minutes"
elif [[ $HOURS -lt 24 ]]; then
  echo "${HOURS} hours"
else
  echo "${DAYS} days"
fi
```

## Counting Knowledge Entries

```bash
# Count sections starting with ### in knowledge_base.md
grep -c "^### " "${TASK_DIR}/knowledge_base.md"
```

## Disk Usage

```bash
du -sh "${WORKSPACE}"
# Output: 15M   claude_work_space/

# Or per section
du -sh "${WORKSPACE}/active_tasks"
du -sh "${WORKSPACE}/archived_tasks"
du -sh "${WORKSPACE}/knowledge_index"
```

## Error Handling

### Task Not Found

```
❌ Task not found: {provided_id}

Available active tasks:
{list active tasks with IDs and names}

Available archived tasks (recent):
{list recent 5 archived tasks}

Use:
- `/teds-status` to see all tasks
- `/teds-status [task-id]` with correct ID
```

### Workspace Issues

```
❌ Cannot access TEDS workspace: {WORKSPACE}

Possible issues:
- Workspace directory deleted or moved
- Permission problems
- Configuration error

Check:
1. Workspace exists: ls -la {WORKSPACE}
2. Configuration: {CLAUDE.md or .teds-config.yaml}
3. Re-initialize if needed: /teds-init
```

### Corrupted Task Data

```
⚠️  Task data incomplete: {TASK_ID}

Missing or unreadable files:
- {file 1}
- {file 2}

This task may be corrupted.

Options:
1. View what's available: ls -la {TASK_DIR}
2. Manually inspect: cat {TASK_DIR}/manifest.yaml
3. Archive if unsalvageable: mv {TASK_DIR} {WORKSPACE}/archived_tasks/

Need help deciding what to do?
```

## Sorting and Filtering

### Sort Active Tasks

**By Progress** (default):
- Show highest progress first (closest to completion)

**By Last Updated**:
- Most recently worked on first

**By Created Date**:
- Newest tasks first

Allow user preference if multiple tasks.

### Highlight Important States

- 🔴 **Blocked tasks**: Show with warning symbol
- ⚠️  **Stalled tasks**: Not updated in >7 days
- 🎯 **Near completion**: >90% progress
- 🆕 **New tasks**: Created <24 hours ago

## Summary Statistics

If showing all tasks, include useful stats:

```markdown
## Overview

**Active Work**:
- {X} tasks in progress
- Average progress: {Y}%
- {Z} blocked tasks

**Recent Activity**:
- Last updated: {most recent task update}
- Active today: {tasks updated in last 24h}
- Checkpoints created: {count from logs}

**Completions**:
- This week: {count}
- This month: {count}
- All time: {total archived}

**Knowledge Accumulated**:
- Total entries: {count}
- Unique topics: {estimate}
- Total documentation: {total size}
```

## Command Suggestions

Based on status, suggest relevant actions:

**If many active tasks**:
```
💡 You have {X} active tasks. Consider completing or archiving some to maintain focus.
```

**If tasks stalled**:
```
⏰ {X} task(s) haven't been updated in over a week:
- {task 1 name} (last updated {time ago})
- {task 2 name} (last updated {time ago})

Consider: `/teds-continue [task-id]` or archiving if no longer relevant.
```

**If blocked tasks**:
```
🔴 {X} task(s) are blocked:
- {task name}: {blocked_reason (brief)}

Action needed: Review and unblock with `/teds-continue [task-id]`
```

**If no active tasks**:
```
🚀 Ready to start a new long-term task?

Use: `/teds-start [name] "[description]"`

Example: `/teds-start refactor-auth "Migrate authentication to OAuth 2.0"`
```

## Important Notes

1. **Be concise for summaries**: Users scan quickly
2. **Be detailed for single task**: Users want full picture
3. **Highlight actionable items**: What should user do?
4. **Show progress visually**: Progress bars, checkmarks
5. **Calculate times accurately**: Users rely on timing info
6. **Handle missing data gracefully**: Files might be incomplete
7. **Suggest next steps**: Guide users to actions

## Performance Considerations

For workspaces with many tasks:
- Limit archived task display (show recent 10)
- Use file timestamps instead of parsing all YAMLs
- Cache workspace statistics
- Offer filtering options

```
Showing {X} most recent tasks. You have {Y} total archived tasks.

To see more: ls {WORKSPACE}/archived_tasks/
To search: grep "name" {WORKSPACE}/archived_tasks/*/manifest.yaml
```
