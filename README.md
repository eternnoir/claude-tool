# Claude Tools

Collection of Claude Code plugins and tools.

---

## Installation

### Add the Marketplace

```bash
claude
/plugin marketplace add eternnoir/claude-tool
```

### Install Plugins

```bash
# Install specific plugin
/plugin install teds@claude-tools

# Or browse and install interactively
/plugin
```

---

## Available Plugins

### TEDS (Task Execution Documentation System)

Comprehensive documentation system for complex, multi-session tasks.

**Features**:
- 📝 Mandatory logging of every action
- 🔄 Checkpoint & resume capability
- 🧠 Knowledge base accumulation
- 📊 Progress tracking and status reporting
- 🎯 Structured phase management
- 📦 Task archival for future reference

**Quick Start**:
```bash
/plugin install teds@claude-tools
/teds-init
/teds-start my-task "Task description"
```

**Documentation**: See [teds/README.md](./teds/README.md)

---

### AkashicRecords

**The first AI-native knowledge management system** - designed for AI agents to autonomously understand, organize, and maintain knowledge bases through self-describing directories.

**Why AI-Native?**

Traditional tools expect humans to organize files. AkashicRecords lets AI read your organizational rules and execute complex workflows autonomously:

- 📖 **AI reads RULE.md** to understand "what is this directory for?"
- 🤖 **AI executes workflows** defined in natural language (e.g., "when URL detected, fetch and archive")
- 🎯 **AI classifies content** by matching topics to directory purposes
- ✅ **Human confirms decisions** - AI recommends, you approve

**Features**:
- 🎯 5 generic Skills (add, update, delete, move, search)
- 📋 RULE.md-driven execution (business logic from YOUR rules, not hardcoded)
- 🧠 Smart content classification with user confirmation
- ✅ Self-governing directories with automatic README.md maintenance
- 🔧 Universal compatibility - no assumptions about directory structure

**Quick Start**:
```bash
/plugin install akashicrecords@claude-tools
/akashic-init                    # AI scans and understands your structure
"Save this note about AI"        # AI recommends location, you confirm
```

**Example**: Your `ReadLater/RULE.md` says "fetch URLs and convert to markdown" → AI reads this → When you share a URL, AI automatically fetches, converts, and archives per your rules.

**Documentation**: See [akashicrecords/README.md](./akashicrecords/README.md)

---

## Why TEDS?

### Problems It Solves

**1. Context Continuity Loss**

When working on complex multi-day projects with Claude:
- Each conversation is a new session; previous context is lost
- You need to re-explain "what we're doing" and "where we left off"
- Claude cannot remember previous work details and decisions

**2. Knowledge Evaporation**

During problem-solving, you learn valuable insights:
- API gotchas and limitations
- Best practices for certain patterns
- Discoveries made during debugging

But this valuable knowledge often **vanishes when the conversation ends**, preventing accumulation and reuse.

**3. Progress Opacity**

In complex tasks, it's hard to answer:
- "Where am I now?"
- "How much work remains?"
- "Which steps are completed?"
- "Where did I get blocked last time?"

**4. Work Continuity Breaks**

Multi-day work often encounters:
- Forgetting previous thought processes
- Repeating the same mistakes
- Not remembering previously attempted solutions
- Lack of complete decision records

### TEDS Solutions

**1. Complete Context Preservation**
- **execution_log.md**: Records every operation and result
- **status.yaml**: Tracks current phase and progress
- **context.md**: Preserves background information and constraints
- Enables full context loading when resuming work

**2. Systematic Knowledge Accumulation**
- **knowledge_base.md**: Automatically captures all discoveries and learnings
- Records solutions, best practices, and pitfall warnings
- Builds searchable, reusable knowledge base
- Provides reference for similar future tasks

**3. Transparent Progress Management**
- **plan.md**: Defines phases, milestones, success criteria
- **status.yaml**: Real-time updates of progress percentage and current phase
- **Checkpoint mechanism**: Automatically creates checkpoints every 30+ minutes
- Visualize task progress at any time

**4. Mandatory Documentation Protocol**

TEDS's core innovation is the **Mandatory Logging Protocol**:

```
After each tool call, immediately record:
✓ What operation was performed
✓ What the result was
✓ What was learned

This isn't based on developer discipline, but enforced through
the agent's self-check protocol.
```

### Core Value

TEDS essentially brings **scientific lab notebook** practices into AI-assisted programming:

> "If it isn't documented, it didn't happen"

It ensures all work processes, decisions, and learnings are systematically preserved, enabling future you (or other developers) to:
1. Understand why decisions were made
2. Reuse solutions
3. Avoid repeating mistakes
4. Build organizational knowledge assets

This is particularly valuable for building long-term knowledge management systems (like AkashicRecords).

---

## Marketplace Structure

```
claude-tools/
├── .claude-plugin/
│   └── marketplace.json          # Marketplace metadata
├── teds/                          # TEDS Plugin
│   ├── .claude-plugin/
│   │   └── plugin.json
│   ├── commands/                 # 6 slash commands
│   ├── agents/                   # 5 specialized agents
│   ├── teds-core-prompt.md      # Core system documentation
│   └── README.md                # Plugin documentation
├── akashicrecords/               # AkashicRecords Plugin
│   ├── .claude-plugin/
│   │   └── plugin.json
│   ├── commands/                 # 2 management commands
│   ├── agents/                   # 1 governance agent
│   ├── skills/                   # 5 generic Skills
│   │   ├── add-content/
│   │   ├── update-content/
│   │   ├── delete-content/
│   │   ├── move-content/
│   │   └── search-content/
│   └── README.md                # Plugin documentation
├── .gitignore
└── README.md                     # This file
```

---

## For Plugin Developers

### Adding Your Plugin to This Marketplace

1. Fork this repository
2. Add your plugin directory under the root
3. Update `.claude-plugin/marketplace.json`:
   ```json
   {
     "plugins": [
       {
         "name": "your-plugin",
         "source": "./your-plugin",
         "description": "Your plugin description",
         "version": "1.0.0"
       }
     ]
   }
   ```
4. Submit a pull request

### Plugin Requirements

- Must have `.claude-plugin/plugin.json`
- Must have `README.md` with usage documentation
- Should follow semantic versioning
- Should include examples and tests

---

## Development

### Local Testing

```bash
# Clone the repository
git clone https://github.com/eternnoir/claude-tool.git
cd claude-tool

# Add as local marketplace
claude
/plugin marketplace add file:///path/to/claude-tools

# Install and test plugins
/plugin install teds@claude-tools
```

### Contributing

Contributions welcome! Please:

1. Follow existing plugin structure
2. Include comprehensive documentation
3. Test thoroughly before submitting PR
4. Update marketplace.json and this README

---

## License

MIT License - See individual plugin directories for specific licenses.
