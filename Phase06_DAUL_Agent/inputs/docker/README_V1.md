<!-- readme_version: 1.0.0 -->

# Phase 01 — Inputs (Docker Agent)

## Purpose
This subfolder holds **all input material dedicated to the Docker agent** during Phase 01 execution.  
It inherits rules from:
- `../README.md` (Inputs root)
- `../../README.md` (Phase01_DAUL_Agent)
- Project root `README_V1.md`

## Contents

Inputs/docker/
├─ prompts/        # runbooks, system msgs tailored for container runtime
├─ configs/        # YAML/JSON config used by local containers
├─ policies/       # optional: container-only policy overrides
└─ metadata_V1.yaml

## Usage
1. Files here are **read-only inputs** for Docker microsteps.  
2. Each file consumed in execution must be hashed (SHA256) and appended to `PhaseLog.jsonl`.  
3. Evidence outputs are written to:

../../outputs/docker/year=YYYY/month=MM/day=DD/

## Required metadata fields (`metadata_V1.yaml`)
```yaml
schema_version: 1.0.0
phase_id: 01
component: inputs-docker
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
	•	Runtime tokens/keys are injected by the runner only.

Execution Flow
	•	Docker microsteps select inputs from this folder.
	•	The exact file(s) used are logged with SHA256 to PhaseLog.jsonl.
	•	After execution, inputs are immutable (new versions require new files + new hashes).

Rule: This folder = authoritative source of Docker inputs for Phase 01.


