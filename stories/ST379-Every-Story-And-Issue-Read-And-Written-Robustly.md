# ST379 — Every story and issue read and written robustly

**Priority:** 🔼 High · **State:** Backlog

**What a user gains.** A person sees every story and issue on the board, however it was edited by hand in the tracker: one the planner cannot fully read is shown with a warning and an offer to correct it, never left out. A field counts as set and is never checked against the text or the comments, and a write never deletes text the planner did not place.

**The test.** In a test organization a person makes issues by hand: one with no Status, one with no Priority, one with a Status the workflow lacks, one closed while its Status is open, one with a fence left open, and overrides a sum field. The board shows each, the odd ones with a warning and a fix offered; a stage result written to the fenced one deletes nothing; the overridden sum stays.

**Issues:**

- [porelo-planner#PL171](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl171) (Review)
- [porelo-planner#PL172](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl172) (Backlog)
- [porelo-planner#PL173](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl173) (Backlog)
- [porelo-planner#PL174](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl174) (Implementing)
- [porelo-planner#PL175](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl175) (Backlog)
- [porelo-planner#PL176](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl176) (Backlog)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST379",
  "title": "Every story and issue read and written robustly",
  "gain": "A person sees every story and issue on the board, however it was edited by hand in the tracker: one the planner cannot fully read is shown with a warning and an offer to correct it, never left out. A field counts as set and is never checked against the text or the comments, and a write never deletes text the planner did not place.",
  "test": "In a test organization a person makes issues by hand: one with no Status, one with no Priority, one with a Status the workflow lacks, one closed while its Status is open, one with a fence left open, and overrides a sum field. The board shows each, the odd ones with a warning and a fix offered; a stage result written to the fenced one deletes nothing; the overridden sum stays.",
  "tested": null,
  "priority": "High",
  "state": "Backlog",
  "issues": [
    "porelo-planner#PL171",
    "porelo-planner#PL172",
    "porelo-planner#PL173",
    "porelo-planner#PL174",
    "porelo-planner#PL175",
    "porelo-planner#PL176"
  ]
}
```
