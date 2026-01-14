---
description: Initialize or validate ProjectMaster configuration for the current directory and its subdirectories
---

# Initialize ProjectMaster Configuration

When the user runs `/project-init`, perform the following tasks:

## Task 1: Scan Current Directory

Scan the current directory and subdirectories to understand the existing structure:

1. **Check for RULE.md files**:
   ```bash
   find . -name "RULE.md" -type f
   ```
   List all RULE.md files found.

2. **Check for milestones.yaml**:
   ```bash
   find . -name "milestones.yaml" -type f
   ```

3. **Check for project directories**:
   Look for typical project directories:
   - meetings/
   - sprints/ or iterations/ or board/
   - docs/
   - decisions/

4. **Identify project structure type**:
   - Initialized ProjectMaster project (has RULE.md with ProjectMaster metadata)
   - AkashicRecords project (has RULE.md but no ProjectMaster config)
   - Uninitialized directory (no RULE.md)
   - Multiple projects (multiple RULE.md files in different subdirectories)

## Task 2: Report Current State

Present findings to the user:

```
📋 ProjectMaster Configuration Scan

Current directory: {path}

🔍 Found:
- RULE.md files: {count} ({locations})
- milestones.yaml: {count} ({locations})
- Project directories: {list}

📊 Assessment:
{One of:}
- ✅ ProjectMaster project detected at {path}
- ⚠️ AkashicRecords project detected (no ProjectMaster config)
- ℹ️ No project governance detected
- 📁 Multiple projects detected: {count}
```

## Task 3: Offer Actions

Based on assessment, offer appropriate actions:

### If ProjectMaster project detected:

```
✅ ProjectMaster is initialized for this project.

**Configuration**:
- Methodology: {from RULE.md}
- Team size: {from RULE.md}
- Documentation format: {from RULE.md}

**Health check**:
- RULE.md: ✅ Present
- milestones.yaml: ✅ Present
- README.md: {✅ Present | ⚠️ Missing}
- Directory structure: {✅ Complete | ⚠️ Missing directories}

Would you like to:
1. Validate governance (check README.md indexes)
2. Update RULE.md configuration
3. View project status (/project-status)
4. No action needed
```

### If AkashicRecords project (no ProjectMaster config):

```
ℹ️ This directory has AkashicRecords governance but no ProjectMaster configuration.

Would you like to add ProjectMaster to this project?

This will:
- Add ProjectMaster-specific configuration to RULE.md
- Create milestones.yaml
- Create project management directories (meetings/, sprints/)
- Maintain AkashicRecords compatibility

Proceed with ProjectMaster initialization?
- Yes, initialize ProjectMaster
- No, keep as is
```

If yes, activate the `initialize-project` Skill to add ProjectMaster to the existing structure.

### If no governance detected:

```
ℹ️ This directory is not initialized for ProjectMaster.

Would you like to initialize project management for this directory?

This will create:
- RULE.md with project governance
- Project directory structure (meetings/, sprints/, docs/)
- milestones.yaml for milestone tracking
- README.md files for navigation

Proceed with initialization?
- Yes, initialize new project
- No, cancel
```

If yes, activate the `initialize-project` Skill with guided Q&A.

### If multiple projects detected:

```
📁 Multiple projects detected:

1. {path1} - {Project Name or "Unnamed"}
2. {path2} - {Project Name or "Unnamed"}
3. {path3} - {Project Name or "Unnamed"}

Which project would you like to work with?
- Select project: {1-3}
- Initialize new project in current directory
- Validate all projects
- Cancel
```

Handle user selection and proceed accordingly.

## Task 4: Validate Governance (if requested)

If user chooses to validate governance:

1. **Read RULE.md**:
   Check that all required fields are present:
   - methodology
   - team_size or team_structure
   - Document Templates section
   - Auto Workflows section
   - Directory Structure section

2. **Check directory structure**:
   Verify that directories specified in RULE.md exist:
   ```bash
   ls -ld meetings/ sprints/ docs/ decisions/
   ```

3. **Check README.md files**:
   Verify that README.md files exist and are up to date:
   - Project root README.md
   - meetings/README.md
   - sprints/README.md (or appropriate work tracking directory)
   - docs/README.md

4. **Check milestones.yaml**:
   Verify structure and required fields:
   ```yaml
   project:
     name: ...
     start_date: ...
   milestones:
     - id: ...
       name: ...
       [etc.]
   ```

5. **Report validation results**:
   ```
   ✅ Governance Validation Report

   **RULE.md**: ✅ All required fields present
   **Directory Structure**: ✅ All directories exist
   **README.md Indexes**: {status}
     - Root: ✅ Present, last updated {date}
     - meetings/: ✅ Present, last updated {date}
     - sprints/: ⚠️ Outdated (last updated {date}, {count} new items)
     - docs/: ❌ Missing
   **milestones.yaml**: ✅ Valid structure

   Issues found: {count}
   ```

6. **Offer fixes**:
   ```
   Would you like to fix issues automatically?
   - Yes, fix all issues
   - Let me fix manually
   ```

   If yes:
   - Create missing README.md files
   - Update outdated README.md indexes
   - Fix structural issues

## Task 5: Execute Chosen Action

Carry out the user's selected action:
- If initialize: Use `initialize-project` Skill
- If validate and fix: Perform governance updates
- If update RULE.md: Open RULE.md for editing and guide user
- If view status: Run `/project-status` command

## Notes

- This command provides a quick way to check and initialize ProjectMaster
- It integrates with existing AkashicRecords projects
- It validates governance health and offers to fix issues
- It's safe to run repeatedly - it only makes changes with user confirmation

## Examples

### Example 1: Uninitialized directory

```
User: /project-init

Claude: 📋 ProjectMaster Configuration Scan

Current directory: /Users/user/my-project

🔍 Found:
- RULE.md files: 0
- milestones.yaml: 0
- Project directories: None

📊 Assessment:
ℹ️ No project governance detected

Would you like to initialize project management for this directory?

This will create:
- RULE.md with project governance
- Project directory structure
- milestones.yaml
- README.md files

Proceed? [Yes/No]

User: Yes

Claude: Great! Let's set up your project...
[Activates initialize-project Skill with Q&A]
```

### Example 2: Existing ProjectMaster project

```
User: /project-init

Claude: 📋 ProjectMaster Configuration Scan

Current directory: /Users/user/ecommerce-redesign

🔍 Found:
- RULE.md files: 1 (./RULE.md)
- milestones.yaml: 1 (./milestones.yaml)
- Project directories: meetings/, sprints/, docs/, decisions/

📊 Assessment:
✅ ProjectMaster project detected

**Configuration**:
- Methodology: Scrum (2-week sprints)
- Team size: 6
- Documentation format: Structured with frontmatter

**Health check**:
- RULE.md: ✅ Present
- milestones.yaml: ✅ Present
- README.md: ✅ Present, updated 2025-11-13
- Directory structure: ✅ Complete

Would you like to:
1. Validate governance
2. Update RULE.md configuration
3. View project status
4. No action needed

User: 1

Claude: Running governance validation...

✅ Governance Validation Report
All systems healthy! No issues found.
```

### Example 3: Governance validation finds issues

```
User: /project-init

Claude: [Scans and detects issues]

⚠️ Governance Validation Report

**Issues found**: 3

1. ⚠️ meetings/README.md is outdated
   - Last updated: 2025-11-01
   - 8 new meetings since then

2. ❌ docs/README.md is missing
   - 5 documentation files exist
   - No index found

3. ⚠️ milestones.yaml has invalid entry
   - milestone-3 references non-existent dependency

Would you like to fix these automatically?

User: Yes

Claude: Fixing issues...

✅ Updated meetings/README.md with 8 new entries
✅ Created docs/README.md with index of 5 files
⚠️ milestones.yaml issue requires manual review:
   milestone-3 depends on "milestone-x" which doesn't exist.
   Please check milestones.yaml and correct the dependency.

2 of 3 issues resolved. 1 requires manual attention.
```

---

This command is the entry point for ProjectMaster setup and maintenance. It ensures projects stay healthy and well-governed.
