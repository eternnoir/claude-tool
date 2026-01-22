#!/bin/bash
# Steady-Hand Plugin - Context Usage Monitor
# Injects quality reminders when context usage exceeds threshold

# Read JSON input from stdin
input=$(cat)
transcript_path=$(echo "$input" | jq -r '.transcript_path // empty')
cwd=$(echo "$input" | jq -r '.cwd // empty')

# Default settings
default_enabled=true
default_threshold=60
default_max_tokens=200000
default_prompt="[System Reminder] Maintain your quality standards. Do not skip validation steps. If remaining context is insufficient to complete the current task with high quality, pause and create a handoff note."

# Find settings file by walking up directory tree
settings_file=""
check_dir="$cwd"
while [ "$check_dir" != "/" ] && [ -n "$check_dir" ]; do
    if [ -f "$check_dir/.claude/steady-hand_local_setting.json" ]; then
        settings_file="$check_dir/.claude/steady-hand_local_setting.json"
        break
    fi
    check_dir=$(dirname "$check_dir")
done

# Auto-create settings file if not found
if [ -z "$settings_file" ] && [ -n "$cwd" ]; then
    settings_file="$cwd/.claude/steady-hand_local_setting.json"
    mkdir -p "$cwd/.claude" 2>/dev/null
    cat > "$settings_file" 2>/dev/null << EOF
{
  "enabled": $default_enabled,
  "threshold": $default_threshold,
  "max_tokens": $default_max_tokens,
  "prompt": "$default_prompt"
}
EOF
fi

# Use defaults
enabled=$default_enabled
threshold=$default_threshold
max_tokens=$default_max_tokens
prompt="$default_prompt"

# Read settings from file
if [ -n "$settings_file" ] && [ -f "$settings_file" ]; then
    settings=$(cat "$settings_file" 2>/dev/null)
    if [ -n "$settings" ]; then
        file_enabled=$(echo "$settings" | jq -r '.enabled // empty')
        file_threshold=$(echo "$settings" | jq -r '.threshold // empty')
        file_max_tokens=$(echo "$settings" | jq -r '.max_tokens // empty')
        file_prompt=$(echo "$settings" | jq -r '.prompt // empty')

        [ -n "$file_enabled" ] && enabled="$file_enabled"
        [ -n "$file_threshold" ] && threshold="$file_threshold"
        [ -n "$file_max_tokens" ] && max_tokens="$file_max_tokens"
        [ -n "$file_prompt" ] && prompt="$file_prompt"
    fi
fi

# Exit if disabled
if [ "$enabled" != "true" ]; then
    exit 0
fi

# Exit if no transcript path
if [ -z "$transcript_path" ] || [ ! -f "$transcript_path" ]; then
    exit 0
fi

# Calculate context usage from most recent valid API response
# Read transcript in reverse to find the most recent usage data
# Use tail -r on macOS, tac on Linux
if command -v tac >/dev/null 2>&1; then
    reverse_cmd="tac"
else
    reverse_cmd="tail -r"
fi

total_tokens=$($reverse_cmd "$transcript_path" 2>/dev/null | while IFS= read -r line; do
    # Skip empty lines
    [ -z "$line" ] && continue

    # Skip sidechain entries
    is_sidechain=$(echo "$line" | jq -r '.isSidechain // false' 2>/dev/null)
    [ "$is_sidechain" = "true" ] && continue

    # Skip error messages
    is_error=$(echo "$line" | jq -r '.isApiErrorMessage // false' 2>/dev/null)
    [ "$is_error" = "true" ] && continue

    # Look for usage data in message
    usage=$(echo "$line" | jq -r '.message.usage // empty' 2>/dev/null)
    [ -z "$usage" ] && continue

    # Calculate total tokens
    input_tk=$(echo "$usage" | jq -r '.input_tokens // 0' 2>/dev/null)
    cache_read=$(echo "$usage" | jq -r '.cache_read_input_tokens // 0' 2>/dev/null)
    cache_create=$(echo "$usage" | jq -r '.cache_creation_input_tokens // 0' 2>/dev/null)

    # Output total and exit loop
    echo $((input_tk + cache_read + cache_create))
    break
done)

# Exit if no token data found
if [ -z "$total_tokens" ] || [ "$total_tokens" -eq 0 ]; then
    exit 0
fi

# Calculate usage percentage
usage_percent=$((total_tokens * 100 / max_tokens))

# Inject reminder if threshold exceeded
if [ "$usage_percent" -ge "$threshold" ]; then
    # Output JSON format for Claude Code to append to context
    jq -n --arg ctx "$prompt" '{"hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalContext":$ctx}}'
fi

exit 0
