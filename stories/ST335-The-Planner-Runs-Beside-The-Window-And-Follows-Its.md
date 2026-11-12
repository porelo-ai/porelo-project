# ST335 — The planner runs beside the window and follows its updates

**Priority:** 🔼 High · **State:** Backlog

**What a user gains.** The planner runs as a service the system knows, started at sign-in; the window follows it to a new address and starts it again where it is gone, and a planner the window started ends with the window, so the window never talks to a stale planner.

**The test.** Update porelo-planner while the window is open, close and reopen the window: it talks to the new planner, whose version it shows; kill the planner: the window finds it again on its new port.

**Issues:**

- [porelo-planner#PL33](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl33) (Backlog)
- [porelo-frontend#F478](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f478) (Review)
- [porelo-frontend#F479](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f479) (Estimated)
- [porelo-planner#PL91](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl91) (Estimated)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST335",
  "title": "The planner runs beside the window and follows its updates",
  "gain": "The planner runs as a service the system knows, started at sign-in; the window follows it to a new address and starts it again where it is gone, and a planner the window started ends with the window, so the window never talks to a stale planner.",
  "test": "Update porelo-planner while the window is open, close and reopen the window: it talks to the new planner, whose version it shows; kill the planner: the window finds it again on its new port.",
  "priority": "High",
  "state": "Backlog",
  "issues": [
    "porelo-planner#PL33",
    "porelo-frontend#F478",
    "porelo-frontend#F479",
    "porelo-planner#PL91"
  ],
  "tested": null
}
```
