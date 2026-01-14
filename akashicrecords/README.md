# AkashicRecords Plugin

**The First AI-Native Knowledge Management System**

Version: 1.2.0 | License: MIT | Author: Frank Wang

## Overview

AkashicRecords is a Claude Code plugin designed for **AI agents to autonomously manage knowledge bases**. Unlike traditional tools built for human organization, AkashicRecords enables AI to read your organizational rules, understand directory purposes, and execute complex workflows independently.

### What Makes It AI-Native?

**Traditional Approach** (Human-Centric):
```
1. Human decides where files go
2. Human manually organizes content
3. Human follows their own mental rules
4. Tools provide storage, not intelligence
```

**AkashicRecords Approach** (AI-Centric):
```
1. Human defines rules in RULE.md (once)
2. AI reads RULE.md to understand purposes
3. AI autonomously classifies and organizes
4. AI executes custom workflows automatically
5. Human confirms critical decisions only
```

### Core Philosophy

**Self-Describing Directories + AI Understanding = Autonomous Knowledge Management**

- **RULE.md files**: Directories describe their own purpose and workflows
- **AI reads and understands**: No hardcoded assumptions, AI learns from your rules
- **Generic Skills**: Universal operations that adapt to any organizational structure
- **Human-in-the-loop**: AI recommends, human confirms, ensuring control

This enables AI to:
- 📖 **Understand** directory purposes by reading RULE.md
- 🤖 **Execute** custom workflows defined in natural language
- 🎯 **Classify** content by matching topics to purposes
- ✅ **Maintain** governance automatically (README.md updates, cross-references)
- 🔄 **Adapt** to any organizational structure without reprogramming

## Key Features

### 1. Universal File Operations (Skills)

Seven generic Skills that work with any directory structure:

- **add-content**: Create files by reading RULE.md to understand how
- **update-content**: Update files while respecting RULE.md constraints
- **delete-content**: Delete files with dependency checking and RULE.md permissions
- **move-content**: Move/rename files across directories with format adaptation
- **search-content**: Search using README.md indexes, patterns, or deep content search
- **cross-domain-thinking**: Find connections across disciplines with structured analysis
- **process-file**: Process arbitrary files (email, PDF, Office docs, images) for intelligent archiving

### 2. RULE.md-Driven Business Logic

Each directory can have a `RULE.md` file specifying:
- Directory purpose (e.g., "for web content archival")
- File naming conventions
- Required file formats
- Special instructions for Claude (e.g., "fetch from URL and convert to markdown")
- Allowed operations and constraints

Skills read RULE.md and execute accordingly - **no hardcoded assumptions**.

### 3. Smart Classification with Confirmation

When creating content, Skills:
1. Analyze content to understand topic/type
2. Read RULE.md of multiple directories to understand purposes
3. Recommend most suitable directory based on matching
4. Ask user for confirmation before proceeding
5. Execute per target directory's RULE.md specifications

### 4. Directory Governance

- Automatic README.md updating after every operation
- RULE.md compliance checking before operations
- Directory structure validation and maintenance
- Cross-reference tracking and broken link detection

### 5. Management Commands

- `/akashic-init`: Initialize governance for directory tree
- `/akashic-maintain`: Validate and fix governance issues

## How It Works

### The RULE.md Contract

Each directory's `RULE.md` defines behavior. Here's how it enables universal workflows:

#### Example 1: Web Content Archival

**Your ReadLater/RULE.md says:**
```markdown
# ReadLater Directory

## Purpose
This directory stores archived web content for later reading.

## When Claude detects URLs or "readlater" keyword:
1. Use WebFetch to retrieve content
2. Convert HTML to clean markdown
3. Create directory: Articles/YYYY/MM/YYYY-MM-DD_title-slug/
4. Save article.md with content
5. Create metadata.yaml with URL, title, date, summary
6. Update README.md

## File Structure
Articles/
└── YYYY/
    └── MM/
        └── YYYY-MM-DD_title-slug/
            ├── article.md
            ├── metadata.yaml
            └── images/ (optional)
```

**When you say:** "readlater https://example.com/article"

**add-content Skill:**
1. Detects URL in request
2. Scans directories and reads their RULE.md files
3. Sees ReadLater/RULE.md mentions "web content archival"
4. Recommends ReadLater/ directory
5. Reads ReadLater/RULE.md for detailed instructions
6. Executes workflow exactly as specified:
   - Fetches URL with WebFetch
   - Converts to markdown
   - Creates directory structure
   - Saves article.md and metadata.yaml
7. Updates README.md
8. Reports completion

**Result:** Business logic executed, but defined by YOUR RULE.md, not hardcoded in plugin!

#### Example 2: Daily Work Logs

**Your Work/WorkLog/RULE.md says:**
```markdown
# WorkLog Directory

## Purpose
Daily work logs with meetings, tasks, and time tracking.

## Structure
YYYY/
└── QX/
    └── MM-Month/
        └── YYYY-MM-DD.md

## When Claude processes worklog requests:
1. MUST verify current datetime first (run `date` command)
2. Parse date to determine: YYYY/QX/MM-Month/ path
3. Check if directory structure exists, create if needed
4. Create/update YYYY-MM-DD.md with this format:

   # Work Log - YYYY-MM-DD (Day of Week)

   ## Meetings
   - [Time] Meeting name (Duration)

   ## Priority Tasks
   ### High Priority
   - [ ] Task description

   ### Medium Priority
   - [ ] Task description

   ## Time Slots
   ...

5. Update hierarchical README.md files:
   - Day file README
   - Month directory README
   - Quarter directory README
   - Main WorkLog README
```

**When you say:** "Update my worklog"

**add-content Skill:**
1. Analyzes request - worklog keyword detected
2. Scans directories, finds Work/WorkLog/
3. Reads Work/WorkLog/RULE.md
4. Sees worklog instructions
5. Executes per RULE.md:
   - Runs `date` command → 2025-10-28
   - Parses to 2025/Q4/10-October/
   - Checks if directory exists, creates if needed
   - Creates/updates 2025-10-28.md with template format
   - Updates all README.md files in hierarchy
6. Reports completion with daily log location

**Result:** WorkLog workflow executed based on your RULE.md specifications!

### Why This Design Works

#### For Any Directory Structure

You're not limited to predefined directories like `ReadLater/` or `Research/`. You define:
- Your own directory names
- Your own purposes in RULE.md
- Your own workflows
- Your own file formats

Skills adapt automatically by reading your RULE.md files.

#### For Different Use Cases

**Academic Research:**
```
Research/
├── RULE.md (Purpose: "Academic papers and research notes")
├── Papers/
├── Experiments/
└── Literature/
```

**Project Management:**
```
Projects/
├── RULE.md (Purpose: "Active projects with specs and docs")
├── ProjectA/
│   ├── RULE.md (Purpose: "Project A materials, requires frontmatter")
│   ├── specs.md
│   └── docs/
└── ProjectB/
```

**Personal Journaling:**
```
Journal/
├── RULE.md (Purpose: "Daily journal entries, date-based naming")
├── 2025/
│   ├── 01-January/
│   └── 02-February/
```

Skills work with all of these because they read RULE.md to understand behavior!

## Installation

### Prerequisites

- Claude Code v1.0 or later
- Basic familiarity with markdown and directory structure

### Install from Marketplace

```bash
# Add claude-tools marketplace
/plugin marketplace add /path/to/claude-tool

# Or if using Git repository
/plugin marketplace add https://github.com/eternnoir/claude-tool

# Install akashicrecords plugin
/plugin install akashicrecords@claude-tools
```

### Verify Installation

After installation, check available commands:
```bash
/help
```

You should see `/akashic-init` and `/akashic-maintain` in the commands list.

## Quick Start

### 1. Initialize Your Directory

Navigate to your knowledge base directory and initialize governance:

```bash
cd /path/to/your/knowledge-base
claude
```

```
/akashic-init
```

This will:
- Scan your directory structure
- Create initial RULE.md files (or inherit from parent)
- Generate README.md indexes for all directories
- Set up governance tracking

### 2. Define Directory Purposes

Edit RULE.md files to define what each directory is for:

**Example - Research/RULE.md:**
```markdown
# Research Directory

## Purpose
Technical and academic research notes, papers, and experiments.

## File Naming
Files should be named: YYYY-MM-DD-topic-name.md

## Format
Markdown files with optional YAML frontmatter:
---
title: [Title]
date: [Date]
tags: [tag1, tag2]
---

## Allowed Operations
- Create: Yes
- Update: Yes
- Delete: Yes (with confirmation)
- Move: Yes (to Archive/ for old content)
```

### 3. Start Using Skills

Skills activate automatically based on your requests:

**Add content:**
```
User: "Save this note about transformers in AI"
→ add-content Skill activates
→ Analyzes content (AI topic)
→ Recommends Research/AI/ based on RULE.md
→ Creates file per RULE.md format
→ Updates README.md
```

**Search content:**
```
User: "Where are my transformer notes?"
→ search-content Skill activates
→ Searches using README.md indexes and patterns
→ Returns matching files with descriptions
```

**Update content:**
```
User: "Update the transformer architecture note"
→ update-content Skill activates
→ Finds file
→ Checks RULE.md for update rules
→ Applies changes while maintaining format
→ Updates README.md timestamp
```

That's it! Skills work automatically based on your requests and RULE.md specifications.

## Skills Reference

### add-content

**Triggers**: "save", "create", "add", "note", URLs, "readlater"

**What it does**:
1. Analyzes content type and topic
2. Scans directories and reads RULE.md files
3. Recommends target directory based on content matching
4. Asks user for confirmation
5. Reads target RULE.md for detailed instructions
6. Executes per RULE.md (including special workflows like web archival)
7. Updates README.md

**Example workflows**:
- URL detected + ReadLater/RULE.md says "web archival" → Fetches, converts, archives
- Note about AI + Research/AI/RULE.md says "research notes" → Creates note with format
- Work request + Work/RULE.md says "requires frontmatter" → Adds frontmatter

**Key feature**: Executes custom workflows specified in RULE.md

### update-content

**Triggers**: "update", "edit", "modify", "change"

**What it does**:
1. Identifies target file (searches if needed)
2. Reads current content
3. Reads directory RULE.md for update rules
4. Applies changes while maintaining format
5. Updates modification timestamps
6. Updates README.md

**Respects**:
- Format requirements (frontmatter, structure)
- Update policies (append-only, versioning)
- Required fields preservation

**Key feature**: Maintains format consistency per RULE.md

### delete-content

**Triggers**: "delete", "remove", "trash"

**What it does**:
1. Identifies target file
2. Reads RULE.md for deletion permissions
3. Checks dependencies (cross-references)
4. Warns about impact
5. Requests user confirmation
6. Executes (delete, archive, or backup per RULE.md)
7. Updates README.md

**Safety features**:
- Dependency checking (finds files that link to this)
- Archive instead of permanent delete (if RULE.md specifies)
- Confirmation required for destructive operations
- Broken link detection and fixing offer

**Key feature**: Safe deletion with dependency awareness

### move-content

**Triggers**: "move", "relocate", "rename", "transfer"

**What it does**:
1. Identifies source file
2. Determines target location (or recommends)
3. Reads both source and target RULE.md
4. Checks compatibility between source/target formats
5. Identifies required transformations
6. Requests user confirmation
7. Executes move with format adaptation
8. Updates cross-references
9. Updates both source and target README.md

**Handles**:
- Format transformations (adding/removing frontmatter)
- Naming convention changes
- Structure reorganization (file → directory with multiple files)
- Cross-reference updates

**Key feature**: Smart format adaptation between directories

### search-content

**Triggers**: "where is", "find", "search for", "locate"

**What it does**:
1. Analyzes search query
2. Chooses search strategy:
   - Structured navigation (via README.md indexes) - preferred
   - Pattern search (filename matching)
   - Deep content search (text search within files)
3. Executes search
4. Checks RULE.md for read permissions
5. Ranks results by relevance
6. Presents with context and descriptions

**Search strategies**:
- **Structured**: Fast, uses README.md curated indexes
- **Pattern**: Direct filename matching with Glob
- **Deep**: Comprehensive text search with Grep/Task subagent

**Key feature**: Multi-strategy search with intelligent ranking

### cross-domain-thinking

**Triggers**: "how does X relate to Y", "connections between", "cross-domain", "analogy", "isomorphic", "parallel"

**What it does**:
1. Identifies the type of cross-domain analysis needed
2. Applies one of four structured methods
3. Presents findings with appropriate epistemic marking
4. Optionally captures insights via AkashicRecords

**Four modes**:
- **Isomorphic Patterns**: Identify structural similarities across domains (e.g., feedback loops in thermostats, markets, and biology)
- **Conceptual Bridges**: Apply principles from one field to illuminate another (e.g., entropy from physics to organizational decay)
- **Novel Applications**: Transfer solutions across contexts with clear risk assessment
- **Productive Tensions**: Find instructive conflicts between frameworks and synthesize resolutions

**Epistemic marking**:
- Strong analogy: "This is structurally identical to..."
- Suggestive parallel: "This resembles... though the mapping isn't perfect"
- Speculative connection: "I wonder if there's a link to..."
- Surface similarity only: "This looks similar but the mechanisms differ"

**Key feature**: Rigorous cross-domain analysis with clear confidence levels

### process-file

**Triggers**: "read", "process", "archive", "import", file paths

**What it does**:
1. Reads project preferences from claude.md (or creates if first use)
2. Detects file type and selects appropriate processing tool
3. Extracts content using type-specific methods
4. Analyzes content and infers user intent
5. Discovers suitable target directory via akashicrecords mechanism
6. Presents analysis and waits for user confirmation
7. Executes archiving via add-content or update-content skills
8. Updates preferences file with learned patterns

**File type handling**:

| Type | Extension | Processing Tool |
|------|-----------|-----------------|
| Email | .eml | `mu view` command |
| PDF | .pdf | `markitdown` tool |
| Word | .docx | `markitdown` tool |
| PowerPoint | .pptx | `markitdown` tool |
| Excel | .xlsx | `markitdown` tool |
| Image | .jpg, .png, .gif, .webp | Read tool (language model) |
| Audio | .mp3, .wav, .m4a | Ask user, record in claude.md |
| Video | .mp4, .mov, .avi | Ask user, record in claude.md |

**Multi-file processing**:
- Launches parallel subagents for each file
- Consolidates analysis results into summary table
- User can approve all or confirm individually

**Preferences learning**:
- Maintains project-specific preferences file
- Records successful processing patterns
- Suggests same approach for similar content

**Key feature**: Intelligent file processing with learned preferences

## Management Commands

### /akashic-init

Initialize directory governance for current location and subdirectories.

**Usage:**
```
cd /path/to/knowledge-base
/akashic-init
```

**What it does:**
1. Scans current directory structure recursively
2. For each directory:
   - Checks for existing RULE.md
   - Creates RULE.md or inherits from parent (asks user)
   - Checks for existing README.md
   - Generates README.md from current contents (if missing)
3. Reports initialization summary

**When to use:**
- Setting up new knowledge base
- Adding AkashicRecords to existing directory
- Reinitializing after major reorganization

### /akashic-maintain

Validate directory governance and fix issues.

**Usage:**
```
/akashic-maintain
```

**What it does:**
1. Scans directory tree recursively
2. Identifies issues:
   - Missing RULE.md files (no inheritance available)
   - Outdated README.md files (>7 days since modification)
   - Orphaned files (not listed in any README.md)
   - Circular inheritance issues
3. Presents comprehensive governance report
4. Offers automated fixes
5. Executes approved fixes
6. Validates after fixes

**When to use:**
- Periodic maintenance (monthly recommended)
- After major directory reorganization
- When README.md files fall out of sync
- Auditing governance compliance

## RULE.md Guide

### Purpose

RULE.md defines how a directory behaves. It's the contract between your knowledge organization and the Skills.

### Format

Use natural language markdown (no strict schema required):

```markdown
# Directory Name

## Purpose
[What this directory is for]

## File Naming Convention
[How files should be named]

## Structure
[Directory structure and organization]

## Special Instructions
[Custom workflows or processes]

## Allowed Operations
[What operations are permitted]
```

### Examples

#### Simple Directory

```markdown
# Meeting Notes

## Purpose
Store meeting notes and minutes.

## File Naming
Files named: YYYY-MM-DD-meeting-topic.md

## Allowed Operations
Create, update, delete with confirmation.
```

#### Advanced with Custom Workflow

```markdown
# ReadLater - Web Content Archive

## Purpose
Archive web content for later reading with full text and metadata.

## Structure
Articles/YYYY/MM/YYYY-MM-DD_title-slug/
├── article.md (main content)
├── metadata.yaml (URL, title, date, summary)
└── images/ (optional)

## When Claude detects URLs or "readlater" keyword:
1. Use WebFetch tool to retrieve content
2. Extract title, clean content, publication date
3. Convert HTML to clean markdown
4. Generate 2-3 sentence summary
5. Create directory: Articles/YYYY/MM/YYYY-MM-DD_title-slug/
6. Save article.md with content
7. Create metadata.yaml with:
   ```yaml
   url: [original URL]
   title: [article title]
   date_archived: [date]
   summary: [brief summary]
   tags: [auto-generated or user-specified]
   ```
8. Update README.md in Articles/, Articles/YYYY/, Articles/YYYY/MM/

## Allowed Operations
- Create: Yes (via web archival workflow)
- Update: Metadata only (preserve original content)
- Delete: Move to Archive/ instead of permanent deletion
- Move: To Archive/ for content >1 year old
```

#### Directory with Format Requirements

```markdown
# Research Papers

## Purpose
Academic research papers and notes with citations.

## File Format
Markdown with YAML frontmatter:

```yaml
---
title: [Paper title]
authors: [Author list]
date: [Publication date]
tags: [topic tags]
citations: [BibTeX keys]
---
```

## File Naming
author-year-short-title.md

Example: smith-2023-transformer-architecture.md

## Allowed Operations
- Create: Yes (must include frontmatter)
- Update: Yes (preserve frontmatter fields)
- Delete: Requires approval (check citations)
```

### RULE.md Inheritance

If a directory doesn't have RULE.md, it inherits from parent:

```
Root/
├── RULE.md (base rules)
├── Research/
│   ├── RULE.md (research-specific, overrides root)
│   ├── AI/
│   │   ├── RULE.md (AI-specific, overrides Research)
│   │   └── papers/
│   │       └── (inherits from AI/RULE.md)
│   └── Physics/
│       └── (inherits from Research/RULE.md)
└── Work/
    ├── RULE.md (work-specific)
    └── Projects/
        └── (inherits from Work/RULE.md)
```

Skills traverse up the tree to find applicable RULE.md.

## README.md Maintenance

README.md files serve as directory indexes and are automatically updated by Skills.

### Format Example

```markdown
# Directory Name

## Overview
Brief description of directory contents and purpose.

## Contents

### Files
- [file1.md](file1.md) - Description (Last updated: 2025-10-28)
- [file2.md](file2.md) - Description (Last updated: 2025-10-25)
- [file3.md](file3.md) - Description (Last updated: 2025-10-20)

### Subdirectories
- [subdirectory/](subdirectory/) - Description

## Recent Changes
- 2025-10-28: Added file3.md
- 2025-10-25: Updated file2.md
- 2025-10-20: Created subdirectory/

Last updated: 2025-10-28
```

### Automatic Updates

Skills automatically update README.md:
- **After add-content**: Add new file entry
- **After update-content**: Update modification timestamp
- **After delete-content**: Remove file entry, add to "Recent Changes"
- **After move-content**: Remove from source, add to target README.md

## Troubleshooting

### Skills Not Activating

**Symptom**: You request an operation but Skill doesn't trigger.

**Solutions**:
1. Use more explicit trigger words:
   - For add: "save", "create", "add"
   - For search: "find", "where is", "search for"
   - For update: "update", "edit", "modify"
2. Check if request is ambiguous - be more specific
3. Try natural phrasing: "I want to save this note about [topic]"

### Classification Recommendations Off

**Symptom**: add-content recommends wrong directory.

**Solutions**:
1. Check RULE.md in target directories - purposes should be clear
2. Manually specify directory: "Save this to Research/AI/"
3. Update RULE.md to better describe directory purpose
4. Add keywords to RULE.md that match your content type

### RULE.md Not Being Followed

**Symptom**: Skills don't follow RULE.md instructions.

**Solutions**:
1. Check RULE.md format - ensure it's clear markdown
2. Use explicit instructions: "When Claude [detects X], do [Y]"
3. Provide examples in RULE.md
4. Test with simple instructions first, then add complexity

### README.md Out of Date

**Symptom**: README.md doesn't reflect current directory state.

**Solution**:
```
/akashic-maintain
```

This will:
- Detect outdated README.md files
- Identify missing entries
- Offer to regenerate
- Update all README.md files

### Cross-References Broken

**Symptom**: Files link to moved/deleted content.

**Solution**:
Use delete-content or move-content Skills - they automatically:
- Detect cross-references
- Warn about broken links
- Offer to update references
- Fix links automatically (with confirmation)

### Governance Violations

**Symptom**: Operations fail due to RULE.md restrictions.

**Solutions**:
1. Read RULE.md to understand restriction
2. Either:
   - Follow RULE.md requirements
   - Or explicitly override (Skills will ask for confirmation)
3. Update RULE.md if rule is outdated

## Best Practices

### 1. Write Clear RULE.md Files

**Good RULE.md**:
```markdown
# Research Notes

## Purpose
Technical research notes on AI, machine learning, and software engineering.
When user saves notes about these topics, recommend this directory.

## File Naming
YYYY-MM-DD-topic-keywords.md

Examples:
- 2025-10-28-transformer-architecture.md
- 2025-10-25-neural-networks-intro.md

## When to Use This Directory
- Academic research content
- Technical deep-dives
- Paper summaries
- Experiment notes
```

**Vague RULE.md** (avoid):
```markdown
# Research

For research stuff.
```

### 2. Maintain One Level of RULE.md

Don't over-specify. Use inheritance:

**Good structure**:
```
Research/
├── RULE.md (research-wide rules)
├── AI/ (inherits from Research)
├── Physics/ (inherits from Research)
└── Biology/ (inherits from Research)
```

**Over-specified** (avoid):
```
Research/
├── RULE.md
├── AI/
│   ├── RULE.md (mostly duplicates parent)
│   ├── DeepLearning/
│   │   └── RULE.md (mostly duplicates parent)
│   └── NLP/
│       └── RULE.md (mostly duplicates parent)
```

### 3. Run Periodic Maintenance

Monthly maintenance keeps governance healthy:

```bash
# Last day of month
/akashic-maintain
```

This catches:
- README.md drift
- Orphaned files
- Governance violations
- Inheritance issues

### 4. Let Skills Recommend, Then Confirm

Don't pre-decide where content goes. Let Skills recommend:

**Good workflow**:
```
User: "Save this note about transformers"
Skill: "I recommend Research/AI/ - this looks like AI research. Confirm?"
User: "Yes" (or "No, use Work/Projects/ instead")
```

**Less optimal**:
```
User: "Save this to Research/AI/2025-10-28-transformers.md with frontmatter..."
(Bypasses intelligent classification and recommendation)
```

### 5. Use Natural Language

Skills understand natural requests:

**Natural** (good):
```
"Save this article for later"
"Find my notes about transformers"
"Update the architecture document"
"Move old research to archive"
```

**Over-specified** (unnecessary):
```
"/add-content --target=Research/AI/ --format=markdown --frontmatter=yes"
(Skills handle this automatically)
```

### 6. Trust README.md Indexes

README.md files are your curated navigation:
- Search consults README.md first (fastest, most relevant)
- Add/Update/Delete maintain README.md automatically
- Trust README.md as source of truth for directory contents

## Integration with CLAUDE.md

### Parallel Operation

This plugin works in parallel with CLAUDE.md subagents:
- Plugin Skills can activate based on user requests
- CLAUDE.md subagents can also activate for same requests
- Both use governance protocol (read RULE.md, update README.md)
- Whichever has higher match confidence triggers first

**No conflict** - both systems respect same governance rules.

### When to Use Plugin vs CLAUDE.md

**Use plugin Skills when**:
- You want explicit file operations
- You need generic workflows
- Working with any directory structure

**CLAUDE.md subagents provide**:
- Business-specific logic beyond file operations
- Complex multi-step workflows
- Custom classification algorithms

**Best practice**: Install plugin for convenience, keep CLAUDE.md for custom logic. They complement each other.

## Examples

### Example 1: Academic Research Workflow

**Setup**:
```
Research/
├── RULE.md (Purpose: "Academic papers and research notes")
├── AI/
│   └── papers/
├── Physics/
└── Biology/
```

**Research/RULE.md**:
```markdown
# Research Directory

## Purpose
Academic research papers, notes, and literature reviews.

## File Naming
author-year-title.md for papers
YYYY-MM-DD-topic.md for notes

## Format
Markdown with optional citations section.

## Allowed Operations
All operations allowed. Archive to Archive/ for old content (>2 years).
```

**Usage**:
```
User: "Save this paper summary about quantum computing"

→ add-content analyzes: academic content, quantum topic
→ Recommends Research/Physics/
→ User confirms
→ Creates smith-2025-quantum-computing.md
→ Updates Research/Physics/README.md
```

### Example 2: Project Management

**Setup**:
```
Projects/
├── RULE.md (Purpose: "Active projects with specs and tracking")
├── ProjectA/
│   ├── RULE.md (requires frontmatter with status, owner)
│   ├── specs/
│   └── docs/
└── ProjectB/
```

**Projects/RULE.md**:
```markdown
# Projects Directory

## Purpose
Active projects with specifications, documentation, and tracking.

## File Format
Requires YAML frontmatter:
---
title: [Title]
status: [planning/in-progress/completed]
owner: [Name]
created: [Date]
---

## Allowed Operations
All operations. When status changes to "completed", offer to archive.
```

**Usage**:
```
User: "Create a spec for the new authentication system"

→ add-content detects project content
→ Recommends Projects/
→ User confirms
→ Reads Projects/RULE.md
→ Creates auth-system-spec.md with required frontmatter
→ Prompts for status, owner
→ Updates Projects/README.md
```

### Example 3: Personal Knowledge Base

**Setup**:
```
MyKnowledge/
├── RULE.md (General rules)
├── Articles/ (saved web content)
├── Notes/ (personal notes)
├── Ideas/ (brainstorming)
└── Archive/ (old content)
```

**MyKnowledge/RULE.md**:
```markdown
# My Knowledge Base

## Purpose
Personal knowledge management with articles, notes, and ideas.

## Classification
- Articles/: Saved web content
- Notes/: Personal insights and learnings
- Ideas/: Brainstorming and creative thoughts
- Archive/: Content >1 year old

## File Naming
YYYY-MM-DD-descriptive-title.md

## Allowed Operations
All operations. Auto-archive to Archive/ for content >1 year.
```

**Usage**:
```
User: "readlater https://example.com/interesting-article"

→ add-content detects URL
→ Scans RULE.md, finds Articles/ for "web content"
→ Recommends Articles/
→ Auto-confirms (obvious match)
→ Fetches article
→ Creates 2025-10-28-interesting-article.md
→ Updates Articles/README.md


User: "Save this idea: AI-powered task automation"

→ add-content analyzes: creative idea
→ Recommends Ideas/ per RULE.md classification
→ User confirms
→ Creates 2025-10-28-ai-task-automation.md
→ Updates Ideas/README.md
```

## FAQ

### Q: Do I need specific directory names like "ReadLater" or "Research"?

**A**: No! You define your own directory names. Skills read RULE.md to understand purpose, not directory names.

### Q: Can Skills handle complex workflows like web archival?

**A**: Yes! Put workflow instructions in RULE.md. Skills read and execute them. For example, RULE.md can say "when URL detected, fetch with WebFetch, convert to markdown, save in specific structure" - Skills will follow exactly.

### Q: What if I don't want to write RULE.md files?

**A**: Skills work with minimal RULE.md. Even a simple "Purpose: [description]" is helpful. Or use inheritance - write RULE.md at root, subdirectories inherit.

### Q: How do Skills choose where to save content?

**A**: Skills:
1. Analyze content (topic, type)
2. Read RULE.md of multiple directories
3. Match content to directory purposes
4. Recommend best match
5. Always ask for your confirmation

### Q: Can I use this with my existing knowledge base?

**A**: Yes! Run `/akashic-init` to add governance to existing directories. It won't change your files, just adds RULE.md and README.md for governance.

### Q: What happens if RULE.md conflicts with my request?

**A**: Skills will warn you and explain the conflict. You can either:
- Follow RULE.md guidelines
- Override the rule (Skills will ask for confirmation)

### Q: Do Skills work without README.md?

**A**: Yes, but README.md makes search faster and more accurate. Run `/akashic-maintain` to generate missing README.md files.

### Q: Can I customize how Skills behave?

**A**: Yes! Write custom workflows in RULE.md. Skills execute what RULE.md specifies. You control behavior through RULE.md, not by modifying plugin.

### Q: How do I update the plugin?

**A**: Reinstall from marketplace:
```
/plugin uninstall akashicrecords@claude-tools
/plugin install akashicrecords@claude-tools
```

Your RULE.md and README.md files are preserved (plugin doesn't touch your data).

## Contributing

Found a bug or have a suggestion?

1. Open an issue: https://github.com/eternnoir/claude-tool/issues
2. Describe the problem or suggestion
3. Include example RULE.md and scenario if applicable

## Companion Output Style: Knowledge Explorer

This output style pairs well with AkashicRecords for intellectual research workflows. It transforms Claude into a perspective-first dialogue partner that challenges assumptions and engages in rigorous exploration.

To use this output style, copy the content below and save it as a Claude Code output style file (e.g., `~/.claude/output-styles/knowledge-explorer.md`).

<details>
<summary>Click to expand Knowledge Explorer output style</summary>

```markdown
---
name: Knowledge Explorer
description: An intellectual research companion for deep exploration. Offers perspectives first, challenges assumptions, and engages in rigorous dialogue.
keep-coding-instructions: false
---

# Knowledge Explorer

You are an intellectual research companion who guides users through knowledge exploration. You combine the rigor of academic inquiry with the creativity of interdisciplinary thinking.

## Core Identity

You are not a passive information retriever. You are an active thinking partner who:
- Offers perspectives first, then invites dialogue
- Challenges assumptions constructively
- Maintains epistemic humility while being intellectually bold
- Treats ambiguity as productive rather than problematic

## Interaction Pattern

### Primary Mode: Perspective-First Dialogue
When a user raises a topic:
1. **Offer an initial perspective** - Present a substantive viewpoint, framework, or observation
2. **Invite challenge** - Create space for the user to push back or extend
3. **Iterate together** - Build on the exchange toward deeper understanding

Do not ask clarifying questions before engaging. Engage first, refine through dialogue.

### Intellectual Stance

**Neutrality with Courage**
- Present multiple perspectives fairly, then indicate which you find compelling and why
- Challenge the user's views when you see blind spots or weak reasoning
- Distinguish between "wrong," "incomplete," and "one valid view among several"
- Never be contrarian for its own sake, but never shy from productive friction

**Epistemic Honesty**
- Clearly mark speculation vs. established knowledge
- Acknowledge limits; flag genuine expert disagreement
- Prefer "I find X more compelling because..." over "X is correct"

## Response Style

- Lead with substance, not meta-commentary
- Use prose for exploration; reserve lists for genuine enumerations
- Vary depth based on question complexity
- End with generative questions or provocations when appropriate

## Tone

- Intellectually warm but rigorous
- Curious and genuinely engaged
- Direct without being dismissive
- Comfortable with open questions

## What You Don't Do

- Provide shallow summaries when depth is needed
- Agree reflexively to seem helpful
- Avoid controversy when honesty requires engaging it
- Treat all perspectives as equally valid when evidence distinguishes them
- Let politeness override precision

## Skill Integration

When cross-domain thinking would deepen the exploration, invoke the **cross-domain-thinking** skill. It provides structured methods for finding connections across fields.

When knowledge persistence is relevant, invoke the **AkashicRecords** skills to search prior work or capture emerging insights.
```

</details>

### How to Install

1. Create the output styles directory if it doesn't exist:
   ```bash
   mkdir -p ~/.claude/output-styles
   ```

2. Save the content above to a file:
   ```bash
   # Create the file and paste the content
   nano ~/.claude/output-styles/knowledge-explorer.md
   ```

3. Use the output style in Claude Code:
   ```bash
   claude --output-style knowledge-explorer
   ```

### When to Use Knowledge Explorer

- **Deep research sessions**: Exploring complex topics across multiple domains
- **Intellectual dialogue**: When you want pushback on your ideas
- **Cross-domain analysis**: Pairs well with cross-domain-thinking skill
- **Knowledge base building**: Captures insights via AkashicRecords integration

## Changelog

### v1.2.0
- Added process-file skill for processing arbitrary files (email, PDF, Office docs, images, audio/video)
- Supports file type detection with appropriate tools (mu, markitdown, language model)
- Includes content analysis and user intent inference
- Features preferences learning for repeated patterns
- Multi-file parallel processing with subagents

### v1.1.0
- Added cross-domain-thinking skill for structured interdisciplinary analysis
- Added Knowledge Explorer companion output style documentation

### v1.0.0 (2025-10-28)
- Initial release
- 5 generic Skills (add, update, delete, move, search)
- RULE.md-driven business logic
- Smart classification with user confirmation
- Governance agent with compliance checking
- 2 management commands (init, maintain)
- Comprehensive documentation

## License

MIT License - see repository for details.

## Author

Frank Wang (eternnoir)
- GitHub: https://github.com/eternnoir/claude-tool
- Email: eternnoir@gmail.com

## Acknowledgments

- Inspired by the need for flexible, adaptable knowledge management
- Built on Claude Code plugin system
- Designed for universal reusability across different workflows

---

**Remember**: AkashicRecords adapts to YOUR structure. You define purposes in RULE.md, Skills execute accordingly. Maximum flexibility, zero hardcoded assumptions.
