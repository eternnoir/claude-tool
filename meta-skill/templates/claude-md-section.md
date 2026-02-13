<!-- META-SKILL:START -->
<!-- Meta-Skill Dynamic Skill Library v{VERSION} | DO NOT edit between markers — re-run meta-skill init to update -->

## Meta-Skill: Dynamic Skill Library

On every user request, you MUST check `SKILLUSE.md` in the project root and match the user's intent against skill descriptions. This is a mandatory behavior — always check before responding.

### How to match

1. Read `SKILLUSE.md` from the project root
2. Each `## heading` is a skill name, the paragraph below is its description
3. If the user's request matches a skill description, read `skill-library/<skill-name>/SKILL.md` and follow its instructions
4. If the skill references supporting files, read those too
5. If no skill matches, proceed normally — do NOT mention the library

### Management

When the user wants to manage skills (add, remove, edit, list, enable), use the `meta-skill` skill.
<!-- META-SKILL:END -->
