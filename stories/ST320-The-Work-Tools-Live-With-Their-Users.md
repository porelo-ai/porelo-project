# ST320 — The work tools live with their users

**Priority:** 🔼 High · **State:** Implementing

**What a user gains.** The issue and story tooling (stage records, stats, the stories and issues index, check-commits and citations) moves from the build tools to the planner, the native-image checks to Core, and dead release-plan code goes. Each part then lives with the agent who uses and changes it, so a change to the work format is made by its owner, not by Machines.

**The test.** Each moved part is built, published and used from its new home, and porelo-buildtools keeps only CI, machines, pins and publishing. Every repository's shared rules check still runs check-commits and check-citations green. A stage line and a planner board move are written and checked against the planner's format. No module or command is left that nobody calls.

**Issues:**

- [porelo-buildtools#BT70](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt70) (Review)
- [porelo-buildtools#BT71](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt71) (Backlog)
- [porelo-buildtools#BT72](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt72) (Review)
- [porelo-buildtools#BT73](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt73) (Review)
- [porelo-planner#PL59](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl59) (Review)
- [porelo-planner#PL60](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl60) (Review)
- [porelo-planner#PL61](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl61) (Review)
- [porelo#B621](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b621) (Review)
- [porelo#B622](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b622) (Implementing)
- [porelo-claude-code#CC56](https://github.com/porelo-ai/porelo-claude-code/blob/main/issues/README.md#cc56) (Review)
- [porelo-claude-code#CC57](https://github.com/porelo-ai/porelo-claude-code/blob/main/issues/README.md#cc57) (Review)
- [porelo-claude-code#CC59](https://github.com/porelo-ai/porelo-claude-code/blob/main/issues/README.md#cc59) (Review)
- [porelo-pi#PI57](https://github.com/porelo-ai/porelo-pi/blob/main/issues/README.md#pi57) (Review)
- [porelo-omp#OM51](https://github.com/porelo-ai/porelo-omp/blob/main/issues/README.md#om51) (Review)
- [porelo-codex#CX19](https://github.com/porelo-ai/porelo-codex/blob/main/issues/README.md#cx19) (Review)
- [porelo-agy#AG18](https://github.com/porelo-ai/porelo-agy/blob/main/issues/README.md#ag18) (Review)
- [porelo#B630](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b630) (Backlog)
- [porelo-buildtools#BT64](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt64) (Review)
- [porelo-buildtools#BT65](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt65) (Review)
- [porelo-planner#PL81](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl81) (Review)
- [porelo-adapters#GH29](https://github.com/porelo-ai/porelo-adapters/blob/main/issues/README.md#gh29) (Review)
- [porelo-planner#PL102](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl102) (Review)
- [porelo-planner#PL103](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl103) (Analyzed)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST320",
  "title": "The work tools live with their users",
  "gain": "The issue and story tooling (stage records, stats, the stories and issues index, check-commits and citations) moves from the build tools to the planner, the native-image checks to Core, and dead release-plan code goes. Each part then lives with the agent who uses and changes it, so a change to the work format is made by its owner, not by Machines.",
  "test": "Each moved part is built, published and used from its new home, and porelo-buildtools keeps only CI, machines, pins and publishing. Every repository's shared rules check still runs check-commits and check-citations green. A stage line and a planner board move are written and checked against the planner's format. No module or command is left that nobody calls.",
  "priority": "High",
  "state": "Implementing",
  "issues": [
    "porelo-buildtools#BT70",
    "porelo-buildtools#BT71",
    "porelo-buildtools#BT72",
    "porelo-buildtools#BT73",
    "porelo-planner#PL59",
    "porelo-planner#PL60",
    "porelo-planner#PL61",
    "porelo#B621",
    "porelo#B622",
    "porelo-claude-code#CC56",
    "porelo-claude-code#CC57",
    "porelo-claude-code#CC59",
    "porelo-pi#PI57",
    "porelo-omp#OM51",
    "porelo-codex#CX19",
    "porelo-agy#AG18",
    "porelo#B630",
    "porelo-buildtools#BT64",
    "porelo-buildtools#BT65",
    "porelo-planner#PL81",
    "porelo-adapters#GH29",
    "porelo-planner#PL102",
    "porelo-planner#PL103"
  ],
  "tested": null
}
```
