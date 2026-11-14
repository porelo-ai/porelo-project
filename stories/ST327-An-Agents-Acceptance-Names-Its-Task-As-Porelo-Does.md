# ST327 — An agent's acceptance names its task as Porelo does

**Priority:** 🔼 High · **State:** Finished (2026-11-14)

**What a user gains.** Each agent repository's acceptance scenarios name a task by its own name in Porelo's commands and take its container's name from porelo task status --json, so the scenarios keep passing when Porelo changes how it names containers.

**The test.** Run the acceptance legs of porelo-agy, porelo-claude-code, porelo-codex, porelo-omp and porelo-pi against the current porelo: all pass, and no scenario builds a container name by hand.

**Issues:**

- [porelo-agy#AG17](https://github.com/porelo-ai/porelo-agy/blob/main/issues/README.md#ag17) (Finished)
- [porelo-claude-code#CC55](https://github.com/porelo-ai/porelo-claude-code/blob/main/issues/README.md#cc55) (Finished)
- [porelo-codex#CX18](https://github.com/porelo-ai/porelo-codex/blob/main/issues/README.md#cx18) (Finished)
- [porelo-omp#OM50](https://github.com/porelo-ai/porelo-omp/blob/main/issues/README.md#om50) (Finished)
- [porelo-pi#PI56](https://github.com/porelo-ai/porelo-pi/blob/main/issues/README.md#pi56) (Finished)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST327",
  "title": "An agent's acceptance names its task as Porelo does",
  "gain": "Each agent repository's acceptance scenarios name a task by its own name in Porelo's commands and take its container's name from porelo task status --json, so the scenarios keep passing when Porelo changes how it names containers.",
  "test": "Run the acceptance legs of porelo-agy, porelo-claude-code, porelo-codex, porelo-omp and porelo-pi against the current porelo: all pass, and no scenario builds a container name by hand.",
  "priority": "High",
  "state": "Finished",
  "issues": [
    "porelo-agy#AG17",
    "porelo-claude-code#CC55",
    "porelo-codex#CX18",
    "porelo-omp#OM50",
    "porelo-pi#PI56"
  ],
  "tested": "2026-11-14"
}
```
