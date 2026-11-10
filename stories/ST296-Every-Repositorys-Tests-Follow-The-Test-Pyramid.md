# ST296 — Every repository's tests follow the test pyramid

**Priority:** ⏫ Highest · **State:** Accepted

**What a user gains.** Each repository proves its flows with unit tests that run in seconds, tests its real pieces narrowly on that core and keeps integration, VM and rented-machine runs for what nothing lower can show, so work is done and checked faster and a fault is found at the lowest level that shows it.

**The test.** Each repository's audit measures its suites against the shares of doc/test-pyramid.md; the guards proven only from above move down first, then real waits give way to an injected clock; after the fixes every flow has unit tests over fakes, each module's unit suite runs in under a minute, and no plan needs a VM to see a flow work.

**Issues:**

- [porelo#B570](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b570) (Accepted)
- [porelo-mcp#MC11](https://github.com/porelo-ai/porelo-mcp/blob/main/issues/README.md#mc11) (Accepted)
- [porelo-pi#PI52](https://github.com/porelo-ai/porelo-pi/blob/main/issues/README.md#pi52) (Accepted)
- [porelo-codex#CX16](https://github.com/porelo-ai/porelo-codex/blob/main/issues/README.md#cx16) (Accepted)
- [porelo-agy#AG15](https://github.com/porelo-ai/porelo-agy/blob/main/issues/README.md#ag15) (Accepted)
- [porelo-buildtools#BT57](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt57) (Accepted)
- [porelo-frontend#F450](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f450) (Accepted)
- [porelo-message-matrix#MX93](https://github.com/porelo-ai/porelo-message-matrix/blob/main/issues/README.md#mx93) (Accepted)
- [porelo-host#HO159](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho159) (Accepted)
- [porelo-intellij#IJ23](https://github.com/porelo-ai/porelo-intellij/blob/main/issues/README.md#ij23) (Accepted)
- [porelo-message-sluice#SL50](https://github.com/porelo-ai/porelo-message-sluice/blob/main/issues/README.md#sl50) (Accepted)
- [porelo-adapters#GH23](https://github.com/porelo-ai/porelo-adapters/blob/main/issues/README.md#gh23) (Accepted)
- [porelo-ecosystems#EC18](https://github.com/porelo-ai/porelo-ecosystems/blob/main/issues/README.md#ec18) (Accepted)
- [porelo-claude-code#CC50](https://github.com/porelo-ai/porelo-claude-code/blob/main/issues/README.md#cc50) (Accepted)
- [porelo-omp#OM48](https://github.com/porelo-ai/porelo-omp/blob/main/issues/README.md#om48) (Accepted)
- [porelo-forge-clients#FC18](https://github.com/porelo-ai/porelo-forge-clients/blob/main/issues/README.md#fc18) (Analyzed)
- [porelo#B512](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b512) (Review)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST296",
  "title": "Every repository's tests follow the test pyramid",
  "gain": "Each repository proves its flows with unit tests that run in seconds, tests its real pieces narrowly on that core and keeps integration, VM and rented-machine runs for what nothing lower can show, so work is done and checked faster and a fault is found at the lowest level that shows it.",
  "test": "Each repository's audit measures its suites against the shares of doc/test-pyramid.md; the guards proven only from above move down first, then real waits give way to an injected clock; after the fixes every flow has unit tests over fakes, each module's unit suite runs in under a minute, and no plan needs a VM to see a flow work.",
  "priority": "Highest",
  "issues": [
    "porelo#B570",
    "porelo-mcp#MC11",
    "porelo-pi#PI52",
    "porelo-codex#CX16",
    "porelo-agy#AG15",
    "porelo-buildtools#BT57",
    "porelo-frontend#F450",
    "porelo-message-matrix#MX93",
    "porelo-host#HO159",
    "porelo-intellij#IJ23",
    "porelo-message-sluice#SL50",
    "porelo-adapters#GH23",
    "porelo-ecosystems#EC18",
    "porelo-claude-code#CC50",
    "porelo-omp#OM48",
    "porelo-forge-clients#FC18",
    "porelo#B512"
  ],
  "tested": null
}
```
