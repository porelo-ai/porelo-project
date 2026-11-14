# ST361 — Fixing small UI issues

**Priority:** ⏫ Highest · **State:** Backlog

**What a user gains.** The planner's board says only what is true and offers only what a person needs: an issue's link to its story's row is not reported as broken, one Reload planning button brings the board up to date whatever went wrong, and no separate switch for finished and rejected stories stands beside the columns that fold; a story's or an issue's description reads as written, its Markdown rendered.

**The test.** Open porelo-project's board: no fault names a link to a story's row. Stop the planner's stream and press Reload planning: the board is live again and shows what was pushed meanwhile. The board offers no Retry planning and no Show Finished and Rejected; the closed columns fold as before. Open a story with a Markdown description: headings, lists and links are rendered, not shown as raw signs.

**Issues:**

- [porelo-planner#PL127](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl127) (Review)
- [porelo-planner#PL128](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl128) (Review)
- [porelo-planner#PL129](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl129) (Review)
- [porelo-planner#PL36](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl36) (Review)
- [porelo-frontend#F549](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f549) (Review)
- [porelo-frontend#F550](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f550) (Review)
- [porelo-frontend#F551](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f551) (Backlog)
- [porelo-frontend#F552](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f552) (Review)
- [porelo-frontend#F553](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f553) (Backlog)
- [porelo-frontend#F554](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f554) (Review)
- [porelo-frontend#F555](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f555) (Review)
- [porelo-frontend#F556](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f556) (Review)
- [porelo-frontend#F558](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f558) (Backlog)
- [porelo-host#HO190](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho190) (Review)
- [porelo-intellij#IJ31](https://github.com/porelo-ai/porelo-intellij/blob/main/issues/README.md#ij31) (Review)
- [porelo#B764](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b764) (Review)

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
    "porelo-frontend#F549",
    "porelo-frontend#F550",
    "porelo-frontend#F551",
    "porelo-frontend#F552",
    "porelo-frontend#F553",
    "porelo-frontend#F554",
    "porelo-frontend#F555",
    "porelo-frontend#F556",
    "porelo-frontend#F558",
    "porelo-host#HO190",
    "porelo-intellij#IJ31",
    "porelo#B764"
  ],
  "tested": null
}
```
