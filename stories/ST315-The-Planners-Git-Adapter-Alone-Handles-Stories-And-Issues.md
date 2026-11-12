# ST315 — The planner's Git adapter alone handles stories and issues

**Priority:** 🔼 High · **State:** Backlog

**What a user gains.** Stories and issues kept as files in Git are read, checked, indexed and written by the planner's Git store adapter alone, so the build tools no longer carry a stories library or story and issue commands, and no repository's build or hand-over runs a check of issue files.

**The test.** In a repository with no story or issue tooling in its build: change an issue's state and add an idea through the planner; the file, its head and the index are written and checked by the planner's Git adapter; a broken head shows as a fault on the board; porelo-buildtools builds without porelo-stories or the story and issue commands, and every repository's build passes without them.

**Issues:**

- [porelo-planner#PL41](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl41) (Finished)
- [porelo-planner#PL42](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl42) (Review)
- [porelo-planner#PL14](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl14) (Estimated)
- [porelo-planner#PL62](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl62) (Estimated)
- [porelo-planner#PL15](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl15) (Estimated)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST315",
  "title": "The planner's Git adapter alone handles stories and issues",
  "gain": "Stories and issues kept as files in Git are read, checked, indexed and written by the planner's Git store adapter alone, so the build tools no longer carry a stories library or story and issue commands, and no repository's build or hand-over runs a check of issue files.",
  "test": "In a repository with no story or issue tooling in its build: change an issue's state and add an idea through the planner; the file, its head and the index are written and checked by the planner's Git adapter; a broken head shows as a fault on the board; porelo-buildtools builds without porelo-stories or the story and issue commands, and every repository's build passes without them.",
  "priority": "High",
  "state": "Backlog",
  "issues": [
    "porelo-planner#PL41",
    "porelo-planner#PL42",
    "porelo-planner#PL14",
    "porelo-planner#PL62",
    "porelo-planner#PL15"
  ],
  "tested": null
}
```
