#!/usr/bin/env bash
# Phase00 — 00B.1 SBOM + Vulnerability Scan (PANP: one command per step)
# Usage:
#   00_sbom_and_scan.sh <IMAGE_DIGEST>
# Example:
#   00_sbom_and_scan.sh docker.io/legalcaseallies/alpine-test@sha256:12d60bc2651acf125ddc54ce76e4a3fedcad94778a90904800e26b72b80918a8

set -euo pipefail

IMG="${1:?image digest required (e.g., docker.io/namespace/name@sha256:...)}"

# Repo base (edit only if your path differs)
BASE_DIR="${BASE_DIR:-$HOME/Desktop/FPC_source_of_truth/FerrariBrain_Agents_Project/Phase00_DAUL_Agent}"
OUT_DIR="$BASE_DIR/Outputs/docker/reports"
mkdir -p "$OUT_DIR"

# Preconditions
command -v syft >/dev/null 2>&1 || { echo "ERROR: syft not found. Install via: brew install syft"; exit 127; }
command -v trivy >/dev/null 2>&1 || { echo "ERROR: trivy not found. Install via: brew install trivy"; exit 127; }

# 1) SBOM (CycloneDX JSON)
SBOM_PATH="$OUT_DIR/sbom.cdx.json"
echo "[00B.1] Generating SBOM → $SBOM_PATH"
syft "$IMG" -o cyclonedx-json > "$SBOM_PATH"

# 2) Vulnerability scan (fail on HIGH/CRITICAL)
VULN_PATH="$OUT_DIR/vuln.trivy.json"
echo "[00B.1] Running vulnerability scan (HIGH/CRITICAL fail) → $VULN_PATH"
trivy image --exit-code 1 --severity CRITICAL,HIGH --format json "$IMG" > "$VULN_PATH"

echo "[00B.1] COMPLETE"
echo "SBOM: $SBOM_PATH"
echo "Vuln report: $VULN_PATH"
