@RTK.md

# CLAUDE.md

Behavioral guidelines to reduce common LLM coding mistakes. Merge with project-specific instructions as needed.

**Tradeoff:** These guidelines bias toward caution over speed. For trivial tasks, use judgment.

## Writing Style

- Never use en dashes (–) or em dashes (—). Use a plain hyphen (-) if a dash is needed
- Use semicolons sparingly
- Avoid staccato drama - runs of short punchy sentences create artificial pauses and an overdramatic tone. Write sentences at natural, varied length
- Keep prose concise and direct
- Single-sentence ordered and unordered list items do not end with a period

## graphify

- **graphify** (`~/.claude/skills/graphify/SKILL.md`) - any input to knowledge graph. Trigger: `/graphify`
  When the user types `/graphify`, invoke the Skill tool with `skill: "graphify"` before doing anything else.

## 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:

- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

## 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:

- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:

- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

## 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:

- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:

```text
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.

## 5. Delegate Sparingly

**Subagents multiply cost. Each one re-establishes context, re-explores, and reports back - then you re-read its report.**

Measured fan-out runs 2.6x to 3.2x the tokens of a sequential pass, and is rarely faster.

Delegate for:

- Genuinely independent, parallelizable tracks, such as a wide multi-file investigation

Do not delegate for:

- Work you could finish directly in a handful of tool calls
- Review or verification - that belongs in the main loop

When delegating:

- Prefer one subagent over several, and keep spawn counts low
- Brief it precisely the first time rather than launching, waiting, and re-briefing
- Commit to the result - don't redo the work or re-derive its findings
- Send independent spawns in a single message so they run concurrently
- Never exceed 20 parallel agents unless explicitly asked

## 6. Session Hygiene

**The whole context is re-sent every turn. Manage it deliberately.**

Auto-compact is off by design, so the discipline has to replace it:

- **New task, new session.** Suggest starting fresh at task boundaries instead of continuing
- **Rewind over correct.** Correcting leaves the failed attempt in context to be re-sent forever; rewinding removes it
- **Directed compact.** When compacting, name the focus ("keep the auth refactor, drop the debugging") rather than letting it guess
- Quality degrades from context rot well before the window fills. Treat a 1M window as headroom, not a target

---

**These guidelines are working if:** fewer unnecessary changes in diffs, fewer rewrites due to overcomplication, and clarifying questions come before implementation rather than after mistakes.
