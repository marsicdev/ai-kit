---
name: create-pr
description: Push current branch and create a GitHub pull request with proper formatting. Use when you have committed changes ready to be pushed and want to open a PR with a well-structured description.
allowed-tools: Bash
---

# Create Pull Request

Push the current branch and create a GitHub pull request.

## Process

### Step 1: Check Status

- Verify all changes are committed: `git status`
- Ensure you're on a feature branch, not main/master

### Step 2: Push Branch

- Push to origin with tracking: `git push -u origin HEAD`
- If branch exists, just push: `git push`

### Step 3: Create PR

Use `gh pr create` with proper formatting.

## PR Format

```markdown
## Summary
Brief description of what this PR does and why.

## Changes
- List of specific changes made
- Organized by component or feature
- Include any breaking changes

## Testing
- [ ] Manual testing steps performed
- [ ] Unit tests added/updated
- [ ] Integration tests pass

## Screenshots
(If UI changes, include before/after screenshots)

## Related Issues
Closes #123 (if applicable)
```

## Example Commands

```bash
# Push current branch
git push -u origin HEAD

# Create PR interactively
gh pr create

# Create PR with title and body
gh pr create --title "feat(auth): add biometric login" --body "..."

# Create draft PR
gh pr create --draft

# Create PR targeting specific base branch
gh pr create --base develop
```

## Guidelines

- Ensure branch is up to date with base branch before creating PR
- Use descriptive PR title following conventional commit format
- Include testing instructions
- Link related issues
- Add reviewers if known: `gh pr create --reviewer username`
- Use draft PRs for work in progress: `gh pr create --draft`

## PR Title Format

Follow conventional commits:
```
type(scope): TICKET-123 brief description

Examples:
feat(auth): TEC-16401 add biometric login support
fix(cart): PROJ-283 resolve quantity calculation bug
refactor(api): simplify error handling
```
