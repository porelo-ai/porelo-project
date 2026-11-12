# ST317 — Builds take outside downloads from a cache

**Priority:** 🟰 Medium · **State:** Implementing

**What a user gains.** Every build fetches what it needs from outside - container images, toolchains, packages - from a cache when it can, so an outage of a registry such as Codeberg's no longer turns a build red, and the cache keeps only the newest copy of each thing so it never fills up.

**The test.** In every repository, a list of each build's outside downloads shows each one cached or named as not cacheable; porelo-host's molecule (on) passes with codeberg.org unreachable once Forgejo's image is cached; after a pinned digest changes, only the new copy stays in the repository's Actions cache.

**Issues:**

- [porelo-buildtools#BT78](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt78) (Review)
- [porelo-message-matrix#MX107](https://github.com/porelo-ai/porelo-message-matrix/blob/main/issues/README.md#mx107) (Review)
- [porelo-ecosystems#EC22](https://github.com/porelo-ai/porelo-ecosystems/blob/main/issues/README.md#ec22) (Review)
- [porelo-mcp#MC13](https://github.com/porelo-ai/porelo-mcp/blob/main/issues/README.md#mc13) (Review)
- [porelo-message-sluice#SL52](https://github.com/porelo-ai/porelo-message-sluice/blob/main/issues/README.md#sl52) (Review)
- [porelo-adapters#GH31](https://github.com/porelo-ai/porelo-adapters/blob/main/issues/README.md#gh31) (Review)
- [porelo-intellij#IJ27](https://github.com/porelo-ai/porelo-intellij/blob/main/issues/README.md#ij27) (Review)
- [porelo-forge-clients#FC21](https://github.com/porelo-ai/porelo-forge-clients/blob/main/issues/README.md#fc21) (Review)
- [porelo-host#HO168](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho168) (Review)
- [porelo-planner#PL52](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl52) (Finished)
- [porelo-frontend#F484](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f484) (Review)
- [porelo-ai.github.io#SI08](https://github.com/porelo-ai/porelo-ai.github.io/blob/main/issues/README.md#si08) (Review)
- [porelo#B618](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b618) (Review)
- [porelo#B623](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b623) (Review)
- [porelo-pi#PI55](https://github.com/porelo-ai/porelo-pi/blob/main/issues/README.md#pi55) (Review)
- [porelo-parent#PA01](https://github.com/porelo-ai/porelo-parent/blob/main/issues/README.md#pa01) (Review)
- [porelo-claude-code#CC60](https://github.com/porelo-ai/porelo-claude-code/blob/main/issues/README.md#cc60) (Review)
- [porelo-omp#OM52](https://github.com/porelo-ai/porelo-omp/blob/main/issues/README.md#om52) (Review)
- [porelo-codex#CX20](https://github.com/porelo-ai/porelo-codex/blob/main/issues/README.md#cx20) (Review)
- [porelo-agy#AG20](https://github.com/porelo-ai/porelo-agy/blob/main/issues/README.md#ag20) (Review)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST317",
  "title": "Builds take outside downloads from a cache",
  "gain": "Every build fetches what it needs from outside - container images, toolchains, packages - from a cache when it can, so an outage of a registry such as Codeberg's no longer turns a build red, and the cache keeps only the newest copy of each thing so it never fills up.",
  "test": "In every repository, a list of each build's outside downloads shows each one cached or named as not cacheable; porelo-host's molecule (on) passes with codeberg.org unreachable once Forgejo's image is cached; after a pinned digest changes, only the new copy stays in the repository's Actions cache.",
  "priority": "Medium",
  "state": "Implementing",
  "issues": [
    "porelo-buildtools#BT78",
    "porelo-message-matrix#MX107",
    "porelo-ecosystems#EC22",
    "porelo-mcp#MC13",
    "porelo-message-sluice#SL52",
    "porelo-adapters#GH31",
    "porelo-intellij#IJ27",
    "porelo-forge-clients#FC21",
    "porelo-host#HO168",
    "porelo-planner#PL52",
    "porelo-frontend#F484",
    "porelo-ai.github.io#SI08",
    "porelo#B618",
    "porelo#B623",
    "porelo-pi#PI55",
    "porelo-parent#PA01",
    "porelo-claude-code#CC60",
    "porelo-omp#OM52",
    "porelo-codex#CX20",
    "porelo-agy#AG20"
  ],
  "tested": null
}
```
