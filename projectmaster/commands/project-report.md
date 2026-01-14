---
description: Generate comprehensive project reports in various formats (summary, sprint, milestone, velocity, full)
---

# Generate Project Report

When the user runs `/project-report [project-name] [report-type]`, generate a comprehensive report document.

## Command Syntax

```
/project-report                          # Interactive: asks for project and type
/project-report [project-name]           # Interactive: asks for type
/project-report [project-name] [type]    # Direct: generates specified report
```

**Report Types**:
- `summary` - High-level project overview (default)
- `sprint` - Current/recent sprint detailed analysis
- `milestone` - Milestone progress and roadmap
- `velocity` - Team velocity and estimation analysis
- `full` - Complete project report (all sections)

## Task 1: Identify Project and Report Type

### If no parameters provided:

1. **Discover projects in workspace**:
   ```bash
   find . -name "RULE.md" -type f
   ```

2. **Present project selection**:
   ```
   📊 Generate Project Report

   Select project:
   1. {Project 1 Name} ({path})
   2. {Project 2 Name} ({path})
   3. {Project 3 Name} ({path})

   Which project? (1-3)
   ```

3. **Present report type selection**:
   ```
   Select report type:
   1. Summary - High-level overview (recommended for stakeholders)
   2. Sprint - Current sprint detailed analysis
   3. Milestone - Milestone progress and timeline
   4. Velocity - Team performance metrics
   5. Full - Comprehensive report (all sections)

   Which type? (1-5)
   ```

### If parameters provided:

Parse and validate:
- Project name matches existing project
- Report type is valid (summary|sprint|milestone|velocity|full)

## Task 2: Gather Report Data

Based on report type, collect relevant information:

### For All Report Types:

- Project name and basic info (from RULE.md)
- Current date and report generation metadata
- Project start date and duration

### For Summary Report:

- Methodology and team size
- Current sprint/phase status
- Milestone completion overview
- Key achievements (last 30 days)
- Upcoming milestones and deadlines
- High-level risks or blockers

### For Sprint Report:

- Current or most recent sprint details
- Sprint goal and dates
- Story breakdown with status
- Burndown/velocity data
- Team assignments
- Blockers and resolutions
- Sprint ceremony notes (planning, review, retro)
- Comparison with previous sprints

### For Milestone Report:

- All milestones with status
- Timeline and roadmap
- Dependencies between milestones
- Progress against targets
- Contributing sprints for each milestone
- Risk analysis for upcoming milestones

### For Velocity Report:

- Historical sprint velocities (last 6-10 sprints)
- Average velocity calculation
- Velocity trends (improving/declining/stable)
- Estimation accuracy analysis
- Team capacity over time
- Factors affecting velocity
- Recommendations for future sprint planning

### For Full Report:

All of the above sections combined.

## Task 3: Generate Report Document

Create a comprehensive markdown document with proper formatting:

### Summary Report Format:

```markdown
# Project Report: {Project Name}

**Report Type**: Summary
**Generated**: {YYYY-MM-DD HH:MM}
**Report Period**: {project_start} to {current_date}
**Project Duration**: {X} months

---

## Executive Summary

{2-3 paragraph overview of project status, key achievements, and next steps}

---

## Project Information

| Field | Value |
|-------|-------|
| **Project Name** | {name} |
| **Methodology** | {Scrum/Kanban/etc.} |
| **Team Size** | {size} members |
| **Project Start** | {date} |
| **Current Phase** | {Sprint X / Phase Y} |
| **Status** | {On Track / At Risk / Behind} |

---

## Current Status

### Active Sprint/Phase

**{Sprint Number}: {Goal}**
- Duration: {start_date} to {end_date}
- Progress: {X}/{Y} stories completed ({percentage}%)
- Status: {On Track | At Risk | Behind}
- Days Remaining: {days}

### Recent Completions

- ✅ {Item 1}
- ✅ {Item 2}
- ✅ {Item 3}

### In Progress

- 🔄 {Item 1} - @{owner}
- 🔄 {Item 2} - @{owner}

### Blockers

{If any blockers exist:}
- ⚠️ {Blocker description} - {impact}

{If no blockers:}
- None. All work proceeding smoothly.

---

## Milestone Progress

**Overall**: {X}/{Y} milestones completed ({percentage}%)

### Completed Milestones
- ✅ {Milestone 1} - {completion_date}
- ✅ {Milestone 2} - {completion_date}

### In Progress
- 🔄 {Milestone name} - {target_date} ({progress}%)
  - Status: {On Time | At Risk | Delayed}

### Upcoming (Next 90 Days)
- 📅 {Milestone name} - {target_date}
- 📅 {Milestone name} - {target_date}

---

## Key Achievements (Last 30 Days)

{Extract from Recent Activity in README.md}

- {Date}: {Achievement}
- {Date}: {Achievement}
- {Date}: {Achievement}

---

## Upcoming Priorities

### This Month
1. {Priority item 1}
2. {Priority item 2}
3. {Priority item 3}

### Next Month
1. {Priority item 1}
2. {Priority item 2}

---

## Risks and Concerns

{If risks exist:}

### High Priority
- ⚠️ {Risk description}
  - Impact: {impact}
  - Mitigation: {mitigation plan}

### Medium Priority
- {Risk description}

{If no major risks:}

No significant risks identified. Project is progressing according to plan.

---

## Team Performance

- **Sprint Velocity**: {average} points/sprint
- **Completion Rate**: {percentage}% of planned work delivered
- **Team Morale**: {from retrospective notes if available}

---

## Recommendations

{Based on analysis, provide 3-5 actionable recommendations}

1. {Recommendation 1}
2. {Recommendation 2}
3. {Recommendation 3}

---

## Next Steps

1. {Next step 1}
2. {Next step 2}
3. {Next step 3}

---

**Report Generated by**: ProjectMaster
**Last Updated**: {YYYY-MM-DD HH:MM}
```

### Sprint Report Format:

```markdown
# Sprint Report: Sprint {Number}

**Project**: {Project Name}
**Sprint Goal**: {Goal}
**Generated**: {YYYY-MM-DD HH:MM}

---

## Sprint Overview

| Field | Value |
|-------|-------|
| **Sprint Number** | {number} |
| **Duration** | {start_date} to {end_date} |
| **Sprint Length** | {X} weeks |
| **Days Elapsed** | {Y} of {Z} days |
| **Status** | {Planning / Active / Review / Completed} |

---

## Sprint Goal

{Detailed description of sprint goal}

---

## Story Breakdown

### Summary

| Status | Count | Story Points |
|--------|-------|--------------|
| ✅ Completed | {X} | {A} pts |
| 🔄 In Progress | {Y} | {B} pts |
| ⏸️ Not Started | {Z} | {C} pts |
| ⚠️ Blocked | {W} | {D} pts |
| **Total** | **{total}** | **{total_pts} pts** |

### Completed Stories

{For each completed story:}

#### ✅ {Story Title}
- **Story Points**: {X}
- **Assignee**: @{name}
- **Completed**: {date}
- **Description**: {brief description}
- **Acceptance Criteria**: All met

---

### In Progress Stories

{For each in-progress story:}

#### 🔄 {Story Title}
- **Story Points**: {X}
- **Assignee**: @{name}
- **Progress**: {percentage}%
- **Status**: On track / Needs attention
- **Next Steps**: {what's next}

---

### Blocked Stories

{If any blockers:}

#### ⚠️ {Story Title}
- **Story Points**: {X}
- **Assignee**: @{name}
- **Blocker**: {blocker description}
- **Impact**: {impact on sprint}
- **Resolution Plan**: {plan}
- **Owner**: @{resolution_owner}

---

## Velocity Analysis

- **Planned Velocity**: {planned} points
- **Actual Velocity**: {actual} points (if sprint completed)
- **Completion Rate**: {percentage}%
- **Comparison to Average**: {above/below/on par} with team average of {avg} points

{If sprint active:}
- **Projected Velocity**: {projected} points based on current progress
- **On Track For**: {percentage}% completion

---

## Team Assignments

{For each team member:}

### @{member_name}
- **Assigned**: {count} stories ({points} points)
- **Completed**: {count} stories ({points} points)
- **In Progress**: {count} stories
- **Utilization**: {percentage}%

---

## Daily Progress

{Summary of daily updates if tracked}

### Week 1
- **Mon**: {summary}
- **Tue**: {summary}
- **Wed**: {summary}
- **Thu**: {summary}
- **Fri**: {summary}

### Week 2
- **Mon**: {summary}
- ...

---

## Sprint Ceremonies

### Sprint Planning
- **Date**: {date}
- **Duration**: {X} minutes
- **Attendees**: {list}
- **Key Decisions**: {summary}
- **Meeting Notes**: [Link](path/to/meeting.md)

{If sprint completed:}

### Sprint Review
- **Date**: {date}
- **Demos**: {count} stories demonstrated
- **Stakeholder Feedback**: {summary}
- **Meeting Notes**: [Link](path/to/meeting.md)

### Sprint Retrospective
- **Date**: {date}
- **What Went Well**: {summary}
- **What Could Improve**: {summary}
- **Action Items**: {list}
- **Meeting Notes**: [Link](path/to/meeting.md)

---

## Blockers and Resolutions

{Detailed list of blockers encountered and how they were resolved}

| Blocker | Reported | Resolved | Duration | Impact |
|---------|----------|----------|----------|--------|
| {description} | {date} | {date / "Open"} | {days} | {High/Med/Low} |

---

## Sprint Health Assessment

**Overall Health**: {Excellent / Good / Fair / Poor}

**Indicators**:
- Velocity: {On Track / Below / Above}
- Blockers: {None / Minor / Significant}
- Team Capacity: {Appropriate / Overloaded / Underutilized}
- Goal Achievement: {Likely / Uncertain / Unlikely}

---

## Recommendations

{3-5 specific recommendations for this sprint or next}

1. {Recommendation}
2. {Recommendation}
3. {Recommendation}

---

## Related Links

- [Sprint Plan Document](path/to/sprint-plan.md)
- [Sprint Planning Meeting](path/to/meeting.md)
- [Related Milestone](path/to/milestones.yaml)
- [Project README](../README.md)

---

**Report Generated by**: ProjectMaster
**Last Updated**: {YYYY-MM-DD HH:MM}
```

### Milestone Report Format:

```markdown
# Milestone Report: {Project Name}

**Generated**: {YYYY-MM-DD HH:MM}
**Report Period**: {project_start} to {current_date}

---

## Milestone Summary

| Metric | Value |
|--------|-------|
| **Total Milestones** | {total} |
| **Completed** | {completed} ({percentage}%) |
| **In Progress** | {in_progress} |
| **Planned** | {planned} |
| **Delayed** | {delayed} |

---

## Timeline Overview

{Text-based timeline visualization}

```
Q1 2025
├── [✅] Alpha Release (2025-02-15) ← Completed on time
└── [✅] Internal Testing (2025-03-01) ← Completed 2 days early

Q2 2025
├── [🔄] Beta Release (2025-03-31) ← In Progress (75%)
└── [📅] Feature Freeze (2025-04-15) ← Planned (blocked by Beta)

Q3 2025
├── [📅] Public Launch (2025-06-30) ← Planned
└── [📅] 1.0 Release (2025-07-31) ← Planned
```

---

## Milestone Details

{For each milestone:}

### {Status Icon} {Milestone Name}

**ID**: {milestone-id}
**Target Date**: {target_date}
**Actual Date**: {actual_date if completed}
**Status**: {planned / in_progress / completed / delayed}
**Owner**: @{name}

**Description**:
{milestone description}

**Deliverables**:
- [X] {Deliverable 1} (if completed)
- [🔄] {Deliverable 2} (if in progress)
- [ ] {Deliverable 3} (if pending)

**Dependencies**:
{If dependencies exist:}
- Depends on: {dependency names}
- Blocks: {dependent milestone names}

**Contributing Sprints**:
- Sprint {X}: {contribution}
- Sprint {Y}: {contribution}

**Progress**: {percentage}%

**Status**: {On Time / Early / Delayed by X days / At Risk}

{If completed:}
**Completion Report**: [View Report](path/to/completion-report.md)

---

{Repeat for each milestone}

---

## Dependency Map

{Visual representation of milestone dependencies}

```
Alpha Release
    └── Internal Testing
            └── Beta Release
                    ├── Feature Freeze
                    └── Public Launch
                            └── 1.0 Release
```

---

## Progress Against Roadmap

**Original Plan vs. Actual**:

| Milestone | Planned Date | Actual/Projected | Variance | Status |
|-----------|--------------|------------------|----------|--------|
| Alpha | 2025-02-15 | 2025-02-15 | On time | ✅ |
| Beta | 2025-03-31 | 2025-04-05 | +5 days | ⚠️ |
| Launch | 2025-06-30 | 2025-07-10 | +10 days | ⚠️ |

---

## Risk Analysis

### Milestones At Risk

{For milestones at risk:}

#### ⚠️ {Milestone Name}
- **Risk Level**: {High / Medium / Low}
- **Reason**: {why at risk}
- **Impact**: {what happens if delayed}
- **Mitigation**: {plan to get back on track}
- **Owner**: @{responsible person}

---

## Recommendations

{Based on milestone analysis:}

1. {Recommendation for getting milestones on track}
2. {Recommendation for risk mitigation}
3. {Recommendation for process improvement}

---

**Report Generated by**: ProjectMaster
**Last Updated**: {YYYY-MM-DD HH:MM}
```

### Velocity Report Format:

```markdown
# Velocity Report: {Project Name}

**Generated**: {YYYY-MM-DD HH:MM}
**Analysis Period**: {first_sprint_date} to {current_date}
**Sprints Analyzed**: {count}

---

## Velocity Summary

| Metric | Value |
|--------|-------|
| **Average Velocity** | {avg} story points/sprint |
| **Highest Velocity** | {max} points (Sprint {X}) |
| **Lowest Velocity** | {min} points (Sprint {Y}) |
| **Standard Deviation** | {stddev} points |
| **Trend** | {Improving / Stable / Declining} |

---

## Sprint-by-Sprint Velocity

| Sprint | Goal | Planned | Actual | Completion % | Status |
|--------|------|---------|--------|--------------|--------|
| Sprint 1 | {goal} | {planned} | {actual} | {pct}% | {icon} |
| Sprint 2 | {goal} | {planned} | {actual} | {pct}% | {icon} |
| Sprint 3 | {goal} | {planned} | {actual} | {pct}% | {icon} |
| ... | ... | ... | ... | ... | ... |

**Total Story Points Delivered**: {total} points across {count} sprints

---

## Velocity Trend Analysis

{Text-based trend visualization}

```
Story Points
50 │
45 │        ●
40 │    ●       ●
35 │●
30 │                ●
25 │                    ●
   └─────────────────────────
    S1  S2  S3  S4  S5  S6
```

**Trend**: {Improving / Stable / Declining}

**Analysis**:
{Interpret the trend:}
- Sprint 1-2: Ramping up, team finding rhythm
- Sprint 3-4: Peak performance, all team members fully onboarded
- Sprint 5-6: {Slight decline due to complexity / Maintained pace / etc.}

---

## Estimation Accuracy

**Overall Accuracy**: {percentage}%

| Sprint | Estimated | Delivered | Accuracy | Notes |
|--------|-----------|-----------|----------|-------|
| Sprint 1 | {est} | {actual} | {pct}% | {notes} |
| Sprint 2 | {est} | {actual} | {pct}% | {notes} |
| ... | ... | ... | ... | ... |

**Observations**:
- {Observation about overestimation/underestimation patterns}
- {Observation about improving accuracy over time}

---

## Factors Affecting Velocity

{Analyze factors that impacted velocity}

### Positive Factors
- {Factor 1}: Increased velocity by ~{X}% (Sprint {Y})
- {Factor 2}: Contributed to higher output

### Negative Factors
- {Factor 1}: Reduced velocity by ~{X}% (Sprint {Y})
- {Factor 2}: Caused delays

### Lessons Learned
- {Lesson 1}
- {Lesson 2}

---

## Team Capacity Analysis

**Team Size Over Time**:
{If team size changed}

| Period | Team Size | Avg Velocity | Points per Person |
|--------|-----------|--------------|-------------------|
| Sprint 1-2 | {size} | {velocity} | {per_person} |
| Sprint 3-5 | {size} | {velocity} | {per_person} |

**Observations**:
- {How team size changes affected overall velocity}
- {Per-person productivity trends}

---

## Story Point Distribution

**By Size**:

| Size | Count | Percentage | Avg Completion Time |
|------|-------|------------|---------------------|
| 1 pt | {count} | {pct}% | {X} days |
| 2 pts | {count} | {pct}% | {X} days |
| 3 pts | {count} | {pct}% | {X} days |
| 5 pts | {count} | {pct}% | {X} days |
| 8 pts | {count} | {pct}% | {X} days |
| 13+ pts | {count} | {pct}% | {X} days |

**Observations**:
- {Most common story size}
- {Correlation between size and completion rate}

---

## Velocity Predictions

**For Next Sprint**:
- **Conservative Estimate**: {avg - stddev} points
- **Expected Estimate**: {avg} points
- **Optimistic Estimate**: {avg + stddev} points

**Recommendation**: Plan for {recommended} story points in Sprint {next}

**Rationale**: {Based on recent trend and team capacity}

---

## Recommendations for Sprint Planning

{5-7 actionable recommendations based on velocity analysis}

1. **Story Sizing**: {recommendation about estimations}
2. **Capacity Planning**: {recommendation about sprint commitments}
3. **Risk Buffer**: {recommendation about buffer time}
4. **Team Focus**: {recommendation based on patterns}
5. **Process Improvements**: {recommendation for efficiency}

---

## Appendix: Data Sources

- Sprint Plans: {paths to sprint documents}
- Sprint Retrospectives: {paths to retro notes}
- Team Composition: {source}
- Story Point Definitions: {link to estimation guide if exists}

---

**Report Generated by**: ProjectMaster
**Last Updated**: {YYYY-MM-DD HH:MM}
```

### Full Report:

Combine all sections above into one comprehensive document with table of contents.

## Task 4: Save and Present Report

1. **Create reports directory** (if doesn't exist):
   ```bash
   mkdir -p reports/
   ```

2. **Generate filename**:
   ```
   reports/{report-type}-{project-name-slug}-{YYYY-MM-DD}.md
   Example: reports/summary-ecommerce-redesign-2025-11-13.md
   ```

3. **Write report file**:
   ```
   Use Write tool to create the report document
   ```

4. **Update governance**:
   - Add entry to project README.md Recent Activity:
     ```markdown
     - 2025-11-13: Generated {report-type} report
     ```
   - Create or update reports/README.md:
     ```markdown
     # Project Reports

     ## Recent Reports
     - [{Date}: {Report Type}](filename.md) - {Brief description}
     ```

5. **Present confirmation**:
   ```
   ✅ Report Generated Successfully!

   📄 Report Type: {type}
   📊 Project: {project name}
   📅 Generated: {date time}

   📁 Saved to: reports/{filename}.md

   📊 Report includes:
   {List of sections included}

   💡 Next steps:
   - View report: Read reports/{filename}.md
   - Share with team
   - Generate different report type: /project-report {project} {other-type}

   Would you like me to:
   - Summarize key findings from the report
   - Open the report for viewing
   - Generate another report type
   ```

## Notes

- Reports are markdown documents - easy to read, share, and version control
- Reports are timestamped - track project evolution over time
- Each report type serves different audiences:
  - **Summary**: Executives, stakeholders
  - **Sprint**: Team, Scrum Master
  - **Milestone**: Project Manager, Product Owner
  - **Velocity**: Team, for sprint planning
  - **Full**: Comprehensive record, audits
- Reports are generated from live data - always current
- Reports become historical record of project progress

## Examples

### Example 1: Generate Summary Report

```
User: /project-report

Claude: 📊 Generate Project Report

Select project:
1. E-Commerce Redesign (./ecommerce-redesign)
2. Mobile App (./mobile-app)

Which project? (1-2)

User: 1

Claude: Select report type:
1. Summary - High-level overview
2. Sprint - Current sprint analysis
3. Milestone - Milestone progress
4. Velocity - Team performance
5. Full - Comprehensive report

Which type? (1-5)

User: 1

Claude: Generating summary report for E-Commerce Redesign...

[Gathers data, generates report]

✅ Report Generated Successfully!

📄 Report Type: Summary
📊 Project: E-Commerce Redesign
📅 Generated: 2025-11-13 10:30

📁 Saved to: reports/summary-ecommerce-redesign-2025-11-13.md

📊 Report includes:
- Executive summary
- Current sprint status (Sprint 5)
- Milestone progress (3/7 completed)
- Key achievements (last 30 days)
- Risks and recommendations

Key Finding: Project is on track. Beta Release milestone due in 15 days with 75% progress.

Would you like me to summarize other key findings?
```

### Example 2: Direct Command

```
User: /project-report ecommerce-redesign velocity

Claude: Generating velocity report for E-Commerce Redesign...

[Analyzes last 6 sprints, calculates metrics]

✅ Velocity Report Generated!

📊 Key Findings:
- Average Velocity: 42 points/sprint
- Trend: Stable
- Estimation Accuracy: 89%
- Recommendation: Plan 40-45 points for Sprint 6

📁 Full report: reports/velocity-ecommerce-redesign-2025-11-13.md
```

---

This command transforms project data into actionable insights. Reports provide clarity for decision-making and accountability for progress.
