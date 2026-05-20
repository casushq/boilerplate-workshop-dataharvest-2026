#!/usr/bin/env bash
# Bootstrap: wire skills, install service, install dependencies. Idempotent — safe to re-run.
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

# Install OFF data prep systemd service (idempotent)
if [ -f "$BOILERPLATE_DIR/systemd/off-data-prep.service" ]; then
    USER="$USER" envsubst < "$BOILERPLATE_DIR/systemd/off-data-prep.service" \
        | sudo tee /etc/systemd/system/off-data-prep.service > /dev/null
    sudo mkdir -p "$HOME/data/openfoodfacts"
    sudo chown "$USER:$USER" "$HOME/data/openfoodfacts"
    sudo systemctl daemon-reload
    sudo systemctl enable off-data-prep.service
    # Start only if not already running or completed
    if ! systemctl is-active --quiet off-data-prep.service && \
       ! [ -f "$HOME/data/openfoodfacts/.done" ]; then
        sudo systemctl start --no-block off-data-prep.service
    fi
fi

echo "Bootstrap complete."
