<!-- readme_version: 1.0.0 -->

# Phase 00 — Controls (Pre-Checkpoint for All Phases)

## Purpose
Mandatory controls that must pass before any PhaseXX checkpoint:
1) **SBOM + Vulnerability Scan** (Docker)
2) **Image Signing + Provenance/Attestations** (Docker)
3) **Verification & CI Enforcement Gates** (project-level)
4) **OpenAI Eval/Policy Gate** (A-side)

## Layout
Phase00_DAUL_Agent/
├─ Inputs/ Outputs/ Confirmations/ Manifests/ Scripts/ Assets/
├─ PhaseLog.jsonl
└─ README_v1.md
## Evidence & Partitioning
All evidence written under event-time partitions:
Outputs//year=YYYY/month=MM/day=DD/
Confirmations//year=YYYY/month=MM/day=DD/
## Rule of Execution
- PANP: **One command per microstep** (declared in manifests).
- After each microstep, run the **evidence logger** to record paths + SHA256 into `Confirmations/` and append to `PhaseLog.jsonl`.
- Only when all controls pass → create a **Phase00 checkpoint**.

## Contracts
- Memory API: `config/agent_memory.binding.yaml`
- Categories: `config/memory_categories.json`
- Chunk schema: `schemas/memory_chunk.schema.json`
- Router policy: `config/router_policy.yaml`

## Security
- No secrets in repo; runtime only.
