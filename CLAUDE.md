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

## Code Style — TypeScript Rules

### ALWAYS
- Use TypeScript, never plain JavaScript
- Use async/await, never .then() chains
- Use named exports when possible
- Use early returns to reduce nesting
- Use descriptive variable names
- Max 350 lines per file
- Max one React component per file

### NEVER
- Use `any` type (find proper type or use `unknown`)
- Use `var` (use `const` or `let`)
- Leave `console.log` in production code
- Use magic numbers (define constants)

---

## Framework Skills

### React Projects
- Always apply `vercel-react-best-practices` skill
- Focus on: performance patterns, Server Components, data fetching, bundle optimization

### React Native Projects
- Always apply `react-native-best-practices` skill
- Focus on: FPS, TTI, bundle size, memory leaks, re-renders, animations

### Expo Projects
- Always apply `expo-app-design` skills:
  - `building-native-ui` — components, animations, tabs, navigation
  - `native-data-fetching` — API calls, caching, offline
  - `expo-tailwind-setup` — Tailwind + NativeWind
  - `expo-api-routes` — Expo Router API routes
- For deployment: use `expo-deployment` skills
- For upgrades: use `upgrading-expo` skill
