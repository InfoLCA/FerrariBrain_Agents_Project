<!-- readme_version: 1.0.0 -->

# Phase 01 — Scripts

## Purpose
Authoritative home for **executable helpers** used by Phase 01 manifests (A = OpenAI, B = Docker).  
Scripts implement functionality; **manifests orchestrate** them (PANP: one command per microstep).

## Layout

Scripts/
├─ openai/              # A-side helpers (bash/python utilities for OpenAI agent)
├─ docker/              # B-side helpers (bash/python, Dockerfiles, compose fragments)
└─ metadata_V1.yaml     # machine-readable index for this folder

## Rules
- Scripts are **referenced by manifests** only; do not execute ad-hoc.
- Any change creates a **new file** (no in-place edits after use).
- Every script used in a microstep is **hashed (SHA256)** and logged to `PhaseLog.jsonl`.

## Evidence & Partitioning
When a script is invoked by a microstep, its outputs are written under **Outputs** by **event_time**:

Outputs//year=YYYY/month=MM/day=DD/

The matching confirmation packet is written under:

Confirmations//year=YYYY/month=MM/day=DD/

## Contracts (must be upheld by any script)
- Memory API binding: `config/agent_memory.binding.yaml`
- Categories registry: `config/memory_categories.json`
- Chunk schema: `schemas/memory_chunk.schema.json`
- Router policy: `config/router_policy.yaml`

## Usage (per microstep)
1. Manifest calls exactly **one command** (PANP) that may invoke a script from this folder.  
2. Record the **script path + SHA256** in `PhaseLog.jsonl`.  
3. Save all artifacts to the dated **Outputs/** partition.  
4. Emit a **confirmation packet** capturing the command, files, hashes, exit code, and timestamp.  
5. Update `Scripts/metadata_V1.yaml` with event_time, ingest_time, and provenance.

## Security
- **No secrets** or `.env` values are stored in scripts.  
- Secrets are injected at runtime only.  
- Scripts are **non-interactive**; fail fast with clear exit codes.

> Guiding rule: **Scripts implement; manifests decide.** Once a script is used in a microstep, treat it as immutable evidence (new versions = new files + new hashes).
