---
description: Initialize AkashicRecords governance for current directory and subdirectories
---

# Initialize AkashicRecords Governance

Mark the current directory and all subdirectories as following AkashicRecords governance rules.

## What this does

1. Scans current directory structure
2. Identifies directories needing RULE.md or README.md
3. Prompts user for initialization strategy
4. Creates initial RULE.md (or inherits from parent)
5. Creates/updates README.md with current contents
6. Validates structure

## Usage

```
/akashic-init
```

Invoke the governance agent to initialize directory governance.
