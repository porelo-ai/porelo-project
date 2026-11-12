# ST343 — A task's timeline seen in an open-source tool on the same machine

**Priority:** 🔽 Low · **State:** Idea

**What a user gains.** A person who wants charts, trace views or evaluations points the export at an open-source tool running locally (MLflow with SQLite first, OpenLIT or Langfuse where their extra services are worth it), with the tool's own telemetry off, and sees the runs of their tasks there; Porelo installs nothing of it by default.

**The test.** Start the chosen tool locally in rootless podman with its telemetry off and outbound network closed, export a few task runs to it, and read each run with its steps and numbers; measure its memory at rest and its disk growth per run.

**Issues:** none yet

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST343",
  "title": "A task's timeline seen in an open-source tool on the same machine",
  "gain": "A person who wants charts, trace views or evaluations points the export at an open-source tool running locally (MLflow with SQLite first, OpenLIT or Langfuse where their extra services are worth it), with the tool's own telemetry off, and sees the runs of their tasks there; Porelo installs nothing of it by default.",
  "test": "Start the chosen tool locally in rootless podman with its telemetry off and outbound network closed, export a few task runs to it, and read each run with its steps and numbers; measure its memory at rest and its disk growth per run.",
  "priority": "Low",
  "state": "Idea",
  "issues": [],
  "tested": null
}
```
