---
name: meta-skill
description: >
  Manage the dynamic skill library. Initialize skill-library/ and SKILLUSE.md,
  add new skills, remove skills, edit existing skills, and list available skills.
  Use when the user wants to manage, create, or modify skills in the skill library.
---

# Meta-Skill: Dynamic Skill Library

A system for managing on-demand skills that are loaded dynamically instead of at session startup. Skills are stored in `skill-library/` and registered in `SKILLUSE.md` at the project root.

## How It Works

### Automatic Matching (via CLAUDE.md)

During initialization, a section is added to CLAUDE.md that instructs Claude to check `SKILLUSE.md` on every user request. When the user's request matches a skill description:

1. Read `skill-library/<skill-name>/SKILL.md` from the project root
2. If the skill references supporting files, read those too
3. Follow the skill's instructions to handle the user's request

### SKILLUSE.md Format

A markdown file at the project root. Each `## heading` is a skill name (maps to `skill-library/<heading>/`), followed by a natural language description:

```markdown
# Skill Library

## code-review
Code review skill. Perform quality reviews, identify potential issues, and provide improvement suggestions.

## api-design
RESTful API design patterns. Naming conventions, error handling, and versioning.
```

### skill-library/ Structure

```
skill-library/
├── code-review/
│   ├── SKILL.md            # Main instructions (required)
│   ├── templates/           # Optional supporting files
│   └── examples/            # Optional examples
└── api-design/
    └── SKILL.md
```

Compatible with `.claude/skills/` — skills can be moved between the two systems.

## Management Operations

### Initialize

When user asks to initialize the skill library:

1. Create `skill-library/` directory in the project root
2. Create `SKILLUSE.md` in the project root with this template:

```markdown
# Skill Library

Skills listed below are available for on-demand loading.
```

3. Append Meta-Skill section to CLAUDE.md:

   Read the template from the plugin's `templates/claude-md-section.md`.

   Replace `{VERSION}` with the version from `.claude-plugin/plugin.json`.

   Then apply to `CLAUDE.md` in the project root:

   - **If CLAUDE.md exists and contains `<!-- META-SKILL:START -->`**: Replace everything between `<!-- META-SKILL:START -->` and `<!-- META-SKILL:END -->` (inclusive) with the new content
   - **If CLAUDE.md exists but has no markers**: Append the content to the end of the file (with a blank line separator)
   - **If CLAUDE.md does not exist**: Create a new CLAUDE.md with the content

4. Display summary:

```
Meta-Skill initialized!

Files created/updated:
  - SKILLUSE.md (skill registry)
  - skill-library/ (skill definitions folder)
  - CLAUDE.md (matching instructions added)

You can now add skills with "add a skill for <topic>".
```

### List

When user asks what skills are available:

1. Read `SKILLUSE.md` to show active (registered) skills
2. Optionally scan `skill-library/` directories to show unregistered skills that exist but aren't active

### Add

When user asks to create a new skill:

1. Confirm the skill name and purpose with the user
2. Create `skill-library/<name>/SKILL.md` with appropriate content
3. Add a `## <name>` section to `SKILLUSE.md` with a description
4. The SKILL.md should follow this structure:

```markdown
# Skill Title

## When to Use
Describe conditions for using this skill.

## Workflow
Step-by-step instructions for Claude to follow.
```

### Remove

When user asks to remove a skill:

1. Remove the `## <name>` section from `SKILLUSE.md`
2. Files in `skill-library/<name>/` are preserved (not deleted)
3. The skill becomes inactive but can be re-enabled later

### Enable

When user asks to enable an existing but unregistered skill:

1. Check that `skill-library/<name>/SKILL.md` exists
2. Read the SKILL.md to generate an appropriate description
3. Add a `## <name>` section to `SKILLUSE.md`

### Edit

When user asks to modify a skill:

1. Read the current `skill-library/<name>/SKILL.md`
2. Make the requested changes
3. Update the description in `SKILLUSE.md` if the skill's purpose changed
