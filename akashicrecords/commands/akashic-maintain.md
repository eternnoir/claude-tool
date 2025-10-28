---
description: Validate and fix AkashicRecords governance issues
---

# Maintain AkashicRecords Governance

Manually check and fix governance issues in current directory tree.

## What this does

1. Scans all subdirectories recursively
2. Identifies missing RULE.md files
3. Identifies outdated README.md files (>7 days since modification)
4. Reports governance violations
5. Offers to fix issues automatically
6. Creates/updates files as needed

## Usage

```
/akashic-maintain
```

Useful for:
- Periodic maintenance
- After major directory reorganization
- Auditing governance compliance
- Fixing inheritance issues

Invoke the governance agent to perform comprehensive validation.
