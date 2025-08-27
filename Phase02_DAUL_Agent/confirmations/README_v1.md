<!-- readme_version: 1.0.0 -->

# Phase 01 — Confirmations

## Purpose
Authoritative store for **validation packets** after each microstep:
- **A = OpenAI agent**
- **B = Docker agent**

Packets capture the command run, evidence hashes, exit code, and timestamp. They enable audit, replay, and phase freezing.

## Layout

Confirmations/
├─ openai/            # A-side packets (JSON)
├─ docker/            # B-side packets (JSON)
└─ metadata_V1.yaml   # index for this folder

## Packet Format (authoritative)
Each microstep produces exactly **one** JSON packet:

```json
{
  "phase": "P01",
  "step": "<NN>",
  "micro": "A or B",
  "cmd": "<exact command executed>",
  "files": [
    { "path": "<relative_path_or_stdout>", "sha256": "<sha256_hash>" }
  ],
  "exit_code": 0,
  "ts": "<ISO8601>"
}

	•	files[].path may be "stdout" when hashing command output captured to file.
	•	SHA256 is mandatory for every listed file or output.

Evidence & Partitioning

Store packets by event_time (when the step ran), not ingest time:

Confirmations/<agent>/year=YYYY/month=MM/day=DD/

This ensures deterministic roll-ups (day → week → month → year).

Usage (per microstep)
	1.	Execute the microstep (A or B).
	2.	Generate one JSON packet exactly in the format above.
	3.	Save it under the correct dated partition.
	4.	Append its path + SHA256 to PhaseLog.jsonl.
	5.	Update Confirmations/metadata_V1.yaml (event_time + ingest_time + provenance).

Contracts to Respect
	•	Memory API binding: config/agent_memory.binding.yaml
	•	Categories registry: config/memory_categories.json
	•	Chunk schema: schemas/memory_chunk.schema.json
	•	Router policy: config/router_policy.yaml

Security
	•	No secrets are stored in packets.
	•	Packets are immutable once written; corrections require a new packet with a new hash.


