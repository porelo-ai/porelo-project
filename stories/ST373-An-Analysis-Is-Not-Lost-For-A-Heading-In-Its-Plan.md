# ST373 — An analysis is not lost for a heading in its plan

**Priority:** ⏫ Highest · **State:** Finished

**What a user gains.** A person who starts the analysis of a story gets its plans saved on the board, even where the agent opened a plan with a heading of its own, instead of losing the whole run to a format refusal.

**The test.** On a rented host, start the analysis of a story whose agent writes a plan opening with a second-level heading: the planner saves it, the issue shows the plan under its Plan section with that heading as a third-level one, and no format refusal is shown.

**Issues:**

- [porelo-planner#PL160](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl160) (Finished)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST373",
  "title": "An analysis is not lost for a heading in its plan",
  "gain": "A person who starts the analysis of a story gets its plans saved on the board, even where the agent opened a plan with a heading of its own, instead of losing the whole run to a format refusal.",
  "test": "On a rented host, start the analysis of a story whose agent writes a plan opening with a second-level heading: the planner saves it, the issue shows the plan under its Plan section with that heading as a third-level one, and no format refusal is shown.",
  "tested": null,
  "priority": "Highest",
  "issues": [
    "porelo-planner#PL160"
  ]
}
```
