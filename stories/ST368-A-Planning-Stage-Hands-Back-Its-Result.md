# ST368 — A planning stage hands back its result, and the planner stores it

**Priority:** 🔼 High · **State:** Finished (2026-11-15)

**What a user gains.** An issue stands in Analyzed or Estimated only when its plan or estimate really stands in the planning store. Analysis and estimation tasks no longer write the store's file format, open a pull request or pass the gate, so no stale copy of a repository can put a second issue file on main or move an issue whose central text holds no plan. The same flow works for a store that is not Git.

**The test.** Start an analysis from the board, unattended: no push, no gate, no pull request. The issue stands in Analyzed with plan, size and points to check in its central file, and no second issue file exists. An estimation ends in Estimated likewise. A stage task without a valid result leaves the issue in its working state, the board says why, and the store is unchanged.

**Issues:**

- [porelo-planner#PL141](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl141) (Finished)
- [porelo-planner#PL142](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl142) (Finished)
- [porelo-planner#PL143](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl143) (Finished)
- [porelo-frontend#F591](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f591) (Finished)
- [porelo#B791](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b791) (Finished)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST368",
  "title": "A planning stage hands back its result, and the planner stores it",
  "gain": "An issue stands in Analyzed or Estimated only when its plan or estimate really stands in the planning store. Analysis and estimation tasks no longer write the store's file format, open a pull request or pass the gate, so no stale copy of a repository can put a second issue file on main or move an issue whose central text holds no plan. The same flow works for a store that is not Git.",
  "test": "Start an analysis from the board, unattended: no push, no gate, no pull request. The issue stands in Analyzed with plan, size and points to check in its central file, and no second issue file exists. An estimation ends in Estimated likewise. A stage task without a valid result leaves the issue in its working state, the board says why, and the store is unchanged.",
  "tested": "2026-11-15",
  "priority": "High",
  "state": "Finished",
  "issues": [
    "porelo-planner#PL141",
    "porelo-planner#PL142",
    "porelo-planner#PL143",
    "porelo-frontend#F591",
    "porelo#B791"
  ]
}
```
