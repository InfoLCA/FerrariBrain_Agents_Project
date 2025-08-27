#!/usr/bin/env bash
# Phase00 — Docker evidence logger (robust, macOS-safe)
# Usage:
#   record_evidence.sh "<STEP_ID>" "<CMD_STRING>" <file1> [file2 ...]
# Notes:
# - Works from ANY current directory.
# - Writes a confirmation packet under Phase00/Confirmations/docker/year=/month=/day=
# - Appends a single JSON line to Phase00/PhaseLog.jsonl with packet path + SHA256.

set -euo pipefail

STEP_ID="${1:?step id (e.g., 00B.1) required}"
CMD_STRING="${2:?command string required}"; shift 2
if [ "$#" -lt 1 ]; then
  echo "ERROR: you must pass at least one evidence file path" >&2
  exit 2
fi

# Resolve Phase00 base
PHASE_DIR="${PHASE_DIR:-$HOME/Desktop/FPC_source_of_truth/FerrariBrain_Agents_Project/Phase00_DAUL_Agent}"
CONF_BASE="$PHASE_DIR/Confirmations/docker"
LOG_FILE="$PHASE_DIR/PhaseLog.jsonl"

# Timestamps/partitions (UTC)
TS="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
Y="$(date -u +%Y)"; M="$(date -u +%m)"; D="$(date -u +%d)"
CONF_DIR="$CONF_BASE/year=$Y/month=$M/day=$D"
mkdir -p "$CONF_DIR"

# Build files array with absolute paths + sha256
FILES_JSON=""
FIRST=1
for f_in in "$@"; do
  # Normalize to absolute path
  case "$f_in" in
    /*) f="$f_in" ;;
    ~*) f="${f_in/#\~/$HOME}" ;;
    *)  f="$(pwd)/$f_in" ;;
  esac
  if [ ! -f "$f" ]; then
    echo "WARNING: evidence file not found: $f" >&2
    continue
  fi
  HASH="$(shasum -a 256 "$f" | awk '{print $1}')"
  # JSON escape minimal characters
  f_esc="${f//\\/\\\\}"; f_esc="${f_esc//\"/\\\"}"
  if [ $FIRST -eq 1 ]; then
    FILES_JSON="{\"path\":\"$f_esc\",\"sha256\":\"$HASH\"}"
    FIRST=0
  else
    FILES_JSON="$FILES_JSON,{\"path\":\"$f_esc\",\"sha256\":\"$HASH\"}"
  fi
done
FILES_JSON="[$FILES_JSON]"

# Create confirmation packet (without packet hash)
PKT_NAME="${STEP_ID}_$(date -u +%H%M%S).json"
PKT_PATH="$CONF_DIR/$PKT_NAME"
# Escape CMD for JSON
CMD_ESC="${CMD_STRING//\\/\\\\}"; CMD_ESC="${CMD_ESC//\"/\\\"}"

{
  printf '{'
  printf '"phase":"P00",'
  printf '"step":"%s",' "$STEP_ID"
  printf '"micro":"B",'
  printf '"cmd":"%s",' "$CMD_ESC"
  printf '"files":%s,' "$FILES_JSON"
  printf '"exit_code":0,'
  printf '"ts":"%s"' "$TS"
  printf '}\n'
} > "$PKT_PATH"

# Packet hash
PKT_HASH="$(shasum -a 256 "$PKT_PATH" | awk '{print $1}')"

# Append to PhaseLog.jsonl as a single JSON line
mkdir -p "$(dirname "$LOG_FILE")"
# Make packet path relative to Phase00 root for readability
REL_PKT_PATH="${PKT_PATH#"$PHASE_DIR"/}"
REL_ESC="${REL_PKT_PATH//\\/\\\\}"; REL_ESC="${REL_ESC//\"/\\\"}"
echo "{\"phase\":\"P00\",\"step\":\"$STEP_ID\",\"micro\":\"B\",\"packet_path\":\"$REL_ESC\",\"packet_sha256\":\"$PKT_HASH\",\"ts\":\"$TS\"}" >> "$LOG_FILE"

echo "Recorded confirmation packet:"
echo "  $PKT_PATH"
echo "Packet SHA256: $PKT_HASH"
echo "Appended to PhaseLog:"
echo "  $LOG_FILE"
