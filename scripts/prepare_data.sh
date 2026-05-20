#!/usr/bin/env bash
# Download the Open Food Facts parquet and build all country subsets.
# Called by the off-data-prep systemd service on first boot. Idempotent.
set -euo pipefail

BOILERPLATE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DATA_DIR="${HOME}/data/openfoodfacts"
SCRIPT="$BOILERPLATE_DIR/skills/openfoodfacts/scripts/download_data.py"

mkdir -p "$DATA_DIR"

echo "[$(date -Iseconds)] Starting OFF data preparation..."
echo "[$(date -Iseconds)] Data directory: $DATA_DIR"

# Download full parquet (~7.5 GB) then build all default country subsets
python3 "$SCRIPT" --data-dir "$DATA_DIR"

echo "[$(date -Iseconds)] OFF data preparation complete."
