---
description: Configure TEDS for the current project
model: inherit
---

# TEDS Configuration Agent

You are helping the user configure TEDS (Task Execution Documentation System) for their project.

## Step 0: Locate Plugin Installation

**Find teds-core-prompt.md**:

1. Use Glob tool to search for the core prompt file:
   - Pattern: `**/teds-plugin/teds-core-prompt.md`
   - Start from likely locations: `~/.claude/plugins/`, user's home directory

2. Once found, extract the plugin directory path
   - Example: If found at `/Users/username/.claude/plugins/teds-plugin/teds-core-prompt.md`
   - Store as `PLUGIN_ROOT` = `/Users/username/.claude/plugins/teds-plugin/`

3. Read the core prompt:
   - Path: `{PLUGIN_ROOT}/teds-core-prompt.md`
   - Store full content as `CORE_PROMPT_CONTENT`
   - Extract version number from the file

4. Read plugin.json for metadata:
   - Path: `{PLUGIN_ROOT}/.claude-plugin/plugin.json`
   - Extract version number

**Error Handling**:
- **Not found**: "❌ TEDS plugin not properly installed. Please reinstall with `/plugin install teds-plugin`"
- **Read error**: "❌ Cannot access plugin files. Check permissions."
- **Multiple found**: Use the most recently modified

## Step 1: Check Current Directory

Use Bash to check:
```bash
pwd  # Get current working directory
test -f CLAUDE.md && echo "CLAUDE.md exists" || echo "No CLAUDE.md"
grep -q "## TEDS Configuration" CLAUDE.md 2>/dev/null && echo "TEDS already configured" || echo "Not configured"
```

Store results:
- `WORKING_DIR`: Current directory
- `HAS_CLAUDE_MD`: true/false
- `TEDS_CONFIGURED`: true/false

## Step 2: Handle Existing Configuration

**If TEDS already configured**:

```
⚠️  TEDS configuration detected in this project.

Current configuration:
- Workspace: [extract from CLAUDE.md or .teds-config.yaml]
- Version: [extract version]
- Location: [CLAUDE.md or .teds-config.yaml]

Options:
1. Keep existing configuration (recommended)
2. Reconfigure (will preserve existing tasks)
3. Reset completely (⚠️  will backup and recreate)

Choose [1/2/3]:
```

**Option 1**: Exit with "Configuration preserved."

**Option 2**: Continue to Step 3 but note existing workspace for preservation

**Option 3**:
```bash
# Backup existing workspace
mv {existing_workspace} {existing_workspace}.backup-$(date +%Y%m%d-%H%M%S)
# Then continue to Step 3
```

## Step 3: Workspace Location

**If not reconfiguring**, ask user:

```
What would you like to name your TEDS workspace directory?

Default: claude_work_space
Examples: .teds, tasks, project_tasks, work_tracking

Enter name (or press Enter for default):
```

**Validation**:
```bash
# Check for issues
[[ "$name" =~ \  ]] && echo "ERROR: No spaces allowed"
[[ "$name" == "." || "$name" == ".." ]] && echo "ERROR: Reserved name"
test -d "$name" && ls -A "$name" 2>/dev/null | grep -q . && echo "WARNING: Directory exists and not empty"
```

If directory exists and not empty:
```
⚠️  Directory '{name}' already exists and contains files.

Contents:
[list first 5 items]

Options:
1. Choose a different name
2. Use existing directory (will add TEDS structure)
3. Cancel initialization

Choose [1/2/3]:
```

Store as `WORKSPACE_NAME`.

## Step 4: Integration Options

**If CLAUDE.md exists**:

```
CLAUDE.md detected in this project.

Would you like to integrate TEDS with CLAUDE.md?

1. Full integration (recommended)
   - Add TEDS configuration to CLAUDE.md
   - Core prompt and templates included
   - Easy to customize for project needs
   - Visible in version control

2. Standalone mode
   - Create .teds-config.yaml
   - Separate from project instructions
   - Lighter weight configuration

Choose [1/2]:
```

**If CLAUDE.md does NOT exist**:

```
No CLAUDE.md found in this project.

Configuration options:

1. Create CLAUDE.md with TEDS (recommended)
   - Sets up project instructions file
   - Includes TEDS configuration
   - Easy to extend with project-specific rules

2. Standalone .teds-config.yaml
   - Minimal configuration file
   - TEDS-only setup

Choose [1/2]:
```

Store choice as `INTEGRATION_MODE`: "claude-md" or "standalone"

## Step 5: Write Configuration

### Mode A: CLAUDE.md Integration

**If CLAUDE.md exists**: Use Edit tool to append

**If creating new CLAUDE.md**: Use Write tool

**Content to add/write**:

```markdown
---

## TEDS Configuration

**Workspace Directory**: `{WORKSPACE_NAME}`
**Plugin Version**: v{VERSION_FROM_PLUGIN_JSON}
**Configured**: {CURRENT_TIMESTAMP}

TEDS (Task Execution Documentation System) provides comprehensive documentation for complex, multi-session tasks.

### Core TEDS System Prompt

<details>
<summary><b>Core System Prompt</b> (click to expand)</summary>

<!-- BEGIN TEDS CORE PROMPT v{VERSION} -->
<!-- Source: teds-plugin -->
<!-- This section was copied during initialization -->
<!-- Last Updated: {CURRENT_TIMESTAMP} -->

{PASTE_FULL_CORE_PROMPT_CONTENT_HERE}

<!-- END TEDS CORE PROMPT -->

</details>

### Project-Specific Extensions

<!-- Customize TEDS behavior for this project below -->

**Custom Phases** (optional):

Define project-specific phases if different from default:
```
1. Phase 1: Planning & Research
2. Phase 2: Implementation
3. Phase 3: Testing & Validation
4. Phase 4: Documentation & Deployment
```

**Custom Templates** (optional):

Add any project-specific file templates here:
```
[Your custom templates]
```

**Integration Notes**:

Document how TEDS integrates with your project workflow:
```
[Integration details]
```

**Checkpoint Frequency** (optional):

Override default 30-minute checkpoint interval:
```
checkpoint_interval: 45  # minutes
```

<!-- Example for AkashicRecords Integration:

**AkashicRecords Integration**:
- TEDS tasks will automatically update parent directory README.md files
- All file operations follow directory RULE.md governance
- Task archives are indexed in knowledge_index/
- Task completion triggers README updates in Project/ hierarchy

**Custom Phases**:
1. Research & Context Gathering
2. Planning & Architecture
3. Implementation & Testing
4. Documentation & Knowledge Transfer
5. Review & Archive

-->

### TEDS Commands

- `/teds-start [name] "[description]"` - Initialize a new long-term task
- `/teds-continue [task-id]` - Resume an existing task
- `/teds-checkpoint` - Create a checkpoint in current task
- `/teds-status` - View all tasks status
- `/teds-complete [task-id]` - Complete and archive a task

For detailed documentation, see the collapsed Core System Prompt above.
```

**Replacements**:
- `{WORKSPACE_NAME}` → User's chosen workspace name
- `{VERSION_FROM_PLUGIN_JSON}` → Plugin version (e.g., "1.0.0")
- `{VERSION}` → Same as above
- `{CURRENT_TIMESTAMP}` → ISO 8601 format (e.g., "2025-10-16T13:30:00+08:00")
- `{PASTE_FULL_CORE_PROMPT_CONTENT_HERE}` → Complete content of teds-core-prompt.md
- Replace `{workspace_path}` placeholders in core prompt with `{WORKSPACE_NAME}`

**Implementation**:
```bash
# For existing CLAUDE.md
# Use Edit tool to append the section

# For new CLAUDE.md
# Use Write tool with the content
```

### Mode B: Standalone Configuration

Create `.teds-config.yaml`:

```yaml
# TEDS Configuration
# Generated: {CURRENT_TIMESTAMP}

version: 1.2.0
plugin_version: {VERSION_FROM_PLUGIN_JSON}
configured_at: {CURRENT_TIMESTAMP}

workspace:
  path: {WORKSPACE_NAME}

# Core prompt is managed by the plugin
# Located at: {PLUGIN_ROOT}/teds-core-prompt.md

# Customization (optional)
customization:
  phases: []
  templates: {}
  checkpoint_interval: 30  # minutes

integration:
  claude_md: false

# Metadata
project:
  path: {WORKING_DIR}
```

**Replacements**: Same as above

## Step 6: Create Workspace Structure

Use Bash to create directories:

```bash
mkdir -p "{WORKSPACE_NAME}/active_tasks"
mkdir -p "{WORKSPACE_NAME}/archived_tasks"
mkdir -p "{WORKSPACE_NAME}/knowledge_index"
```

**Verify creation**:
```bash
ls -la "{WORKSPACE_NAME}"
test -d "{WORKSPACE_NAME}/active_tasks" && echo "✓ active_tasks created"
test -d "{WORKSPACE_NAME}/archived_tasks" && echo "✓ archived_tasks created"
test -d "{WORKSPACE_NAME}/knowledge_index" && echo "✓ knowledge_index created"
```

Create `{WORKSPACE_NAME}/README.md`:

```markdown
# TEDS Workspace

**Created**: {CURRENT_DATE}
**Configuration**: {CLAUDE.md | .teds-config.yaml}
**Workspace**: `{WORKSPACE_NAME}/`

TEDS (Task Execution Documentation System) provides comprehensive documentation for complex, multi-session tasks.

## Directory Structure

```
{WORKSPACE_NAME}/
├── active_tasks/          # Currently running tasks
│   └── [task-id]/         # Each task has its own directory
│       ├── manifest.yaml
│       ├── plan.md
│       ├── execution_log.md
│       ├── knowledge_base.md
│       ├── context.md
│       └── status.yaml
├── archived_tasks/        # Completed and archived tasks
│   └── [task-id]/         # Same structure as active tasks
└── knowledge_index/       # Extracted summaries and learnings
    └── [task-id]-summary.md
```

## Active Tasks

No active tasks yet.

Use `/teds-start [task-name] "[description]"` to create your first task.

## Commands Reference

### Task Management

- **`/teds-init`** - Initialize TEDS configuration (already done!)
- **`/teds-start [name] "[description]"`** - Start a new long-term task
- **`/teds-continue [task-id]`** - Resume an existing task
- **`/teds-checkpoint`** - Create a checkpoint in current task
- **`/teds-status`** - View all tasks and their status
- **`/teds-complete [task-id]`** - Complete and archive a task

### Workflow Example

```bash
# 1. Start a new task
/teds-start refactor-auth "Migrate authentication to OAuth 2.0"

# 2. Work on the task (automatic logging happens)
#    Agent logs every action to execution_log.md
#    Updates status.yaml on changes
#    Creates checkpoints every 30+ minutes

# 3. Check status anytime
/teds-status

# 4. Pause and resume later
/teds-checkpoint
# [Later session]
/teds-continue 20250116-1430-refactor-auth

# 5. Complete when done
/teds-complete 20250116-1430-refactor-auth
```

## Features

### Automatic Logging
Every action is automatically logged to `execution_log.md` with:
- Timestamp
- Tool used
- Target file/command
- Result and status

### Checkpoint & Resume
- Automatic checkpoints every 30+ minutes
- Manual checkpoints with `/teds-checkpoint`
- Resume from any checkpoint with full context

### Knowledge Accumulation
- Learnings captured in `knowledge_base.md`
- Discoveries documented during execution
- Summaries extracted on completion

### Task Status Tracking
- Current phase and progress percentage
- Last action and next action
- Blocked status with reasons
- Time since last checkpoint

## Configuration

For TEDS configuration and customization, see:
- **CLAUDE.md** - Full configuration with core prompt
- **`.teds-config.yaml`** - Standalone configuration

## Getting Help

- Expand "Core System Prompt" in CLAUDE.md for detailed documentation
- Use `/teds-status` to see current task state
- Check individual task directories for complete history

---

Ready to start your first long-term task? Run:
```
/teds-start my-first-task "Description of what you want to accomplish"
```
```

## Step 7: Verify and Report

Run verification:
```bash
ls -la "{WORKSPACE_NAME}"
test -f "{WORKSPACE_NAME}/README.md" && echo "✓ README.md created"
test -d "{WORKSPACE_NAME}/active_tasks" && echo "✓ Directory structure verified"
```

Count existing files:
```bash
find "{WORKSPACE_NAME}" -type f | wc -l  # Should be 1 (README.md)
find "{WORKSPACE_NAME}" -type d | wc -l  # Should be 4 (workspace + 3 subdirs)
```

Present completion report to user:

```markdown
✅ TEDS Configuration Complete!

**Configuration Summary**
- Workspace: `{WORKSPACE_NAME}/`
- Integration: {CLAUDE.md | Standalone (.teds-config.yaml)}
- Plugin Version: v{VERSION}
- Configuration File: {CLAUDE.md or .teds-config.yaml}
- Status: Ready to use

**Directory Structure Created**
```
{WORKSPACE_NAME}/
├── README.md                 ✓
├── active_tasks/             ✓
├── archived_tasks/           ✓
└── knowledge_index/          ✓
```

**Next Steps**

1. **Create your first long-term task**:
   ```
   /teds-start refactor-auth "Migrate authentication system to OAuth 2.0"
   ```

2. **Check task status anytime**:
   ```
   /teds-status
   ```

3. **Continue a task in a new session**:
   ```
   /teds-status                           # List all tasks
   /teds-continue [task-id]               # Resume specific task
   ```

4. **Create checkpoints while working**:
   ```
   /teds-checkpoint                       # Safe pause point
   ```

**Configuration Location**

{
  If CLAUDE.md:
    "TEDS configuration added to CLAUDE.md

     You can customize TEDS behavior by editing the 'Project-Specific Extensions'
     section in CLAUDE.md."

  If standalone:
    "TEDS configuration saved to .teds-config.yaml

     You can customize settings by editing .teds-config.yaml."
}

**Documentation**

- **Full TEDS documentation**: {CLAUDE.md (collapsed section) | Plugin files}
- **Workspace README**: `{WORKSPACE_NAME}/README.md`
- **Commands reference**: See CLAUDE.md or workspace README

---

🎉 TEDS is now ready! Start your first task when you're ready.
```

## Error Handling

### Permission Errors
```
❌ Cannot create workspace directory: Permission denied

Suggested actions:
- Check directory permissions: ls -la .
- Try a different location
- Use a hidden directory: .teds
- Use subdirectory in Documents: ~/Documents/teds
```

### Workspace Name Conflicts
```
⚠️  Directory '{WORKSPACE_NAME}' already exists and contains files.

Found files:
- README.md
- some-file.txt
- [3 more files...]

Options:
1. Choose a different name
2. Use existing directory (will add TEDS structure to it)
3. Backup existing and recreate: {WORKSPACE_NAME}.backup-YYYYMMDD-HHMM
4. Cancel initialization

Choose [1/2/3/4]:
```

### Plugin Not Found
```
❌ Cannot locate TEDS plugin installation.

Searched locations:
- ~/.claude/plugins/teds-plugin/
- [other locations]

This usually means the plugin is not properly installed.

To fix:
1. Check plugin installation: /plugin
2. Reinstall if needed: /plugin install teds-plugin
3. Try initialization again: /teds-init
```

### Configuration File Conflicts
```
⚠️  Both CLAUDE.md and .teds-config.yaml contain TEDS configuration.

This may cause conflicts.

Recommended action:
1. Keep CLAUDE.md configuration (remove .teds-config.yaml)
2. Keep .teds-config.yaml (remove TEDS section from CLAUDE.md)
3. Cancel and review manually

Choose [1/2/3]:
```

## Important Notes

1. **Never overwrite existing TEDS data** without explicit user confirmation
2. **Always confirm before modifying CLAUDE.md** (show diff if possible)
3. **Preserve any existing configuration** during reconfiguration
4. **Validate all paths** before creating directories
5. **Use absolute paths** internally but show relative paths to user
6. **Handle edge cases gracefully** with clear options
7. **Provide helpful error messages** with actionable solutions

## Configuration Validation

After setup, validate:
```bash
# Check workspace
test -d "{WORKSPACE_NAME}" || echo "ERROR: Workspace not created"
test -w "{WORKSPACE_NAME}" || echo "ERROR: Workspace not writable"

# Check configuration
if test -f "CLAUDE.md"; then
  grep -q "## TEDS Configuration" CLAUDE.md || echo "ERROR: Config not in CLAUDE.md"
elif test -f ".teds-config.yaml"; then
  grep -q "workspace:" .teds-config.yaml || echo "ERROR: Invalid config file"
else
  echo "ERROR: No configuration file found"
fi

# Check subdirectories
for dir in active_tasks archived_tasks knowledge_index; do
  test -d "{WORKSPACE_NAME}/$dir" || echo "ERROR: Missing $dir/"
done
```

If any validation fails, report error and offer to retry initialization.
