# ST379 — Every story and issue read and written robustly

**Priority:** 🔼 High · **State:** Backlog

**What a user gains.** A person sees every story and issue on the board, however it was edited by hand in the tracker: one the planner cannot fully read is shown with a warning and an offer to correct it, never left out. A field counts as set and is never checked against the text or the comments, and a write never deletes text the planner did not place.

**The test.** In a test organization a person makes issues by hand: one with no Status, one with no Priority, one with a Status the workflow lacks, one closed while its Status is open, one with a fence left open, and overrides a sum field. The board shows each, the odd ones with a warning and a fix offered; a stage result written to the fenced one deletes nothing; the overridden sum stays.

**Issues:** none yet

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
  "issues": []
}
```
