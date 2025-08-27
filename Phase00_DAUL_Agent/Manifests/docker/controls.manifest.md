<!-- readme_version: 1.0.0 -->

# Phase 00 — Docker Controls (B)

> Replace `${IMAGE_DIGEST}` with your image digest, e.g.  
> `docker.io/legalcaseallies/alpine-test@sha256:12d60bc2651acf125ddc54ce76e4a3fedcad94778a90904800e26b72b80918a8`

All steps follow PANP (one command per step).  
After each step, run the evidence logger:

    Phase00_DAUL_Agent/Scripts/docker/record_evidence.sh "<STEP_ID>" "<COMMAND_STRING>" <file1> [file2 ...]

---

## 00B.1 — SBOM + Vulnerability Scan (PANP)

    Phase00_DAUL_Agent/Scripts/docker/00_sbom_and_scan.sh ${IMAGE_DIGEST}

**Evidence files:**
- `Phase00_DAUL_Agent/Outputs/docker/reports/sbom.cdx.json`
- `Phase00_DAUL_Agent/Outputs/docker/reports/vuln.trivy.json`

**Record evidence:**

    Phase00_DAUL_Agent/Scripts/docker/record_evidence.sh "00B.1" "Phase00_DAUL_Agent/Scripts/docker/00_sbom_and_scan.sh ${IMAGE_DIGEST}" "Phase00_DAUL_Agent/Outputs/docker/reports/sbom.cdx.json" "Phase00_DAUL_Agent/Outputs/docker/reports/vuln.trivy.json"

---

## 00B.2 — Image Signing (PANP)

    cosign sign ${IMAGE_DIGEST}

**Evidence:** signature stored in registry (no local file).  
(Verification artifacts produced in 00B.4.)

---

## 00B.3 — Provenance / Attestation (PANP)

    cosign attest --yes --predicate Phase00_DAUL_Agent/Outputs/docker/reports/sbom.cdx.json --type cyclonedx ${IMAGE_DIGEST} > Phase00_DAUL_Agent/Outputs/docker/artifacts/attestation.intoto.jsonl

**Record evidence:**

    Phase00_DAUL_Agent/Scripts/docker/record_evidence.sh "00B.3" "cosign attest --predicate .../sbom.cdx.json --type cyclonedx ${IMAGE_DIGEST}" "Phase00_DAUL_Agent/Outputs/docker/artifacts/attestation.intoto.jsonl"

---

## 00B.4 — Verify Signature & Attestation (PANP)

    cosign verify --certificate-identity-regexp '.*' --certificate-oidc-issuer-regexp '.*' --output json ${IMAGE_DIGEST} > Phase00_DAUL_Agent/Outputs/docker/reports/verify.signature.json

    cosign verify-attestation --type cyclonedx --certificate-identity-regexp '.*' --certificate-oidc-issuer-regexp '.*' --output json ${IMAGE_DIGEST} > Phase00_DAUL_Agent/Outputs/docker/reports/verify.attestation.json

**Record evidence:**

    Phase00_DAUL_Agent/Scripts/docker/record_evidence.sh "00B.4" "cosign verify/verify-attestation ${IMAGE_DIGEST}" "Phase00_DAUL_Agent/Outputs/docker/reports/verify.signature.json" "Phase00_DAUL_Agent/Outputs/docker/reports/verify.attestation.json"

---

## Checkpoint (create only if 00B.1–00B.4 PASS)

    mkdir -p Phase00_DAUL_Agent/checkpoints/docker
    shasum -a 256 \
      Phase00_DAUL_Agent/Outputs/docker/reports/sbom.cdx.json \
      Phase00_DAUL_Agent/Outputs/docker/reports/vuln.trivy.json \
      Phase00_DAUL_Agent/Outputs/docker/artifacts/attestation.intoto.jsonl \
      Phase00_DAUL_Agent/Outputs/docker/reports/verify.signature.json \
      Phase00_DAUL_Agent/Outputs/docker/reports/verify.attestation.json \
    > Phase00_DAUL_Agent/checkpoints/docker/P00__$(date -u +%Y%m%dT%H%M%SZ).sha256
