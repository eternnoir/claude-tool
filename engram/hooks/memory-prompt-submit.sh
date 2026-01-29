#!/bin/bash
# Engram - Memory Prompt Submit Hook
# Injects datetime, conversation counter, and memory instructions on every UserPromptSubmit

set -euo pipefail

# Resolve project directory from stdin or environment
if [ -n "${CLAUDE_PROJECT_DIR:-}" ]; then
    PROJECT_DIR="$CLAUDE_PROJECT_DIR"
else
    # Read hook input from stdin to get cwd
    INPUT=$(cat)
    PROJECT_DIR=$(echo "$INPUT" | jq -r '.cwd // empty' 2>/dev/null || true)
    if [ -z "$PROJECT_DIR" ]; then
        PROJECT_DIR="$(pwd)"
    fi
fi

SETTINGS_FILE="$PROJECT_DIR/.claude/memory-settings.json"

# ─── MODE A: Not Initialized ───
if [ ! -f "$SETTINGS_FILE" ]; then
    cat << 'NOTINIT'
{"hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalContext":"\n\n[ENGRAM MEMORY SYSTEM] Not initialized.\nNo memory configuration found. Use the memory-init skill to initialize the memory system.\nAsk the user which preset they want:\n  - personal-assistant (daily life, preferences, habits)\n  - project-assistant (codebase, architecture, decisions)\n  - character-companion (persona, relationship, story)\nOr offer a custom configuration."}}
NOTINIT
    exit 0
fi

# ─── MODE B: Initialized ───

# Read settings
ENABLED=$(jq -r '.enabled // true' "$SETTINGS_FILE")
if [ "$ENABLED" != "true" ]; then
    exit 0
fi

PRESET=$(jq -r '.preset // "personal-assistant"' "$SETTINGS_FILE")
PREFS_FILE=$(jq -r '.files.preferences // "memory_preferences.md"' "$SETTINGS_FILE")
CONVOS_FILE=$(jq -r '.files.conversations // "memory_conversations.md"' "$SETTINGS_FILE")
LONGTERM_FILE=$(jq -r '.files.longterm // "memory_longterm.md"' "$SETTINGS_FILE")
RELOAD_INTERVAL=$(jq -r '.reload_interval // 10' "$SETTINGS_FILE")
LANG=$(jq -r '.language // "en"' "$SETTINGS_FILE")

# Datetime
DATETIME=$(date '+%Y/%m/%d %H:%M:%S')
WEEKDAY=$(date '+%A')

# Turn counter
COUNTER_FILE="$PROJECT_DIR/.claude/memory_counter.txt"
if [ -f "$COUNTER_FILE" ]; then
    COUNTER=$(tr -d '[:space:]' < "$COUNTER_FILE" 2>/dev/null)
    [ -z "$COUNTER" ] && COUNTER=0
else
    COUNTER=0
fi
COUNTER=$((COUNTER + 1))
echo "$COUNTER" > "$COUNTER_FILE"

# Reload flag
RELOAD_HINT=""
if [ "$COUNTER" -eq 1 ] || [ $((COUNTER % RELOAD_INTERVAL)) -eq 0 ]; then
    RELOAD_HINT="[RELOAD]"
fi

# ─── Build instructions by language ───
if [ "$LANG" = "zh" ]; then
    INSTRUCTIONS="記憶系統指令（三檔分離）：
1. ${PREFS_FILE}（User Preferences）：用 Read tool 直接讀取全檔到 context（turn 1 必讀、每 ${RELOAD_INTERVAL} 輪重讀、更新後下輪重讀）
2. ${CONVOS_FILE}（Conversation History）：根據話題用 Grep 搜尋相關段落（最新在最前面）
3. ${LONGTERM_FILE}（Long-Term Memories）：根據話題用 Grep 搜尋相關段落（只增不刪）
自動觸發提醒：
- 發現新偏好/決策/里程碑 → 使用 memory-remember skill 寫入對應檔案
- 話題涉及過去討論/歷史上下文 → 使用 memory-recall skill 搜尋記憶
- 對話結束或自然總結點 → 使用 memory-remember skill 儲存對話摘要
- 主動查詢：對當前話題不確定時，必須先查詢記憶檔案再回覆"
else
    INSTRUCTIONS="Memory System Instructions (Three-File Separation):
1. ${PREFS_FILE} (User Preferences): Read full file into context via Read tool (MUST read on turn 1, re-read every ${RELOAD_INTERVAL} turns, re-read after updates)
2. ${CONVOS_FILE} (Conversation History): Search relevant sections via Grep by topic keywords (newest first)
3. ${LONGTERM_FILE} (Long-Term Memories): Search relevant sections via Grep by topic keywords (append-only, never delete)
Auto-trigger reminders:
- Discover new preferences/decisions/milestones → use memory-remember skill to write to appropriate file
- Topic relates to past discussions/historical context → use memory-recall skill to search memories
- Conversation ends or natural summary point → use memory-remember skill to save conversation summary
- Proactive query: when uncertain about current topic, MUST search memory files before responding"
fi

# ─── Output JSON ───
# Use jq to safely encode the context string
CONTEXT=$(printf "\n\n[ENGRAM MEMORY SYSTEM]\nDatetime: %s (%s)\nConversation Turn: %s %s\nPreset: %s\n\n%s" \
    "$DATETIME" "$WEEKDAY" "$COUNTER" "$RELOAD_HINT" "$PRESET" "$INSTRUCTIONS")

jq -n --arg ctx "$CONTEXT" \
    '{"hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalContext":$ctx}}'
