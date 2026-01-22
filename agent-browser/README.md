# agent-browser

Claude Code plugin for browser automation - navigate websites, interact with web pages, fill forms, take screenshots, and extract data.

## Source

This plugin is based on [vercel-labs/agent-browser](https://github.com/vercel-labs/agent-browser).

## Installation

Requires `agent-browser` CLI to be installed:

```bash
npm install -g @anthropic-ai/agent-browser
```

## Quick Start

```bash
agent-browser open <url>        # Navigate to page
agent-browser snapshot -i       # Get interactive elements with refs
agent-browser click @e1         # Click element by ref
agent-browser fill @e2 "text"   # Fill input by ref
agent-browser close             # Close browser
```

## Documentation

See the [official repository](https://github.com/vercel-labs/agent-browser) for full documentation.
