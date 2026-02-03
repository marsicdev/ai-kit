# ai-kit

Reusable Claude Code agents, skills, and coding rules — organized by tech stack using branches.

## Branch Strategy

| Branch | Contents | Use for |
|--------|----------|---------|
| `main` | General rules, shared skills, shared agents | Any project |
| `web` | + TypeScript rules, React/Next.js/Expo/RN/Remotion skills & agents | JS/TS web & mobile projects |
| `flutter` | + Dart/Flutter rules, Flutter skills & agents | Flutter projects |

- General changes go on `main`, then merge to `web` and `flutter`
- Stack-specific changes stay on their branch
- Never merge `web` <-> `flutter`

## Installation

Add as a **git submodule** on the appropriate branch:

```bash
# Web project
git submodule add -b web git@github.com:marsicdev/ai-kit.git ai-kit

# Flutter project
git submodule add -b flutter git@github.com:marsicdev/ai-kit.git ai-kit

# General project
git submodule add git@github.com:marsicdev/ai-kit.git ai-kit
```

Then run setup:

```bash
bash ai-kit/scripts/setup.sh
```

This symlinks `agents/` and `skills/` into your project's `.claude/` directory and copies `CLAUDE.md` to your project root (if one doesn't exist).

### Updating

```bash
git submodule update --remote ai-kit
bash ai-kit/scripts/setup.sh
```

### Project `.gitignore`

Add these — the symlinks point into the submodule, so track the submodule, not the symlinks:

```
.claude/agents
.claude/skills
```

## What's Included

### `main` branch

**Agents (2):** brainstormer, code-reviewer

**Skills (18):**
- Shared: accessibility-compliance, ui-skills, ui-ux-pro-max, web-design-guidelines, frontend-design, seo-audit, pptx, agent-browser, find-skills, skill-creator, supabase-postgres-best-practices, better-auth-best-practices, ai-sdk, references/
- Migrated from commands: commit, commit-and-push, handoff, interview, code-review

### `web` branch (extends main)

**Agents (+4):** frontend-developer, fullstack-developer, accessibility-tester, ui-ux-designer

**Skills (+15):** vercel-react-best-practices, vercel-composition-patterns, next-best-practices, next-upgrade, react-native-best-practices, building-native-ui, native-data-fetching, expo-api-routes, expo-cicd-workflows, expo-deployment, expo-dev-client, expo-tailwind-setup, upgrading-expo, use-dom, remotion-best-practices

### `flutter` branch (extends main)

**Agents (+1):** mobile-developer (Flutter-focused)

**Skills (+10):** make-plan, commit (Flutter override), commit-staged, create-pr, fix-issue, update-docs, update-plan, read-spec, flutter-patterns (with embedded patterns), flutter-setup (with embedded guides)
