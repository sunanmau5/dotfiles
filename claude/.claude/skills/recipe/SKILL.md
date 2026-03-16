---
name: recipe
description: Convert a recipe URL or pasted text into the user's Obsidian recipe format
user-invocable: true
---

Convert a recipe into the user's Obsidian recipe format.

The user will provide either a **URL** or a **block of text** containing a recipe. Your job is to reformat it to match the established style below exactly.

## Format rules

**Frontmatter:**
```
---
id: <Recipe Name>
aliases: []
tags:
  - recipe
---
```

**Sections:**
- Use `####` (h4) for all section headings
- Place a `---` divider on the line immediately after each heading (ingredients and instructions alike)
- Ingredients are bullet lists (`-`)
- Instructions are numbered lists
- If the recipe has distinct component groups (e.g. chicken + sauce + toppings), split them into separate `####` sections, each with their own `---` divider
- Each ingredient group should be followed by its own `#### Instructions` block (with `---`) if instructions are provided; if a recipe only has one instruction set, one block is fine
- If the original source has a URL, add a final section: `#### [Link](url)`

**Measurements:**
- Always use metric: g, ml, °C, cm
- Convert any imperial values (oz → g, cups → ml, °F → °C, inches → cm)
- Always put a space between the number and the unit: `300 g`, `400 ml`, `2 tbsp`, `180 °C`
- Keep tbsp and tsp as-is (they are universal)

**Tone:**
- Practical and concise
- Keep useful tips or caveats in parentheses within the relevant step
- Bold key ingredients or critical warnings where helpful (e.g. **do not add salt yet**)
- Do not add unnecessary fluff or introductions

**What NOT to include:**
- Serving suggestions unrelated to the recipe itself
- Nutritional info
- Author bios or blog preamble
- Equipment lists (unless critical)

## Workflow

1. If the input is a URL, fetch the page and extract the recipe content.
2. Parse ingredients and instructions.
3. Convert all measurements to metric with a space between number and unit.
4. Reformat into the structure above.
5. Output the full markdown file content, ready to paste into Obsidian — nothing else, no commentary before or after.

The file content should start with `---` (the frontmatter opening) and end after the last recipe line.

## Input

$ARGUMENTS
