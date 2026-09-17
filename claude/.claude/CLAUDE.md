@RTK.md

# CLAUDE.md

## Writing Style

- Never use en dashes (–) or em dashes (—). Use a plain hyphen (-) if a dash is needed
- Use semicolons sparingly
- Avoid staccato drama - runs of short punchy sentences create artificial pauses and an overdramatic tone. Write sentences at natural, varied length
- Keep prose concise and direct
- Single-sentence ordered and unordered list items do not end with a period

## graphify

- **graphify** (`~/.claude/skills/graphify/SKILL.md`) - any input to knowledge graph. Trigger: `/graphify`
  When the user types `/graphify`, invoke the Skill tool with `skill: "graphify"` before doing anything else.

## Code Navigation

When tracing where a symbol is defined or finding all references to it, use LSP (goToDefinition, findReferences, hover) instead of Grep. LSP gives exact results; Grep gives text matches.

Use Grep/Glob for discovery (finding files, searching patterns). Use LSP for understanding (definitions, references, type info).

After locating a file with Grep/Glob, use LSP to navigate within it rather than reading the whole file.

## Output Manipulation

- When working with json objects, prefer to use `jq` than `python3` commands, if
  not installed, prompt the user to add `jq` to Brewfile and install with
  `brew bundle`
