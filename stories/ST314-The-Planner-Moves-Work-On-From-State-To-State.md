# ST314 — The planner moves work on from state to state by itself

**Priority:** 🔼 High · **State:** Accepted

**What a user gains.** The planner moves an issue on by itself when its task ends, as the project's work rules say: work that ends DONE in Implementing goes to Reading and a reader starts with the proposed model; an OK reading goes to Review; a blocking reading goes to Reworking and asks the person under Needs you, whose entry opens the Reworking dialog; a task that fails stays with a warning and asks too.

**The test.** With Implementing then Reading, and Reading done Review or blocked Reworking: an issue's work ends DONE, the planner sets Reading and starts the reader without a dialog; an OK reading sets Review; a blocking one sets Reworking and a Needs-you entry opens its dialog, nothing starts unasked; a failed task keeps its card, with a warning and a Needs-you entry to its result.

**Issues:**

- [porelo-planner#PL71](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl71) (Review)
- [porelo-planner#PL70](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl70) (Backlog)
- [porelo-frontend#F475](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f475) (Review)
- [porelo-planner#PL64](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl64) (Estimated)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST314",
  "title": "The planner moves work on from state to state by itself",
  "gain": "The planner moves an issue on by itself when its task ends, as the project's work rules say: work that ends DONE in Implementing goes to Reading and a reader starts with the proposed model; an OK reading goes to Review; a blocking reading goes to Reworking and asks the person under Needs you, whose entry opens the Reworking dialog; a task that fails stays with a warning and asks too.",
  "test": "With Implementing then Reading, and Reading done Review or blocked Reworking: an issue's work ends DONE, the planner sets Reading and starts the reader without a dialog; an OK reading sets Review; a blocking one sets Reworking and a Needs-you entry opens its dialog, nothing starts unasked; a failed task keeps its card, with a warning and a Needs-you entry to its result.",
  "priority": "High",
  "state": "Accepted",
  "issues": [
    "porelo-planner#PL71",
    "porelo-planner#PL70",
    "porelo-frontend#F475",
    "porelo-planner#PL64"
  ],
  "tested": null
}
```
