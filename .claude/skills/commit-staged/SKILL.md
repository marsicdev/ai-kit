---
name: commit-staged
description: Create conventional git commits from staged changes only. Use when you have selectively staged changes and want to commit just those with a properly formatted message.
allowed-tools: Bash
---

# Git Commit (Staged Only)

Create a git commit from staged changes only using Conventional Commits format.

## Process

1. **Check staged changes**: Run `git diff --cached` to see staged changes
2. **Verify staging**: Ensure the right files are staged with `git status`
3. **Create commit**: Generate and execute commit with proper format

## Commit Message Format

```
type(scope): subject

[optional body]
```

### Types

| Type | Description |
|------|-------------|
| `feat` | New feature |
| `fix` | Bug fix |
| `docs` | Documentation only |
| `style` | Formatting, missing semicolons (no code change) |
| `refactor` | Code restructuring (no feature/fix) |
| `perf` | Performance improvement |
| `test` | Adding/updating tests |
| `build` | Build system or dependencies |
| `ci` | CI configuration |
| `chore` | Maintenance tasks |
| `revert` | Revert previous commit |

### Rules

- **Subject**: Imperative mood, present tense, no period, ~50 chars
- **Scope**: Optional, describes the affected area (e.g., `auth`, `ui`, `api`)
- **Body**: Optional, wrap at 72 chars, explain "what" and "why"

## Examples

```
feat(auth): add biometric login support

fix(cart): resolve quantity update on iOS

refactor: simplify user repository data mapping
```

## Constraints

- Only commit what is staged (do not stage additional files)
- Never commit sensitive files (.env, credentials, API keys)
- Review staged diff before committing
- Keep commits atomic and focused
