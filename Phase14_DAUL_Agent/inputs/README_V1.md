<!-- readme_version: 1.0.0 -->

# Phase 01 — Inputs

## Purpose
This folder contains **all human-prepared inputs** required to execute **Phase 01 (Dual-Agent A/B)**.  
It is read by both agents:
- **A (OpenAI agent)** — API-first, read-only
- **B (Docker agent)** — local runtime, read-only

## Layout

Inputs/
├─ openai/          # prompts, configs specific to OpenAI agent
├─ docker/          # prompts, configs specific to Docker agent
├─ shared/          # common prompts, policies, templates
└─ metadata_V1.yaml # machine-readable index for this Inputs folder

## What goes here
- Prompts, system messages, runbooks, policy snippets used by Phase 01
- Agent configs that are **safe to commit** (no secrets)
- Memory API bindings that are **static references** (dynamic tokens are injected at runtime)

## Evidence & Partitioning
Outputs (hashes, copies) from using these inputs are written by the execution steps into:

../outputs/year=YYYY/month=MM/day=DD/

Use **event_time** (when the step occurred) for partitioning; **ingest_time** goes in metadata for audit replay.

## Required metadata fields (`metadata_V1.yaml`)
Add/maintain these keys (single source of truth for this folder):
```yaml
schema_version: 1.0.0
phase_id: 01
component: inputs
scope: [openai, docker, shared]
timestamps:
  event_time: <ISO8601>     # when inputs became active
  ingest_time: <ISO8601>    # when recorded
provenance:
  source_session_id: <id>
  source_files:
    - path: <relative_path>
      sha256: <hash>
privacy:
  pii_present: false
  redaction_status: "not_required"
status: initialized

Contracts this folder must respect
	•	Memory API binding: config/agent_memory.binding.yaml
	•	Categories registry: config/memory_categories.json
	•	Chunk schema: schemas/memory_chunk.schema.json
	•	Router policy: config/router_policy.yaml

Security
	•	No secrets or .env values are stored here.
	•	Tokens/keys are injected at runtime by the runner only.

Usage (per microstep)
	1.	The runner selects inputs from openai/, docker/, or shared/.
	2.	The exact files used are hashed (SHA256) and appended to PhaseLog.jsonl.
	3.	Execution proceeds; evidence is written under the dated outputs/ partition.

Guiding rule: Inputs are immutable once a microstep is executed. Any change requires a new file + new hash.


