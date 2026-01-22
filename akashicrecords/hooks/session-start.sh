#!/bin/bash
#
# session-start.sh - Inject todo tracking instructions on session start
#
# For SessionStart hooks, stdout is added to Claude's context.
# This allows us to inject instructions that tell Claude to use <todo> tags.
#

# Read hook input from stdin
input=$(cat)

# Extract cwd from hook input
cwd=$(echo "$input" | jq -r '.cwd // empty' 2>/dev/null) || exit 0

# If no cwd, exit silently
[ -z "$cwd" ] && exit 0

# Find settings file
settings_file=""
check_dir="$cwd"
while [ "$check_dir" != "/" ] && [ -n "$check_dir" ]; do
    if [ -f "$check_dir/.claude/todo-settings-local.json" ]; then
        settings_file="$check_dir/.claude/todo-settings-local.json"
        break
    fi
    check_dir=$(dirname "$check_dir")
done

# If no settings file found, exit silently
[ -z "$settings_file" ] && exit 0

# Read settings
settings=$(cat "$settings_file" 2>/dev/null) || exit 0
[ -z "$settings" ] && exit 0

# Check if todo tracking is enabled
enabled=$(echo "$settings" | jq -r '.enabled // false' 2>/dev/null) || exit 0
[ "$enabled" != "true" ] && exit 0

# Output instructions to stdout - this gets injected into Claude's context
cat << 'EOF'
<system-instruction source="akashicrecords-todo-tracker">
## Automatic Todo Detection

When you detect REAL actionable items in the conversation, mark them with `<todo>` tags:

```
<todo priority="high" due="2024-01-15">Specific task to be done</todo>
```

### When to use <todo> tags:
- External requests (emails asking for action/information)
- Commitments made that need follow-up
- Deadlines mentioned for real tasks
- Action items from meetings
- User explicitly says "remember", "don't forget", "need to do"

### When NOT to use <todo> tags:
- Discussions ABOUT todo systems
- Examples or demonstrations
- General conversation
- Tasks you are completing right now in this session

### Tag attributes:
- priority: "high" | "medium" | "low" (required)
- due: "YYYY-MM-DD" (optional, if deadline mentioned)

Only output <todo> tags for genuine actionable items, not for every task discussed.
</system-instruction>
EOF

exit 0
