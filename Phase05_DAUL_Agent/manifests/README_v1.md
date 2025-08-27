<!-- readme_version: 1.0.0 -->

# Phase 01 — Manifests

## Purpose
Authoritative, **executable blueprints** for Phase 01 (Dual-Agent A/B).  
Manifests define microsteps, commands (PANP: one command per step), required evidence, contracts, and checkpoints.

## Layout

Manifests/
├─ openai/              # A-side manifests/configs (agent-facing)
├─ docker/              # B-side manifests/configs (local/container runtime)
└─ metadata_V1.yaml     # machine-readable index for this folder

## What a manifest MUST specify
- **Microstep ID** (e.g., `07A`, `07B`)
- **Command (PANP)** — exactly one shell command
- **Inputs consumed** (paths + expected hashes if pinned)
- **Evidence required** (files or stdout + SHA256)
- **Contracts** (schema & policy references)
- **Checkpoint** criteria (when to freeze/tag)

## Evidence & Partitioning
Artifacts produced by executing manifests are written under **Outputs** by **event_time**:

Outputs//year=YYYY/month=MM/day=DD/

Confirmation packets for each microstep go to:

Confirmations//year=YYYY/month=MM/day=DD/

## Contracts (must be referenced by every manifest)
- Memory API binding: `config/agent_memory.binding.yaml`
- Categories registry: `config/memory_categories.json`
- Chunk schema: `schemas/memory_chunk.schema.json`
- Router policy: `config/router_policy.yaml`

## Usage (per microstep)
1. Execute the listed **PANP** command exactly as written.  
2. Write outputs to the dated **Outputs/** partition.  
3. Produce one **confirmation packet** (JSON) with paths + SHA256.  
4. Append to `PhaseLog.jsonl` and update `Manifests/metadata_V1.yaml`.  
5. If criteria met, create the **checkpoint** (digest + tag).

## Security
- Manifests contain **no secrets**. Runtime tokens/keys are injected via environment only.  
- Manifests are **immutable** once executed; changes require a new file and a new hash.
