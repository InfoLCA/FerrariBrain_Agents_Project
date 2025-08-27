<!-- readme_version: 1.0.0 -->

# Scripts — Docker (Phase 01)

## Purpose
This subfolder contains all **B-side helper scripts** used by the Docker agent during Phase 01.  
Scripts provide the **implementation logic** (build, run, test), while manifests orchestrate them under PANP rules.

## Layout

Scripts/docker/
├─ bash/             # shell helpers for container tasks
├─ dockerfiles/      # Dockerfiles and Compose fragments
├─ tools/            # other utilities or wrappers
└─ metadata_V1.yaml  # machine-readable index

## Rules
- Each script is referenced by exactly **one PANP command** in a manifest.  
- Once executed, scripts are **immutable**; new versions require new files + new hashes.  
- Scripts must be **non-interactive** and exit with clear status codes.  

## Evidence & Partitioning
- Outputs from Docker scripts go to:

Outputs/docker/year=YYYY/month=MM/day=DD/

- Confirmation packets are logged in:

Confirmations/docker/year=YYYY/month=MM/day=DD/

- Each script path + SHA256 is appended to `PhaseLog.jsonl`.  

## Contracts
Scripts must comply with global project contracts:
- Memory API binding → `config/agent_memory.binding.yaml`  
- Categories registry → `config/memory_categories.json`  
- Chunk schema → `schemas/memory_chunk.schema.json`  
- Router policy → `config/router_policy.yaml`

## Security
- No `.env` files or secrets are committed here.  
- Secrets must be injected at runtime only.  

> Rule: **This folder is the authoritative source of Docker scripts for Phase 01.**
