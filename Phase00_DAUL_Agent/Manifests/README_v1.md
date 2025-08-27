<!-- readme_version: 1.0.0 -->

# Phase 00 — Manifests

## Purpose
Executable blueprints for Phase00 controls. Each microstep declares:
- **Command (PANP)**
- **Required evidence** (file paths + SHA256)
- **Confirmation packet** format
- **Checkpoint** rule (only after all controls PASS)

## Evidence Logging
After each microstep, run:
Scripts/docker/record_evidence.sh “<STEP_ID>” “<COMMAND_STRING>”  [file2 …]
This writes a confirmation packet under `Confirmations/<agent>/...` and appends to `PhaseLog.jsonl`.
