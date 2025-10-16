---
description: View status of TEDS tasks
---

# View TEDS Task Status

Launch the **teds-status** agent to display comprehensive status of your TEDS tasks.

## Usage

```bash
# View all tasks
/teds-status

# View specific task details
/teds-status task-id
```

## Examples

```bash
# List all active tasks
/teds-status

# Detailed status for one task
/teds-status 20250116-1430-refactor-auth
```

## All Tasks View

When called without arguments, shows summary of all tasks:

```
# TEDS Tasks Status

## Active Tasks (2)

ID                          | Name              | Phase          | Progress | Status
----------------------------|-------------------|----------------|----------|--------
20250116-1430-refactor-auth | refactor-auth     | Implementation | 45%      | active
20250115-0920-migrate-db    | migrate-database  | Testing        | 78%      | active

## Recently Completed (1)

ID                          | Name              | Completed       | Duration
----------------------------|-------------------|-----------------|----------
20250114-1100-update-deps   | update-deps       | 2 hours ago     | 3.5 hours

Run `/teds-status [task-id]` for detailed information.
```

## Single Task View

When called with a task ID, shows detailed status:

```
# Task Status: refactor-auth

**ID**: 20250116-1430-refactor-auth
**Status**: Active (not blocked)
**Phase**: Phase 2 - Implementation
**Progress**: 45%
**Created**: 2025-01-16 14:30
**Last Updated**: 2 minutes ago
**Last Checkpoint**: 45 minutes ago

## Next Action

Implement OAuth flow integration with Google provider

## Recent Activity (Last 5 actions)

### 16:45 - File Edit
- Tool: Edit
- Target: src/auth/AuthService.ts
- Result: Added OAuth configuration interface
- Status: success

### 16:42 - File Creation
- Tool: Write
- Target: src/auth/OAuthProvider.ts
- Result: Created OAuth provider abstract class
- Status: success

### 16:38 - Read Documentation
- Tool: Read
- Target: docs/oauth-spec.md
- Result: Reviewed OAuth 2.0 specification
- Status: success

[... 2 more recent actions ...]

## Key Learnings

- Google OAuth requires web credentials, not service account
- Need to handle refresh token expiration gracefully
- PKCE extension recommended for enhanced security

## Issues

None - task is progressing normally

---

Continue: `/teds-continue 20250116-1430-refactor-auth`
Checkpoint: `/teds-checkpoint 20250116-1430-refactor-auth`
Complete: `/teds-complete 20250116-1430-refactor-auth`
```

## Status Indicators

### Task Status
- **Active**: Task is progressing normally
- **Blocked**: Task encountered an issue (shows reason)
- **Completed**: Task finished and archived

### Progress Indicators
- **0-25%**: Early stages / Planning
- **26-50%**: Active implementation
- **51-75%**: Main work done, refinements ongoing
- **76-99%**: Final touches, testing, documentation
- **100%**: Ready to complete

### Blocked Status

If a task shows `blocked: true`, the status will include:
```
⚠️  Status: BLOCKED

Blocked Reason: Cannot connect to production database for migration testing

Last Attempted: 30 minutes ago
Proposed Solution: Set up staging database mirror

Action Required: User decision on staging environment setup
```

## Workspace Information

The status view also shows:
```
Workspace: claude_work_space/
Active Tasks: 2
Archived Tasks: 15
Total Knowledge Entries: 47
```

## Using Status for Task Management

**Daily workflow**:
1. Morning: `/teds-status` to see all active tasks
2. Choose task: `/teds-continue [task-id]`
3. Work with continuous logging
4. Check progress: `/teds-status [task-id]`
5. End of day: `/teds-checkpoint`

**Weekly review**:
- Review all active tasks
- Identify blocked tasks
- Archive completed tasks
- Extract learnings

## Related Commands

- `/teds-start [name]` - Start new task
- `/teds-continue [task-id]` - Resume task
- `/teds-checkpoint` - Save current progress
- `/teds-complete [task-id]` - Archive task
