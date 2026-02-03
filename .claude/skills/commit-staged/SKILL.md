---
name: commit-staged
description: Create conventional git commits from staged changes only. Extracts ticket numbers from branch names and uses conventional commit format.
allowed-tools: Bash
---

# Git Commit (Staged Only)

Create a git commit from staged changes only using Conventional Commits format with ticket extraction.

## Process

1. **Check staged changes**: Run `git diff --cached` to see staged changes
2. **Get branch name**: Run `git branch --show-current` to extract ticket number
3. **Verify staging**: Ensure the right files are staged with `git status`
4. **Create commit**: Generate and execute commit with proper format

## Commit Message Format

```
type(scope): TICKET-123 subject

[optional body]
```

If no ticket found in branch name, omit it:
```
type(scope): subject
```

### Ticket Extraction

Extract ticket from branch name patterns:
- `feature/TEC-16401-description` → `TEC-16401`
- `bugfix/PROJ-283-fix-login` → `PROJ-283`
- `hotfix/APP-12345-critical` → `APP-12345`
- Pattern: `[A-Z]+-\d+` (uppercase prefix, dash, numbers)

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
- **Ticket**: Include if found in branch name, placed after colon
- **Body**: Optional, wrap at 72 chars, explain "what" and "why"

## Examples

```
feat(auth): TEC-16401 add biometric login support

fix(cart): PROJ-283 resolve quantity update bug

refactor: simplify user repository data mapping
```

## Constraints

- Only commit what is staged (do not stage additional files)
- Never commit sensitive files (.env, credentials, API keys)
- Review staged diff before committing
- Keep commits atomic and focused
- Never include AI attribution (Co-Authored-By, etc.)
