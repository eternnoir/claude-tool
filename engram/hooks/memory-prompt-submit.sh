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
SEARCH_MODE=$(jq -r '.search_mode // ""' "$SETTINGS_FILE")

# Upgrade detection: if search_mode is not set, default to weak and prepare hint
UPGRADE_HINT=""
if [ -z "$SEARCH_MODE" ]; then
    SEARCH_MODE="weak"
    UPGRADE_HINT="\n[ENGRAM] New: Search Mode available (strong/weak). Use memory-init skill to configure."
fi

# Build SEARCH_MODE_INSTRUCTION based on mode + language
if [ "$SEARCH_MODE" = "strong" ]; then
    if [ "$LANG" = "zh" ]; then
        SEARCH_MODE_INSTRUCTION="- 強制搜尋：每次回覆前，必須先分析使用者意圖，然後使用 memory-recall skill 搜尋相關記憶。沒有例外 — 永遠先搜尋再回覆。"
    else
        SEARCH_MODE_INSTRUCTION="- MANDATORY: Before EVERY response, first analyze the user's intent and use memory-recall skill to search relevant memories. No exceptions — always search first, respond second."
    fi
else
    if [ "$LANG" = "zh" ]; then
        SEARCH_MODE_INSTRUCTION="- 主動查詢：每次對話如果有可能涉及過去，必須先使用 memory-recall skill 搜尋記憶再回覆"
    else
        SEARCH_MODE_INSTRUCTION="- Proactive query: if a conversation could possibly relate to past context, MUST use memory-recall skill to search memories before responding"
    fi
fi

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
    RELOAD_HINT="[ENGRAM RELOAD]"
fi

# ─── Build instructions ───
REMINDER_FILE_SETTING=$(jq -r '.reminder_file // ".claude/memory-reminder.md"' "$SETTINGS_FILE")
REMINDER_PATH="$PROJECT_DIR/$REMINDER_FILE_SETTING"

if [ -f "$REMINDER_PATH" ]; then
    # Read from user-customizable reminder file, substitute placeholders
    INSTRUCTIONS=$(cat "$REMINDER_PATH")
    INSTRUCTIONS="${INSTRUCTIONS//\{\{PREFS_FILE\}\}/$PREFS_FILE}"
    INSTRUCTIONS="${INSTRUCTIONS//\{\{CONVOS_FILE\}\}/$CONVOS_FILE}"
    INSTRUCTIONS="${INSTRUCTIONS//\{\{LONGTERM_FILE\}\}/$LONGTERM_FILE}"
    INSTRUCTIONS="${INSTRUCTIONS//\{\{RELOAD_INTERVAL\}\}/$RELOAD_INTERVAL}"
    INSTRUCTIONS="${INSTRUCTIONS//\{\{SEARCH_MODE_INSTRUCTION\}\}/$SEARCH_MODE_INSTRUCTION}"
elif [ "$LANG" = "zh" ]; then
    INSTRUCTIONS="記憶系統指令（三檔分離）：
1. ${PREFS_FILE}（User Preferences）：用 Read tool 直接讀取全檔到 context（turn 1 必讀、每 ${RELOAD_INTERVAL} 輪重讀、更新後下輪重讀）
2. ${CONVOS_FILE}（Conversation History）：根據話題用 Grep 搜尋相關段落（最新在最前面）
3. ${LONGTERM_FILE}（Long-Term Memories）：根據話題用 Grep 搜尋相關段落（只增不刪）
自動觸發提醒：
- 發現新偏好/決策/里程碑 → 使用 memory-remember skill 寫入對應檔案
- 話題涉及過去討論/歷史上下文 → 使用 memory-recall skill 搜尋記憶
- 對話結束或自然總結點 → 使用 memory-remember skill 儲存對話摘要
$SEARCH_MODE_INSTRUCTION"
else
    INSTRUCTIONS="Memory System Instructions (Three-File Separation):
1. ${PREFS_FILE} (User Preferences): Read full file into context via Read tool (MUST read on turn 1, re-read every ${RELOAD_INTERVAL} turns, re-read after updates)
2. ${CONVOS_FILE} (Conversation History): Search relevant sections via Grep by topic keywords (newest first)
3. ${LONGTERM_FILE} (Long-Term Memories): Search relevant sections via Grep by topic keywords (append-only, never delete)
Auto-trigger reminders:
- Discover new preferences/decisions/milestones → use memory-remember skill to write to appropriate file
- Topic relates to past discussions/historical context → use memory-recall skill to search memories
- Conversation ends or natural summary point → use memory-remember skill to save conversation summary
$SEARCH_MODE_INSTRUCTION"
fi

# ─── Output JSON ───
# Use jq to safely encode the context string
CONTEXT=$(printf "\n\n[ENGRAM MEMORY SYSTEM]\nDatetime: %s (%s)\nConversation Turn: %s %s\nPreset: %s\n\n%s%b" \
    "$DATETIME" "$WEEKDAY" "$COUNTER" "$RELOAD_HINT" "$PRESET" "$INSTRUCTIONS" "$UPGRADE_HINT")

jq -n --arg ctx "$CONTEXT" \
    '{"hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalContext":$ctx}}'
