#!/usr/bin/env bash
set -euo pipefail
img="${1:?docker_image_ref}"
# sign image + store attestations (cosign keyless; adjust as needed)
mkdir -p ../../Outputs/docker/artifacts
cosign sign --yes "$img"
cosign attest --yes --predicate ../../Outputs/docker/reports/sbom.cdx.json --type cyclonedx "$img" > ../../Outputs/docker/artifacts/attestation.intoto.jsonl
