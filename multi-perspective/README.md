# Multi-Perspective Plugin

**Dynamic expert analysis for rigorous thinking**

Version: 1.0.0 | License: MIT | Author: Frank Wang

## Overview

Multi-Perspective is a Claude Code plugin that analyzes propositions through dynamically generated expert perspectives. Unlike fixed expert panels, it creates relevant experts tailored to each unique proposition.

### Key Features

- **Dynamic Expert Generation**: Creates 4-6 relevant experts based on the proposition's domain
- **User Confirmation Mechanism**: Review and adjust the expert panel before analysis begins
- **Three Analysis Modes**:
  - **Validation Mode**: Find blindspots, assumptions, and counterarguments
  - **Comprehensive Analysis Mode**: Get detailed perspectives from each expert
  - **Debate Mode**: Watch experts engage in structured dialogue
- **Flexible Save Options**: Support for specified paths, AkashicRecords integration, or formatted output

## Quick Start

### 1. Present Your Proposition

```
I believe [your proposition]
```

Or use the command:

```
/analyze "your proposition"
```

### 2. Confirm Understanding

The skill will restate your proposition and identify:
- Key domains involved
- Implicit assumptions in the framing

Confirm or adjust before continuing.

### 3. Review Expert Panel

Receive 4-6 recommended experts, including:
- Their areas of expertise
- Their likely stance (supportive/skeptical/neutral)
- Their unique insights

Accept, modify, or add custom experts.

### 4. Select Analysis Mode

Choose:
- **Validation Mode**: Best for testing robustness of an idea
- **Comprehensive Analysis Mode**: Best for understanding all angles
- **Debate Mode**: Best for exploring genuine disagreements

### 5. Receive Analysis

Get structured analysis based on the selected mode, followed by synthesis and recommendations.

### 6. Optional: Save Results

Choose your preferred save method: specify a path, use AkashicRecords, or copy formatted content.

## When to Use

- Testing arguments or assumptions
- Preparing presentations or decisions
- Exploring controversial topics
- Discovering blindspots in your thinking
- Developing balanced understanding of complex issues

## Skill Reference

### multi-perspective-analysis

**Triggers**: "perspectives on", "analyze from multiple angles", "validate my assumption", "what do experts think", "debate", "challenge this idea"

**Workflow**:
1. Proposition intake and clarification
2. Dynamic expert generation
3. User confirmation of expert panel
4. Mode selection
5. Analysis execution
6. Optional save (supporting multiple methods)

## Example Use Cases

### Technical Decisions

```
/analyze "We should migrate from monolithic to microservices architecture"

Generated experts:
- Enterprise Architect
- DevOps Engineer
- CTO
- Technology Historian
- Systems Theorist
```

### Business Strategy

```
/analyze "Remote work improves productivity"

Generated experts:
- Organizational Psychologist
- Remote-First CEO
- Traditional Management Consultant
- Labor Economist
- Systems Thinker
```

### Philosophical Questions

```
/analyze "AI should have legal personhood"

Generated experts:
- AI Ethicist
- Legal Scholar
- Philosopher of Mind
- AI Researcher
- Policy Maker
- Systems Theorist
```

## Save Options

After analysis completion, you can choose:

1. **Specify Path**: Save directly to your specified file path
2. **Via AkashicRecords**: Use the knowledge management system (if enabled)
3. **Formatted Output**: Output Markdown formatted content for manual copying

Saved files will include:
- Appropriate frontmatter (date, type, experts, tags)
- Complete analysis content
- Key insights summary

## Best Practices

1. **Be Specific**: Clear propositions get better expert matching
2. **Review Experts**: Adjust the panel if it doesn't fit your needs
3. **Choose Mode Carefully**: Each mode serves a different purpose
4. **Save Important Analyses**: Build a knowledge base of your thinking
5. **Iterate**: Refine propositions based on initial insights

## Changelog

### v1.0.0
- Initial release
- Dynamic expert generation (4-6 experts)
- Three analysis modes (Validation, Comprehensive, Debate)
- User confirmation checkpoints
- Flexible save options (specified path, AkashicRecords, formatted output)

## License

MIT License

## Author

Frank Wang
