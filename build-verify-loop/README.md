# Build-Verify Loop

Self-iterating autonomous orchestration loop for Claude Code. The main agent acts as a pure orchestrator — it spawns isolated **Implementor** and **Critic** subagents in rounds and lets them run until the artifact converges, an iteration cap is hit, or escalation is needed.

Domain-agnostic. Works for code, documents, plans, designs, copy, specs, proposals — anything with an iterable artifact and explicit acceptance criteria.

Short alias: **bvl** (equivalent trigger).

## How it works

The main agent never writes the artifact and never judges individual findings. Each round:

1. **Implementor** — produces or revises the artifact, addressing prior findings
2. **Critic** — adversarial audit against the acceptance criteria

Findings flow **verbatim** from Critic to next-round Implementor. No orchestrator filter, paraphrase, or summary. This discipline is what makes the loop work — the moment the orchestrator starts editing findings, signal is lost.

The loop exits on convergence (two consecutive clean rounds), iteration cap (default 5), or an escalation condition (blocked, stalled, disputed).

## Installation

```bash
/plugin install build-verify-loop@legacybridge-cc-plugins
```

## Usage

```
/build-verify-loop <task>
/bvl <task>
```

Or natural language:

- "Run a build-verify loop on X"
- "Use bvl on Y"
- "Autonomously complete Z with self-verification"
- 「使用 bvl skill 做 X」「自主完成 Y」「閉環跑 Z」

## When to use

Good fits:

- Producing or revising a non-trivial artifact (code module, document section, design doc, plan, proposal, spec)
- The user has acceptance criteria they can articulate up front
- The user wants the work done without per-round confirmation, but with rigor preserved

Not for:

- Single-shot tasks (no iteration needed)
- Open-ended exploration where AC cannot be defined
- Real-time conversational tasks
- Tasks where the user wants to be involved in every round
- Tasks requiring external side effects (deploy, send email, post to chat)

## Required inputs

When triggered, the skill confirms (in one batched prompt) that the following are provided:

1. **TASK** — one-line goal statement
2. **ARTIFACT** — file path(s) the Implementor reads and writes each round
3. **ACCEPTANCE CRITERIA (AC)** — bullet list defining "done"
4. **DOMAIN CONTEXT** — minimal pointers the subagents need (style guide, repo layout, prior decisions)
5. **ITERATION_CAP** — optional override (default 5)

## Documentation

Full skill definition with orchestration discipline, subagent design step, exit conditions, and final report format: [`skills/build-verify-loop/SKILL.md`](./skills/build-verify-loop/SKILL.md).
