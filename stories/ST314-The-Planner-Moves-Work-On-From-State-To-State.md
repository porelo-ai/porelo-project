# ST314 — The planner moves work on from state to state by itself

**Priority:** 🔼 High · **State:** Finished (2026-11-14)

**What a user gains.** The planner moves an issue on by itself when its task ends, as the project's work rules say: work that ends DONE in Implementing goes to Reading and a reader starts with the proposed model; an OK reading goes to Review; a blocking reading goes to Reworking and asks the person under Needs you, whose entry opens the Reworking dialog; a task that fails stays with a warning and asks too.

**The test.** With Implementing then Reading, and Reading done Review or blocked Reworking: an issue's work ends DONE, the planner sets Reading and starts the reader without a dialog; an OK reading sets Review; a blocking one sets Reworking and a Needs-you entry opens its dialog, nothing starts unasked; a failed task keeps its card, with a warning and a Needs-you entry to its result.

**Issues:**

- [porelo-planner#PL71](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl71) (Finished)
- [porelo-planner#PL70](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl70) (Finished)
- [porelo-frontend#F475](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f475) (Finished)
- [porelo-planner#PL64](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl64) (Finished)
- [porelo-frontend#F492](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f492) (Finished)
- [porelo-planner#PL85](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl85) (Finished)
- [porelo-planner#PL49](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl49) (Finished)
- [porelo#B646](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b646) (Finished)
- [porelo#B647](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b647) (Finished)
- [porelo#B648](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b648) (Finished)
- [porelo-planner#PL90](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl90) (Finished)
- [porelo-planner#PL92](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl92) (Finished)
- [porelo-frontend#F500](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f500) (Finished)
- [porelo-frontend#F501](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f501) (Finished)
- [porelo#B633](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b633) (Finished)
- [porelo-buildtools#BT80](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt80) (Finished)
- [porelo-frontend#F493](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f493) (Finished)
- [porelo-frontend#F504](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f504) (Finished)
- [porelo-planner#PL95](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl95) (Finished)
- [porelo-planner#PL97](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl97) (Finished)
- [porelo#B671](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b671) (Finished)
- [porelo-frontend#F510](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f510) (Finished)
- [porelo-planner#PL118](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl118) (Finished)
- [porelo-planner#PL119](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl119) (Finished)
- [porelo-planner#PL120](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl120) (Finished)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST314",
  "title": "The planner moves work on from state to state by itself",
  "gain": "The planner moves an issue on by itself when its task ends, as the project's work rules say: work that ends DONE in Implementing goes to Reading and a reader starts with the proposed model; an OK reading goes to Review; a blocking reading goes to Reworking and asks the person under Needs you, whose entry opens the Reworking dialog; a task that fails stays with a warning and asks too.",
  "test": "With Implementing then Reading, and Reading done Review or blocked Reworking: an issue's work ends DONE, the planner sets Reading and starts the reader without a dialog; an OK reading sets Review; a blocking one sets Reworking and a Needs-you entry opens its dialog, nothing starts unasked; a failed task keeps its card, with a warning and a Needs-you entry to its result.",
  "priority": "High",
  "issues": [
    "porelo-planner#PL71",
    "porelo-planner#PL70",
    "porelo-frontend#F475",
    "porelo-planner#PL64",
    "porelo-frontend#F492",
    "porelo-planner#PL85",
    "porelo-planner#PL49",
    "porelo#B646",
    "porelo#B647",
    "porelo#B648",
    "porelo-planner#PL90",
    "porelo-planner#PL92",
    "porelo-frontend#F500",
    "porelo-frontend#F501",
    "porelo#B633",
    "porelo-buildtools#BT80",
    "porelo-frontend#F493",
    "porelo-frontend#F504",
    "porelo-planner#PL95",
    "porelo-planner#PL97",
    "porelo#B671",
    "porelo-frontend#F510",
    "porelo-planner#PL118",
    "porelo-planner#PL119",
    "porelo-planner#PL120"
  ],
  "tested": "2026-11-14"
}
```
