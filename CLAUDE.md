# Global CLAUDE.md

## NEVER EVER DO

These rules are ABSOLUTE:

### NEVER Publish Sensitive Data

- NEVER publish passwords, API keys, tokens to git/npm/docker
- Before ANY commit: verify no secrets included

### NEVER Commit .env Files

- NEVER commit these files to git:
    - .env
    - .env.local
    - .env.development
    - .env.production
    - .env.test
    - .env.staging
- ALWAYS verify all .env files are in .gitignore

### NEVER Add Co-Authored-By in Commits

- NEVER include `Co-Authored-By: Claude` or similar AI attribution lines in commit messages
- Keep commits clean without AI tool signatures

---

## Testing

- Framework: Playwright (when used)
- Location: /tests folder in project root
- Naming: .test.ts or .spec.ts

---

## Code Comments — Rules for Claude

### DO

- Add comments where business logic is complex
- Add comments where code is not self-explanatory
- Keep comments concise and useful

### DO NOT

- Add obvious comments
- Write long paragraph comments
- Comment every line
- Add comments to self-explanatory code

---

## Project CLAUDE.md Requirements

When creating new projects, ALWAYS generate a project CLAUDE.md with:

- Project overview (what it does)
- Tech stack
- Build commands
- Test commands
- Architecture overview

---

## Plan Mode

- Make the plan extremely concise. Sacrifice grammar for the sake of concision.
- At the end of each plan, give me a list of unresolved questions to answer, if any.
- For multi-step plans, divide them into multiple phases with different headings.
- ALWAYS write the plan to a `.md` file (e.g., `PLAN.md` or `docs/plan-feature-name.md`)
- **MANDATORY**: After finishing any plan, ALWAYS ask the user: "Would you like me to save this plan to a `.md` file in the project root?" — Do NOT skip this step. If the user agrees, save it immediately (e.g., `PLAN.md` or `plan-<feature-name>.md`).

- Read codebase/relevant files BEFORE answering questions.
- Check in before major changes for verification.
- Give high-level explanations of changes made.
- Keep changes simple — minimal code impact.
- NEVER speculate about unread code. Read files first.

---

## Architecture Documentation

- Maintain a documentation file describing app architecture.
- Update when architecture changes.

<!-- END GENERAL RULES -->

---

## Flutter / Dart Rules

### ALWAYS

- Use early returns to reduce nesting
- Use descriptive variable names
- Max 350 lines per file
- Max one Widget per file
- Handle null safety properly
- Use `final` and `const` appropriately
- Use `handle` prefix on event handler methods
- Use `fetch` prefix for network data retrieval methods
- Use `create` prefix for remote data creation methods
- Use `load` prefix for local data retrieval methods
- Use `save` prefix for local data storage methods

### Imports

- Use `package:app_name/src/...` imports, never relative `../` paths

### Sizes & Gaps

- Use `Sizes.p4`, `Sizes.p8`, `Sizes.p16` etc. from `app_sizes.dart`
- Use `gapH8`, `gapH16`, `gapW24` SizedBox constants, never `SizedBox(height: 16.0)`

### Enums

- Add properties, constructors, and methods directly to enums (enhanced enums)

### Constructors

- Use `required this.field` pattern, not private backing fields with getters

### Widgets

- Extract UI into reusable `StatelessWidget` classes, not `_build` helper methods

### Riverpod

- Use `@Riverpod(keepAlive: true)` for critical providers (SharedPreferences, etc.)
- Initialize eagerly before `runApp`, access synchronously with `.requireValue`

### Shell Aliases

```bash
fclean    # flutter clean
fpg       # flutter pub get
fpu       # flutter pub upgrade
brb       # dart run build_runner build -d
brw       # dart run build_runner watch -d
fpgbrb    # fpg && brb
fpgbrw    # fpg && brw
```

Assume `brw` runs automatically in projects using build_runner.

### Conventional Commits

Format: `type(scope): subject`

Types: feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert
