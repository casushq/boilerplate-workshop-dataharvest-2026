#!/usr/bin/env bash
# Download Open Food Facts parquet files.
# Called by the off-data-prep systemd service on first boot. Idempotent.
#
# If OFF_S3_ENDPOINT and OFF_S3_BUCKET are set (injected by cloud-config),
# files are downloaded from Hetzner Object Storage (~10× faster than HuggingFace
# for EU-region VMs). Falls back to the HuggingFace download for food.parquet
# if S3 is not configured.
set -euo pipefail

BOILERPLATE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DATA_DIR="${HOME}/data/openfoodfacts"
SCRIPT_DIR="$BOILERPLATE_DIR/skills/openfoodfacts/scripts"
LOG_FILE="$DATA_DIR/prepare.log"

mkdir -p "$DATA_DIR"

echo "[$(date -Iseconds)] Starting OFF data download..." | tee -a "$LOG_FILE"
echo "[$(date -Iseconds)] Data directory: $DATA_DIR" | tee -a "$LOG_FILE"

# ---------------------------------------------------------------------------
# S3 download (preferred if configured)
# ---------------------------------------------------------------------------

# All EU country files + combined + US.  This is the full set uploaded by
# scripts/upload_parquet.py — edit this list to add/remove files.
S3_FILES=(
  food.parquet
  food_eu_all.parquet
  food_united-states.parquet
  # EU-27 individual countries
  food_austria.parquet
  food_belgium.parquet
  food_bulgaria.parquet
  food_croatia.parquet
  food_cyprus.parquet
  food_czech-republic.parquet
  food_denmark.parquet
  food_estonia.parquet
  food_finland.parquet
  food_france.parquet
  food_germany.parquet
  food_greece.parquet
  food_hungary.parquet
  food_ireland.parquet
  food_italy.parquet
  food_latvia.parquet
  food_lithuania.parquet
  food_luxembourg.parquet
  food_malta.parquet
  food_netherlands.parquet
  food_poland.parquet
  food_portugal.parquet
  food_romania.parquet
  food_slovakia.parquet
  food_slovenia.parquet
  food_spain.parquet
  food_sweden.parquet
  # Non-EU Europe
  food_albania.parquet
  food_andorra.parquet
  food_armenia.parquet
  food_azerbaijan.parquet
  food_belarus.parquet
  food_bosnia-and-herzegovina.parquet
  food_georgia.parquet
  food_iceland.parquet
  food_kosovo.parquet
  food_liechtenstein.parquet
  food_moldova.parquet
  food_monaco.parquet
  food_montenegro.parquet
  food_north-macedonia.parquet
  food_norway.parquet
  food_russia.parquet
  food_san-marino.parquet
  food_serbia.parquet
  food_switzerland.parquet
  food_turkey.parquet
  food_ukraine.parquet
  food_united-kingdom.parquet
  food_vatican-city.parquet
  # Manifest
  manifest.json
)

_s3_download_all() {
  local endpoint="${OFF_S3_ENDPOINT}"
  local bucket="${OFF_S3_BUCKET}"
  local base_url="${endpoint}/${bucket}"
  local failed=0

  echo "[$(date -Iseconds)] Downloading from S3: ${base_url}" | tee -a "$LOG_FILE"

  for fname in "${S3_FILES[@]}"; do
    # Skip comment lines (bash array can't have real comments inside, but this handles #)
    [[ "$fname" == \#* ]] && continue
    [[ -z "$fname" ]] && continue

    dest="$DATA_DIR/$fname"
    url="${base_url}/${fname}"

    if [ -f "$dest" ]; then
      echo "[$(date -Iseconds)]   ✓ $fname already present — skipping" | tee -a "$LOG_FILE"
      continue
    fi

    echo "[$(date -Iseconds)]   Downloading $fname ..." | tee -a "$LOG_FILE"
    if curl -fsSL --retry 3 --retry-delay 5 -o "${dest}.tmp" "$url"; then
      mv "${dest}.tmp" "$dest"
      size_mb=$(( $(stat -c%s "$dest" 2>/dev/null || stat -f%z "$dest") / 1000000 ))
      echo "[$(date -Iseconds)]   ✓ $fname  (${size_mb} MB)" | tee -a "$LOG_FILE"
    else
      rm -f "${dest}.tmp"
      echo "[$(date -Iseconds)]   ✗ $fname — download failed (url: $url)" | tee -a "$LOG_FILE"
      failed=$(( failed + 1 ))
    fi
  done

  if [ "$failed" -gt 0 ]; then
    echo "[$(date -Iseconds)] WARNING: $failed file(s) failed to download from S3." | tee -a "$LOG_FILE"
    return 1
  fi
  return 0
}

_huggingface_fallback() {
  echo "[$(date -Iseconds)] Falling back to HuggingFace download for food.parquet ..." | tee -a "$LOG_FILE"
  python3 "$SCRIPT_DIR/download_data.py" --data-dir "$DATA_DIR" 2>&1 | tee -a "$LOG_FILE"
}

# ---------------------------------------------------------------------------
# Choose download path
# ---------------------------------------------------------------------------

S3_CONFIGURED=false
if [ -n "${OFF_S3_ENDPOINT:-}" ] && [ -n "${OFF_S3_BUCKET:-}" ]; then
  S3_CONFIGURED=true
fi

if [ "$S3_CONFIGURED" = "true" ]; then
  echo "[$(date -Iseconds)] S3 configured — using Hetzner Object Storage." | tee -a "$LOG_FILE"
  if ! _s3_download_all; then
    echo "[$(date -Iseconds)] S3 download had errors; attempting HuggingFace fallback for food.parquet." | tee -a "$LOG_FILE"
    if [ ! -f "$DATA_DIR/food.parquet" ]; then
      _huggingface_fallback
    fi
  fi
else
  echo "[$(date -Iseconds)] OFF_S3_ENDPOINT/OFF_S3_BUCKET not set — using HuggingFace fallback." | tee -a "$LOG_FILE"
  _huggingface_fallback
fi

# ---------------------------------------------------------------------------
# Mark done
# ---------------------------------------------------------------------------
touch "$DATA_DIR/.done"
echo "[$(date -Iseconds)] OFF data download complete." | tee -a "$LOG_FILE"
