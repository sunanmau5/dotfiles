---
name: code-review
description: Comprehensive code review workflow and reference guides for reviewing pull requests, diffs, architecture, security, performance, and code quality across React, Vue, Angular, Svelte, TypeScript, Python, Django, FastAPI, Java, PHP, C#/.NET, Go, Rust, Kotlin, Swift, NestJS, C, C++, CSS, and Qt. Use when Codex is asked to review code, review PRs, inspect changes, find bugs, assess maintainability, perform security or performance review, create review feedback, or establish review standards.
---

# Code Review Skill

Transform code reviews from gatekeeping to knowledge sharing through constructive feedback, systematic analysis, and collaborative improvement.

## Core Principles

### 1. The Review Mindset

**Goals of Code Review:**

- Catch bugs and edge cases
- Ensure code maintainability
- Share knowledge across team
- Enforce coding standards
- Improve design and architecture
- Build team culture

**Not the Goals:**

- Show off knowledge
- Nitpick formatting (use linters)
- Block progress unnecessarily
- Rewrite to your preference

### 2. Effective Feedback

**Good Feedback is:**

- Specific and actionable
- Educational, not judgmental
- Focused on the code, not the person
- Balanced (praise good work too)
- Prioritized (critical vs nice-to-have)

```markdown
Bad: "This is wrong."
Good: "This could cause a race condition when multiple users
access simultaneously. Consider using a mutex here."

Bad: "Why didn't you use X pattern?"
Good: "Have you considered the Repository pattern? It would
make this easier to test. Here's an example: [link]"

Bad: "Rename this variable."
Good: "[nit] Consider `userCount` instead of `uc` for
clarity. Not blocking if you prefer to keep it."
```

### 3. Review Scope

**What to Review:**

- Logic correctness and edge cases
- Security vulnerabilities
- Performance implications
- Test coverage and quality
- Error handling
- Documentation and comments
- API design and naming
- Architectural fit

**What Not to Review Manually:**

- Code formatting (use Prettier, Black, etc.)
- Import organization
- Linting violations
- Simple typos

## Review Process

### Phase 1: Context Gathering (2-3 minutes)

Before diving into code, understand:

1. Read PR description and linked issue
2. Check PR size (>400 lines? Ask to split)
3. Review CI/CD status (tests passing?)
4. Understand the business requirement
5. Note any relevant architectural decisions

> For large diffs, pipe the diff through [`scripts/pr-analyzer.py`](scripts/pr-analyzer.py) (`git diff main...HEAD | python scripts/pr-analyzer.py`) to triage complexity and get a suggested review approach before reading.

### Phase 2: High-Level Review (5-10 minutes)

1. **Architecture & Design** - Does the solution fit the problem?
   - For significant changes, consult [Architecture Review Guide](reference/architecture-review-guide.md)
   - Check: SOLID principles, coupling/cohesion, anti-patterns
2. **Performance Assessment** - Are there performance concerns?
   - For performance-critical code, consult [Performance Review Guide](reference/performance-review-guide.md)
   - Check: Algorithm complexity, N+1 queries, memory usage
3. **File Organization** - Are new files in the right places?
4. **Testing Strategy** - Are there tests covering edge cases?

### Phase 3: Line-by-Line Review (10-20 minutes)

For each file, check:

- **Logic & Correctness** - Edge cases, off-by-one, null checks, race conditions
- **Security** - Input validation, injection risks, XSS, sensitive data
- **Performance** - N+1 queries, unnecessary loops, memory leaks
- **Maintainability** - Clear names, single responsibility, comments
- **Reuse** - Before accepting new code, search for existing utilities/helpers that could replace it. Check adjacent files and shared modules for similar patterns. See [Universal Quality Guide](reference/code-quality-universal.md) for anti-patterns like parameter sprawl, leaky abstractions, nested conditionals, stringly-typed code, TOCTOU, and no-op updates.

### Phase 4: Summary & Decision (2-3 minutes)

1. Summarize key concerns
2. Highlight what you liked
3. Make clear decision:
   - Approve
   - Comment with minor suggestions
   - Request changes for required fixes
4. Offer to pair if complex

## Review Techniques

### Technique 1: The Checklist Method

Use checklists for consistent reviews. See [Security Review Guide](reference/security-review-guide.md) for comprehensive security checklist.

### Technique 2: The Question Approach

Instead of stating problems, ask questions:

```markdown
Bad: "This will fail if the list is empty."
Good: "What happens if `items` is an empty array?"

Bad: "You need error handling here."
Good: "How should this behave if the API call fails?"
```

### Technique 3: Suggest, Don't Command

Use collaborative language:

```markdown
Bad: "You must change this to use async/await"
Good: "Suggestion: async/await might make this more readable. What do you think?"

Bad: "Extract this into a function"
Good: "This logic appears in 3 places. Would it make sense to extract it?"
```

### Technique 4: Differentiate Severity

Use labels to indicate priority:

- `[blocking]` - Must fix before merge
- `[important]` - Should fix, discuss if disagree
- `[nit]` - Nice to have, not blocking
- `[suggestion]` - Alternative approach to consider
- `[learning]` - Educational comment, no action needed
- `[praise]` - Good work, keep it up

Use three severity tiers across all guides: `[blocking]` blocks the merge, `[important]` should be addressed, and `[nit]` is optional. Treat `[suggestion]`, `[learning]`, and `[praise]` as non-blocking annotations.

## Language-Specific Guides

Load only the detailed guide that matches the code under review:

| Language/Framework     | Reference File                              | Key Topics                                                                                                        |
| ---------------------- | ------------------------------------------- | ----------------------------------------------------------------------------------------------------------------- |
| **React**              | [React Guide](reference/react.md)           | Hooks, useEffect, React 19 Actions, RSC, Suspense, TanStack Query v5                                              |
| **Vue 3**              | [Vue Guide](reference/vue.md)               | Composition API, reactivity, Props/Emits, Watchers, Composables                                                   |
| **Angular 17+**        | [Angular Guide](reference/angular.md)       | Signals, standalone components, RxJS, zoneless change detection, template optimization                            |
| **Rust**               | [Rust Guide](reference/rust.md)             | Ownership/borrowing, unsafe review, async code, cancellation safety, error handling                               |
| **TypeScript**         | [TypeScript Guide](reference/typescript.md) | Type safety, async/await, immutability                                                                            |
| **Python**             | [Python Guide](reference/python.md)         | Mutable defaults, exception handling, class attributes                                                            |
| **Django / DRF**       | [Django Guide](reference/django.md)         | Security review, N+1 queries, serializer anti-patterns, ViewSet, async views                                      |
| **FastAPI**            | [FastAPI Guide](reference/fastapi.md)       | Depends, Pydantic v2 validation, async correctness, sessions/N+1, auth vs authorization, test-driven verification |
| **Java**               | [Java Guide](reference/java.md)             | Java 17/21 features, Spring Boot 3, virtual threads, Stream/Optional                                              |
| **PHP**                | [PHP Guide](reference/php.md)               | PHP 8.x type system, PDO, security review, Composer, PHPUnit/PHPStan                                              |
| **C# / .NET**          | [C# Guide](reference/csharp.md)             | C# 12 features, async programming, EF Core performance, ASP.NET Core, LINQ                                        |
| **Go**                 | [Go Guide](reference/go.md)                 | Error handling, goroutine/channel, context, interface design                                                      |
| **Kotlin / Android**   | [Kotlin Guide](reference/kotlin.md)         | Coroutines, Flow, Jetpack Compose, null safety, memory leaks, architecture patterns                               |
| **Swift / SwiftUI**    | [Swift Guide](reference/swift.md)           | Optionals, Swift Concurrency, Sendable/actors, SwiftUI property wrappers, value vs reference types, API design    |
| **NestJS**             | [NestJS Guide](reference/nestjs.md)         | Dependency injection, layered architecture, DTO validation, Guard/Interceptor, circular dependencies              |
| **Svelte / SvelteKit** | [Svelte Guide](reference/svelte.md)         | Runes, load functions, form actions, store migration, SSR/CSR boundaries                                          |
| **C**                  | [C Guide](reference/c.md)                   | Pointer/buffer safety, memory safety, undefined behavior, error handling                                          |
| **C++**                | [C++ Guide](reference/cpp.md)               | RAII, lifetimes, Rule of 0/3/5, exception safety                                                                  |
| **CSS/Less/Sass**      | [CSS Guide](reference/css-less-sass.md)     | Variables, !important, performance, responsive design, compatibility                                              |
| **Qt**                 | [Qt Guide](reference/qt.md)                 | Object model, signals/slots, memory management, thread safety, performance                                        |

## Cross-Cutting Guides

Language-agnostic patterns applicable to all code reviews:

| Topic                 | Reference File                                                 | Key Topics                                                                                                                          |
| --------------------- | -------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| **Universal Quality** | [Universal Quality Guide](reference/code-quality-universal.md) | Reuse audit, parameter sprawl, leaky abstractions, nested conditionals, stringly-typed code, TOCTOU, no-op updates, redundant state |

## Additional Resources

- [Architecture Review Guide](reference/architecture-review-guide.md) - architecture review, SOLID, anti-patterns, coupling
- [Performance Review Guide](reference/performance-review-guide.md) - performance review, Web Vitals, N+1 queries, complexity
- [Common Bugs Checklist](reference/common-bugs-checklist.md) - common bugs by language
- [Security Review Guide](reference/security-review-guide.md) - security review checklist
- [Code Review Best Practices](reference/code-review-best-practices.md) - communication and process guidance
- [PR Review Template](assets/pr-review-template.md) - PR review comment template
- [Review Checklist](assets/review-checklist.md) - quick reference checklist
