# Claude Tools

A curated collection of 8 professional-grade Claude Code plugins for enhancing AI-assisted workflows.

---

## Installation

### Add the Marketplace

```bash
claude
/plugin marketplace add legacybridge-tech/claude-plugins
```

### Install Plugins

```bash
# Install specific plugin
/plugin install teds@legacybridge-cc-plugins
/plugin install akashicrecords@legacybridge-cc-plugins
/plugin install projectmaster@legacybridge-cc-plugins
/plugin install multi-perspective@legacybridge-cc-plugins
/plugin install gemini-api@legacybridge-cc-plugins
/plugin install agent-browser@legacybridge-cc-plugins
/plugin install tailwindplus@legacybridge-cc-plugins
/plugin install steady-hand@legacybridge-cc-plugins

# Or browse and install interactively
/plugin
```

---

## Available Plugins

| Plugin | Description | Version |
|--------|-------------|---------|
| **TEDS** | Task Execution Documentation System | 1.2.0 |
| **AkashicRecords** | AI-native knowledge management | 1.6.0 |
| **ProjectMaster** | Software project management | 1.2.1 |
| **Multi-Perspective** | Multi-expert proposition analysis | 1.0.0 |
| **Gemini API** | Google Gemini API integration | 1.0.0 |
| **Agent Browser** | Browser automation for web tasks | 1.0.0 |
| **TailwindPlus** | TailwindPlus UI component library | 1.0.0 |
| **Steady-Hand** | Context usage monitoring & quality reminders | 1.1.3 |

---

### TEDS (Task Execution Documentation System)

Comprehensive documentation system for complex, multi-session tasks with mandatory logging and knowledge accumulation.

**Key Features**:
- Mandatory logging of every action
- Checkpoint & resume capability
- Knowledge base accumulation
- Progress tracking and status reporting

**Quick Start**:
```bash
/plugin install teds@legacybridge-cc-plugins
/teds-init
/teds-start my-task "Task description"
```

**Documentation**: [teds/README.md](./teds/README.md)

---

### AkashicRecords

AI-native knowledge management system where AI reads your organizational rules (RULE.md) and autonomously manages your knowledge base.

**Key Features**:
- 12 generic Skills (add, update, delete, move, search + todo tracking)
- RULE.md-driven workflows (your rules, not hardcoded logic)
- Smart content classification with confirmation
- Self-governing directories with automatic maintenance

**Quick Start**:
```bash
/plugin install akashicrecords@legacybridge-cc-plugins
/akashic-init                    # AI scans and understands your structure
"Save this note about AI"        # AI recommends location, you confirm
```

**Documentation**: [akashicrecords/README.md](./akashicrecords/README.md)

---

### ProjectMaster

Comprehensive software project management system that adapts to your team's workflow with support for Agile, Scrum, Kanban, and Waterfall methodologies.

**Key Features**:
- Adaptive methodology support
- Meeting management with automatic action item extraction
- Sprint/iteration tracking
- Milestone tracking with dependency management
- Communication tracking (emails, messages, screenshots)

**Quick Start**:
```bash
/plugin install projectmaster@legacybridge-cc-plugins
/project-init
"Create meeting notes for today's sprint planning"
```

**Documentation**: [projectmaster/README.md](./projectmaster/README.md)

---

### Multi-Perspective

Multi-perspective analysis tool for examining propositions through dynamically generated expert perspectives.

**Key Features**:
- Dynamic expert generation (4-6 relevant experts per proposition)
- Three analysis modes: Validation, Comprehensive, Debate
- User confirmation checkpoints
- Flexible save options

**Quick Start**:
```bash
/plugin install multi-perspective@legacybridge-cc-plugins
/analyze "We should adopt microservices architecture"
```

**Documentation**: [multi-perspective/README.md](./multi-perspective/README.md)

---

### Gemini API

Google Gemini API integration for text generation, multimodal analysis, image generation, and more.

**Key Features**:
- Text generation with configurable parameters
- Multimodal analysis (images, video, audio)
- Image generation (Nano Banana)
- Function calling and search grounding

**Quick Start**:
```bash
/plugin install gemini-api@legacybridge-cc-plugins
"Use Gemini to analyze this image"
```

**Documentation**: [gemini-api/README.md](./gemini-api/README.md)

---

### Agent Browser

Browser automation plugin for web testing, form filling, screenshots, and data extraction.

**Key Features**:
- Navigate websites
- Interact with web pages
- Fill forms and take screenshots
- Extract data from pages

**Prerequisites**: Requires `@anthropic-ai/agent-browser` CLI

**Quick Start**:
```bash
/plugin install agent-browser@legacybridge-cc-plugins
"Open Google and search for Claude Code"
```

**Documentation**: [agent-browser/README.md](./agent-browser/README.md)

---

### TailwindPlus

Access TailwindPlus UI component library with 657+ professional components.

**Key Features**:
- 657+ UI components
- Multiple frameworks (HTML, React, Vue)
- Tailwind CSS v3/v4 support
- Three categories: Application UI, Marketing, eCommerce

**Prerequisites**: Requires TailwindPlus data file and license

**Quick Start**:
```bash
/plugin install tailwindplus@legacybridge-cc-plugins
"Find me a hero section component"
```

**Documentation**: [tailwindplus/README.md](./tailwindplus/README.md)

---

### Steady-Hand

Context usage monitoring plugin that maintains quality standards by injecting reminders when context usage exceeds threshold.

**The Problem**: As conversations grow longer, Claude may experience quality degradation - skipping validation steps, rushing through tasks, or overlooking details.

**Key Features**:
- Real-time context usage monitoring via hooks
- Configurable threshold alerts (default: 60%)
- Auto-creates settings file on first run
- Customizable reminder prompts

**Quick Start**:
```bash
/plugin install steady-hand@legacybridge-cc-plugins
# Settings auto-created at .claude/steady-hand_local_setting.json
```

**Documentation**: [steady-hand/README.md](./steady-hand/README.md)

---

## Philosophy & Design

### RULE.md-Driven Architecture

All plugins in this marketplace follow a RULE.md-driven approach:
- Business logic defined in natural language, not hardcoded
- AI reads rules and executes accordingly
- Users define workflows once, AI automates forever

### AI-Native Design

These plugins are designed for AI agents to execute autonomously:
- Self-describing directories with clear purposes
- Mandatory documentation protocols
- Human-in-the-loop confirmation for critical decisions
- Automatic governance and maintenance

### Why These Tools?

#### Context Continuity Problem

When working on complex multi-day projects with Claude:
- Each conversation is a new session; previous context is lost
- You need to re-explain "what we're doing" and "where we left off"
- Valuable knowledge often vanishes when conversations end

**Solution**: TEDS provides complete context preservation with execution logs, status tracking, and knowledge base accumulation.

#### Knowledge Organization Overhead

Traditional knowledge management requires constant human decisions:
- "Where should this file go?"
- "What should I name it?"
- "How should I format it?"

**Solution**: AkashicRecords shifts from manual organization to automated governance. You define rules once (RULE.md), AI executes them automatically.

#### Project Management Complexity

Software teams have diverse workflows:
- Different methodologies (Scrum, Kanban, Waterfall)
- Various meeting types and documentation needs
- Multiple communication channels to track

**Solution**: ProjectMaster adapts to YOUR workflow, not the other way around. Configure once, automate forever.

---

## Marketplace Structure

```
claude-tools/
├── .claude-plugin/
│   └── marketplace.json          # Marketplace metadata (v1.10.0)
├── LICENSE                       # MIT License
├── CLAUDE.md                     # Development guide
├── README.md                     # This file
├── teds/                         # TEDS Plugin
├── akashicrecords/               # AkashicRecords Plugin
├── projectmaster/                # ProjectMaster Plugin
├── multi-perspective/            # Multi-Perspective Plugin
├── gemini-api/                   # Gemini API Plugin
├── agent-browser/                # Agent Browser Plugin
├── tailwindplus/                 # TailwindPlus Plugin
└── steady-hand/                  # Steady-Hand Plugin
```

---

## For Plugin Developers

### Adding Your Plugin to This Marketplace

1. Fork this repository
2. Add your plugin directory under the root
3. Follow the structure in [CLAUDE.md](./CLAUDE.md)
4. Update `.claude-plugin/marketplace.json`
5. Submit a pull request

### Plugin Requirements

- Must have `.claude-plugin/plugin.json` with name, description, version, author
- Must have `README.md` with usage documentation
- Should have `skills/` directory with SKILL.md files
- Should follow semantic versioning

---

## Development

### Local Testing

```bash
# Clone the repository
git clone https://github.com/legacybridge-tech/claude-plugins.git
cd claude-tool

# Add as local marketplace
claude
/plugin marketplace add file:///path/to/claude-tool

# Install and test plugins
/plugin install teds@legacybridge-cc-plugins
```

### Contributing

Contributions welcome! Please:

1. Follow existing plugin structure (see CLAUDE.md)
2. Include comprehensive documentation
3. Test thoroughly before submitting PR
4. Update marketplace.json and this README

---

## License

MIT License - See [LICENSE](./LICENSE) file for details.

---

## Author

Frank Wang ([@eternnoir](https://github.com/eternnoir))

## Support

- Issues: https://github.com/legacybridge-tech/claude-plugins/issues
- Documentation: https://code.claude.com/docs
