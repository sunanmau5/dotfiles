---
name: commit
description: Create a git commit from already-staged files following Angular convention. Use when the user wants to commit staged changes.
allowed-tools: Bash(git *)
---

Create a git commit for the currently staged changes. Do not stage any files — only commit what is already staged.

Steps:
1. Run `git diff --cached` to see what's staged
2. Run `git branch --show-current` to check for a ticket number in the branch name
3. Commit with `git commit -m`

Rules for the commit message:
- Start with a type prefix: feat, fix, docs, style, refactor, test, chore
- If the branch name contains a ticket number (e.g. MP-1234), include it in parentheses after the type: feat(MP-1234):
- Use lowercase for the subject line after the prefix
- Limit the subject line to 72 characters
- Do not end the subject line with any punctuation
- Use the imperative mood in the subject line
- Separate the subject from the body with a blank line
- Wrap the body at 72 characters
- Only include a body when it provides useful information not already in the subject
- Do not add any signature, attribution, or Co-Authored-By trailer
