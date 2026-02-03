---
name: update-plan
description: Update implementation plan files by marking completed tasks and committing changes. Use after completing tasks in a phased implementation to track progress and keep the plan file current.
allowed-tools: Read, Edit, Bash
---

# Update Implementation Plan

Update the plan file by checking off completed tasks and optionally committing the changes.

## Process

### Step 1: Review Completed Work

- Identify tasks that have been finished since last update
- Note any discoveries or changes from the original plan
- Check for tasks that are partially complete

### Step 2: Update Plan File

- Mark completed tasks with `[x]` replacing `[ ]`
- Add notes for any deviations or discoveries
- Update any estimates or scope changes
- Do NOT remove uncompleted tasks

### Step 3: Commit Changes

Create a commit with the plan updates:

```
docs: update implementation plan

- Mark completed: [list items]
- Next up: [next tasks]
```

## Plan File Format

```markdown
## Phase 1: Setup
- [x] Create project structure
- [x] Add dependencies
- [ ] Configure environment

## Phase 2: Implementation
- [ ] Implement feature A
- [ ] Add tests

## Notes
- Discovery: Found existing utility that can be reused
- Change: Using different approach for X due to Y
```

## Guidelines

- Only mark tasks as complete when fully done
- Keep the plan file as the single source of truth
- Commit plan updates separately from code changes when possible
- Add notes section if significant discoveries were made
- Don't modify task descriptions unless absolutely necessary

## Finding Plan Files

Look for plan files in:
- `ai_specs/plans/*.md`
- `docs/plans/*.md`
- Root directory `*-plan.md` or `PLAN.md`
- Any file mentioned in recent conversation
