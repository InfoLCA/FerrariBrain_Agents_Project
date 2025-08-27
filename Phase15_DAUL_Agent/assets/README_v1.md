<!-- readme_version: 1.0.0 -->

# Phase 01 — Assets

## Purpose
This folder stores all **non-executable artifacts** for Phase 01 (Dual-Agent A/B).  
Assets provide documentation, previews, and supporting visuals to ensure reproducibility and explainability for both OpenAI and Docker agents.

## Layout

Assets/
├─ openai/              # A-side assets generated/used by OpenAI agent
├─ docker/              # B-side assets generated/used by Docker agent
└─ metadata_V1.yaml     # machine-readable index for this folder

## What goes here
- Images (PNG, JPG, SVG)  
- HTML previews or dashboards  
- Diagrams and rendered notebooks  
- Reports in human-readable formats (PDF, Markdown)  

## Evidence & Partitioning
All assets are partitioned by **event_time** (when created):

Assets//year=YYYY/month=MM/day=DD/

Each asset must be logged with its **SHA256 hash** in `PhaseLog.jsonl` and indexed in `metadata_V1.yaml`.

## Contracts
Assets must reference the same compliance contracts as other subfolders:
- Memory API binding → `config/agent_memory.binding.yaml`  
- Categories registry → `config/memory_categories.json`  
- Chunk schema → `schemas/memory_chunk.schema.json`  
- Router policy → `config/router_policy.yaml`

## Usage
1. Generate or place an asset in the correct agent subfolder.  
2. Record the asset’s path and SHA256 in `PhaseLog.jsonl`.  
3. Update `Assets/metadata_V1.yaml` with event_time and ingest_time.  

## Security
- Assets contain **no secrets** or sensitive PII.  
- Once stored, assets are **immutable**; new versions = new files + new hashes.  

> Rule: **Assets provide the human-facing trace of Phase 01.**
