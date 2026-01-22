# TailwindPlus Plugin

**Access TailwindPlus UI component library with 657+ professional components**

Version: 1.0.0 | License: MIT | Author: Frank Wang

## Overview

TailwindPlus is a Claude Code plugin that provides access to the TailwindPlus UI component library. Search, browse, and retrieve production-ready code for Marketing, Application UI, and eCommerce components in multiple frameworks.

### Key Features

- **657+ Components**: Comprehensive UI component library
- **Multiple Frameworks**: Get code in HTML, React, or Vue
- **Tailwind CSS v3/v4**: Support for both Tailwind versions
- **Theme Modes**: Light, dark, and system theme support
- **Three Categories**: Application UI, Marketing, and eCommerce components

## Prerequisites

This plugin requires:

1. **TailwindPlus Subscription**: You must have an active TailwindPlus subscription (purchase at [tailwindplus.com](https://tailwindplus.com))
2. **TailwindPlus Data File (JSON)**: Download using [tailwindplus-downloader](https://github.com/richardkmichael/tailwindplus-downloader)
3. **jq**: Required for JSON processing (`brew install jq` on macOS)

### Downloading the Data File

Use the [tailwindplus-downloader](https://github.com/richardkmichael/tailwindplus-downloader) tool to download the TailwindPlus component data:

```bash
# Clone the downloader
git clone https://github.com/richardkmichael/tailwindplus-downloader.git
cd tailwindplus-downloader

# Follow the instructions in the repository to download the data file
# You will need your TailwindPlus credentials
```

> **Note**: The downloader requires a valid TailwindPlus subscription. Make sure you are authorized to access the TailwindPlus component library before using this plugin.

## Installation

### Add the marketplace

```bash
/plugin marketplace add /path/to/claude-tool
```

### Install TailwindPlus

```bash
/plugin install tailwindplus@claude-tools
```

### Configure Data Path

After installation, update the skill's script paths to point to your TailwindPlus data directory.

## Usage

### Search for Components

```
Find me a hero section component
```

The skill will search the component library and show matching options.

### Get Component Code

```
Get the pricing table component in React with Tailwind v4
```

The skill retrieves the exact component code with your specified options.

### List All Components

```
List all available TailwindPlus components
```

Returns all component names organized by category.

## Component Categories

### Application UI
- Forms (Input groups, Select menus, Textareas, etc.)
- Navigation (Navbars, Sidebars, Tabs, etc.)
- Data Display (Tables, Lists, Stats, etc.)
- Overlays (Modals, Dialogs, Notifications, etc.)
- Layout (Containers, Dividers, Panels, etc.)

### Marketing
- Hero Sections
- Feature Sections
- Pricing Tables
- Testimonials
- Call-to-Action Sections
- Footer Sections

### eCommerce
- Product Lists
- Product Overviews
- Shopping Carts
- Checkout Forms
- Order History
- Category Previews

## Framework Options

| Framework | Description |
|-----------|-------------|
| `html` | Pure HTML with Tailwind CSS classes |
| `react` | React/JSX components |
| `vue` | Vue.js single-file components |

## Theme Modes

- **Application UI & Marketing**: Use `light`, `dark`, or `system`
- **eCommerce**: Use `none` only

## Examples

### Finding a Button Component

```
User: I need a primary button with an icon

Claude: Let me search for button components...
[Searches and returns options]
Here's the code for "Application UI.Elements.Buttons.Primary" in React:
[Returns component code]
```

### Getting a Pricing Table

```
User: Show me pricing table components for a SaaS product

Claude: Searching for pricing components...
Found several options. Here's the three-tier pricing table:
[Returns component code in requested framework]
```

## Skill Reference

### tailwindplus

**Triggers**: "tailwindplus", "tailwind component", "UI component", "get component"

**Capabilities**:
- Search component library by keyword
- List all available components by category
- Retrieve component code with framework and theme options
- Get component metadata and info

## Notes

- TailwindPlus is a commercial component library - ensure you have a valid license
- Component paths use dot notation: `Category.Subcategory.Component Name`
- The skill reads from a local TailwindPlus data file

## Troubleshooting

### Script Path Errors

If you see path errors, update the script paths in SKILL.md to match your TailwindPlus data location.

### Component Not Found

Ensure the component name uses the exact path format: `"Category.Subcategory.Component Name"`

### Mode Errors

Remember: eCommerce components require `mode: none`, while Application UI and Marketing use `light`, `dark`, or `system`.

## License

MIT License

## Author

Frank Wang
