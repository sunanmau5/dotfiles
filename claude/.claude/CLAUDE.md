@RTK.md

# CLAUDE.md

## Writing Style

- Never use en dashes (–) or em dashes (—). Use a plain hyphen (-) if a dash is needed
- Use semicolons sparingly
- Avoid staccato drama - runs of short punchy sentences create artificial pauses and an overdramatic tone. Write sentences at natural, varied length
- Keep prose concise and direct
- Single-sentence ordered and unordered list items do not end with a period
- Always write the relative pronoun (that, which, who, whose), never drop it in a contact clause. Write "the values that a restore would write", not "the values a restore would write"
- Don't make an action or process the subject that does something ("a restore writes", "the check catches"). Name who does it, or use a "when" clause: "the values that we get when we restore a version"

## graphify

- **graphify** (`~/.claude/skills/graphify/SKILL.md`) - any input to knowledge graph. Trigger: `/graphify`
  When the user types `/graphify`, invoke the Skill tool with `skill: "graphify"` before doing anything else.

## Output Manipulation

- When working with json objects, prefer to use `jq` than `python3` commands, if
  not installed, prompt the user to add `jq` to Brewfile and install with
  `brew bundle`
