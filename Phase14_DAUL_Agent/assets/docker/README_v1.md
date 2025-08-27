<!-- readme_version: 1.0.0 -->

# Assets — Docker (Phase 01)

## Purpose
This subfolder contains all **B-side assets** produced or used by the **Docker agent** during Phase 01.  
Assets are non-executable artifacts that provide explainability, previews, and documentation for the pipeline.

## Layout

Assets/docker/
├─ images/          # screenshots, diagrams, visualizations
├─ html/            # HTML previews, dashboards
├─ reports/         # PDF/Markdown reports, rendered notebooks
└─ metadata_V1.yaml # machine-readable index

## Rules
- Assets here are **non-executable** and linked to specific microsteps.  
- Once logged, files are **immutable** — new versions require new files + new hashes.  

## Evidence & Partitioning
All assets are stored by **event_time**:

Assets/docker/year=YYYY/month=MM/day=DD/

- Hash every asset (SHA256) and append to `PhaseLog.jsonl`.  
- Record entries in `Assets/docker/metadata_V1.yaml` with `event_time` and `ingest_time`.  

## Contracts
Assets must align with global contracts:
- Memory API binding → `config/agent_memory.binding.yaml`  
- Categories registry → `config/memory_categories.json`  
- Chunk schema → `schemas/memory_chunk.schema.json`  
- Router policy → `config/router_policy.yaml`

## Security
- No secrets or sensitive PII are stored in assets.  
- Assets are immutable after creation.

> Rule: **This folder = authoritative source of Docker assets for Phase 01.**
