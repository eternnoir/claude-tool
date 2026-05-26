---
name: build-verify-loop
description: Self-iterating autonomous loop where the main agent acts as a pure orchestrator, spawning isolated Implementor and Critic subagents in rounds until the artifact converges, an iteration cap is reached, or human escalation is needed. Domain-agnostic — works for code, documents, plans, designs, copy, specs, proposals, or anything with an iterable artifact and explicit acceptance criteria. Also addressable by the short alias "bvl".
---

# Build-Verify Loop

A standalone Claude Code skill. Drop this directory into `~/.claude/skills/build-verify-loop/` and trigger with `/build-verify-loop <task>`. No additional configuration required.

## What this is

An orchestration pattern for autonomous work. The main agent does not do the work itself — it spawns two isolated subagents per round:

- **Implementor** — produces / revises the artifact, addressing prior findings
- **Critic** — adversarial audit against acceptance criteria

The loop continues until the Critic finds nothing material for two consecutive rounds, or an exit condition forces escalation. The main agent never judges the content of individual findings, never paraphrases between subagents, and never injects its own framing — this is the discipline that makes the loop work.

## When to use

Trigger phrases:

- `/build-verify-loop <task>` or `/bvl <task>`
- "Run a build-verify loop on X" / "Use bvl on X" / "Run bvl for Y"
- "Autonomously complete X with self-verification"
- "Self-iterate Y until done"
- 「自主完成 X」「閉環跑 Y」「自己跑迴圈做 Z」「用 bvl 跑 X」「啟動 bvl 做 Y」「使用 bvl skill 做 X」

Good fits:

- Producing or revising a non-trivial artifact (code module, document section, design doc, plan, proposal, spec)
- The user has acceptance criteria they can articulate up front
- The user wants the work done without per-round confirmation, but with rigor preserved

## When NOT to use

- Single-shot tasks (no iteration needed)
- Open-ended exploration where AC cannot be defined
- Real-time conversational tasks
- Tasks where the user wants to be involved in every round
- Tasks requiring external side effects (deploy, send email, post to chat) — this skill is for artifact production only

## Required inputs

When triggered, ensure the following are provided. If any are missing, ask in **one batched message** before starting the loop:

1. **TASK** — one-line goal statement
2. **ARTIFACT** — file path(s) the Implementor will read and write each round
3. **ACCEPTANCE CRITERIA (AC)** — bullet list defining "done". Examples by domain:
   - Code: tests must pass, no hardcoded credentials, function signature matches `foo(x: int) -> str`
   - Document: covers sections A/B/C, audience is non-technical executives, under 800 words, tone formal
   - Plan: includes pre-conditions, rollback, owner per phase, risk register
4. **DOMAIN CONTEXT** (optional but recommended) — short paragraph orienting subagents to the work
5. **ITERATION_CAP** (optional, default 5) — max rounds before forced escalation

## Main agent role: pure orchestrator

The main agent's job during the loop:

- Compile a self-contained brief once (Round 0)
- **Design the subagents for this task** — analyze failure modes, pick or design Critic lens(es), decide whether to customize the Implementor (see "Designing subagents for the task" below)
- Spawn Implementor and Critic subagents each round with isolated context
- Track findings; judge structural signals (count, severity trend, convergence, **drift** — HIGH-severity findings rebounding in a later round after an earlier round closed them, indicating that fixes introduced new issues)
- Trigger exit conditions
- Report to user at end

The main agent must **not**:

- Judge content of individual findings (don't side with Implementor or Critic)
- Translate / paraphrase / summarize / **filter** between subagents — pass artifacts and findings verbatim, **always, without exception**. See "Hard Rule: verbatim pass" below.
- Inject opinions ("I think this is OK now") or framing into subagent prompts
- Continue past iteration cap silently
- Arbitrate substantive disagreements between subagents — escalate to the user

This discipline is the entire point. The main agent's accumulated conversation context can bias judgment toward convergence or toward preferences the user has expressed in unrelated discussions. Subagents spawned with fresh context, given only the brief and the artifact, do not carry that bias.

### Hard Rule: verbatim pass — no orchestrator filtering of findings

When passing Critic findings to the next Implementor round, the orchestrator **must pass the full finding list verbatim**, without dropping, paraphrasing, summarizing, reordering, or annotating "this one is legit, this one is over-claim".

This is a Hard Rule, not a guideline. The temptation will be real and the reasoning will sound legitimate — "Critic over-claimed on finding #3, why waste a round addressing it?" Resist. The moment the orchestrator starts filtering findings on judgment, the entire fresh-context isolation discipline erodes: each individual filter looks reasonable, but the cumulative effect is that the orchestrator's accumulated bias is back in the loop, just laundered through "reasonable filtering". The skill stops being a build-verify loop and becomes "the main agent's opinions, refined through a couple of subagent rounds".

**Filter judgment belongs to the Implementor, not the orchestrator.** If a finding is over-claimed, wrong, or impractical, the Implementor's job is to push back in writing (see Implementor prompt below). The orchestrator's job is to deliver every finding intact so the Implementor can exercise that judgment.

If the orchestrator notices a finding seems clearly wrong, the correct action is **not** to drop it. The correct action is to surface the observation **in the final report** for the user, after the loop exits — never inside the loop, never before passing findings forward.

## Loop protocol

### Round 0 — Brief preparation

Compile a brief from the user's inputs using this exact schema. Do not add commentary, do not amend across rounds.

```
TASK: <one-line goal>
ARTIFACT: <path(s)>
ACCEPTANCE CRITERIA:
  - <ac 1>
  - <ac 2>
  ...
DOMAIN CONTEXT: <optional paragraph>
```

### Round N — Implementor phase

Spawn a `general-purpose` subagent with the following composite prompt:

1. The Implementor role prompt (embed verbatim — see below)
2. The brief (verbatim)
3. If N > 1: the previous round's Critic findings (verbatim, not summarized)

The Implementor reads the artifact, addresses findings if any, writes the updated artifact at the same path, and returns:

- `DONE — artifact updated at <path>` (with optional disagreement notes)
- `BLOCKED — <reason and what unblock requires>`

### Round N — Critic phase

Spawn a `general-purpose` subagent with the following composite prompt:

1. The Critic role prompt (embed verbatim — see below)
2. The brief (verbatim)
3. The artifact path ONLY (do **not** pass the Implementor's return message — the Critic re-reads the artifact fresh)

The Critic returns a structured finding list, `NO FINDINGS`, or `BLOCKED`.

### Exit conditions

After each Critic phase, evaluate:

| Condition | Action |
|-----------|--------|
| Critic returns `NO FINDINGS` for 2 consecutive rounds | **EXIT: success** |
| Round count reaches `ITERATION_CAP` | **EXIT: escalate** — cap reached |
| Critic findings substantially repeat the prior round's findings (no progress) | **EXIT: escalate** — stalled |
| Implementor returns `BLOCKED` | **EXIT: escalate** — blocked |
| Critic findings shrink to LOW-severity nitpicks for 2+ rounds | **EXIT: success-with-residual** — ask user if one more pass is desired |
| Implementor disputes a HIGH-severity finding in its return message | **EXIT: escalate** — substantive disagreement |

**Drift signal** (not an exit condition by itself — a structural observation to surface):

If a round closes HIGH-severity findings and a later round shows new HIGH-severity findings introduced by those fixes, this is **drift**. Drift is normal in iterative work but should be:

- Tagged in the finding evolution table (e.g., `R3: 4 HIGH (drift from R2 fixes)`)
- Reported to the user at loop exit in the structural summary
- Distinguished from `Critic findings repeat prior round` (stalled, which IS an exit condition) — drift means new findings replacing old ones, stalled means same findings persisting

If drift recurs across multiple rounds (HIGH rebounds 3+ times), escalate as "stalled with churn" — the underlying spec or AC may be under-specified.

## Subagent role prompts

These prompts are intentionally domain-neutral. Embed them **verbatim** when spawning subagents — do not paraphrase, do not adapt to "fit the domain". The prompts are designed to work across code, documents, plans, designs, and other iterable artifacts.

### Implementor prompt

```
You are the Implementor in a build-verify loop.

Your job:
1. Read the TASK, ARTIFACT path(s), and ACCEPTANCE CRITERIA from the brief below.
2. Read the current state of the artifact.
3. If prior Critic FINDINGS are attached, address each one in your update.
4. Produce an updated artifact at the same path(s).

Discipline:
- Address findings literally. Do not reinterpret them in more convenient ways.
- Every finding in the input MUST receive an explicit response in your return message. For each finding, choose one of:
    (a) Apply the fix and note "Addressed: <finding ref>" — the artifact change speaks for the fix.
    (b) Push back: explain why the finding is wrong, impractical, over-claimed, or misunderstanding the artifact, with concrete reasoning. If the finding has a legitimate kernel, apply a partial fix that addresses the kernel and explain what you did not change.
    (c) Defer with reason: explain why the fix is out of scope for this loop / requires a decision outside your authority.
- Silently skipping a finding is forbidden. The orchestrator is required to pass findings verbatim and cannot filter on your behalf — the filter judgment is yours, and you must surface it in writing. A finding that received no response will be treated by the next Critic round as if you accepted the issue and failed to address it.
- Do NOT take shortcuts that satisfy AC literally while violating its intent. Examples:
    Code — do not mock the thing under test, do not skip difficult test cases, do not hardcode outputs to make checks pass.
    Documents — do not pad with filler to hit length, do not bury weak sections, do not cite sources without verifying they support the claim.
    Plans — do not hide unknowns under vague language, do not claim coverage you cannot demonstrate.
- Optimize for actual AC satisfaction, not for "passing this round's Critic".

Return ONE of:
- DONE — artifact updated at <path>. Optional notes: <any disagreement with findings, with reasoning>.
- BLOCKED — <reason>. State what unblock requires.

Do NOT include a summary of what you did. The Critic reads the artifact fresh.
```

### Critic prompt

```
You are the Critic in a build-verify loop. Your role is adversarial audit.

Your job:
1. Read the TASK and ACCEPTANCE CRITERIA from the brief below.
2. Read the artifact at the path(s) provided.
3. Audit ruthlessly against AC and general quality standards for the domain.
4. Return a structured finding list.

Discipline:
- Assume nothing works until evidence in the artifact shows it does.
- Demand evidence for every claim the artifact makes.
- Look for: missing AC coverage, hidden assumptions, edge cases, internal inconsistencies, ways the Implementor may have gamed the AC, ambiguity that fails under stress.
- Do NOT compliment, hedge, or soften findings to be polite.
- Do NOT give the benefit of the doubt on ambiguity — flag it as a finding.
- Do NOT trust any prior round's outcome — every audit is fresh.
- **Severity is a commitment, not exploratory.** If you flag HIGH, you own it — do not annotate "I'm not sure" or self-downgrade in the same finding. If you cannot defend a finding at HIGH, flag it at the severity you can defend, or do not flag it. The same applies to MEDIUM vs LOW. A finding's severity is your assessment, not a hedge.

What NOT to do:
- Do NOT suggest implementation fixes. Only flag what is wrong and why. The Implementor decides how to fix.
- Do NOT score or approve the artifact. Only enumerate findings. The orchestrator decides exit.
- Do NOT critique decisions outside the artifact (such as AC reasonableness or scope) unless they cause an internal contradiction.

Return format:

FINDING #1
  Severity: HIGH | MEDIUM | LOW
  AC reference: <AC bullet number, or "general quality" if outside AC>
  Issue: <one-line problem statement>
  Evidence: <specific section / line / claim in the artifact that shows this>

FINDING #2
  ...

If no material findings: return exactly "NO FINDINGS — artifact passes audit".
If the artifact is missing or unreadable: return "BLOCKED — <reason>".
```

## Designing subagents for the task

The default Implementor and Critic prompts above are starting points. For non-trivial tasks the orchestrator should **reason about what subagents this specific task needs** — what failure modes matter, which audit angle catches them, whether one Critic is enough — before Round 1.

Do this design step once, after Round 0 brief preparation and before spawning the first Implementor. The output is: which Implementor prompt to use (default or customized) and which Critic prompt(s) to use (default Destruction lens, one of the reference lenses below, a custom lens designed from scratch, or multiple Critics in parallel).

### Step 1 — Analyze the artifact's failure modes

Ask: "What does failure look like for **this** artifact, and which failure mode is most costly or most likely?"

Examples by domain:

| Artifact | Plausible failure modes |
|----------|------------------------|
| Code module | Bugs / edge cases · security vulns · unmaintainable structure · perf regression |
| Customer proposal | Audience mismatch · weak business case · factual errors · brand voice off |
| Technical design doc | Missed edge cases · internal contradictions · alternatives not considered · scaling assumptions wrong |
| Sales / marketing copy | Weak hook · factual incorrect · tone off · missing objection handling |
| Plan / roadmap | Hidden unknowns · unclear ownership · missing rollback · over-optimistic timeline |
| Spec / requirements | Ambiguity · contradictions · missing AC · stakeholder coverage gap |

Pick the **1–3 highest-cost or highest-probability** failure modes for this artifact. This list drives lens selection.

### Step 2 — Map failure modes to Critic lens

Each failure mode suggests an audit lens. Common mappings:

| Failure mode | Lens |
|--------------|------|
| Things break / edge case / hidden assumption / spec contradiction | **Destruction** (default) |
| Internal contradictions / drift across sections / spec-vs-impl gap | **Coherence** |
| Audience friction / cognitive load / tone mismatch / unclear next step | **Experience** |
| Adversarial misuse / trust boundary leak / input validation gap | **Security** |
| Regulatory / compliance / contract / policy gap | Compliance (design custom) |
| Sub-optimal architecture / unconsidered alternatives | Construction-as-critic (design custom) |

If a failure mode doesn't fit a provided lens, **design a custom lens** following the shape of the reference templates below — identify the mindset for that audit angle, list 5–8 concrete patterns to flag, keep the shared frame.

### Step 3 — Single Critic or multi-Critic?

- **Single Critic** (default) — failure modes are dominated by one lens, or token budget is constrained. Covers the majority of tasks.
- **Multi-Critic parallel** — failure modes are genuinely orthogonal (e.g., a security-critical user-facing API needs Security **and** Experience), or the artifact is near-final and deserves deep multi-angle audit. Each Critic returns its own list; concatenate findings without dedupe (a single issue flagged by multiple lenses is signal, not noise).
- **3+ lenses** — rare. Only when stakes justify the token cost.

Cost scales roughly linearly with lens count per round. Pick the smallest set that covers the chosen failure modes.

### Step 4 — Customize the Implementor (only when needed)

The default Implementor works for most artifacts. Customize the Implementor's role prompt when:

- The artifact requires a specific **voice / tone / persona** (e.g., "writer addressing non-technical executives", "API doc writer", "legal counsel drafting clauses")
- The artifact requires **domain expertise to produce correctly** (e.g., scientific writing, accessibility-compliant UI, regulated documentation)
- The "right way to do this work" **meaningfully diverges from generic best practice**

When customizing, modify the Implementor's `Discipline` paragraph to inject the perspective. Keep the rest (return format, no shortcuts, no self-summary) intact.

If none of these conditions apply, do not customize. A generic Implementor with the right Critic feedback converges fine.

### Step 5 — Tell the user what was designed

Before Round 1, the orchestrator briefly reports its design choice in one or two lines:

> "For this task I'll use [default Implementor / customized Implementor with X perspective] + [Critic lens(es): A (+ B)]. Iteration cap N. Say so before Round 1 if you want different."

This is a one-line update, not a justification essay. User can override; if no objection within a beat, proceed to Round 1.

---

## Reference: Critic lens templates

The three templates below are **examples of well-designed lenses** — concrete grounding for the design step above. They are not a menu to pick from blindly. The orchestrator may use one verbatim, modify one, combine multiple, or write a new lens following the same shape.

Shared frame across all lenses (do not change when designing or modifying):

- Read TASK + AC + artifact, audit ruthlessly, return structured findings
- Do not suggest fixes, do not score, do not approve
- Do not soften, do not give benefit of the doubt
- Use the same finding format (Severity / AC reference / Issue / Evidence)

The lens-specific paragraphs (`Discipline` and `Look for`) are what changes per lens.

### Coherence lens

**When to use** — Cross-artifact alignment work: multi-section documents, spec-vs-implementation checks, multi-document review (multiple ADRs, multi-spec), long-conversation drift detection, anywhere "do the parts fit together" matters more than "does any single part work".

**Lens-specific paragraphs** (replace the default Critic's `Discipline` and `Look for` sections):

```
Discipline (Coherence lens):
- Read the artifact as a whole. Then read it again section by section, asking "does this section's claim agree with what other sections say?"
- If the artifact references external sources (other docs, decisions, specs), trace each reference and verify consistency.
- Treat contradictions, undefined cross-references, and silent goal drift as the primary failure modes.

Look for:
- Internal contradictions: one section claims X, another assumes ¬X
- Goal drift: stated goal in intro vs. what later sections actually optimize for
- Missing connections: section A presupposes a result section B should establish, but B does not
- Terminology drift: same concept named differently across sections, or different concepts collapsed under one name
- Scope creep: artifact silently expands beyond stated TASK
- Stale references: pointers to artifacts / decisions that no longer exist or have changed
```

### Experience lens

**When to use** — Reader-facing or user-facing artifacts: documentation, onboarding flows, UI copy, customer proposals, error messages, tutorials, anything where the audience's cognitive load and emotional response matter.

**Lens-specific paragraphs**:

```
Discipline (Experience lens):
- Read the artifact as the intended audience, not as the author. Assume the audience has the context level stated in the brief, no more.
- Track cognitive load: where does the reader have to hold multiple things in mind, infer unstated steps, or context-switch?
- Track emotional response: where might the reader feel confused, frustrated, talked-down-to, or lost?
- Test for first-time-reader failure: would a fresh reader know what to do next at every point?

Look for:
- Jargon / undefined terms used before introduction
- Required prerequisite knowledge not stated in the brief's audience profile
- Buried critical information (in footnotes, parentheticals, or after long preamble)
- Tone mismatches (overly formal, condescending, hedged, or evasive when directness is needed)
- Missing "what next" — reader finishes a section unsure what to do
- Cognitive cliffs: sudden jumps in complexity without scaffolding
- Empty politeness: words that take space without adding meaning
```

### Security lens

**When to use** — Security-sensitive artifacts: code touching authentication / authorization / cryptography / data handling, infrastructure config, API design, anything with a trust boundary or attack surface.

**Lens-specific paragraphs**:

```
Discipline (Security lens):
- Assume an adversary with the capabilities relevant to this artifact's threat model. If threat model is unstated, default to "external untrusted user with API access".
- For every input the artifact accepts, ask: what if the value is hostile, malformed, oversized, or crafted?
- For every output, ask: what does this leak? Could timing, error verbosity, or side channels reveal more?
- For every trust boundary, ask: is it actually enforced, or just assumed?

Look for:
- Input validation gaps: unbounded input, type confusion, injection vectors (SQL, command, template, prompt)
- Authentication / authorization bypasses: assumed identity, missing checks, role confusion
- Secrets handling: hardcoded credentials, secrets in logs / errors / version control, plaintext storage
- Crypto misuse: rolling own crypto, weak primitives, missing IVs, key reuse, wrong mode
- Trust boundary leaks: data crossing boundaries without sanitization, internal info in external responses
- Time-of-check vs. time-of-use races
- Dependency / supply chain trust assumptions
- Error handling: stack traces or internal state leaked to untrusted recipients
```

### Multi-Critic spawn mechanics

When the design step selects multiple Critic lenses (see "Designing subagents for the task" Step 3), or the user explicitly requests multiple lenses at trigger time (e.g., `/build-verify-loop draft proposal — critics: destruction, coherence, experience`):

- Spawn all Critics **in parallel** in a single orchestrator turn (do not serialize)
- Each Critic gets its own lens prompt, the same brief, and the same artifact path — they audit independently
- Wait for all Critic returns before evaluating exit conditions
- Concatenate the finding lists when passing to the next Implementor round — **do not dedupe and do not merge**; the same issue surfaced by multiple lenses is high-confidence signal, not noise
- Tag each finding with the lens that produced it (e.g., `FINDING #1 [Security]`) so the Implementor knows which audit angle generated it
- Exit conditions evaluate against the combined finding list — `NO FINDINGS` requires all Critics to return clean

## Final report format

At loop exit, report to the user in this structure:

```
LOOP EXIT
- Outcome: success | escalated | blocked | success-with-residual
- Rounds executed: N / ITERATION_CAP
- Final artifact: <path>

Subagent design used (audit trail):
- Implementor: <default | customized with "<perspective>">
- Critic(s): <lens name>  (or for multi-Critic: <lens A> + <lens B> + ...)
- Iteration cap: <N>

Finding evolution (orchestrator's structural summary, not verbatim findings):
- Round 1: <H:_ M:_ L:_> per Critic (tag if multi-Critic)
- Round 2: <H:_ M:_ L:_> per Critic
  ...
  (Tag drift rounds explicitly, e.g., "R3: 4 HIGH (drift from R2 fixes)")

Open items (if escalated or success-with-residual):
- <Item 1>
- <Item 2>

Next step requested from user: <if any>
```

## Configuration overrides (advanced)

Power users can adjust defaults at trigger time:

- **Custom subagent types** — if you have specialized builder / critic subagents (named personas, role-specific agents), name them and the orchestrator will spawn those instead of `general-purpose`. The role prompts above are still injected unless you specify "use the subagent's native behavior".
- **Iteration cap** — override the default of 5.
- **Strict critic mode** — append to the Critic prompt: `Any ambiguity is HIGH severity.` Use for high-stakes artifacts.
- **Lenient critic mode** — append to the Critic prompt: `Only flag findings that materially affect AC satisfaction. Skip stylistic nitpicks.` Use for early-draft fast iteration.

## Domain examples

| Domain | TASK example | ARTIFACT | AC example |
|--------|--------------|----------|------------|
| Code | Implement password validator | `src/validators/password.ts` | Tests in `tests/password.test.ts` pass; min 8 chars with mixed case and digit; no hardcoded values |
| Document | Draft customer-facing proposal | `proposals/acme-q3.md` | Exec summary under 200 words; 3 priced options; references MSA §4.2; tone matches `style-guide.md` |
| Plan | Migration plan for legacy DB | `plans/db-migration.md` | Pre-conditions section; rollback steps; risk register with mitigation; owner per phase; estimated downtime |
| Design | API endpoint design doc | `design/user-api.md` | All 5 use cases covered; auth strategy specified; error responses enumerated; versioning approach stated |
| Spec | Test plan for feature X | `tests/feature-x-plan.md` | Happy path plus 3 edge cases per AC; integration scenario; rollback test; manual QA checklist |
| Copy | Landing page hero section | `web/hero.html` | One headline under 10 words; one subheadline under 30 words; one CTA; passes brand voice rubric |

## Anti-patterns to enforce

The orchestrator must never:

- Pass the Implementor's self-report to the Critic (Critic reads the artifact path fresh)
- Summarize, paraphrase, or filter findings when passing them back to the next Implementor round — pass verbatim
- Inject opinions or framing into subagent prompts
- Skip the iteration cap check
- Vote or arbitrate when subagents disagree on substance — that is an escalation, not a decision the orchestrator gets to make

## What this skill does NOT do

- Does not define the AC for the user — user must supply it
- Does not pick the artifact format — user decides
- Does not persist state across separate `/build-verify-loop` invocations — each loop is fresh
- Does not integrate with version control / commit / push — orchestrator only reads and writes the artifact
- Does not call out to external systems (CI, deploy, notifications)

## Installation

Single-file skill. Place this directory at:

```
~/.claude/skills/build-verify-loop/
```

Then trigger with `/build-verify-loop <task>`.

No additional configuration, dependencies, or setup required.
