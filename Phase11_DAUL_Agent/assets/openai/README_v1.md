<!-- readme_version: 1.0.0 -->

# Assets — OpenAI (Phase 01)

## Purpose
This subfolder contains all **A-side assets** produced or used by the OpenAI agent during Phase 01.  
Assets provide supporting visuals, previews, and documentation that complement the executable pipeline.

## Layout

Assets/openai/
├─ images/          # screenshots, diagrams, visualizations
├─ html/            # HTML previews, rendered dashboards
├─ reports/         # PDF or Markdown reports, notebooks
└─ metadata_V1.yaml # machine-readable index

## Rules
- Assets here are **non-executable artifacts**.  
- They are linked to microsteps for **explainability** and **traceability**.  
- Each file is **immutable** once logged — new versions = new files + new hashes.  

## Evidence & Partitioning
Assets are stored by **event_time**:

Assets/openai/year=YYYY/month=MM/day=DD/

- Each file must be hashed (SHA256).  
- Hash + path logged to `PhaseLog.jsonl`.  
- Entry added to `Assets/openai/metadata_V1.yaml`.  

## Contracts
Assets must align with the same compliance contracts:
- Memory API binding → `config/agent_memory.binding.yaml`  
- Categories registry → `config/memory_categories.json`  
- Chunk schema → `schemas/memory_chunk.schema.json`  
- Router policy → `config/router_policy.yaml`

## Security
- No secrets or sensitive PII are stored in assets.  
- Files are immutable after creation.  

> Rule: **This folder = authoritative source of OpenAI assets for Phase 01.**
