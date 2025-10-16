---
description: Complete and archive a TEDS task
---

# Complete TEDS Task

Launch the **teds-archiver** agent to complete and archive a finished TEDS task.

## Usage

```bash
/teds-complete task-id
```

## Examples

```bash
# Complete a specific task
/teds-complete 20250116-1430-refactor-auth

# List tasks first, then complete
/teds-status
/teds-complete 20250115-0920-migrate-db
```

## What This Does

The archiver agent will:
1. **Verify completion** against success criteria in `plan.md`
2. **Ask for confirmation** if any criteria are incomplete
3. **Finalize documentation**:
   - Add completion entry to `execution_log.md`
   - Update `status.yaml`: set status to "completed"
   - Summarize all learnings in `knowledge_base.md`
   - Set completion timestamp in `manifest.yaml`
4. **Extract knowledge**:
   - Create summary document in `knowledge_index/[task-id]-summary.md`
   - Include: objectives, approach, learnings, outcomes
5. **Archive task**:
   - Move from `active_tasks/` to `archived_tasks/`
   - Preserve complete directory structure
6. **Update tracking**:
   - Add entry to workspace task history

## Verification Process

Before archiving, the agent checks:

```
Reviewing task completion...

Success Criteria (from plan.md):
✅ All OAuth providers integrated (Google, GitHub)
✅ Tests passing with >90% coverage
✅ Documentation updated
⚠️  Performance benchmarks not run

Incomplete: 1 criterion

Options:
1. Complete anyway (mark as acceptable)
2. Continue task to finish remaining work
3. Cancel and return to task

Choose [1/2/3]:
```

## Completion Report

After successful archival:

```
# Task Completed: refactor-auth

**Task ID**: 20250116-1430-refactor-auth
**Duration**: 2025-01-16 14:30 to 2025-01-18 16:45
**Total Time**: ~12 hours over 2 days
**Status**: Successfully completed

## Key Outcomes

✅ OAuth 2.0 authentication fully implemented
✅ Google and GitHub providers integrated
✅ Comprehensive test suite (94% coverage)
✅ Documentation complete with examples
✅ Migration guide for existing users

## Key Learnings

1. **Google OAuth Setup**
   - Requires web credentials, not service account
   - Redirect URIs must match exactly (including trailing slash)

2. **Token Management**
   - Refresh tokens expire after 6 months if unused
   - Implemented automatic refresh 5 minutes before expiration

3. **Security Considerations**
   - PKCE extension essential for public clients
   - State parameter prevents CSRF attacks

4. **Testing Insights**
   - Mock OAuth providers for unit tests
   - Integration tests need real credentials (use staging)

## Statistics

- **Files Modified**: 23
- **Tests Added**: 47
- **Documentation Pages**: 8
- **Checkpoints Created**: 6
- **Knowledge Entries**: 12

## Files Archived

- **Location**: claude_work_space/archived_tasks/20250116-1430-refactor-auth/
- **Summary**: claude_work_space/knowledge_index/20250116-1430-refactor-auth-summary.md

## Reusable Components

The following patterns can be applied to future tasks:
- OAuth provider abstract class design
- Token refresh mechanism
- Integration testing strategy

---

Task successfully archived. Knowledge preserved for future reference.
```

## Archived Task Structure

Completed tasks maintain full structure:

```
archived_tasks/20250116-1430-refactor-auth/
├── manifest.yaml          # Includes completion timestamp
├── plan.md                # Original plan with all criteria
├── execution_log.md       # Complete action history
├── knowledge_base.md      # All learnings
├── context.md             # Background preserved
└── status.yaml            # Final status: completed
```

## Knowledge Index

The summary in `knowledge_index/` provides quick reference:

```markdown
# Task Summary: refactor-auth

**Completed**: 2025-01-18
**Duration**: 12 hours over 2 days

## Quick Reference

**Objective**: Implement OAuth 2.0 authentication with Google and GitHub

**Approach**:
- Abstract provider pattern
- Separate token management service
- Comprehensive test coverage

**Key Learnings**: [3-5 most important insights]

**Outcomes**: [What was delivered]

**For Future Tasks**: [Reusable patterns and approaches]

Full details: ../archived_tasks/20250116-1430-refactor-auth/
```

## When to Complete a Task

**Good times to complete**:
- ✅ All success criteria met
- ✅ Documentation complete
- ✅ Tests passing
- ✅ No known issues
- ✅ Ready for handoff or deployment

**Consider continuing if**:
- ⚠️  Critical criteria not met
- ⚠️  Tests failing
- ⚠️  Blockers unresolved
- ⚠️  Documentation incomplete

You can always archive with incomplete criteria if you explicitly accept them, but the agent will prompt for confirmation.

## Accessing Archived Tasks

Archived tasks remain fully accessible:

```bash
# View archived task
cd workspace/archived_tasks/20250116-1430-refactor-auth
cat execution_log.md

# Quick summary
cat workspace/knowledge_index/20250116-1430-refactor-auth-summary.md
```

## Related Commands

- `/teds-status` - View all tasks including archived
- `/teds-start [name]` - Start new task (potentially reusing patterns)
- `/teds-continue [task-id]` - Resume if you need to reopen
