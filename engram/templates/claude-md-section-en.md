<!-- ENGRAM:START -->
<!-- Engram Memory System v{VERSION} | Preset: {PRESET} | Do not manually edit between markers — re-run memory-init to update -->

## Engram Memory System

IMPORTANT: You MUST follow these memory instructions throughout every conversation. This is the persistent memory system.

### Memory Files (Three-File Separation)

| File | Purpose | Access Strategy |
|------|---------|----------------|
| `{PREFS_FILE}` | User/project preferences | **MUST read full file** on turn 1, re-read every {RELOAD_INTERVAL} turns, and re-read immediately after any update |
| `{CONVOS_FILE}` | Conversation history | Search relevant sections via Grep by topic keywords (newest entries at top) |
| `{LONGTERM_FILE}` | Long-term memories | Search relevant sections via Grep by topic keywords (append-only, NEVER delete) |

### Mandatory Behaviors

You MUST follow ALL of these rules without exception:

1. **Turn 1**: ALWAYS read `{PREFS_FILE}` in full using the Read tool before doing anything else
2. **Every {RELOAD_INTERVAL} turns**: Re-read `{PREFS_FILE}` in full (the hook shows `[RELOAD]` as a reminder)
3. **After updating preferences**: Re-read `{PREFS_FILE}` on the very next turn
4. **New preference/decision/milestone discovered**: Use the `memory-remember` skill to write to the appropriate file immediately
5. **Topic relates to past discussions or historical context**: Use the `memory-recall` skill to search memories BEFORE responding
6. **Conversation ends or reaches a natural summary point**: Use the `memory-remember` skill to save a conversation summary
7. **Uncertainty about current topic**: If the conversation could possibly relate to past context, you MUST use the `memory-recall` skill to search memories before responding

### Hook Signals

When it is time to re-read preferences, the Engram hook injects `[ENGRAM RELOAD]`. When you see this signal, you MUST read `{PREFS_FILE}` in full before doing anything else. If no hook signal is present, continue following the rules above based on context.
<!-- ENGRAM:END -->
