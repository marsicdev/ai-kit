#!/bin/bash
# Usage: bash <submodule-path>/scripts/setup.sh
# Run from project root after adding submodule

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
PROJECT_DIR="$(pwd)"
TARGET_DIR="$PROJECT_DIR/.claude"

mkdir -p "$TARGET_DIR"

# Symlink agents and skills into project's .claude/
ln -sfn "$REPO_DIR/.claude/agents" "$TARGET_DIR/agents"
ln -sfn "$REPO_DIR/.claude/skills" "$TARGET_DIR/skills"

# Copy CLAUDE.md into project root (or warn if exists)
if [ ! -f "$PROJECT_DIR/CLAUDE.md" ]; then
  cp "$REPO_DIR/CLAUDE.md" "$PROJECT_DIR/CLAUDE.md"
  echo "Copied CLAUDE.md to project root."
else
  echo "CLAUDE.md already exists. Review $REPO_DIR/CLAUDE.md and merge manually."
fi

echo ""
echo "Setup complete. Branch: $(git -C "$REPO_DIR" branch --show-current)"
echo "Symlinked agents/ and skills/ into $TARGET_DIR"
