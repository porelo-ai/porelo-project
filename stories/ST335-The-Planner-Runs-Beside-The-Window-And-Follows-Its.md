# ST335 — The planner runs beside the window and follows its updates

**Priority:** 🔼 High · **State:** Finished (2026-11-14)

**What a user gains.** The window follows the planner to a new address and starts it again where it is gone, and a planner the window started ends with the window, so the window never talks to a stale planner.

**The test.** Update porelo-planner while the window is open, close and reopen the window: it talks to the new planner, whose version it shows; kill the planner: the window finds it again on its new port.

**Issues:**

- [porelo-frontend#F478](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f478) (Finished)
- [porelo-frontend#F479](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f479) (Finished)
- [porelo-planner#PL91](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl91) (Finished)
- [porelo-planner#PL113](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl113) (Finished)
- [porelo-frontend#F526](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f526) (Finished)
- [porelo-frontend#F544](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f544) (Finished)
- [porelo-planner#PL89](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl89) (Finished)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST335",
  "title": "The planner runs beside the window and follows its updates",
  "gain": "The window follows the planner to a new address and starts it again where it is gone, and a planner the window started ends with the window, so the window never talks to a stale planner.",
  "test": "Update porelo-planner while the window is open, close and reopen the window: it talks to the new planner, whose version it shows; kill the planner: the window finds it again on its new port.",
  "priority": "High",
  "issues": [
    "porelo-frontend#F478",
    "porelo-frontend#F479",
    "porelo-planner#PL91",
    "porelo-planner#PL113",
    "porelo-frontend#F526",
    "porelo-frontend#F544",
    "porelo-planner#PL89"
  ],
  "tested": "2026-11-14"
}
```
