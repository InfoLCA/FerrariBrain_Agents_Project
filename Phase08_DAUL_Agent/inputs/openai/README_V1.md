<!-- readme_version: 1.0.0 -->
# Phase 01 — Inputs (OpenAI Agent)

## Purpose
This subfolder holds **all input material dedicated to the OpenAI agent** during Phase 01 execution.  
It inherits rules from:
- `../README.md` (Inputs folder root)  
- `../../README.md` (Phase01_DAUL_Agent)  
- Root project `README.md`  

## Contents

Inputs/openai/
├─ prompts/       # agent prompts and system messages
├─ configs/       # JSON/YAML configs specific to OpenAI runtime
├─ policies/      # optional: OpenAI-agent policy overrides
└─ metadata_V1.yaml

## Usage
1. All files here are **read-only inputs** for OpenAI agent microsteps.  
2. Each file used in execution must be hashed (SHA256) and appended to `PhaseLog.jsonl`.  
3. Evidence outputs are written to `../../outputs/openai/year=YYYY/month=MM/day=DD/`.

## Required metadata fields (`metadata_V1.yaml`)
```yaml
schema_version: 1.0.0
phase_id: 01
component: inputs-openai
scope: [prompts, configs, policies]
timestamps:
  event_time: <ISO8601>
  ingest_time: <ISO8601>
provenance:
  source_session_id: <id>
  source_files:
    - path: <relative_path>
      sha256: <hash>
privacy:
  pii_present: false
  redaction_status: "not_required"
status: initialized

Contracts to Respect
	•	Memory API binding: config/agent_memory.binding.yaml
	•	Categories registry: config/memory_categories.json
	•	Chunk schema: schemas/memory_chunk.schema.json
	•	Router policy: config/router_policy.yaml

Security
	•	No secrets or .env values are committed here.
	•	Runtime tokens/keys are injected by the execution environment only.

Execution Flow
	•	Microsteps that require OpenAI inputs will pull from this subfolder.
	•	The exact file(s) consumed are logged with SHA256 into PhaseLog.jsonl.
	•	Once executed, inputs are immutable (new versions require new files + new hashes).

Rule: This folder = authoritative source of OpenAI inputs for Phase 01.


