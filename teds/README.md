# TEDS Plugin

**Task Execution Documentation System (TEDS)** - A Claude Code plugin for comprehensive documentation of complex, multi-session tasks.

**Version**: 1.0.0
**Status**: Active Development
**Created**: 2025-10-16

---

## Overview

TEDS provides a systematic approach to managing long-term tasks that span multiple work sessions, require detailed tracking, and benefit from accumulated knowledge. It's designed for tasks that are too complex for simple todo lists but need structured documentation without excessive overhead.

### Key Features

- 📝 **Mandatory Logging**: Every action automatically logged
- 🔄 **Checkpoint & Resume**: Pause and resume work seamlessly
- 🧠 **Knowledge Accumulation**: Capture learnings and insights
- 📊 **Progress Tracking**: Clear status and progress visibility
- 🎯 **Phase Management**: Structured execution with defined phases
- 📦 **Task Archival**: Preserve completed work for future reference

---

## Why TEDS?

### Problems It Solves

**1. Context Continuity Loss**

When working on complex multi-day projects with Claude:
- Each conversation is a new session; previous context is lost
- You need to re-explain "what we're doing" and "where we left off"
- Claude cannot remember previous work details and decisions
- Picking up where you left off becomes a guessing game

**2. Knowledge Evaporation**

During problem-solving, you accumulate valuable insights:
- API gotchas and limitations ("Google OAuth requires exact redirect URI match")
- Best practices for certain patterns (token refresh strategies)
- Debugging discoveries (why certain approaches failed)
- Architecture decisions and trade-offs

But this valuable knowledge often **vanishes when the conversation ends**, preventing accumulation and reuse. You end up re-learning the same lessons repeatedly.

**3. Progress Opacity**

In complex tasks spanning multiple sessions, it's hard to answer:
- "Where am I now in the overall plan?"
- "How much work remains?"
- "Which steps are completed vs. in-progress?"
- "Where did I get blocked last time?"
- "What was I planning to do next?"

Without clear visibility, you waste time reconstructing the current state instead of making progress.

**4. Work Continuity Breaks**

Multi-day work often encounters:
- Forgetting previous thought processes and reasoning
- Repeating the same mistakes because failures weren't documented
- Not remembering previously attempted solutions
- Lack of complete decision records (why choice A over choice B?)
- Lost momentum between sessions

**5. Incomplete Audit Trail**

For significant changes (migrations, refactors, major features):
- No record of what actually happened
- Can't reconstruct decision timeline
- Difficult to onboard others to the work
- Hard to debug issues months later ("why did we do it this way?")

### TEDS Solutions

**1. Complete Context Preservation**
- **execution_log.md**: Records every operation and result with timestamps
- **status.yaml**: Tracks current phase, progress, and next action
- **context.md**: Preserves background information and constraints
- **plan.md**: Maintains the overall strategy and success criteria
- Enables full context loading when resuming work after days or weeks

**2. Systematic Knowledge Accumulation**
- **knowledge_base.md**: Automatically captures all discoveries and learnings
- Organized sections: Key Learnings, Solutions, References, Best Practices, Gotchas
- Records not just what worked, but what didn't and why
- Builds searchable, reusable knowledge base
- Provides reference for similar future tasks
- Creates organizational knowledge assets over time

**3. Transparent Progress Management**
- **plan.md**: Defines phases, milestones, success criteria upfront
- **status.yaml**: Real-time updates of progress percentage and current phase
- **Checkpoint mechanism**: Automatically creates checkpoints every 30+ minutes
- **Execution log**: Complete history of what's been done
- Visualize task progress at any time with `/teds-status`

**4. Mandatory Documentation Protocol**

TEDS's core innovation is the **Mandatory Logging Protocol**:

```
After EVERY action (Read/Write/Edit/Bash/any tool use), immediately:

1. Append to execution_log.md:
   - What operation was performed
   - What the result was
   - Status (success/failed/partial)

2. Update status.yaml when state changes

3. Add to knowledge_base.md when discovering insights

Self-Check Protocol:
Before responding to user:
- [ ] Did I log this action to execution_log.md?
- [ ] Did I update status.yaml if state changed?
- [ ] Is there new knowledge for knowledge_base.md?

If ANY checkbox is unchecked, DO NOT respond yet.
```

This isn't based on developer discipline or manual reminders, but **enforced through the agent's self-check protocol**. The agent literally won't respond until logging is complete.

**5. Complete Audit Trail**

Every task maintains a complete, timestamped record:
- What was planned (plan.md)
- What actually happened (execution_log.md)
- What was learned (knowledge_base.md)
- Why it was done (context.md)
- Current state at any point (status.yaml)

This creates accountability and traceability for significant work.

### Core Value

TEDS essentially brings **scientific lab notebook** practices into AI-assisted programming:

> "If it isn't documented, it didn't happen"

It ensures all work processes, decisions, and learnings are systematically preserved, enabling future you (or other developers) to:
1. **Understand why**: Complete decision history and reasoning
2. **Reuse solutions**: Searchable knowledge base of what worked
3. **Avoid repeating mistakes**: Documented failures and gotchas
4. **Resume seamlessly**: Full context restoration across sessions
5. **Build knowledge assets**: Organizational learning that compounds over time

### When to Use TEDS

✅ **Use TEDS for**:
- Multi-session projects (>3 hours across multiple days)
- Complex refactoring or migrations
- Significant feature implementations
- Exploratory work with learnings
- Complex bug investigations
- Work that needs complete audit trail

❌ **Skip TEDS for**:
- Simple bug fixes (< 1 hour)
- Single-file edits
- Routine maintenance
- One-off scripts

**Rule of thumb**: If you'll thank yourself next week for having a complete record, use TEDS.

---

## Plugin Structure

```
teds-plugin/
├── .claude-plugin/
│   └── plugin.json                # Plugin metadata
├── teds-core-prompt.md           # Core TEDS system documentation
├── commands/                      # Slash commands (6 commands)
│   ├── teds-init.md              # Initialize TEDS configuration
│   ├── teds-start.md             # Start new task
│   ├── teds-continue.md          # Resume existing task
│   ├── teds-checkpoint.md        # Create checkpoint
│   ├── teds-status.md            # View task status
│   └── teds-complete.md          # Complete and archive task
├── agents/                        # Specialized agents (5 agents)
│   ├── teds-config.md            # Configuration management
│   ├── teds-initializer.md       # Task initialization
│   ├── teds-executor.md          # Task execution with logging
│   ├── teds-status.md            # Status reporting
│   └── teds-archiver.md          # Task completion and archival
└── README.md                      # This file
```

---

## Installation

### Local Development

For testing during development:

```bash
# 1. Create test marketplace
mkdir test-marketplace
cd test-marketplace
mkdir -p .claude-plugin

# 2. Create marketplace.json
cat > .claude-plugin/marketplace.json << 'EOF'
{
  "name": "test-marketplace",
  "owner": {"name": "Frank Wang"},
  "plugins": [
    {
      "name": "teds-plugin",
      "source": "./teds-plugin",
      "description": "TEDS - Task Execution Documentation System"
    }
  ]
}
EOF

# 3. Link or copy teds-plugin directory
ln -s /path/to/teds-plugin ./teds-plugin

# 4. Install in Claude Code
claude
/plugin marketplace add ./test-marketplace
/plugin install teds-plugin@test-marketplace
```

### Production Installation

(Once published to a marketplace)

```bash
claude
/plugin marketplace add eternnoir/claude-tool
/plugin install teds-plugin
```

---

## Quick Start

### 1. Initialize TEDS in Your Project

```bash
cd your-project/
claude
/teds-init
```

This will:
- Prompt for workspace directory name (default: `claude_work_space`)
- Offer to integrate with CLAUDE.md (if exists)
- Create directory structure
- Save configuration

### 2. Start Your First Task

```bash
/teds-start refactor-auth "Migrate authentication system to OAuth 2.0"
```

The initializer agent will:
- Create task structure with unique ID
- Initialize all documentation files
- Guide you through planning (phases, success criteria)
- Begin execution tracking

### 3. Work on the Task

Simply continue working. The executor agent will:
- Log every action automatically
- Update status as you progress
- Capture learnings in knowledge base
- Create checkpoints every 30+ minutes

### 4. Resume Later

```bash
/teds-status                      # See all tasks
/teds-continue 20250116-1430-refactor-auth
```

The agent loads all context and resumes where you left off.

### 5. Complete the Task

```bash
/teds-complete 20250116-1430-refactor-auth
```

The archiver agent will:
- Verify completion criteria
- Finalize documentation
- Extract knowledge summary
- Archive for future reference

---

## Commands Reference

### `/teds-init`
Initialize TEDS configuration for the current project.
- Run once per project
- Choose workspace name
- Optionally integrate with CLAUDE.md

### `/teds-start [name] "[description]"`
Start a new long-term task.
- Generates unique task ID
- Creates complete documentation structure
- Begins planning phase

### `/teds-continue [task-id]`
Resume work on an existing task.
- Loads full context
- Shows recent progress
- Continues with automatic logging

### `/teds-checkpoint [task-id]`
Create an immediate checkpoint.
- Safe pause point
- Captures current state
- Updates progress summary

### `/teds-status [task-id]`
View task status.
- Without ID: Shows all tasks
- With ID: Detailed single task view
- Includes progress, blockers, recent activity

### `/teds-complete [task-id]`
Complete and archive a task.
- Verifies completion criteria
- Extracts knowledge summary
- Moves to archived_tasks/
- Preserves all documentation

---

## Architecture

### Core Concept: Agents

TEDS uses specialized agents for each operation:

**teds-config**: Handles initial setup and configuration
- Reads plugin's core prompt
- Copies configuration to CLAUDE.md or creates .teds-config.yaml
- Creates workspace structure

**teds-initializer**: Creates new tasks
- Generates unique task ID
- Initializes all documentation files
- Guides user through planning

**teds-executor**: Main execution engine
- **Mandatory logging protocol**: Logs every action
- Continuous status updates
- Knowledge capture
- Checkpoint creation

**teds-status**: Status reporting
- Summary of all tasks
- Detailed single task view
- Progress visualization

**teds-archiver**: Task completion
- Completion verification
- Knowledge extraction
- Archival and indexing

### Mandatory Logging

The core innovation of TEDS is **mandatory logging**. The executor agent is designed with a self-check protocol that ensures every action is logged before proceeding.

**Self-Check Protocol**:
```
Before responding to user after each action:
- [ ] Did I log this action to execution_log.md?
- [ ] Did I update status.yaml if state changed?
- [ ] Is there new knowledge for knowledge_base.md?

If ANY checkbox is unchecked, DO NOT respond yet.
```

This ensures comprehensive documentation without relying on user reminders.

### Task Documentation Structure

Each task maintains complete documentation:

```
workspace/active_tasks/YYYYMMDD-HHMM-taskname/
├── manifest.yaml           # Task metadata
├── plan.md                 # Execution plan, phases, success criteria
├── execution_log.md        # Complete action history
├── knowledge_base.md       # Learnings and discoveries
├── context.md              # Background and constraints
└── status.yaml             # Current state (phase, progress, next action)
```

---

## Configuration

### CLAUDE.md Integration

When you choose to integrate with CLAUDE.md, TEDS adds:

```markdown
## TEDS Configuration

**Workspace Directory**: `claude_work_space`
**Plugin Version**: v1.0.0

### Core TEDS System Prompt

<details>
<summary><b>Core System Prompt</b></summary>

[Full core prompt content]

</details>

### Project-Specific Extensions

[Customize TEDS behavior here]
```

### Standalone Configuration

If using standalone mode, creates `.teds-config.yaml`:

```yaml
version: 1.2.0
workspace:
  path: claude_work_space

customization:
  phases: []
  checkpoint_interval: 30

integration:
  claude_md: false
```

---

## Use Cases

### Ideal For

✅ **Multi-session projects**: Work that spans days or weeks
✅ **Complex refactoring**: Large codebase changes
✅ **Feature implementation**: Significant new features
✅ **Migration projects**: Database, framework, or system migrations
✅ **Research & development**: Exploratory work with learnings
✅ **Bug investigation**: Complex bugs requiring multiple approaches

### Not Ideal For

❌ Simple bug fixes (< 1 hour)
❌ Single-file edits
❌ Routine maintenance tasks
❌ One-off scripts

**Rule of thumb**: If the task requires >3 hours across multiple sessions, use TEDS.

---

## Examples

### Example 1: OAuth Migration

```bash
# Start task
/teds-start migrate-oauth "Migrate from session-based auth to OAuth 2.0"

# Agent guides through planning:
# - Phase 1: Research OAuth providers
# - Phase 2: Implement Google OAuth
# - Phase 3: Implement GitHub OAuth
# - Phase 4: Migration strategy
# - Success criteria defined

# Work session 1 (Monday)
# - Research OAuth flows
# - Document in context.md
# - Begin Google OAuth implementation
# - Agent logs 15 actions
# - Checkpoint created after 45 minutes

# Resume session 2 (Tuesday)
/teds-continue 20250113-0900-migrate-oauth
# - Agent shows: Last session: 1 day ago, Progress: 30%
# - Continue Google OAuth
# - Complete and test
# - Knowledge: "Google requires exact redirect URI match"

# Resume session 3 (Wednesday)
/teds-continue 20250113-0900-migrate-oauth
# - Implement GitHub OAuth
# - Apply learnings from Google implementation
# - Complete both providers
# - Progress: 85%

# Final session (Thursday)
/teds-continue 20250113-0900-migrate-oauth
# - Migration strategy and testing
# - Documentation updates
# - Complete

/teds-complete 20250113-0900-migrate-oauth
# Knowledge preserved:
# - OAuth redirect URI gotchas
# - Token refresh patterns
# - Testing strategies
# - 47 actions logged over 4 days
```

### Example 2: Database Migration

```bash
/teds-start migrate-db "Migrate from MySQL to PostgreSQL"

# Phases defined:
# 1. Schema analysis and conversion
# 2. Data migration strategy
# 3. Application code updates
# 4. Testing and validation

# Multi-week task with:
# - Daily work sessions
# - Automatic checkpoints
# - Progress tracking
# - Knowledge accumulation about PostgreSQL differences
# - Solutions to migration challenges documented

# Result:
# - Complete migration history
# - PostgreSQL migration guide for future
# - Reusable patterns extracted
```

---

## Development

### Testing the Plugin

1. **Create test project**:
   ```bash
   mkdir test-project
   cd test-project
   claude
   ```

2. **Initialize TEDS**:
   ```bash
   /teds-init
   # Choose workspace name
   # Test configuration creation
   ```

3. **Test task lifecycle**:
   ```bash
   # Start task
   /teds-start test-task "Test TEDS functionality"

   # Verify files created
   ls -la claude_work_space/active_tasks/*/

   # Continue task
   /teds-continue [task-id]

   # Check status
   /teds-status

   # Complete task
   /teds-complete [task-id]

   # Verify archival
   ls -la claude_work_space/archived_tasks/*/
   ```

4. **Test edge cases**:
   - Blocked task scenarios
   - Incomplete success criteria
   - Multiple active tasks
   - Checkpoint timing
   - Knowledge capture

### Debugging

**Check configuration**:
```bash
# CLAUDE.md integration
grep -A 20 "## TEDS Configuration" CLAUDE.md

# Standalone
cat .teds-config.yaml
```

**Check workspace structure**:
```bash
tree claude_work_space/
```

**Check task documentation**:
```bash
TASK_ID="[your-task-id]"
cat claude_work_space/active_tasks/$TASK_ID/status.yaml
tail -50 claude_work_space/active_tasks/$TASK_ID/execution_log.md
```

### Iteration Workflow

After making changes to the plugin:

```bash
# Uninstall current version
/plugin uninstall teds-plugin@test-marketplace

# Reinstall to pick up changes
/plugin install teds-plugin@test-marketplace

# Or restart Claude Code to reload
```

---

## Design Decisions

### Why Agent-Based?

Agents provide the best balance of:
- **Flexibility**: Easy to customize behavior via prompts
- **Transparency**: Users can read and understand agent logic
- **Maintainability**: Pure markdown, no code to debug
- **Integration**: Works within Claude Code's existing architecture

### Why Not MCP?

MCP tools would provide stronger enforcement of logging, but:
- Adds complexity (requires Node.js server)
- Harder to develop and test
- More dependencies to manage
- Agent prompts with self-check protocol proved sufficient

### Why Mandatory Logging?

The key insight: **The value of TEDS is in the complete documentation trail**.

Without mandatory logging:
- Gaps in execution history
- Lost context on resume
- Incomplete knowledge capture
- Defeats the purpose of TEDS

The self-check protocol ensures logging happens without requiring user reminders.

### File Format Choices

- **YAML**: Structured data (manifest, status) - easy to parse
- **Markdown**: Documentation (plan, log, knowledge) - human-readable
- **Timestamps**: ISO 8601 - unambiguous, sortable

---

## Future Enhancements

### Planned Features

- **Task templates**: Pre-defined plans for common task types
- **Task dependencies**: Link related tasks
- **Time tracking**: Automatic work session duration
- **Metrics**: Velocity, success rate, knowledge density
- **Search**: Query across task history and knowledge
- **Export**: Generate reports from task data

### Integration Ideas

- **AkashicRecords integration**: Update README.md files automatically
- **Git integration**: Commit message templates from execution log
- **Issue tracker sync**: Update tickets from task progress
- **Calendar integration**: Schedule checkpoints and milestones

### Community Contributions

Ideas welcome! Focus areas:
- Additional agent behaviors
- Template library
- Visualization tools
- Integration with other systems

---

## Troubleshooting

### Common Issues

**"TEDS not initialized"**
```bash
# Run initialization
/teds-init
```

**"Task not found"**
```bash
# Check available tasks
/teds-status

# Use correct task ID
/teds-continue [full-task-id]
```

**"Cannot access workspace"**
```bash
# Check workspace exists
ls -la claude_work_space/

# Check configuration
grep "Workspace Directory" CLAUDE.md
# or
cat .teds-config.yaml
```

**"Logging not happening"**
- This shouldn't occur if using teds-executor agent properly
- Check that you're using `/teds-continue` not just continuing manually
- Executor agent has built-in self-check protocol

### Getting Help

1. Check this README
2. Review command documentation in `commands/`
3. Check agent logic in `agents/`
4. Open an issue on GitHub

---

## Contributing

### Development Setup

1. Fork the repository
2. Create feature branch
3. Make changes
4. Test thoroughly with local marketplace
5. Submit pull request

### Code Style

- **Commands**: Clear, concise user documentation
- **Agents**: Detailed operational instructions
- **Core prompt**: System-level documentation
- All markdown files should be well-formatted

### Testing Checklist

- [ ] Configuration works (both CLAUDE.md and standalone)
- [ ] All commands execute without errors
- [ ] Task lifecycle complete (init → start → continue → complete)
- [ ] Logging happens after every action
- [ ] Checkpoints created automatically
- [ ] Knowledge captured appropriately
- [ ] Status displays correctly
- [ ] Archival preserves all data

---

## License

MIT License - See LICENSE file for details

---

## Acknowledgments

Inspired by:
- **GTD (Getting Things Done)**: Project management philosophy
- **Lab notebooks**: Scientific documentation practices
- **Event sourcing**: Complete audit trail concept
- **JARVIS/TARS**: AI assistants with personality and independence

Built for the **AkashicRecords** knowledge management system.

---

## Version History

### v1.0.0 (2025-10-16)
- Initial release
- 6 commands, 5 agents
- Complete task lifecycle support
- Mandatory logging protocol
- Knowledge base accumulation
- Checkpoint & resume functionality

---

**Author**: eternnoir
**Email**: eternnoir@gmail.com
**Repository**: https://github.com/eternnoir/claude-tool
**Documentation**: This README

---

## Related Resources

- [Claude Code Documentation](https://docs.claude.com/claude-code)
- [Plugin Development Guide](https://docs.claude.com/claude-code/plugins)
- [Slash Commands Reference](https://docs.claude.com/claude-code/slash-commands)
- [Agents Documentation](https://docs.claude.com/claude-code/sub-agents)

---

**Ready to start?**

```bash
/teds-init
```

Let TEDS help you manage your next complex, long-term task! 🚀
