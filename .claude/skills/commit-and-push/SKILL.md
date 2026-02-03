---
name: commit-and-push
description: Full commit and push workflow with validation — groups files into logical commits
allowed-tools: Bash
---

Perform a complete commit and push workflow with validation.

## Steps

1. **Check current git status** — Review all modified files and understand what changes have been made

2. **Create meaningful commits**
   - Stage appropriate files
   - Extract ticket number from branch name if present (pattern: `PREFIX-NNNNN`)
   - With ticket: `PREFIX-NNNNN: descriptive message`
   - Without ticket: clear descriptive message
   - Use present tense, imperative mood

3. **Verify before commit**
   - Ensure NO .env files are staged (.env, .env.local, .env.development, .env.production, .env.test, .env.staging)
   - Ensure NO secrets, API keys, or credentials are included
   - Ensure NO console.log statements in production code

4. **Group files into logical commits**
   - If multiple files are changed, group them by feature/purpose
   - Create separate commits for unrelated changes
   - Example: one commit for UI changes, another for API changes

5. **Push to remote** — Push commits to the current branch

## Rules

- NEVER commit .env files
- NEVER commit secrets or API keys
- NEVER add "Co-Authored-By" or any AI attribution text to commit messages
- Group related changes into logical commits
- Ensure tests pass before pushing (if tests exist)
