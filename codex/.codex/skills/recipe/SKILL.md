---
name: recipe
description: Convert a recipe URL or pasted recipe text into the user's Obsidian recipe markdown format. Use when Codex needs to extract recipe content from a webpage or raw text, convert measurements to metric, maintain menu.md wiki links, and create or return a recipe note using the user's current no-frontmatter format.
---

# Recipe

Convert a recipe URL or pasted recipe text into the user's Obsidian recipe format.

Use this skill when the user asks to add, convert, format, import, or clean up a recipe. Work one recipe at a time unless the user explicitly asks for batch work.

## Vault Context

- Recipe notes live in `/Users/sunanrm/Library/Mobile Documents/iCloud~md~obsidian/Documents/cloud-storage`
- `menu.md` is the source of truth for recipe discoverability
- New recipe notes should be linked from `menu.md` in the right section
- Existing recipe notes in the vault are the style reference

## Required Workflow

1. Determine whether the input is a URL, pasted text, or a request to create a recipe from a dish name.
2. If the input is a URL, fetch the source and extract the recipe before drafting.
3. If the input is pasted text, work from the supplied text and do not invent source details.
4. If the input is only a dish name, draft a practical 4-serving version and state any assumptions before writing.
5. Remove non-recipe content such as author bio, blog story, ads, nutrition, unrelated serving suggestions, and equipment lists unless equipment is critical.
6. Convert measurements to the user's metric style.
7. Draft the recipe in the exact format rules below.
8. Ask for user approval before writing or modifying recipe files unless the user explicitly asked you to write immediately.
9. After approval, create or update the recipe note and update `menu.md`.
10. Verify the recipe filename appears in `menu.md` as a wiki link.

## Recipe Format

- Do not use frontmatter
- Start the note with `# <Recipe Name>`
- Use `##` for section headings
- Do not use `---` dividers
- Use `## Ingredients` for the main ingredient list
- Use unordered lists for ingredients with `-`
- Use `## Instructions` for method steps
- Use ordered lists for instructions with `1.` markers
- Put source links at the end as `### [Link](url)` when a source exists
- Do not wrap the final recipe in a markdown code fence when writing to a file

## Section Guidance

- Default to one `## Ingredients` section and one `## Instructions` section
- Split ingredient groups only when it improves clarity, such as sauce, filling, dough, topping, or garnish
- Use clear subsection headings under ingredients only when useful
- Keep instructions in one ordered list unless separate components are clearer
- Preserve important sequencing and dependency details from the source
- Keep optional garnish only if it materially affects the dish
- Prefer concise practical wording over source prose

## Menu Format

Update `menu.md` with wiki links grouped under these sections:

```markdown
## Main dish

- [[Recipe Name]]

## Side dish

- [[Recipe Name]]

## Sauce

- [[Recipe Name]]

## Dessert

- [[Recipe Name]]
```

Choose the most appropriate section. If a recipe could belong in more than one section, use the primary serving role.

## Measurements

- Always use metric units: `g`, `ml`, `°C`, and `cm`
- Always put a space between number and unit: `300 g`, `400 ml`, `180 °C`, `20 cm`
- Keep `tbsp` and `tsp` as-is
- Convert imperial values such as `oz`, `lb`, `cups`, `°F`, and `inches`
- Use practical kitchen conversions instead of false precision
- Round grams and milliliters to sensible values unless precision matters
- Convert oven temperatures to standard Celsius equivalents
- Retain count-based units like eggs, cloves, onions, carrots, limes, and sheets
- Prefer 4-serving recipes unless the user specifies another serving count

## Writing Style

- Keep prose concise and direct
- Never use en dashes or em dashes
- Use a plain hyphen if a dash is needed
- Single-sentence ordered and unordered list items do not end with a period
- Do not add unnecessary introductions or commentary to recipe files
- Keep useful tips or caveats in parentheses in the relevant step
- Use bold text only for critical warnings when it prevents a likely mistake

## Output Template

```markdown
# Recipe Name

## Ingredients

- Ingredient
- Ingredient

## Instructions

1. Step
2. Step

### [Link](https://example.com)
```

Omit the link heading when there is no source.

## Output Constraints

- If the user asks for recipe text only, return only the final markdown content
- If writing files, modify the recipe note and `menu.md` directly after approval
- Do not add commentary inside recipe files
