<!-- readme_version: 1.0.0 -->

# Scripts — OpenAI (Phase 01)

## Purpose
This subfolder holds all **A-side helper scripts** used by the OpenAI agent during Phase 01.  
Scripts provide the **implementation details**, while manifests control orchestration.

## Layout

Scripts/openai/
├─ bash/             # shell scripts for setup or validation
├─ python/           # Python helpers/utilities
├─ tools/            # other utilities or wrappers
└─ metadata_V1.yaml  # machine-readable index

## Rules
- Each script is referenced by exactly **one PANP command** in a manifest.  
- Once executed, the script is **immutable**; any change requires a new file + new hash.  
- Scripts are **non-interactive** and must exit with status codes only.  

## Evidence & Partitioning
- All outputs from these scripts are written to:

Outputs/openai/year=YYYY/month=MM/day=DD/

- Confirmation packets are recorded in:

Confirmations/openai/year=YYYY/month=MM/day=DD/

- Hashes of each script are appended to `PhaseLog.jsonl`.  

## Contracts
Scripts must comply with the global contracts:
- Memory API binding → `config/agent_memory.binding.yaml`  
- Categories registry → `config/memory_categories.json`  
- Chunk schema → `schemas/memory_chunk.schema.json`  
- Router policy → `config/router_policy.yaml`

## Security
- No `.env` or secrets inside scripts.  
- Secrets injected only at runtime by the execution environment.  

> Rule: **This folder is the authoritative source of OpenAI scripts for Phase 01.**
