---
name: make-plan
description: Create detailed implementation plans for Flutter features. Use when planning new features, refactoring, or multi-step implementations. Generates phased plans with checkboxes, folder structure guidance, and testing steps.
allowed-tools: Read, Glob, Grep, Write, Edit
---

# Implementation Plan Generator

Create a comprehensive implementation plan for: **$ARGUMENTS**

## Plan Structure

Generate a plan with the following sections:

### Overview

Single sentence or short paragraph explaining:
- The problem being solved
- The proposed solution approach

### Folder Structure

Specify where new files should be created using this Flutter project organization:

```
lib/
├── src/
│   ├── constants/          # App-wide constants (app_sizes.dart, etc.)
│   ├── common_widgets/     # Reusable widgets shared across features
│   ├── features/           # Feature modules (organized by domain)
│   │   └── <feature_name>/
│   │       ├── data/       # Repositories, data sources, DTOs
│   │       ├── domain/     # Models, entities, business logic
│   │       └── presentation/ # Screens, widgets, controllers
│   ├── routing/            # App routing configuration
│   ├── services/           # App-wide services (auth, storage, etc.)
│   └── utils/              # Helper functions and extensions
├── main.dart               # App entry point
└── bootstrap.dart          # App initialization and provider setup
```

For each new file, specify:
- Full path from `lib/`
- Reason for placement in that location

### Implementation Phases

List phases as H3 headings with subtasks:
- Prefix all subtasks with `- [ ]` (checkboxes)
- Ensure code compiles at the end of each phase
- Include testing and verification steps

### Implementation Notes

- Key considerations and constraints
- Migration strategy (if applicable)
- Possible future enhancements (out of scope)
- Error handling and edge cases

## Guidelines

When creating the plan:
- Use absolute imports: `import 'package:app_name/src/...';`
- Place constants in `lib/src/constants/` and reuse them
- Create widget classes, not `_build` helper methods
- Consider Riverpod for state management patterns
- Include both automated and manual testing steps
