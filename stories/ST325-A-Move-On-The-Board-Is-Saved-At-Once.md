# ST325 — A move on the board is saved at once

**Priority:** 🔼 High · **State:** Finished (2026-11-14)

**What a user gains.** A person moves a story or an issue on the planning board and it is saved at once, with no Save and no Undo; a move that can do harm warns first, a slow save shows as still saving instead of as a failure, and each row in Needs you offers the action that answers it.

**The test.** Drag a story to another state: it is saved without a Save button and the board shows it within seconds; a move of a story with running tasks or issues in other repositories warns and can be cancelled; a slow save reads as saving, then saved; a row in Needs you after a stopped or failed step offers start again, stop or move on, and that action works from the row.

**Issues:**

- [porelo-planner#PL38](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl38) (Finished)
- [porelo-planner#PL43](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl43) (Finished)
- [porelo-planner#PL77](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl77) (Finished)
- [porelo-planner#PL99](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl99) (Finished)
- [porelo-planner#PL112](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl112) (Finished)
- [porelo-planner#PL117](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl117) (Finished)
- [porelo-planner#PL114](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl114) (Finished)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST325",
  "title": "A move on the board is saved at once",
  "gain": "A person moves a story or an issue on the planning board and it is saved at once, with no Save and no Undo; a move that can do harm warns first, a slow save shows as still saving instead of as a failure, and each row in Needs you offers the action that answers it.",
  "test": "Drag a story to another state: it is saved without a Save button and the board shows it within seconds; a move of a story with running tasks or issues in other repositories warns and can be cancelled; a slow save reads as saving, then saved; a row in Needs you after a stopped or failed step offers start again, stop or move on, and that action works from the row.",
  "priority": "High",
  "issues": [
    "porelo-planner#PL38",
    "porelo-planner#PL43",
    "porelo-planner#PL77",
    "porelo-planner#PL99",
    "porelo-planner#PL112",
    "porelo-planner#PL117",
    "porelo-planner#PL114"
  ],
  "tested": "2026-11-14"
}
```
