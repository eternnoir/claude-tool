---
description: View comprehensive status of all projects in the workspace including sprints, milestones, team activity, and governance health
---

# Project Status Overview

When the user runs `/project-status`, provide a comprehensive overview of all project activities, progress, and health.

## Task 1: Discover Projects

Scan the workspace to find all ProjectMaster-managed projects:

1. **Find all RULE.md files**:
   ```bash
   find . -name "RULE.md" -type f
   ```

2. **For each RULE.md found**:
   - Read the file
   - Check if it has ProjectMaster configuration (methodology field)
   - Extract project name (from RULE.md or parent directory name)
   - Note project location

3. **Identify primary project**:
   - If in a project directory: That project
   - If in workspace root with multiple projects: All projects
   - If single project in workspace: That project

## Task 2: Gather Project Data

For each project, collect comprehensive status information:

### 2.1 Basic Project Info

From RULE.md:
- Project name
- Methodology (Scrum, Kanban, Waterfall, etc.)
- Team size
- Start date

### 2.2 Current Sprint/Iteration Status

Read active sprint document:
```bash
grep -r "status: active" sprints/*/sprint-plan.md
```

Extract:
- Sprint number and goal
- Start and end dates
- Days remaining
- Story completion (X/Y stories, A/B points)
- Velocity percentage
- Blockers (if any)
- Team members and assignments

### 2.3 Milestone Status

Read milestones.yaml:
- Total milestones
- Completed milestones
- In-progress milestones
- Next milestone due
- Any delayed milestones
- Overall completion percentage

### 2.4 Recent Activity

Check Recent Activity section in project README.md:
- Last 5-7 activities
- Types: meetings, sprint updates, milestone completions, document additions

### 2.5 Team Activity

Scan recent content for @mentions:
- Who's been active recently
- Current assignments
- Upcoming responsibilities

### 2.6 Governance Health

Quick governance check:
- RULE.md present and valid
- README.md files up to date
- Directory structure intact
- milestones.yaml valid

### 2.7 Upcoming Items

- Next sprint start (if Scrum)
- Upcoming milestones
- Scheduled meetings
- Deadlines approaching

## Task 3: Present Status Report

Format and present the comprehensive status:

### For Single Project:

```
📊 Project Status: {Project Name}

═══════════════════════════════════════════════════════

📋 PROJECT INFO
**Methodology**: {Scrum | Kanban | Waterfall | Agile}
**Team**: {size} members
**Started**: {start_date}
**Status**: {Active | Planning | On Hold}

═══════════════════════════════════════════════════════

🏃 CURRENT SPRINT
**Sprint {number}**: {Goal}
**Progress**: Day {X} of {Y} ({Z}% elapsed)
**Stories**: {completed}/{total} completed ({A}/{B} points)
**Velocity**: {percentage}% - {On Track | At Risk | Behind}

✅ Completed ({count}):
- {Story titles}

🔄 In Progress ({count}):
- {Story title} - @{owner}
- {Story title} - @{owner}

⚠️ Blocked ({count}):
- {Story title} - {blocker reason}

═══════════════════════════════════════════════════════

🎯 MILESTONES
**Overall Progress**: {X}/{Y} milestones ({percentage}%)

✅ Completed ({count}):
- {Milestone name} ({completion_date})

🔄 In Progress ({count}):
- {Milestone name} - {target_date} ({progress}%)

📅 Upcoming ({count}):
- {Milestone name} - {target_date} ({days} days)

⚠️ At Risk:
{If any milestones delayed or at risk}
- {Milestone name} - {issue description}

**Next Milestone**: {Name} ({target_date}, {days_remaining} days)

═══════════════════════════════════════════════════════

👥 TEAM ACTIVITY
{Top 3-5 most active team members in last week/sprint}

**@{member1}**:
- Current: {current story/task}
- Completed: {count} stories this sprint
- Upcoming: {next assignment}

**@{member2}**:
- Current: {current story/task}
- Completed: {count} stories
- Blockers: {blocker if any}

[Continue for other active members]

═══════════════════════════════════════════════════════

📅 RECENT ACTIVITY
{Last 7 days or current sprint}

- {Date}: {Activity description}
- {Date}: {Activity description}
- {Date}: {Activity description}
- {Date}: {Activity description}
- {Date}: {Activity description}

═══════════════════════════════════════════════════════

🔔 UPCOMING
**This Week**:
- {Upcoming item 1}
- {Upcoming item 2}

**Next Week**:
- {Upcoming item 1}

**Next Month**:
- {Milestone or major deliverable}

═══════════════════════════════════════════════════════

🏥 GOVERNANCE HEALTH
RULE.md: ✅ Valid
milestones.yaml: ✅ Valid
README indexes: ✅ Up to date ({last_updated})
Directory structure: ✅ Complete

**Overall Health**: {Excellent | Good | Needs Attention}

{If issues exist:}
⚠️ Issues:
- {Issue description}

═══════════════════════════════════════════════════════

💡 QUICK ACTIONS
- Update sprint progress: "Sprint {number} progress update"
- Check milestone: "Milestone status for {next_milestone}"
- Find content: "Find meetings about {topic}"
- Generate report: "/project-report"

═══════════════════════════════════════════════════════
```

### For Multiple Projects (Workspace Overview):

```
📊 Workspace Status: {count} Projects

═══════════════════════════════════════════════════════

📁 PROJECT: {Project 1 Name}
Location: {path}
Status: {Active | On Hold}
Current: Sprint {X} - {Goal} ({progress}%)
Next Milestone: {Name} ({date})
Health: ✅ Good
[Quick summary - 2-3 lines]

───────────────────────────────────────────────────────

📁 PROJECT: {Project 2 Name}
Location: {path}
Status: {Active}
Current: Sprint {Y} - {Goal} ({progress}%)
Next Milestone: {Name} ({date})
Health: ⚠️ Needs Attention (README outdated)
[Quick summary - 2-3 lines]

───────────────────────────────────────────────────────

[Continue for each project]

═══════════════════════════════════════════════════════

📊 WORKSPACE SUMMARY

**Total Projects**: {count}
**Active**: {count}
**Total Sprints in Progress**: {count}
**Upcoming Milestones (Next 30 days)**: {count}
**Team Members Across Projects**: {count unique}

**Activity Level**: {High | Medium | Low}
- Total activities last 7 days: {count}
- Most active project: {name}

**Health Status**:
- ✅ Healthy: {count} projects
- ⚠️ Needs Attention: {count} projects
- ❌ Issues: {count} projects

═══════════════════════════════════════════════════════

💡 ACTIONS
- View specific project: "Show status for {project_name}"
- Detailed report: "/project-report {project_name}"
- Validate all: "/project-init" (in each project directory)

═══════════════════════════════════════════════════════
```

### For Project in Planning Phase (No Active Sprint):

```
📊 Project Status: {Project Name}

═══════════════════════════════════════════════════════

📋 PROJECT INFO
**Status**: Planning / Setup
**Methodology**: {methodology}
**Team**: {size} members
**Initialized**: {date}

═══════════════════════════════════════════════════════

🏃 SPRINT STATUS
No active sprint.

**Backlog**: {count} items ready
- {Item 1}
- {Item 2}
- {Item 3}

💡 Ready to start? Try:
"Start sprint 1 for {theme}"

═══════════════════════════════════════════════════════

🎯 MILESTONES
**Defined**: {count} milestones
**Target**: {first_milestone} ({target_date})

📅 Roadmap:
- {Milestone 1} - {date}
- {Milestone 2} - {date}
- {Milestone 3} - {date}

═══════════════════════════════════════════════════════

💡 GET STARTED
1. Plan your first sprint: "Start sprint 1"
2. Schedule kickoff: "Create meeting notes for kickoff"
3. Refine backlog: "Add user story for {feature}"

═══════════════════════════════════════════════════════
```

## Task 4: Handle User Follow-ups

After presenting status, be ready to handle common follow-ups:

### Common Follow-up Requests:

**"Show more details on {sprint/milestone/team member}"**
- Activate appropriate Skill (manage-sprint, track-milestone) to provide detailed view

**"What's blocking us?"**
- Extract and present all blockers from sprints and milestones

**"Who's working on what?"**
- Present detailed team assignment breakdown

**"Show me last week's activity"**
- Time-filtered activity view

**"Generate a report"**
- Redirect to `/project-report` command

**"What should we focus on?"**
- Analyze status and provide recommendations based on:
  - Blockers needing resolution
  - At-risk milestones
  - Sprint health
  - Upcoming deadlines

## Task 5: Provide Recommendations

Based on status analysis, offer actionable recommendations:

### If Sprint Behind Schedule:
```
⚠️ Recommendation: Sprint {number} is behind schedule

Current: {X}% complete with {Y}% time remaining

Suggestions:
- Review blockers in next standup
- Consider descoping lower-priority stories
- Allocate additional resources to critical stories
- Plan time for recovery in next sprint
```

### If Milestone at Risk:
```
⚠️ Recommendation: {Milestone name} at risk

Target: {date} ({days} days)
Progress: {percentage}% ({behind/on track})

Suggestions:
- Prioritize milestone-critical stories
- Review sprint allocations
- Consider extending milestone deadline
- Add checkpoint meeting: "Create meeting for milestone review"
```

### If No Recent Activity:
```
ℹ️ Notice: Low activity in last {days} days

Last activity: {date} - {description}

Suggestions:
- Resume work: "Start sprint {number}"
- Update project status
- Archive if project completed
- Mark project on hold if paused
```

### If Governance Issues:
```
⚠️ Governance needs attention

Issues:
- README indexes outdated
- {count} directories missing README
- milestones.yaml has validation errors

Suggestion:
Run "/project-init" to validate and fix governance
```

## Notes

- This command provides executive-level visibility into project health
- It aggregates data from multiple sources (RULE.md, sprints, milestones, meetings)
- It highlights both progress and issues
- It's safe to run frequently - read-only operation
- It works for single projects or workspace with multiple projects

## Examples

### Example 1: Healthy Active Project

```
User: /project-status

Claude: 📊 Project Status: E-Commerce Redesign

[Shows complete status with all sections]

Current Sprint: On Track ✅
Next Milestone: 15 days away
Team: Fully assigned
Governance: Healthy ✅

Overall: Project is progressing well. Keep momentum!
```

### Example 2: Project with Issues

```
User: /project-status

Claude: 📊 Project Status: Mobile App

[Shows status]

⚠️ Alerts:
- Sprint 5 at 50% complete with only 2 days remaining
- 2 stories blocked on external dependencies
- Beta Release milestone at risk (3 days behind)

Recommendations:
1. Review blockers urgently
2. Descope non-critical Sprint 5 stories
3. Reassess Beta Release date

Would you like to:
- Review blocked stories in detail
- Update milestone dates
- Generate risk report
```

### Example 3: Multiple Projects

```
User: /project-status

Claude: 📊 Workspace Status: 3 Projects

PROJECT: E-Commerce Redesign
✅ Healthy | Sprint 5 (75%) | Beta: 15 days

PROJECT: Mobile App Rewrite
⚠️ At Risk | Sprint 3 (40%) | MVP: OVERDUE

PROJECT: Internal Tools
✅ Healthy | Kanban (12 cards active) | No milestones

SUMMARY:
2 of 3 projects healthy
1 project needs immediate attention (Mobile App)

Focus: Mobile App MVP is overdue. Review?
```

---

This command is the project dashboard - quick visibility into everything that matters.
