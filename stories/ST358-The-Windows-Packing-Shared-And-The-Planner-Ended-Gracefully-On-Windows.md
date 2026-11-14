# ST358 — The Windows packing shared and the planner ended gracefully on Windows

**Priority:** 🟰 Medium · **State:** Implementing

**What a user gains.** The window's Windows packing and install check can be called by another repository, such as the planner, with its app's name, version and files, and on Windows the window asks the planner it started to end through its own stop, ending it hard only when it does not end in time.

**The test.** The planner's Windows build packs itself with the window's scripts at a pinned commit and leaves no signing key or file behind; closing the window on Windows ends the planner without an error, or hard after the wait.

**Issues:**

- [porelo-frontend#F507](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f507) (Implementing)
- [porelo-frontend#F538](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f538) (Review)

## Notes

- Gathered on 2026-11-13 from issues that stood in no story, or moved out of a High story, by the operator's word.

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST358",
  "title": "The Windows packing shared and the planner ended gracefully on Windows",
  "gain": "The window's Windows packing and install check can be called by another repository, such as the planner, with its app's name, version and files, and on Windows the window asks the planner it started to end through its own stop, ending it hard only when it does not end in time.",
  "test": "The planner's Windows build packs itself with the window's scripts at a pinned commit and leaves no signing key or file behind; closing the window on Windows ends the planner without an error, or hard after the wait.",
  "priority": "Medium",
  "state": "Implementing",
  "issues": [
    "porelo-frontend#F507",
    "porelo-frontend#F538"
  ],
  "tested": null
}
```
