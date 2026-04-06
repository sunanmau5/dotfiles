---
name: recipe
description: Convert a recipe URL or pasted recipe text into the user's Obsidian recipe markdown format. Use when Codex needs to extract recipe content from a webpage or raw text, convert measurements to metric, preserve component groupings, and return a paste-ready markdown note with exact frontmatter and section formatting.
---

# Recipe

Convert the provided recipe into the user's Obsidian format and return only the final markdown file content.

## Workflow

1. Determine the input type.
   - If the user provides a URL, fetch the page and extract the actual recipe content.
   - If the user provides pasted text, work only from the supplied text.
2. Parse the recipe into:
   - title
   - ingredient groups
   - instruction groups
   - source URL, if present
3. Remove non-recipe content.
   - Exclude author bio, story text, ads, nutrition, equipment lists unless critical, and unrelated serving suggestions.
4. Convert measurements to metric.
   - Use `g`, `ml`, `°C`, and `cm`.
   - Convert imperial values such as `oz`, `cups`, `°F`, and `inches`.
   - Keep `tbsp` and `tsp` as written.
   - Always format units with a space: `300 g`, `400 ml`, `180 °C`, `2 tbsp`.
5. Rewrite for clarity without changing the recipe's intent.
   - Keep the tone practical and concise.
   - Preserve useful tips or caveats in parentheses in the relevant step.
   - Bold key ingredients or critical warnings when helpful.
6. Output the exact markdown structure below and nothing else.

## Output Format

Use this structure exactly:

```markdown
---
id: <Recipe Name>
tags:
  - recipe
---

#### <Ingredient Section Name>
---
- item

#### Instructions
---
1. step

#### [Link](url)
```

Apply these rules:

- Use `####` for every section heading.
- Put `---` on the line immediately after every heading.
- Use bullet lists for ingredients.
- Use numbered lists for instructions.
- If the recipe has multiple components, create separate ingredient sections for each component.
- Follow each ingredient component with its own `#### Instructions` block when the source provides a matching instruction set.
- If there is only one shared instruction set, use one `#### Instructions` section after the ingredient sections.
- If the source came from a URL, end with `#### [Link](url)`.

## Parsing Guidance

- Infer sensible ingredient section names when the source groups components without clear headings.
- Keep ingredient lines compact but specific.
- Preserve sequencing and dependency details in instructions.
- Keep optional garnish or finishing additions only if they materially affect the recipe.
- If a source omits exact headings, choose clear generic labels such as `#### Ingredients`, `#### Sauce`, or `#### Dough`.

## Measurement Guidance

Use practical kitchen conversions instead of false precision.

- Round to sensible whole numbers for `g` and `ml` unless finer detail is useful.
- Convert oven temperatures from Fahrenheit to Celsius using standard cooking equivalents.
- Convert pan or dough dimensions from inches to centimeters.
- Retain count-based units like cloves, eggs, onions, and limes.

## Output Constraints

- Start with the opening `---` of the frontmatter.
- End after the final recipe line.
- Do not add commentary, explanation, or fences around the final answer.
