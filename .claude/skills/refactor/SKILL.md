---
name: refactor
description: Refactor Flutter/Dart code following project patterns and best practices. Use when you want to improve code structure, readability, or maintainability without changing behavior.
allowed-tools: Read, Glob, Grep, Write, Edit
---

# Flutter Refactor

Refactor the following code: **$ARGUMENTS**

## Process

### Step 1: Analyze Current Code

- Read the target file(s)
- Identify what patterns are being violated
- Note the current behavior to preserve

### Step 2: Apply Flutter/Dart Rules

Apply these rules from CLAUDE.md:

#### Code Style
- [ ] Max 350 lines per file
- [ ] Max one Widget per file
- [ ] Use early returns to reduce nesting
- [ ] Use descriptive variable names
- [ ] Handle null safety properly
- [ ] Use `final` and `const` appropriately

#### Naming Conventions
- [ ] `handle` prefix for event handlers (e.g., `handleSubmit`)
- [ ] `fetch` prefix for network data retrieval (e.g., `fetchUser`)
- [ ] `create` prefix for remote data creation (e.g., `createOrder`)
- [ ] `load` prefix for local data retrieval (e.g., `loadCache`)
- [ ] `save` prefix for local data storage (e.g., `savePreferences`)

#### Imports
- [ ] Use `package:app_name/src/...` absolute imports
- [ ] Never use relative `../` paths

#### Sizes & Gaps
- [ ] Use `Sizes.p4`, `Sizes.p8`, `Sizes.p16` constants
- [ ] Use `gapH8`, `gapH16`, `gapW24` SizedBox constants
- [ ] Never use `SizedBox(height: 16.0)` directly

#### Enums
- [ ] Add properties, constructors, methods directly to enums (enhanced enums)

#### Constructors
- [ ] Use `required this.field` pattern
- [ ] Avoid private backing fields with getters when unnecessary

#### Widgets
- [ ] Extract UI into `StatelessWidget` classes
- [ ] Never use `_build` helper methods
- [ ] Each widget in its own file if reusable

#### Riverpod
- [ ] Use `@Riverpod(keepAlive: true)` for critical providers
- [ ] Initialize eagerly before `runApp` when needed
- [ ] Access with `.requireValue` for pre-initialized providers

### Step 3: Verify Behavior Preserved

- Ensure no functional changes
- Check edge cases still work
- Run analyzer: `flutter analyze`

### Step 4: Report Changes

Provide summary:
1. **Files Modified**: List of changed files
2. **Patterns Applied**: Which rules were applied
3. **Behavior**: Confirm unchanged

## Constraints

- NEVER change functionality — refactor only
- Keep changes focused and reviewable
- Preserve all existing tests
- Run `flutter analyze` after changes

## Commit Message

When ready to commit:
```
refactor(scope): description of structural improvement
```

Examples:
- `refactor(auth): extract login form into separate widget`
- `refactor(api): use absolute imports throughout`
- `refactor(home): apply constant sizes pattern`
