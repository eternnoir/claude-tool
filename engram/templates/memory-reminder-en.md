<!-- Legacy mode: These instructions are injected by the hook when CLAUDE.md integration is not active. -->
<!-- If CLAUDE.md integration is enabled, edit the ENGRAM:START/END section in CLAUDE.md instead. -->

Memory System Instructions (Three-File Separation):
1. {{PREFS_FILE}} (User Preferences): Read full file into context via Read tool (MUST read on turn 1, re-read every {{RELOAD_INTERVAL}} turns, re-read after updates)
2. {{CONVOS_FILE}} (Conversation History): Search relevant sections via Grep by topic keywords (newest first)
3. {{LONGTERM_FILE}} (Long-Term Memories): Search relevant sections via Grep by topic keywords (append-only, never delete)
Auto-trigger reminders:
- Discover new preferences/decisions/milestones → use memory-remember skill to write to appropriate file
- Topic relates to past discussions/historical context → use memory-recall skill to search memories
- Conversation ends or natural summary point → use memory-remember skill to save conversation summary
- Proactive query: if a conversation could possibly relate to past context, MUST use memory-recall skill to search memories before responding
