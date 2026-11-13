# ST4 — A task fetches a snapshot from its host's forge

**Priority:** 🟰 Medium · **State:** Backlog

**What a user gains.** A task on the host can fetch Porelo's snapshot from the host's own forge registry by the name its project uses, without reaching outside.

**The test.** A build inside a task on the host fetches porelo's snapshot from the forge's registry by the name its project declares, with no credential put into the project; the task reaches nothing else on the host.

**Issues:**

- [porelo-project#PJ75](https://github.com/porelo-ai/porelo-project/blob/main/issues/README.md#pj75) (Backlog)
- [porelo#B474](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b474) (Backlog)
- [porelo-host#HO131](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho131) (Review)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST4",
  "title": "A task fetches a snapshot from its host's forge",
  "gain": "A task on the host can fetch Porelo's snapshot from the host's own forge registry by the name its project uses, without reaching outside.",
  "test": "A build inside a task on the host fetches porelo's snapshot from the forge's registry by the name its project declares, with no credential put into the project; the task reaches nothing else on the host.",
  "priority": "Medium",
  "issues": [
    "porelo-project#PJ75",
    "porelo#B474",
    "porelo-host#HO131"
  ],
  "tested": null
}
```
