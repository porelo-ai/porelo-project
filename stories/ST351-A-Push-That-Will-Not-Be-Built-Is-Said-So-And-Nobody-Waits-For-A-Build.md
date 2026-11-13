# ST351 — A push that will not be built is said so, and nobody waits for a build

**Priority:** 🔼 High · **State:** Backlog

**What a user gains.** When a push will not be built, because it waits at the gate for a person, no build followed or the watch did not start, the agent and the person are told at once and nobody waits for a build report.

**The test.** Push from a task whose work waits at the gate, from a project that follows no builds, and from one whose build watch did not start: the agent is told at once that no build comes and does not wait, and the window reads that no build comes for this push.

**Issues:**

- [porelo#B710](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b710) (Review)
- [porelo#B712](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b712) (Review)
- [porelo-frontend#F539](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f539) (Backlog)

## Notes

- Gathered on 2026-11-13 from issues that stood in no story, or moved out of a High story, by the operator's word.

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST351",
  "title": "A push that will not be built is said so, and nobody waits for a build",
  "gain": "When a push will not be built, because it waits at the gate for a person, no build followed or the watch did not start, the agent and the person are told at once and nobody waits for a build report.",
  "test": "Push from a task whose work waits at the gate, from a project that follows no builds, and from one whose build watch did not start: the agent is told at once that no build comes and does not wait, and the window reads that no build comes for this push.",
  "priority": "High",
  "state": "Backlog",
  "issues": [
    "porelo#B710",
    "porelo#B712",
    "porelo-frontend#F539"
  ],
  "tested": null
}
```
