# ST360 — A task keeps its limit and key across a restart

**Priority:** 🔼 High · **State:** Backlog

**What a user gains.** An unattended run stops at its time limit even when porelod restarted in between, and a caller finds its task by its key after a machine restart, also when the task's start failed and it was kept, so no run goes on unbounded and no second task is started by mistake.

**The test.** Start an unattended run with a few minutes' limit, restart porelod during it: the run ends at its limit and List says it ended by the limit. Start a task that fails and is kept, restart the machine: List gives it back under the caller's key.

**Issues:**

- [porelo#B761](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b761) (Backlog)
- [porelo#B762](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b762) (Backlog)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST360",
  "title": "A task keeps its limit and key across a restart",
  "gain": "An unattended run stops at its time limit even when porelod restarted in between, and a caller finds its task by its key after a machine restart, also when the task's start failed and it was kept, so no run goes on unbounded and no second task is started by mistake.",
  "test": "Start an unattended run with a few minutes' limit, restart porelod during it: the run ends at its limit and List says it ended by the limit. Start a task that fails and is kept, restart the machine: List gives it back under the caller's key.",
  "priority": "High",
  "issues": [
    "porelo#B761",
    "porelo#B762"
  ],
  "tested": null
}
```
