#!/bin/bash
#
# detect-todo.sh - Pattern-based todo detection for Stop hook
#
# This hook uses simple pattern matching to detect <todo> tags in Claude's output.
# No Claude API calls - fast and reliable.
#
# Exit Codes:
#   0 - Always exit 0 (Stop hooks should not use non-zero codes)
#
# Output:
#   - Todos detected: JSON to stdout with {"result": "message"}
#   - No todos: no output
#

# Read hook input from stdin
input=$(cat)

# Extract transcript path from hook input
transcript_path=$(echo "$input" | jq -r '.transcript_path // empty' 2>/dev/null) || exit 0

# If no transcript path, exit silently
[ -z "$transcript_path" ] || [ ! -f "$transcript_path" ] && exit 0

# Read last assistant message from transcript
# Get the last line with role:assistant
last_assistant=$(grep '"role":"assistant"' "$transcript_path" 2>/dev/null | tail -1)
[ -z "$last_assistant" ] && exit 0

# Extract text content from the message
assistant_text=$(echo "$last_assistant" | jq -r '
  .message.content |
  if type == "array" then
    map(select(.type == "text")) | map(.text) | join("\n")
  else
    .
  end
' 2>/dev/null) || exit 0

[ -z "$assistant_text" ] && exit 0

# Check for <todo> tags using pattern matching
if echo "$assistant_text" | grep -q '<todo[^>]*>' 2>/dev/null; then
    # Extract all todo tags
    todos=$(echo "$assistant_text" | grep -oE '<todo[^>]*>[^<]*</todo>' 2>/dev/null || true)

    if [ -n "$todos" ]; then
        # Build notification message
        message="[TODO_TRACKER] Todo item detected:

$todos

Use /todo-add to manually add, or /todo-list to view all todos."

        # Output JSON to stdout
        jq -n --arg msg "$message" '{"result": $msg}' 2>/dev/null || true
    fi
fi

exit 0
