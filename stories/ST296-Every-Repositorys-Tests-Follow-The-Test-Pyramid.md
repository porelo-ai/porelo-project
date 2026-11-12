# ST296 — Every repository's tests follow the test pyramid

**Priority:** ⏫ Highest · **State:** Estimated

**What a user gains.** Each repository proves its flows with unit tests that run in seconds, tests its real pieces narrowly on that core and keeps integration, VM and rented-machine runs for what nothing lower can show, so work is done and checked faster and a fault is found at the lowest level that shows it.

**The test.** Each repository's audit measures its suites against the shares of doc/test-pyramid.md; the guards proven only from above move down first, then real waits give way to an injected clock; after the fixes every flow has unit tests over fakes, each module's unit suite runs in under a minute, and no plan needs a VM to see a flow work.

**Issues:**

- [porelo#B652](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b652) (Estimated)
- [porelo#B653](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b653) (Estimated)
- [porelo#B654](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b654) (Estimated)
- [porelo#B655](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b655) (Estimated)
- [porelo#B656](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b656) (Estimated)
- [porelo#B657](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b657) (Estimated)
- [porelo#B658](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b658) (Estimated)
- [porelo#B659](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b659) (Estimated)
- [porelo#B660](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b660) (Estimated)
- [porelo#B661](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b661) (Estimated)
- [porelo#B662](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b662) (Estimated)
- [porelo#B663](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b663) (Estimated)
- [porelo#B664](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b664) (Estimated)
- [porelo#B665](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b665) (Estimated)
- [porelo-mcp#MC11](https://github.com/porelo-ai/porelo-mcp/blob/main/issues/README.md#mc11) (Estimated)
- [porelo-pi#PI52](https://github.com/porelo-ai/porelo-pi/blob/main/issues/README.md#pi52) (Estimated)
- [porelo-codex#CX16](https://github.com/porelo-ai/porelo-codex/blob/main/issues/README.md#cx16) (Estimated)
- [porelo-agy#AG15](https://github.com/porelo-ai/porelo-agy/blob/main/issues/README.md#ag15) (Estimated)
- [porelo-buildtools#BT57](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt57) (Estimated)
- [porelo-frontend#F495](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f495) (Estimated)
- [porelo-frontend#F496](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f496) (Estimated)
- [porelo-frontend#F497](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f497) (Estimated)
- [porelo-frontend#F498](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f498) (Estimated)
- [porelo-frontend#F499](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f499) (Estimated)
- [porelo-message-matrix#MX93](https://github.com/porelo-ai/porelo-message-matrix/blob/main/issues/README.md#mx93) (Estimated)
- [porelo-host#HO159](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho159) (Estimated)
- [porelo-intellij#IJ23](https://github.com/porelo-ai/porelo-intellij/blob/main/issues/README.md#ij23) (Estimated)
- [porelo-message-sluice#SL53](https://github.com/porelo-ai/porelo-message-sluice/blob/main/issues/README.md#sl53) (Estimated)
- [porelo-message-sluice#SL54](https://github.com/porelo-ai/porelo-message-sluice/blob/main/issues/README.md#sl54) (Estimated)
- [porelo-message-sluice#SL55](https://github.com/porelo-ai/porelo-message-sluice/blob/main/issues/README.md#sl55) (Estimated)
- [porelo-adapters#GH23](https://github.com/porelo-ai/porelo-adapters/blob/main/issues/README.md#gh23) (Estimated)
- [porelo-ecosystems#EC18](https://github.com/porelo-ai/porelo-ecosystems/blob/main/issues/README.md#ec18) (Estimated)
- [porelo-claude-code#CC50](https://github.com/porelo-ai/porelo-claude-code/blob/main/issues/README.md#cc50) (Estimated)
- [porelo-omp#OM48](https://github.com/porelo-ai/porelo-omp/blob/main/issues/README.md#om48) (Estimated)
- [porelo-forge-clients#FC18](https://github.com/porelo-ai/porelo-forge-clients/blob/main/issues/README.md#fc18) (Estimated)
- [porelo#B512](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b512) (Review)
- [porelo#B625](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b625) (Review)
- [porelo-buildtools#BT82](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt82) (Review)

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
    "porelo#B652",
    "porelo#B653",
    "porelo#B654",
    "porelo#B655",
    "porelo#B656",
    "porelo#B657",
    "porelo#B658",
    "porelo#B659",
    "porelo#B660",
    "porelo#B661",
    "porelo#B662",
    "porelo#B663",
    "porelo#B664",
    "porelo#B665",
    "porelo-mcp#MC11",
    "porelo-pi#PI52",
    "porelo-codex#CX16",
    "porelo-agy#AG15",
    "porelo-buildtools#BT57",
    "porelo-frontend#F495",
    "porelo-frontend#F496",
    "porelo-frontend#F497",
    "porelo-frontend#F498",
    "porelo-frontend#F499",
    "porelo-message-matrix#MX93",
    "porelo-host#HO159",
    "porelo-intellij#IJ23",
    "porelo-message-sluice#SL53",
    "porelo-message-sluice#SL54",
    "porelo-message-sluice#SL55",
    "porelo-adapters#GH23",
    "porelo-ecosystems#EC18",
    "porelo-claude-code#CC50",
    "porelo-omp#OM48",
    "porelo-forge-clients#FC18",
    "porelo#B512",
    "porelo#B625",
    "porelo-buildtools#BT82"
  ],
  "tested": null
}
```
