---
name: memory-status
description: Display memory system status. Auto-triggered when the user asks about memory state or for diagnostics.
---

# Memory Status

Display the current state of the Engram memory system.

## When to Use

Use when:
- The user asks about the memory system status
- The user wants to know what's been remembered
- Diagnostics are needed (missing files, empty preferences, etc.)
- The user asks "what do you know about me?"

## Workflow

### 1. Read Configuration

Read `.claude/memory-settings.json` for:
- Preset type
- File names
- Language setting
- Reload interval

### 2. Read Turn Counter

Read `.claude/memory_counter.txt` for the current conversation turn count.

### 3. Inspect Memory Files

For each of the three memory files, gather:
- File exists? (yes/no)
- File size (approximate line count)
- Last modified date
- Number of entries:
  - Preferences: count of filled (non-empty) fields
  - Conversations: count of `### YYYY-MM-DD` entries
  - Long-term: count of `- YYYY-MM-DD:` entries

### 4. Display Status Report

Format:

```
Engram Memory System Status
═══════════════════════════

Configuration:
  Preset:           <preset>
  Language:          <language>
  Reload interval:   every <N> turns
  Conversation turn: <current-turn>

Memory Files:
  <preferences-file>
    Status:  <exists/missing>
    Size:    <lines> lines
    Fields:  <filled>/<total> filled

  <conversations-file>
    Status:  <exists/missing>
    Size:    <lines> lines
    Entries: <count> conversations

  <longterm-file>
    Status:  <exists/missing>
    Size:    <lines> lines
    Entries: <count> memories

Recent Conversations (last 3):
  - YYYY-MM-DD HH:MM - Topic
  - YYYY-MM-DD HH:MM - Topic
  - YYYY-MM-DD HH:MM - Topic

Health Check:
  ✓ All files present
  ✓ Preferences populated
  ✗ No conversation summaries yet
```

### 5. Health Check Items

Check for:
- Missing memory files → warn and offer to recreate
- Empty preferences file → suggest filling in
- No conversation summaries → note that this is normal for new setups
- Missing counter file → offer to reinitialize
- Missing settings file → offer to run memory-init
