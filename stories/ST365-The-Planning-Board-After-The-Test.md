# ST365 — The planning board after the test

**Priority:** 🟰 Medium · **State:** Finished (2026-11-15)

**What a user gains.** A person who finishes a story on the planning board finishes its issues in Review with it in one move, and the first board after the planner starts reads every repository at one moment, so it shows no false problems.

**The test.** Move a story whose issues stand in Review to Finished on the board: the story and each of those issues stand in Finished after one confirmation, and an issue in another open state is named and stops the move. Restart the planner after a push that adds issues and names them in a story: the first board shows no "is no issue" problems.

**Issues:**

- [porelo-planner#PL138](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl138) (Finished)
- [porelo-planner#PL139](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl139) (Finished)
- [porelo-frontend#F594](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f594) (Finished)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST365",
  "title": "The planning board after the test",
  "gain": "A person who finishes a story on the planning board finishes its issues in Review with it in one move, and the first board after the planner starts reads every repository at one moment, so it shows no false problems.",
  "test": "Move a story whose issues stand in Review to Finished on the board: the story and each of those issues stand in Finished after one confirmation, and an issue in another open state is named and stops the move. Restart the planner after a push that adds issues and names them in a story: the first board shows no \"is no issue\" problems.",
  "tested": "2026-11-15",
  "priority": "Medium",
  "state": "Finished",
  "issues": [
    "porelo-planner#PL138",
    "porelo-planner#PL139",
    "porelo-frontend#F594"
  ]
}
```
