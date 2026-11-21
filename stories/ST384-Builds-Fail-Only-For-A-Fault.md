# ST384 — Builds fail only for a fault

**Priority:** 🔼 High · **State:** Backlog

**What a user gains.** Whoever pushes to Porelo can trust a red Build: it fails only for a fault in what was pushed, never by chance of timing, a cache or a runner, so no Build is re-run to get past it.

**The test.** Each test or step that failed by chance before passes ten Builds in a row on every system it runs on, and where its cause was a bound, the start, cache or memory it guarded is measured below that bound in the log.

**Issues:**

- [porelo-planner#PL188](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl188) (Implementing)
- [porelo-planner#PL189](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl189) (Review)
- [porelo-frontend#F631](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f631) (Review)
- [porelo#B818](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b818) (Implementing)
- [porelo-pi#PI75](https://github.com/porelo-ai/porelo-pi/blob/main/issues/README.md#pi75) (Review)
- [porelo-message-matrix#MX110](https://github.com/porelo-ai/porelo-message-matrix/blob/main/issues/README.md#mx110) (Review)
- [porelo-planner#PL190](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl190) (Review)
- [porelo-planner#PL191](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl191) (Review)
- [porelo-buildtools#BT99](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt99) (Review)
- [porelo-buildtools#BT100](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt100) (Review)
- [porelo#B820](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b820) (Review)
- [porelo-frontend#F632](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f632) (Review)
- [porelo-message-sluice#SL59](https://github.com/porelo-ai/porelo-message-sluice/blob/main/issues/README.md#sl59) (Review)
- [porelo-mcp#MC15](https://github.com/porelo-ai/porelo-mcp/blob/main/issues/README.md#mc15) (Review)
- [porelo-adapters#GH38](https://github.com/porelo-ai/porelo-adapters/blob/main/issues/README.md#gh38) (Backlog)
- [porelo-message-matrix#MX120](https://github.com/porelo-ai/porelo-message-matrix/blob/main/issues/README.md#mx120) (Review)
- [porelo-claude-code#CC83](https://github.com/porelo-ai/porelo-claude-code/blob/main/issues/README.md#cc83) (Review)
- [porelo-pi#PI76](https://github.com/porelo-ai/porelo-pi/blob/main/issues/README.md#pi76) (Review)
- [porelo-omp#OM70](https://github.com/porelo-ai/porelo-omp/blob/main/issues/README.md#om70) (Review)
- [porelo-codex#CX33](https://github.com/porelo-ai/porelo-codex/blob/main/issues/README.md#cx33) (Review)
- [porelo-agy#AG32](https://github.com/porelo-ai/porelo-agy/blob/main/issues/README.md#ag32) (Review)
- [porelo-host#HO199](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho199) (Review)
- [porelo-ecosystems#EC31](https://github.com/porelo-ai/porelo-ecosystems/blob/main/issues/README.md#ec31) (Review)
- [porelo-forge-clients#FC29](https://github.com/porelo-ai/porelo-forge-clients/blob/main/issues/README.md#fc29) (Review)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST384",
  "title": "Builds fail only for a fault",
  "gain": "Whoever pushes to Porelo can trust a red Build: it fails only for a fault in what was pushed, never by chance of timing, a cache or a runner, so no Build is re-run to get past it.",
  "test": "Each test or step that failed by chance before passes ten Builds in a row on every system it runs on, and where its cause was a bound, the start, cache or memory it guarded is measured below that bound in the log.",
  "priority": "High",
  "tested": null,
  "issues": [
    "porelo-planner#PL188",
    "porelo-planner#PL189",
    "porelo-frontend#F631",
    "porelo#B818",
    "porelo-pi#PI75",
    "porelo-message-matrix#MX110",
    "porelo-planner#PL190",
    "porelo-planner#PL191",
    "porelo-buildtools#BT99",
    "porelo-buildtools#BT100",
    "porelo#B820",
    "porelo-frontend#F632",
    "porelo-message-sluice#SL59",
    "porelo-mcp#MC15",
    "porelo-adapters#GH38",
    "porelo-message-matrix#MX120",
    "porelo-claude-code#CC83",
    "porelo-pi#PI76",
    "porelo-omp#OM70",
    "porelo-codex#CX33",
    "porelo-agy#AG32",
    "porelo-host#HO199",
    "porelo-ecosystems#EC31",
    "porelo-forge-clients#FC29"
  ]
}
```
