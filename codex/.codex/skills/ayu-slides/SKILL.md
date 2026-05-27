---
name: ayu-slides
description: Create or modify technical HTML slide decks in an Ayu Mirage, terminal/editor-inspired style. Use when the user wants frontend-slides output with minimal information design, code snippets, fixed 16:9 presentation behavior, Vim-like navigation, and strict wording/code-organization rules.
---

# Ayu Slides

Create technical HTML presentations by using the installed `frontend-slides` skill as the base engine, then applying these Ayu/editor rules as hard constraints.

## Base Skill

Use `frontend-slides` whenever generating or modifying a deck. Follow its fixed-stage rules:

- Single self-contained HTML file
- Fixed 1920x1080 slide stage
- Whole-stage scaling to viewport
- `.slide.active` / `.slide.visible` visibility model
- Include the full `frontend-slides/viewport-base.css` contents in generated decks

Do not use Slidev/Reveal.js unless the user explicitly asks to switch frameworks.

## Visual System

Use a quiet Ayu Mirage terminal/editor style:

```css
:root {
  --font-mono: "JetBrainsMonoNL Nerd Font Mono", "JetBrainsMonoNL Nerd Font", "JetBrains Mono", monospace;
  --color-bg: #1f2430;
  --color-panel: #212733;
  --color-panel-soft: #252b38;
  --color-text: #cbccc6;
  --color-muted: #5c6773;
  --color-blue: #60b8d6;
  --color-blue-bright: #73d0ff;
  --color-green: #53bf97;
  --color-yellow: #fdcc60;
  --color-red: #f08778;
  --color-red-soft: #f29d93;
}
```

Rules:

- Prefer a nvim/tmux/editor shell: sidebar slide navigator, tabbar, main document area
- Keep the design minimal; avoid decorative neobrutalism, gradients, glassmorphism, or “AI deck” styling
- Use code snippets as first-class content blocks
- Disable font ligatures globally and on `pre`/`code`
- Use ASCII arrows only: `->` and `<-`
- Do not use Unicode arrows
- Use `rem` for spacing/layout on Tailwind-style `.25rem` increments
- `px` is allowed for font sizes, 1px borders, and mandatory 1920x1080 stage dimensions
- Keep lists indented with real list markers so wrapped lines align under list text

## Layout Rules

- The slide shell should use the full 16:9 stage; do not add an unnecessary outer card/frame
- Use a persistent left sidebar as a slide navigator
- Generate sidebar entries from each slide’s `data-file`, in DOM order
- The active tab should mirror the current slide’s `data-file`
- Use `data-file` values as semantic filenames, not fake implementation files
- Avoid numbering filenames unless the user asks for numbered navigation
- For split slides, use an equal 50/50 content split by default
- Keep footer/progress inside `.deck-stage`, positioned absolutely relative to the slide canvas, not the browser viewport

## Navigation

Support:

- `j`, `ArrowDown`, `Space`, `PageDown` -> next slide
- `k`, `ArrowUp`, `PageUp` -> previous slide
- `Home` -> first slide
- `End` -> last slide
- clickable sidebar filenames -> jump to slide

Use both `event.key` and `event.code` for `j/k` so keyboard layouts and ligature fonts do not affect navigation.

## Wording Rules

Tone should be calm, precise, and practical:

- Prefer “current gap”, “scope”, “setup”, “boundary”, “outside scope”
- Avoid dramatic wording like “broken”, “must”, “failure”, “not staging on your laptop”, “too often”
- Do not use periods on titles
- If body text is one sentence, omit the final period
- If a bullet is one sentence, omit the final period
- Keep slide copy minimal for speaker-led decks
- Do not manually insert line breaks inside prose; let CSS wrapping handle it
- Preserve intentional line breaks in code blocks

## Code Organization Rules

When generating HTML:

- Define design tokens once in `:root`
- Prefer shared classes over slide-specific CSS
- Avoid hardcoded one-off styling in slide markup
- Keep code windows and panels reusable
- Keep visible filenames accurate; do not invent misleading filenames like `storage.adapter.ts` unless they are real or explicitly illustrative
- Use semantic `data-file` names that match the slide topic

When modifying an existing deck:

- Preserve user edits unless the requested change requires touching them
- Do not run broad rewrite scripts for structural changes unless the user approves
- Prefer small `apply_patch` edits for individual slide changes
- After changing navigation or slide count, verify all `data-file` entries and the slide count

## Verification Checklist

Before finalizing:

- No Unicode arrows remain
- No font ligatures render `->` as an arrow
- Sidebar order matches DOM slide order
- Active tab matches current slide `data-file`
- Code blocks wrap inside their containers
- Lists wrap with proper indentation
- Footer/progress stays inside the scaled slide stage
- No text or panels overflow at normal browser sizes
