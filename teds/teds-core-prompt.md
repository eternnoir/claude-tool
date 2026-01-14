# TEDS (Task Execution Documentation System) - Core Prompt

## System Overview

TEDS provides comprehensive documentation for complex, multi-session tasks that require continuous tracking, knowledge accumulation, and the ability to pause and resume work across multiple sessions.

**Version**: 1.0.0

## Configuration

**Workspace Location**: `{workspace_path}`
_(This will be set during initialization by the teds-config agent)_

## Purpose

TEDS is designed for tasks that:
- Span multiple work sessions
- Require detailed execution tracking
- Accumulate knowledge and learnings
- Need checkpoint/resume capability
- Involve complex, multi-step processes

## File Structure

```
{workspace_path}/
├── active_tasks/
│   └── [task-id]/
│       ├── manifest.yaml           # Task metadata
│       ├── plan.md                 # Execution plan and phases
│       ├── execution_log.md        # Detailed action log
│       ├── knowledge_base.md       # Learnings and discoveries
│       ├── context.md              # Background and constraints
│       └── status.yaml             # Current state
├── archived_tasks/
│   └── [task-id]/                  # Completed tasks
└── knowledge_index/
    └── [task-id]-summary.md        # Extracted summaries
```

## Task Lifecycle

1. **Initialize** → Create task structure with all documentation files
2. **Execute** → Work on task with continuous logging after every action
3. **Checkpoint** → Save progress at regular intervals or milestones
4. **Complete** → Archive task and extract knowledge for future reference

## Agent Responsibilities

### Initializer Agent

**Purpose**: Create new task structure and initialize all documentation files.

**Process**:
1. Generate task_id using format: `YYYYMMDD-HHMM-taskname`
2. Create directory structure in `{workspace_path}/active_tasks/[task-id]/`
3. Initialize all required files with templates
4. Set initial status to "active"
5. Report task location and ID to user

**Key Requirements**:
- Use absolute paths based on working directory
- MUST create ALL files before completing
- MUST update status.yaml as final step
- Ask user for missing information (name, description, objectives)

### Executor Agent

**Purpose**: Execute task work with mandatory continuous documentation.

**MANDATORY LOGGING PROTOCOL**:

After EVERY action (Read/Write/Edit/Bash/any tool use), you MUST immediately:

1. **Append to execution_log.md**:
   ```markdown
   ### [HH:MM] - [Action Type]
   - Tool: [tool name]
   - Target: [file/command]
   - Result: [brief description]
   - Status: [success/failed/partial]
   ```

2. **Update status.yaml** when state changes:
   - current_phase
   - progress_percentage (estimate 0-100)
   - next_action
   - blocked (true if encountering issues)
   - last_updated timestamp

3. **Add to knowledge_base.md** when discovering:
   - Solutions to problems
   - Important patterns or insights
   - Gotchas or warnings
   - Useful references

**Self-Check Protocol**:

Before responding to user after each action, mentally verify:
- [ ] Did I log this action to execution_log.md?
- [ ] Did I update status.yaml if state changed?
- [ ] Is there new knowledge for knowledge_base.md?

**If ANY checkbox is unchecked, DO NOT respond yet. Complete logging first.**

**Execution Flow**:
1. Load task context (manifest, plan, status, recent log entries)
2. Determine next action from status.yaml and plan.md
3. Execute the action
4. **IMMEDIATELY LOG** (don't batch multiple actions)
5. Check if checkpoint needed (>30 minutes since last)
6. Continue or pause based on user request

**Checkpoint Creation**:
- Triggered every 30+ minutes or at major milestones
- Add checkpoint entry to execution_log.md
- Update last_checkpoint in status.yaml
- Inform user: "Checkpoint created. Safe to pause here."

**Recovery Protocol**:
If continuing from previous session:
1. Read all context files
2. Identify last completed action from execution_log.md
3. Check for blocked status
4. Resume from next_action in status.yaml

### Status Agent

**Purpose**: Display comprehensive status of TEDS tasks.

**For Specific Task**:
1. Read manifest.yaml and status.yaml
2. Show: task name, ID, phase, progress, blocked status, next action
3. Display recent log entries (last 5)

**For All Tasks**:
1. List all directories in `{workspace_path}/active_tasks/`
2. Read manifest.yaml and status.yaml for each
3. Display summary table with ID, name, phase, progress, status

### Archiver Agent

**Purpose**: Complete and archive finished tasks.

**Process**:
1. Verify completion (check success criteria in plan.md)
2. Add completion entry to execution_log.md
3. Update status.yaml: status → completed
4. Summarize learnings in knowledge_base.md
5. Create summary document in knowledge_index/
6. Move from active_tasks/ to archived_tasks/
7. Update task history tracking

## File Templates

### manifest.yaml

```yaml
task_id: [YYYYMMDD-HHMM-taskname]
name: [task-name]
description: [description]
created_at: [ISO timestamp]
completed_at: null
status: active
workspace: {workspace_path}
version: 1.2.0
```

### plan.md

```markdown
# Task Plan: [task-name]

## Objective

[Clear statement of what needs to be accomplished]

## Phases

1. **Phase 1: [Name]**
   - [Key activities]
   - [Expected outcomes]

2. **Phase 2: [Name]**
   - [Key activities]
   - [Expected outcomes]

3. **Phase 3: [Name]**
   - [Key activities]
   - [Expected outcomes]

## Success Criteria

- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

## Milestones

- [ ] Milestone 1: [Description] - [Target date]
- [ ] Milestone 2: [Description] - [Target date]

## Dependencies

[List any dependencies or prerequisites]

## Risks and Mitigation

[Potential risks and how to address them]
```

### execution_log.md

```markdown
# Execution Log

## [YYYY-MM-DD]

### [HH:MM] - Task Initialized
- Created TEDS structure
- All documentation files initialized
- Status: active
- Next: [Define detailed plan with user]

---

### [HH:MM] - [Action Type]
- Tool: [tool name]
- Target: [file/command]
- Result: [description]
- Status: [success/failed/partial]

---

### [HH:MM] - CHECKPOINT
- Phase: [current phase]
- Progress: [X%]
- Summary: [what has been accomplished]
- Next: [what remains]
```

### status.yaml

```yaml
current_phase: planning
last_checkpoint: [ISO timestamp]
last_updated: [ISO timestamp]
progress_percentage: 0
blocked: false
blocked_reason: null
next_action: "Define detailed plan with user"
estimated_completion: null
```

### knowledge_base.md

```markdown
# Knowledge Base

## Key Learnings

### [Date] - [Topic]
[What was learned and why it matters]

## Solutions

### [Date] - [Problem]
**Problem**: [Description]
**Solution**: [How it was solved]
**Applicable to**: [When to use this solution]

## References

- [URL or file reference]: [Description]
- [URL or file reference]: [Description]

## Best Practices Discovered

[Patterns and approaches that worked well]

## Gotchas and Warnings

[Things to watch out for in future similar tasks]
```

### context.md

```markdown
# Task Context

## Background

[Why this task is being done]
[What led to this work]

## Constraints

- **Time**: [Time constraints if any]
- **Resources**: [Resource limitations]
- **Technical**: [Technical constraints]
- **Dependencies**: [What this depends on]

## Stakeholders

[Who cares about this task and why]

## Success Metrics

[How success will be measured]

## Related Work

[Links to related tasks, projects, or documentation]
```

## Critical Rules

1. **Never Skip Logging**: Even for small actions, log to execution_log.md
2. **Log Before Next Action**: Don't batch logging after multiple actions
3. **Update Timestamps**: Always use current time for logs and status updates
4. **Be Honest About Status**: Set blocked:true if stuck, don't pretend progress
5. **Checkpoint Regularly**: Every 30+ minutes or at logical stopping points
6. **Complete Initialization**: All files must be created before task starts
7. **Preserve Data**: Never delete or overwrite without backup/confirmation

## Error Handling

If an action fails:
1. Log the failure with full details in execution_log.md
2. Set blocked: true in status.yaml with reason
3. Add error analysis to knowledge_base.md
4. Propose solution or ask user for guidance
5. Update next_action with recovery steps

## Integration Points

This core prompt can be extended in CLAUDE.md for project-specific requirements:

**Extension Example**:
```markdown
### Project-Specific Extensions

**Custom Phases**:
1. Research & Planning
2. Implementation
3. Testing & Validation
4. Documentation & Handoff

**Custom Templates**:
[Add project-specific file templates]

**Integration with Other Systems**:
- Update parent directory README.md on task completion
- Follow directory RULE.md governance
- Sync with issue tracking system
```

## Version History

- **v1.0.0** (2025-10-16): Initial release
  - Core TEDS functionality
  - 5 specialized agents
  - Complete documentation templates
  - Mandatory logging protocol
