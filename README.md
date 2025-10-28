# Claude Tools

Collection of Claude Code plugins and tools for enhancing AI-assisted workflows.

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
/plugin install akashicrecords@claude-tools

# Or browse and install interactively
/plugin
```

---

## Available Plugins

### TEDS (Task Execution Documentation System)

Comprehensive documentation system for complex, multi-session tasks with mandatory logging and knowledge accumulation.

**Key Features**:
- 📝 Mandatory logging of every action
- 🔄 Checkpoint & resume capability
- 🧠 Knowledge base accumulation
- 📊 Progress tracking and status reporting

**Quick Start**:
```bash
/plugin install teds@claude-tools
/teds-init
/teds-start my-task "Task description"
```

**Documentation**: [teds/README.md](./teds/README.md)

---

### AkashicRecords

AI-native knowledge management system where AI reads your organizational rules (RULE.md) and autonomously manages your knowledge base.

**Key Features**:
- 🎯 5 generic Skills (add, update, delete, move, search)
- 📋 RULE.md-driven workflows (your rules, not hardcoded logic)
- 🧠 Smart content classification with confirmation
- ✅ Self-governing directories with automatic maintenance

**Quick Start**:
```bash
/plugin install akashicrecords@claude-tools
/akashic-init                    # AI scans and understands your structure
"Save this note about AI"        # AI recommends location, you confirm
```

**Documentation**: [akashicrecords/README.md](./akashicrecords/README.md)

---

## Why These Tools?

### Why TEDS?

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

### Why AkashicRecords?

#### Problems It Solves

**1. Manual Knowledge Organization Overhead**

Traditional knowledge management requires constant human decisions:
- "Where should this file go?"
- "What should I name it?"
- "How should I format it?"
- "Which category does this belong to?"

This cognitive overhead accumulates, making knowledge capture feel like a chore rather than a natural process.

**2. Repetitive Workflow Execution**

Common workflows must be executed manually every time:
- Saving web articles: fetch URL → convert to markdown → create directory → save with metadata
- Daily logs: check date → parse to directory path → create structure → apply template
- Research notes: add frontmatter → categorize → update index → tag properly

Each workflow requires multiple steps, repeated identically for each new item.

**3. Inflexible Tool Assumptions**

Most knowledge management tools make hardcoded assumptions:
- Predefined folder structures (Inbox, Archive, etc.)
- Fixed workflows (tag-based, date-based, category-based)
- Rigid schemas and required fields
- One-size-fits-all organization paradigms

These assumptions conflict with individual organizational preferences and use cases.

**4. Knowledge Base Maintenance Burden**

As knowledge bases grow, maintenance becomes overwhelming:
- Indexes (README.md) fall out of sync with actual content
- Cross-references break when files move or get deleted
- Directory purposes become unclear over time
- Orphaned files accumulate without proper categorization

Manual maintenance doesn't scale, leading to gradual knowledge base decay.

#### AkashicRecords Solutions

**1. AI-Native Organization**

Instead of human-driven organization:
```
Traditional:
Human decides → Human organizes → Human maintains

AkashicRecords:
Human defines rules once (RULE.md) → AI understands rules →
AI recommends organization → Human confirms → AI maintains
```

AI reads RULE.md files to understand directory purposes, then autonomously:
- Analyzes content to determine topic and type
- Matches content to appropriate directories
- Recommends placement based on rule matching
- Executes organization with human confirmation

**2. Workflow Automation via RULE.md**

Define workflows once in natural language, AI executes automatically:

**Your RULE.md says:**
```markdown
When Claude detects URLs:
1. Use WebFetch to retrieve content
2. Convert HTML to clean markdown
3. Create directory: Articles/YYYY/MM/YYYY-MM-DD_title/
4. Save article.md and metadata.yaml
5. Update README.md
```

**AI executes exactly as specified** - no coding required, just describe what you want.

This means:
- Complex workflows become reusable
- Business logic lives in documentation (RULE.md)
- Anyone can define custom workflows in plain language
- Workflows adapt per directory (different RULE.md = different behavior)

**3. Universal Adaptability**

No hardcoded assumptions - Skills adapt to YOUR structure:
- Read RULE.md to understand what directories are for
- Execute per your specifications, not predefined logic
- Work with any organizational paradigm (date-based, topic-based, project-based, etc.)
- Support custom formats, naming conventions, and workflows

**Same Skills work for**:
- Academic research (papers with citations)
- Personal journaling (date-based entries)
- Project management (specs with frontmatter)
- Web archival (URL fetching and conversion)
- Work logs (hierarchical time tracking)

All through different RULE.md files, no code changes needed.

**4. Self-Governing Directories**

Automated maintenance eliminates decay:
- **Automatic README.md updates**: Every add/update/delete/move operation updates indexes
- **Dependency tracking**: Skills detect cross-references and warn before breaking them
- **Governance validation**: `/akashic-maintain` finds and fixes governance violations
- **Orphan detection**: Identifies files not listed in any README.md

The knowledge base maintains itself through:
- Continuous compliance checking (RULE.md requirements)
- Automatic index synchronization (README.md always current)
- Proactive issue detection and fixing offers
- Cross-reference integrity maintenance

#### Core Value

AkashicRecords fundamentally shifts knowledge management from **manual organization** to **automated governance**:

> "You define the rules, AI executes them"

Instead of organizing every file manually, you:
1. **Define rules once** (what is each directory for?)
2. **Let AI understand** (AI reads RULE.md to comprehend purposes)
3. **AI recommends** (intelligent classification based on content analysis)
4. **You confirm** (human-in-the-loop for critical decisions)
5. **AI maintains** (automatic governance and upkeep)

This creates a **self-maintaining knowledge base** that:
- Adapts to your organizational preferences
- Executes your custom workflows automatically
- Scales without increasing maintenance burden
- Accumulates knowledge without cognitive overhead

**Result**: Knowledge capture becomes effortless, organization becomes automatic, and maintenance becomes invisible.

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
