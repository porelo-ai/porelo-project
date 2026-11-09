# ST296 — Every repository's tests follow the test pyramid

**Priority:** ⏫ Highest · **State:** Accepted

**What a user gains.** Each repository proves its flows with unit tests that run in seconds, tests its real pieces narrowly on that core and keeps integration, VM and rented-machine runs for what nothing lower can show, so work is done and checked faster and a fault is found at the lowest level that shows it.

**The test.** Each repository's audit measures its suites against the shares of doc/test-pyramid.md and names every flow tested only through an integration or VM run; after the fixes, every such flow has unit tests over fakes, each module's unit suite runs in under a minute, and no plan needs a VM to see a flow work.

**Issues:** none yet

## Data

```json
{
  "id": "ST296",
  "title": "Every repository's tests follow the test pyramid",
  "state": "Accepted",
  "gain": "Each repository proves its flows with unit tests that run in seconds, tests its real pieces narrowly on that core and keeps integration, VM and rented-machine runs for what nothing lower can show, so work is done and checked faster and a fault is found at the lowest level that shows it.",
  "test": "Each repository's audit measures its suites against the shares of doc/test-pyramid.md and names every flow tested only through an integration or VM run; after the fixes, every such flow has unit tests over fakes, each module's unit suite runs in under a minute, and no plan needs a VM to see a flow work.",
  "priority": "Highest",
  "issues": [],
  "tested": null
}
```
