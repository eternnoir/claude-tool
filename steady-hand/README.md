# Steady-Hand Plugin

Maintains Claude Code quality standards by injecting context-aware reminders when context usage exceeds a configurable threshold.

## The Problem

As conversations with Claude Code grow longer, a subtle but significant issue emerges: **quality degradation at high context usage**.

When context usage approaches 60-80% of the maximum window:
- Claude may start skipping validation steps
- Responses can become less thorough
- Important details might be overlooked
- The assistant may "rush" to complete tasks

This is particularly problematic for complex, multi-step tasks where maintaining consistent quality is critical.

### Why This Happens

Claude Code has a finite context window (typically 200K tokens). As conversations accumulate history, tool outputs, and file contents, the available "thinking space" shrinks. Without awareness of this limitation, Claude continues working as if resources are unlimited.

### The Solution

**Steady-Hand** acts as a "steady hand on the wheel" - a gentle reminder system that:

1. **Monitors** context usage in real-time via the `UserPromptSubmit` hook
2. **Alerts** Claude when usage exceeds a configurable threshold
3. **Encourages** quality maintenance through injected system reminders
4. **Suggests** creating handoff notes when context is critically low

Think of it as a "fuel gauge" for your Claude Code sessions - you wouldn't drive without knowing your gas level, and you shouldn't work through complex tasks without knowing your context level.

## How It Works

1. **Hook Trigger**: Uses the `UserPromptSubmit` hook, which runs after user submits a prompt but before Claude processes it
2. **Context Calculation**: Parses the JSONL transcript file to calculate current context usage:
   ```
   total_tokens = input_tokens + cache_read_input_tokens + cache_creation_input_tokens
   ```
3. **Threshold Check**: Compares usage against the configured threshold (default: 60%)
4. **Reminder Injection**: If threshold is exceeded, injects a customizable reminder into the context

## Installation

1. Add this plugin to your Claude Code configuration:
   ```bash
   /plugin install steady-hand@claude-tools
   ```
2. The settings file `.claude/steady-hand_local_setting.json` will be **automatically created** on first run

## Configuration

The settings file is located at `.claude/steady-hand_local_setting.json` in your project root (or any parent directory):

```json
{
  "enabled": true,
  "threshold": 60,
  "max_tokens": 200000,
  "prompt": "[System Reminder] Maintain your quality standards. Do not skip validation steps. If remaining context is insufficient to complete the current task with high quality, pause and create a handoff note."
}
```

### Settings

| Setting | Type | Default | Description |
|---------|------|---------|-------------|
| `enabled` | boolean | `true` | Enable or disable the plugin |
| `threshold` | integer | `60` | Context usage percentage (0-100) at which to inject reminder |
| `max_tokens` | integer | `200000` | Maximum context window size (Claude Sonnet default) |
| `prompt` | string | See above | Custom reminder message to inject |

### Recommended Thresholds

| Use Case | Threshold | Rationale |
|----------|-----------|-----------|
| Complex coding tasks | 50-60% | Leave room for tool outputs and file reads |
| Simple conversations | 70-80% | Less overhead needed |
| Research/exploration | 60-70% | Balance between depth and capacity |

### Model-Specific Max Tokens

Adjust `max_tokens` based on your model:
- Claude Sonnet: 200,000 tokens (default)
- Claude Opus: 200,000 tokens
- Claude Haiku: 200,000 tokens

## Context Calculation

The plugin calculates context usage by:
1. Reading the transcript JSONL file (provided via `transcript_path` in hook input)
2. Finding the most recent valid API response (excluding sidechain and error messages)
3. Summing up token counts from the usage data

This approach is based on research from the Claude Code community, as there is currently no official environment variable for context usage.

## Requirements

- `jq` command-line JSON processor
- macOS or Linux (uses `tail -r` on macOS, `tac` on Linux)

## Troubleshooting

### Reminder not appearing
1. Check that the settings file is in the correct location (`.claude/steady-hand_local_setting.json`)
2. Verify `enabled` is set to `true`
3. Ensure your context usage actually exceeds the threshold
4. Check debug logs for hook execution

### Incorrect threshold behavior
- Verify `max_tokens` matches your model's context window
- Check that `threshold` is a number between 0-100

### Hook not executing
- Verify the plugin is installed: `/plugin list`
- Check that hooks are loaded in debug logs

## Best Practices

1. **Start with 60% threshold** - This gives Claude enough warning to maintain quality
2. **Customize the prompt** - Tailor the reminder to your specific workflow
3. **Use handoff notes** - When context is critically low, have Claude document the current state for continuation in a new session
4. **Monitor debug logs** - Check `/Users/yourname/.claude/debug/` for hook execution details

## References

- [Calculate Claude Code Context Usage](https://codelynx.dev/posts/calculate-claude-code-context) - Research on context calculation
- [GitHub Issue #6577](https://github.com/anthropics/claude-code/issues/6577) - Request for official context usage API
