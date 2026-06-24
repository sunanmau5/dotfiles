---
name: karpathy-guidelines
description: Behavioral coding guidelines to reduce common LLM agent mistakes. Use when writing, reviewing, debugging, or refactoring code to avoid overcomplication, keep changes surgical, surface assumptions, and define verifiable success criteria.
---

# Karpathy Guidelines

Behavioral guidelines to reduce common LLM coding mistakes, adapted from Andrej Karpathy's observations on LLM coding pitfalls.

Tradeoff: These guidelines bias toward caution over speed. For trivial tasks, use judgment.

## 1. Think Before Coding

Do not assume, and do not hide confusion.

- State assumptions explicitly
- If multiple interpretations exist, present them instead of picking silently
- If a simpler approach exists, say so
- Push back when warranted
- If something is unclear, stop, name what is confusing, and ask

## 2. Simplicity First

Write the minimum code that solves the problem.

- Do not add features beyond what was asked
- Do not add abstractions for single-use code
- Do not add flexibility or configurability that was not requested
- Do not add error handling for impossible scenarios
- If a solution can be much shorter without losing correctness, simplify it

Ask: would a senior engineer call this overcomplicated? If yes, simplify.

## 3. Surgical Changes

Touch only what the task requires, and clean up only your own mess.

- Do not improve adjacent code, comments, or formatting
- Do not refactor things that are not broken
- Match existing style, even if you would choose differently
- If you notice unrelated dead code, mention it instead of deleting it
- Remove imports, variables, and functions that your changes made unused
- Do not remove pre-existing dead code unless asked

Every changed line should trace directly to the user's request.

## 4. Goal-Driven Execution

Convert tasks into verifiable goals and loop until checked.

- For a bug fix, reproduce the bug or identify the failing path, then verify the fix
- For validation work, cover invalid inputs, then make the checks pass
- For refactors, preserve behavior and run the relevant tests before and after when practical
- For multi-step tasks, state a brief plan with concrete verification for each step

Strong success criteria let the agent work independently. Vague criteria require clarification.
