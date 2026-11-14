# ST361 — Fixing small UI issues

**Priority:** ⏫ Highest · **State:** Backlog

**What a user gains.** The planner's board says only what is true and offers only what a person needs: an issue's link to its story's row is not reported as broken, one Reload planning button brings the board up to date whatever went wrong, and no separate switch for finished and rejected stories stands beside the columns that fold; a story's or an issue's description reads as written, its Markdown rendered.

**The test.** Open porelo-project's board: no fault names a link to a story's row. Stop the planner's stream and press Reload planning: the board is live again and shows what was pushed meanwhile. The board offers no Retry planning and no Show Finished and Rejected; the closed columns fold as before. Open a story with a Markdown description: headings, lists and links are rendered, not shown as raw signs.

**Issues:**

- [porelo-planner#PL127](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl127) (Review)
- [porelo-planner#PL128](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl128) (Backlog)
- [porelo-planner#PL129](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl129) (Backlog)
- [porelo-planner#PL36](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl36) (Backlog)
- [porelo-frontend#F549](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f549) (Backlog)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST361",
  "title": "Fixing small UI issues",
  "gain": "The planner's board says only what is true and offers only what a person needs: an issue's link to its story's row is not reported as broken, one Reload planning button brings the board up to date whatever went wrong, and no separate switch for finished and rejected stories stands beside the columns that fold; a story's or an issue's description reads as written, its Markdown rendered.",
  "test": "Open porelo-project's board: no fault names a link to a story's row. Stop the planner's stream and press Reload planning: the board is live again and shows what was pushed meanwhile. The board offers no Retry planning and no Show Finished and Rejected; the closed columns fold as before. Open a story with a Markdown description: headings, lists and links are rendered, not shown as raw signs.",
  "priority": "Highest",
  "state": "Backlog",
  "issues": [
    "porelo-planner#PL127",
    "porelo-planner#PL128",
    "porelo-planner#PL129",
    "porelo-planner#PL36",
    "porelo-frontend#F549"
  ],
  "tested": null
}
```
