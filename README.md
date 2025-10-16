# Claude Tools

Collection of Claude Code plugins and tools by Frank Wang.

**Version**: 1.0.0
**Repository**: https://github.com/eternnoir/claude-tool

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

**Version**: 1.0.0
**Status**: Stable

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

## Marketplace Structure

```
claude-tools/
├── .claude-plugin/
│   └── marketplace.json        # Marketplace metadata
├── teds/                        # TEDS Plugin
│   ├── .claude-plugin/
│   │   └── plugin.json
│   ├── commands/               # 6 slash commands
│   ├── agents/                 # 5 specialized agents
│   ├── teds-core-prompt.md    # Core system documentation
│   └── README.md              # Plugin documentation
├── .gitignore
└── README.md                   # This file
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

---

## Author

**eternnoir**
Email: eternnoir@gmail.com
GitHub: [@eternnoir](https://github.com/eternnoir)

---

## Version History

### v1.0.0 (2025-10-16)
- Initial marketplace release
- Added TEDS Plugin v1.0.0

---

**Ready to get started?**

```bash
/plugin marketplace add eternnoir/claude-tool
/plugin install teds@claude-tool
/teds-init
```
