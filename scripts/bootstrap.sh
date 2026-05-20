#!/usr/bin/env bash
# Bootstrap: wire skills and install dependencies. Idempotent — safe to re-run.
set -euo pipefail

BOILERPLATE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Ensure submodules are checked out (handles fresh clone without --recurse-submodules)
git -C "$BOILERPLATE_DIR" submodule update --init --recursive

# Wire openfoodfacts skill into Claude Code
mkdir -p "$HOME/.claude/skills"
ln -sfn "$BOILERPLATE_DIR/skills/openfoodfacts" "$HOME/.claude/skills/openfoodfacts"

# Wire openfoodfacts skill into pi agent
mkdir -p "$HOME/.pi/agent/skills"
ln -sfn "$BOILERPLATE_DIR/skills/openfoodfacts" "$HOME/.pi/agent/skills/openfoodfacts"

# Install Python dependencies for the skill
if command -v pip3 &>/dev/null; then
    pip3 install -q -r "$BOILERPLATE_DIR/skills/openfoodfacts/scripts/requirements.txt"
fi

echo "Bootstrap complete."
