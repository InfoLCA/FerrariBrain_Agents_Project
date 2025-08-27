<!-- readme_version: 1.0.0 -->

# Manifests — Docker (Phase 01)

## Purpose
This subfolder contains all **B-side manifests** used by the Docker agent during Phase 01.  
Each manifest is the **authoritative, executable blueprint** for a Docker microstep: exactly one command (PANP), declared inputs, required evidence, contracts, and checkpoint rules.

## Layout

Manifests/docker/
├─ year=YYYY/
│  ├─ month=MM/
│  │  └─ day=DD/          # daily partitions by event_time
└─ metadata_V1.yaml       # machine-readable index for this folder

## Manifest Requirements
Every Docker manifest **must** specify:
- **Microstep ID** (e.g., `07B`)
- **One command (PANP)** to execute
- **Inputs consumed** (paths; expected SHA256 if pinned)
- **Expected outputs** (paths; SHA256 recorded after run)
- **Confirmation packet** schema (JSON fields: phase, step, micro, cmd, files[path+sha256], exit_code, ts)
- **Checkpoint** criteria (digest + tag when conditions met)

## Evidence & Partitioning
- Execution artifacts are written under:

Outputs/docker/year=YYYY/month=MM/day=DD/

- Confirmation packets are written under:

Confirmations/docker/year=YYYY/month=MM/day=DD/

## Contracts (must be referenced by every manifest)
- **Memory API binding:** `config/agent_memory.binding.yaml`
- **Categories registry:** `config/memory_categories.json`
- **Chunk schema:** `schemas/memory_chunk.schema.json`
- **Router policy:** `config/router_policy.yaml`

## Usage (per microstep)
1. Execute the **PANP** command exactly as written.  
2. Write outputs to the dated **Outputs/docker/** partition.  
3. Produce one **confirmation packet** (JSON) with paths + SHA256 and place it under the dated **Confirmations/docker/** partition.  
4. Append entries to `PhaseLog.jsonl` and update `Manifests/docker/metadata_V1.yaml`.  
5. If checkpoint conditions are met, create the **checkpoint** (digest + tag).

## Security
- Manifests contain **no secrets**. Runtime tokens/keys are injected via environment only.  
- Once executed, manifests are **immutable**; any change requires a new file and a new hash.

> Rule: **This folder is the authoritative source of Docker manifests for Phase 01.**
