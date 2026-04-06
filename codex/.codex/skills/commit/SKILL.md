---
name: commit
description: Create a git commit from already-staged files without changing the index. Use when the user wants to commit what is currently staged, especially when they ask to commit staged changes, create a commit message, or follow Angular commit conventions.
---

# Commit

Create a commit from the current git index only. Do not stage, unstage, or modify files as part of this skill.

## Workflow

1. Confirm the repository state from the current working directory.
2. Run `git diff --cached` to inspect the staged changes.
3. Run `git branch --show-current` to check whether the branch name contains a ticket identifier such as `MP-1234`.
4. Derive a commit message from the staged diff.
5. Run `git commit -m` using only the staged changes.

If there are no staged changes, stop and tell the user that there is nothing to commit.

## Commit Message Rules

Write the commit message in Angular-style format.

- Start the subject with one of: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`
- If the branch name contains a ticket number, include it in parentheses immediately after the type, for example `feat(MP-1234):`
- Use lowercase for the subject text after the prefix
- Keep the subject line at 72 characters or fewer
- Use the imperative mood
- Do not end the subject line with punctuation
- Add a blank line between subject and body
- Include a body only when it adds information not obvious from the subject
- Wrap body lines at 72 characters
- Do not add signatures or trailers such as `Co-Authored-By`

## Message Selection Heuristics

Choose the type that best matches the staged diff.

- Use `feat` for new user-facing behavior
- Use `fix` for bug fixes or correctness changes
- Use `docs` for documentation-only changes
- Use `style` for formatting-only changes with no behavior impact
- Use `refactor` for structural changes without user-visible behavior changes
- Use `test` for test-only changes
- Use `chore` for maintenance work that does not fit the other types

Prefer a short subject that describes the primary change. Add a body only for non-obvious context such as why the change was needed, important constraints, or grouped changes that need one sentence of explanation.

## Execution Notes

- Do not stage any files, even if related edits are present in the working tree
- Do not rewrite the user's staged set
- Do not use interactive git commands
- Preserve unrelated unstaged changes
- After committing, report the final commit message back to the user
