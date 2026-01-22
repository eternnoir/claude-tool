# ProjectMaster

> Comprehensive software project management system that adapts to your team's workflow

## Overview

ProjectMaster is a Claude Code plugin that provides intelligent project management capabilities for software development teams. It supports multiple development methodologies (Agile, Scrum, Kanban, Waterfall) and integrates seamlessly with the AkashicRecords governance system.

### Key Features

- **Adaptive Methodology Support**: Works with Agile, Scrum, Kanban, Waterfall, or hybrid approaches
- **Interactive Initialization**: Guided Q&A to understand your team's workflow
- **Meeting Management**: Structured meeting notes with automatic action item extraction
- **Sprint/Iteration Tracking**: Manage sprints, user stories, and tasks
- **Milestone Tracking**: Monitor project progress and deliverables
- **Communication Tracking**: Import and track emails, chat messages, screenshots with timeline management
- **Governance Integration**: Full compatibility with AkashicRecords RULE.md system
- **Natural Language Configuration**: Define workflows in RULE.md using plain language
- **Automatic Documentation**: Updates README.md indexes and maintains project status

## Philosophy

ProjectMaster follows the principle of **"Understand First, Prescribe Never"**:

1. **No assumptions**: Every team is different - ask before creating
2. **RULE.md driven**: Workflows defined in natural language, not hardcoded
3. **Human-in-the-loop**: AI recommends, humans decide
4. **Governance aware**: Respects and maintains directory governance
5. **Methodology agnostic**: Adapts to your process, not the other way around

## Installation

### Add the marketplace

```bash
/plugin marketplace add /path/to/claude-tool
```

### Install ProjectMaster

```bash
/plugin install projectmaster@claude-tools
```

Restart Claude Code to activate the plugin.

## Quick Start

### 1. Initialize a new project

Simply describe your need, and the `initialize-project` Skill will activate:

```
User: "I want to start a new project called 'Mobile App Redesign'"

Claude: I'll help you initialize a new project. Let me ask a few questions to set up
the right structure for your team...

[Interactive Q&A begins]
```

### 2. Track meetings

Mention meeting keywords to activate the `track-meeting` Skill:

```
User: "Create meeting notes for today's sprint planning"

Claude: I'll create a structured meeting note. What's the meeting title?
```

### 3. Manage sprints

Use sprint-related keywords:

```
User: "Start a new sprint for the authentication feature"

Claude: I'll create a new sprint following your Scrum workflow defined in RULE.md...
```

### 4. Track milestones

Record milestone achievements:

```
User: "Mark the 'Beta Release' milestone as completed"

Claude: I'll update the milestone status and generate a progress report...
```

### 5. Search project content

Find information across your project:

```
User: "Find all decisions about database selection"

Claude: Searching across meetings, docs, and decisions...
```

### 6. Track communications

Import external communications into the project timeline:

```
User: "Track this email from the client about the design review"

Claude: Analyzing email content and extracting key information...
Timeline updated with new communication entry.
```

## Core Concepts

### RULE.md Extensions for Projects

ProjectMaster extends AkashicRecords RULE.md with project-specific fields:

```markdown
# Project: Mobile App Redesign

## Purpose
Complete redesign of the mobile application with focus on UX improvements.

## Methodology
methodology: scrum
sprint_length: 2_weeks
daily_standup: true

## Team Structure
team_size: 7
roles:
  - product_owner: Alice Chen
  - scrum_master: Bob Smith
  - developers: [Carol, David, Eve]
  - designers: [Frank, Grace]

## Directory Structure
project-name/
├── RULE.md                  # This file
├── README.md               # Project overview (auto-maintained)
├── meetings/               # Meeting notes
│   ├── README.md
│   ├── daily-standups/
│   ├── sprint-planning/
│   └── retrospectives/
├── sprints/                # Sprint documentation
│   ├── README.md
│   ├── sprint-01/
│   └── sprint-02/
├── docs/                   # Technical documentation
├── decisions/              # Architecture decision records
├── communications/         # Email archives, external communications
└── milestones.yaml        # Milestone tracking

## Document Templates

### Meeting Notes Format
```yaml
---
title: [Meeting Title]
type: [standup|planning|retrospective|review|general]
date: [YYYY-MM-DD]
attendees: [list]
duration: [minutes]
---

## Agenda
- Item 1
- Item 2

## Discussion
[Notes]

## Action Items
- [ ] Task description - @owner - due: YYYY-MM-DD

## Decisions
[Key decisions made]
```

### Sprint Format
```yaml
---
sprint_number: 1
start_date: YYYY-MM-DD
end_date: YYYY-MM-DD
sprint_goal: [Goal]
status: [planning|active|completed]
---

## Sprint Goal
[Description]

## User Stories
- [ ] As a [user], I want [goal] so that [benefit]
  - Story Points: X
  - Priority: High|Medium|Low
  - Assignee: @name

## Sprint Retrospective
[Added at sprint end]
```

## Auto Workflows

ProjectMaster supports custom workflows in RULE.md:

```markdown
## When Claude creates meeting notes:
1. Extract all action items with @mentions
2. Update team member task lists
3. Link to related user stories if mentioned
4. Add to README.md meeting index

## When Claude marks milestone complete:
1. Update milestones.yaml status
2. Generate milestone summary report
3. Archive related sprint documentation
4. Update project timeline visualization

## When Claude archives sprint:
1. Move sprint folder to archived-sprints/
2. Generate sprint metrics report
3. Update velocity calculations
4. Link retrospective to next sprint planning
```

## Allowed Operations
All operations allowed. Track milestones and maintain governance.
```

### Governance Protocol

Every ProjectMaster Skill follows the AkashicRecords governance protocol:

1. **Pre-check**: Read RULE.md for project-specific workflows
2. **Execute**: Perform the operation following RULE.md specifications
3. **Post-update**: Update README.md indexes and project metadata
4. **Report**: Confirm completion with clear summary

## Skills Reference

### 1. initialize-project

**Triggers**: "new project", "start project", "initialize project", "create project"

**What it does**: Creates a new project with customized structure through interactive Q&A.

**Interactive Q&A Flow**:

**Phase 1: Methodology**
- What development methodology does your team use?
  - Scrum
  - Kanban
  - Waterfall
  - Agile (general)
  - Hybrid/Custom
- Sprint length? (if Scrum)
- Do you hold daily standups?

**Phase 2: Team Structure**
- Team size?
- Key roles? (Product Owner, Scrum Master, developers, etc.)
- Decision-making process?
- Communication channels?

**Phase 3: Documentation Preferences**
- Meeting notes format preference?
  - Simple markdown
  - Structured with frontmatter
  - Table-based
- Technical documentation style?
  - Informal
  - Formal/RFC-style
  - API documentation focused
- File naming convention?
  - Date-prefixed: `2025-11-13_meeting-notes.md`
  - Descriptive: `sprint-planning-sprint-5.md`
  - Numbered: `001-initial-planning.md`

**Phase 4: Integration Requirements**
- Version control: Git integration needed?
- Issue tracker: GitHub Issues / Jira / Linear / Other?
- CI/CD: Which tools?
- Other integrations: Slack, email, documentation sites?

**Output**: Complete project structure with customized RULE.md, directory tree, and initial documentation files.

### 2. track-meeting

**Triggers**: "meeting notes", "record meeting", "create meeting"

**What it does**: Creates structured meeting notes following project RULE.md template.

**Features**:
- Guided prompts for meeting details
- Automatic action item extraction with @mentions
- Links to related project artifacts
- Updates meeting index in README.md
- Categorizes by meeting type (standup, planning, retrospective, etc.)

### 3. manage-sprint

**Triggers**: "sprint", "iteration", "user story", "backlog", "velocity"

**What it does**: Manages sprint/iteration lifecycle for Agile teams.

**Capabilities**:
- **Sprint Planning**: Create sprint with goals and user stories
- **Daily Updates**: Track progress, blockers, updates
- **Sprint Review**: Document completed stories and demos
- **Retrospective**: Capture what went well, what to improve
- **Velocity Tracking**: Calculate and track team velocity

**Adapts to methodology**:
- Scrum: Full sprint ceremonies
- Kanban: Continuous flow tracking
- Waterfall: Phase-based milestones
- Hybrid: Custom workflows per RULE.md

### 4. track-milestone

**Triggers**: "milestone", "deadline", "deliverable", "release"

**What it does**: Manages project milestones and deliverables.

**Features**:
- Create milestones with dates and criteria
- Update milestone status (planned/in-progress/completed/delayed)
- Dependency tracking between milestones
- Automatic timeline updates
- Progress reports generation
- Alerts for approaching deadlines

### 5. project-search

**Triggers**: "find in project", "search project", "where is", "locate"

**What it does**: Intelligent search across all project artifacts.

**Search strategies**:
1. **README.md indexes** (fastest, preferred)
2. **Pattern matching** (filename search)
3. **Content search** (full-text across documents)
4. **Cross-reference search** (follow links and mentions)

**Search filters**:
- By type: meetings, sprints, docs, decisions, communications
- By date range: last week, last sprint, all time
- By person: @mentions
- By status: completed, in-progress, blocked

### 6. communication-tracker

**Triggers**: "email", "message", "communication", "screenshot", "track", "import"

**What it does**: Track and integrate external communications (emails, chat messages, screenshots) into project context with timeline management.

**Supported sources**:
- **Email**: Via `mu` command or direct text input
- **Screenshots**: Claude vision analyzes images of email/chat
- **Chat logs**: Slack, Teams, Discord, LINE formats
- **Documents**: PDF, DOCX via `markitdown`

**Features**:
- **First-time configuration**: Interactive Q&A for preferences (timeline format, backup policy, timestamp handling)
- **Timeline management**: Chronological `timeline.yaml` and `timeline.md`
- **Original backup**: Preserves raw data in `communications/raw/`
- **Key point extraction**: Automatically extracts decisions, action items, deadlines
- **Thread tracking**: Links related communications in conversation threads
- **Cross-referencing**: Links to sprints, milestones, meetings

**Directory structure** (created on first use):
```
communications/
├── config.yaml           # User preferences
├── README.md             # Communications index
├── timeline.yaml         # Machine-readable timeline
├── timeline.md           # Human-readable timeline
├── raw/                  # Original backups
├── by-date/              # Organized by YYYY-MM/
└── by-source/            # Organized by email/chat/screenshot/
```

**Integration**:
- Links communications to meetings, sprints, milestones
- Adds "Related Communications" sections to other documents
- Searchable via project-search Skill

## Commands Reference

### /project-init

Initialize ProjectMaster configuration for the current directory or subdirectories.

```bash
/project-init
```

This command:
- Scans for existing project structures
- Offers to create RULE.md if missing
- Validates directory governance
- Suggests improvements

### /project-status

View status of all projects in the workspace.

```bash
/project-status
```

Shows:
- Active projects with current sprint/phase
- Recent milestones
- Upcoming deadlines
- Team velocity trends
- Governance health

### /project-report

Generate comprehensive project report.

```bash
/project-report [project-name] [report-type]
```

Report types:
- `summary`: High-level project overview
- `sprint`: Current/recent sprint details
- `milestone`: Milestone progress
- `velocity`: Team velocity analysis
- `full`: Complete project status

## Integration with AkashicRecords

ProjectMaster and AkashicRecords work together seamlessly:

### Shared Governance

Both plugins read and respect the same RULE.md files:

```markdown
# Shared Directory RULE.md

## Purpose
Project documentation and knowledge base.

## When Claude adds content:
1. Determine if it's project management (meetings, sprints) or knowledge (articles, notes)
2. Route to appropriate directory
3. Update both project status and knowledge index

## Cross-references
- Meeting notes can reference knowledge articles
- Technical docs can reference sprint decisions
- All links automatically maintained by both plugins
```

### Complementary Skills

**AkashicRecords** handles:
- General knowledge management
- Article archiving
- Content classification
- Generic CRUD operations

**ProjectMaster** handles:
- Project-specific workflows
- Sprint/milestone tracking
- Meeting management
- Methodology-aware operations

### Coexistence Pattern

Both plugins can operate in the same directory:

```
project-root/
├── RULE.md                    # Shared governance
├── README.md                  # Both plugins update this
├── knowledge/                 # Managed by AkashicRecords
│   ├── RULE.md
│   ├── README.md
│   └── articles/
└── project-mgmt/             # Managed by ProjectMaster
    ├── RULE.md
    ├── README.md
    ├── meetings/
    └── sprints/
```

## Examples

### Example 1: Initialize a Scrum Project

```
User: I want to create a new project for our e-commerce platform redesign

Claude: I'll help you set up a new project! Let me gather some information about
your team's workflow.

📋 Development Methodology
What development process does your team follow?
1. Scrum (with sprints and ceremonies)
2. Kanban (continuous flow)
3. Waterfall (phase-based)
4. Hybrid/Custom

User: Scrum

Claude: Great! A few more questions about your Scrum setup:

- How long are your sprints? (e.g., 1 week, 2 weeks)
- Do you hold daily standups?
- Sprint planning at the start of each sprint?

User: 2 weeks, yes daily standups, yes sprint planning

Claude: Perfect! Now about your team...

👥 Team Structure
- How many people on the team?
- Key roles? (e.g., Product Owner, Scrum Master, Developers, Designers)

User: 6 people - 1 PO, 1 Scrum Master, 4 Developers

Claude: Excellent! Let me create your project structure...

✅ Created: ecommerce-redesign/
   ├── RULE.md (with Scrum workflow)
   ├── README.md
   ├── meetings/
   │   ├── daily-standups/
   │   ├── sprint-planning/
   │   ├── sprint-reviews/
   │   └── retrospectives/
   ├── sprints/
   │   └── backlog/
   ├── docs/
   ├── decisions/
   └── milestones.yaml

Your project is ready! The RULE.md is configured for 2-week Scrum sprints with
daily standups. You can start by creating your first sprint or adding backlog items.

Try: "Create sprint 1 for user authentication features"
```

### Example 2: Track a Sprint Planning Meeting

```
User: I need to record notes from today's sprint planning meeting

Claude: I'll create a sprint planning meeting note. Let me gather the details:

📅 Meeting Details:
- Meeting type: Sprint Planning (detected)
- Date: 2025-11-13 (today)
- Sprint number: 5
- Attendees: Who attended?

User: The whole team - Alice (PO), Bob (SM), Carol, David, Eve, Frank (devs)

Claude: Great! What was the sprint goal?

User: Complete user authentication and profile management features

Claude: Perfect! Can you share the user stories or should I help you create them?

User: Let me give you the stories:
1. As a user, I want to sign up with email so I can create an account
2. As a user, I want to log in with email/password so I can access my account
3. As a user, I want to edit my profile so I can update my information
4. As a user, I want to reset my password if I forget it

Claude: Excellent! Let me create the meeting notes and sprint document...

✅ Created: meetings/sprint-planning/2025-11-13_sprint-5-planning.md
✅ Created: sprints/sprint-05/sprint-plan.md
✅ Updated: README.md (added meeting and sprint to index)
✅ Updated: milestones.yaml (linked stories to Q1 authentication milestone)

Sprint 5 is now set up! The sprint runs for 2 weeks (per your RULE.md configuration).

Action items extracted:
- [ ] Bob: Set up sprint board - due: 2025-11-14
- [ ] Carol: Begin Story 1 (Sign up) - due: 2025-11-15

Next: Track daily progress with "Today's standup update..."
```

### Example 3: Mark Milestone Complete

```
User: We've completed the beta release milestone!

Claude: Congratulations! 🎉 Let me update the milestone and generate a summary.

📊 Analyzing Beta Release Milestone:
- Related sprints: Sprint 3, Sprint 4, Sprint 5
- User stories completed: 18
- Total story points: 87
- Timeline: 6 weeks (planned: 6 weeks) ✅ On time!

Would you like me to:
1. Update milestone status to "completed"
2. Archive related sprint documentation
3. Generate milestone completion report
4. Update project timeline

User: Yes to all

Claude: Processing...

✅ Updated: milestones.yaml (Beta Release → completed)
✅ Created: reports/milestone-beta-release-completion.md
✅ Archived: sprints/sprint-03,04,05 → archived-sprints/
✅ Updated: README.md (project timeline updated)

📄 Milestone Report Summary:
- Duration: 2025-10-01 to 2025-11-13 (6 weeks)
- Velocity: 14.5 points/week (team of 4 devs)
- Features delivered: Authentication, Profile Management, User Settings
- Next milestone: Public Release (due: 2025-12-15)

Great work! Ready to start planning the next milestone?
```

## Best Practices

### 1. Start with Initialization

Always use the `initialize-project` Skill before manually creating structures. The interactive Q&A ensures your RULE.md captures your team's actual workflow.

### 2. Keep RULE.md Updated

When your process changes, update the RULE.md:

```markdown
## Methodology
<!-- Changed from 2-week to 1-week sprints -->
sprint_length: 1_week
```

ProjectMaster will automatically adapt to the new configuration.

### 3. Consistent Meeting Documentation

Use the `track-meeting` Skill for all meetings to maintain consistent format and automatic indexing.

### 4. Link Everything

When creating content, mention related items:
- Reference user stories by name
- @mention team members
- Link to decisions or docs

ProjectMaster maintains these cross-references.

### 5. Regular Status Updates

Use `/project-status` regularly to keep the team aligned and spot blockers early.

### 6. Customize Templates

Edit the RULE.md templates to match your team's preferences. ProjectMaster reads and follows them exactly.

### 7. Archive Regularly

Completed sprints and old meetings should be archived (per RULE.md). This keeps active directories clean while preserving history.

## Troubleshooting

### Skills not activating

**Problem**: ProjectMaster Skills don't activate when expected.

**Solutions**:
- Check that the plugin is installed: `/plugin`
- Restart Claude Code after installation
- Use explicit trigger words: "initialize project", "track meeting", etc.
- Verify RULE.md exists (many Skills require it)

### Wrong directory structure created

**Problem**: Initialization created unexpected structure.

**Solution**:
- The structure comes from Q&A responses
- Delete and re-initialize with different answers
- Or manually edit RULE.md and use `/project-init` to align

### Meeting notes wrong format

**Problem**: Meeting notes don't match team's format.

**Solution**:
- Edit the RULE.md template section
- ProjectMaster reads templates from RULE.md dynamically
- Example: Change frontmatter fields, add/remove sections

### Milestone tracking not working

**Problem**: Milestones not updating or tracking correctly.

**Solution**:
- Check milestones.yaml exists (created during initialization)
- Verify RULE.md has milestone tracking enabled
- Use explicit language: "Mark [milestone name] as completed"

### Search not finding content

**Problem**: `project-search` Skill can't locate documents.

**Solutions**:
- Ensure README.md indexes are updated (use `/project-init` to rebuild)
- Check if files are in governance (RULE.md should allow indexing)
- Try explicit search: "search for [specific term] in meetings"

### Integration conflicts with AkashicRecords

**Problem**: Both plugins trying to manage the same content.

**Solution**:
- Clarify scope in RULE.md:
  ```markdown
  ## Content Routing
  - Project management → ProjectMaster (meetings, sprints, milestones)
  - Knowledge management → AkashicRecords (articles, notes, archives)
  - Technical docs → AkashicRecords (unless sprint-specific)
  ```
- Both plugins respect RULE.md, so clear definitions prevent conflicts

## Contributing

ProjectMaster is part of the claude-tools marketplace. To contribute:

1. Fork the repository
2. Make changes in `projectmaster/`
3. Test with local marketplace
4. Submit pull request

## License

MIT License - See LICENSE file for details.

## Support

- Issues: https://github.com/eternnoir/claude-tool/issues
- Documentation: https://github.com/eternnoir/claude-tool/blob/main/projectmaster/README.md
- Claude Code Docs: https://code.claude.com/docs

---

Built with ❤️ for software teams who want AI-assisted project management that adapts to their workflow, not the other way around.
