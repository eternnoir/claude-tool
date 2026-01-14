---
name: tailwindplus
description: Access TailwindPlus UI component library - search, list, and retrieve code for Marketing, Application UI, and eCommerce components in HTML/React/Vue with Tailwind CSS v3/v4
---

# TailwindPlus Component Browser

This skill provides access to the TailwindPlus UI component library with 657+ professional components.

## Available Commands

Run these scripts from the skill directory to interact with TailwindPlus components:

### List All Components
```bash
cd /Users/frankwang/Library/CloudStorage/Dropbox/personal_sync_doc/src/mcp-tailwindplus/.claude/skills/tailwindplus/scripts && python3 list_components.py
```
Returns all component names organized by category.

### Search Components
```bash
cd /Users/frankwang/Library/CloudStorage/Dropbox/personal_sync_doc/src/mcp-tailwindplus/.claude/skills/tailwindplus/scripts && python3 search_components.py "hero"
cd /Users/frankwang/Library/CloudStorage/Dropbox/personal_sync_doc/src/mcp-tailwindplus/.claude/skills/tailwindplus/scripts && python3 search_components.py "pricing table"
```
Search for components by keyword (case-insensitive).

### Get Component Code
```bash
cd /Users/frankwang/Library/CloudStorage/Dropbox/personal_sync_doc/src/mcp-tailwindplus/.claude/skills/tailwindplus/scripts && python3 get_component.py "Application UI.Forms.Input Groups.Simple" --framework html --version 4 --mode light
cd /Users/frankwang/Library/CloudStorage/Dropbox/personal_sync_doc/src/mcp-tailwindplus/.claude/skills/tailwindplus/scripts && python3 get_component.py "Ecommerce.Components.Product Overviews.With image gallery and expandable details" --framework react --version 4 --mode none
```

**Required Parameters:**
- `full_name`: The complete dotted path (e.g., "Application UI.Forms.Input Groups.Simple")
- `--framework`: `html`, `react`, or `vue`
- `--version`: `3` or `4` (Tailwind CSS version)
- `--mode`: Theme mode

**Mode Requirements (CRITICAL):**
- Application UI and Marketing components: use `light`, `dark`, or `system`
- eCommerce components: use `none` only

### Get Component Info
```bash
cd /Users/frankwang/Library/CloudStorage/Dropbox/personal_sync_doc/src/mcp-tailwindplus/.claude/skills/tailwindplus/scripts && python3 info.py
```
Returns metadata about the TailwindPlus data file.

## Component Categories

1. **Application UI** - Forms, navigation, data display, overlays, layout components
2. **Marketing** - Hero sections, features, pricing, testimonials, CTAs, footers
3. **Ecommerce** - Product lists, shopping carts, checkout forms, order history

## Framework Options

- `html` - Pure HTML with Tailwind CSS classes
- `react` - React/JSX components
- `vue` - Vue.js components

## Usage Examples

When user asks for a component:
1. First search to find available components
2. Get the exact component code with proper parameters

Example workflow for finding a button component:
```bash
# Step 1: Search
cd /Users/frankwang/Library/CloudStorage/Dropbox/personal_sync_doc/src/mcp-tailwindplus/.claude/skills/tailwindplus/scripts && python3 search_components.py "button"
# Step 2: Get the component
cd /Users/frankwang/Library/CloudStorage/Dropbox/personal_sync_doc/src/mcp-tailwindplus/.claude/skills/tailwindplus/scripts && python3 get_component.py "Application UI.Elements.Buttons.Primary" --framework react --version 4 --mode light
```

## Data Location

The TailwindPlus data file is located at:
`/Users/frankwang/Dropbox/personal_sync_doc/tailwindplus/`

The skill scripts automatically find the latest JSON file in this directory.
