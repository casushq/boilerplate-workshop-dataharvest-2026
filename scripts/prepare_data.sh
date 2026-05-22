#!/usr/bin/env bash
# Download the Open Food Facts parquet and build the country subsets.
# Called by the off-data-prep systemd service on first boot. Idempotent:
# download_data.py skips a complete food.parquet and any subset that
# already exists, so re-running (including on retry) is cheap.
set -euo pipefail

BOILERPLATE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DATA_DIR="${HOME}/data/openfoodfacts"
SCRIPT="$BOILERPLATE_DIR/skills/openfoodfacts/scripts/download_data.py"

# Country subsets to build. download_data.py offers ~30; building every one
# is rarely worth the time. Override per workshop with OFF_SUBSETS, or edit
# this default. (eu = the showcase default, nl = workshop host country,
# fr/de = richest OFF data, be = small + commonly compared.)
SUBSETS="${OFF_SUBSETS:-eu nl fr de be}"

# Retry attempts for the whole download+build. download_data.py exits
# non-zero on an incomplete download or a failed subset, so a transient
# failure (HuggingFace rate-limit, dropped connection) is retried rather
# than poisoning the .done sentinel.
ATTEMPTS="${OFF_PREP_ATTEMPTS:-5}"

mkdir -p "$DATA_DIR"

echo "[$(date -Iseconds)] Starting OFF data preparation..."
echo "[$(date -Iseconds)] Data directory: $DATA_DIR"
echo "[$(date -Iseconds)] Subsets: $SUBSETS"

n=1
while true; do
    # shellcheck disable=SC2086  # SUBSETS must word-split into --subsets args
    if python3 "$SCRIPT" --data-dir "$DATA_DIR" --subsets $SUBSETS; then
        break
    fi
    if [ "$n" -ge "$ATTEMPTS" ]; then
        echo "[$(date -Iseconds)] ERROR: data prep failed after $ATTEMPTS attempts" >&2
        exit 1
    fi
    # Jittered exponential backoff: ~30s, 60s, 120s, 240s, each + 0-29s of
    # jitter so a fleet of VMs provisioning together does not re-hit the
    # source in lockstep.
    delay=$(( 30 * (2 ** (n - 1)) + RANDOM % 30 ))
    echo "[$(date -Iseconds)] attempt $n/$ATTEMPTS failed; retrying in ${delay}s" >&2
    sleep "$delay"
    n=$(( n + 1 ))
done

echo "[$(date -Iseconds)] OFF data preparation complete."
