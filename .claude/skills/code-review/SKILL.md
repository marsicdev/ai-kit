---
name: code-review
description: Review code against plan and standards using code-reviewer agent
allowed-tools: Task, Read, Glob, Grep, AskUserQuestion
argument-hint: "[file-or-folder]"
---

Review the following code:

@$ARGUMENTS

Use the code-reviewer agent to perform a thorough review. The agent should:

1. Check alignment with any existing plan or requirements
2. Assess code quality, patterns, and conventions
3. Review architecture and design decisions
4. Verify documentation and standards compliance
5. Identify issues (Critical/Important/Suggestions)

If no specific file/folder provided, review recent changes or ask what to review.
