# ST325 — A move on the board is saved at once

**Priority:** ⏫ Highest · **State:** Backlog

**What a user gains.** A person moves a story or an issue on the planning board and it is saved at once, with no Save and no Undo; a move that can do harm warns first, a slow save shows as still saving instead of as a failure, and each row in Needs you offers the action that answers it.

**The test.** Drag a story to another state: it is saved without a Save button and the board shows it within seconds; a move of a story with running tasks or issues in other repositories warns and can be cancelled; a slow save reads as saving, then saved; a row in Needs you after a stopped or failed step offers start again, stop or move on, and that action works from the row.

**Issues:**

- [porelo-planner#PL38](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl38) (Backlog)
- [porelo-planner#PL43](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl43) (Review)
- [porelo-planner#PL77](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl77) (Backlog)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST325",
  "title": "A move on the board is saved at once",
  "gain": "A person moves a story or an issue on the planning board and it is saved at once, with no Save and no Undo; a move that can do harm warns first, a slow save shows as still saving instead of as a failure, and each row in Needs you offers the action that answers it.",
  "test": "Drag a story to another state: it is saved without a Save button and the board shows it within seconds; a move of a story with running tasks or issues in other repositories warns and can be cancelled; a slow save reads as saving, then saved; a row in Needs you after a stopped or failed step offers start again, stop or move on, and that action works from the row.",
  "priority": "Highest",
  "state": "Backlog",
  "issues": [
    "porelo-planner#PL38",
    "porelo-planner#PL43",
    "porelo-planner#PL77"
  ],
  "tested": null
}
```
