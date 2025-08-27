<!-- readme_version: 1.0.0 -->

# Manifests — OpenAI (Phase 01)

## Purpose
This subfolder contains all **A-side manifests** used by the OpenAI agent during Phase 01.  
Each manifest is the **authoritative definition** of what the OpenAI agent executes, how inputs are consumed, and how outputs + confirmations are produced.

## Layout

Manifests/openai/
├─ year=YYYY/
│  ├─ month=MM/
│  │  └─ day=DD/          # daily partitions by event_time
└─ metadata_V1.yaml       # machine-readable index for this folder

## Manifest Requirements
Each OpenAI manifest MUST specify:
- Microstep ID (e.g., `07A`)  
- Exactly **one command** (PANP)  
- Inputs consumed (paths + expected SHA256 if pinned)  
- Expected outputs (paths + hashes)  
- Confirmation packet schema  
- Checkpoint conditions  

## Evidence & Partitioning
- Outputs written under:  

Outputs/openai/year=YYYY/month=MM/day=DD/

- Confirmations written under:  

Confirmations/openai/year=YYYY/month=MM/day=DD/

## Contracts
All manifests in this folder must reference:
- Memory API binding: `config/agent_memory.binding.yaml`  
- Categories registry: `config/memory_categories.json`  
- Chunk schema: `schemas/memory_chunk.schema.json`  
- Router policy: `config/router_policy.yaml`  

## Security
- No secrets or `.env` values are embedded in manifests.  
- Tokens/keys are injected at runtime only.  
- Once executed, manifests are immutable — new revisions require new files + new hashes.

> Rule: **This folder is the authoritative source of OpenAI manifests for Phase 01.**
