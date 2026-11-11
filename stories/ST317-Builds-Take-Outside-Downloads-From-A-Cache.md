# ST317 — Builds take outside downloads from a cache

**Priority:** 🟰 Medium · **State:** Accepted

**What a user gains.** Every build fetches what it needs from outside - container images, toolchains, packages - from a cache when it can, so an outage of a registry such as Codeberg's no longer turns a build red, and the cache keeps only the newest copy of each thing so it never fills up.

**The test.** In every repository, a list of each build's outside downloads shows each one cached or named as not cacheable; porelo-host's molecule (on) passes with codeberg.org unreachable once Forgejo's image is cached; after a pinned digest changes, only the new copy stays in the repository's Actions cache.

**Issues:**

- [porelo-message-matrix#MX107](https://github.com/porelo-ai/porelo-message-matrix/blob/main/issues/README.md#mx107) (Idea)
- [porelo-ecosystems#EC22](https://github.com/porelo-ai/porelo-ecosystems/blob/main/issues/README.md#ec22) (Analyzed)
- [porelo-mcp#MC13](https://github.com/porelo-ai/porelo-mcp/blob/main/issues/README.md#mc13) (Idea)
- [porelo-message-sluice#SL52](https://github.com/porelo-ai/porelo-message-sluice/blob/main/issues/README.md#sl52) (Analyzed)
- [porelo-adapters#GH31](https://github.com/porelo-ai/porelo-adapters/blob/main/issues/README.md#gh31) (Idea)
- [porelo-intellij#IJ27](https://github.com/porelo-ai/porelo-intellij/blob/main/issues/README.md#ij27) (Analyzed)
- [porelo-forge-clients#FC21](https://github.com/porelo-ai/porelo-forge-clients/blob/main/issues/README.md#fc21) (Idea)
- [porelo-host#HO168](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho168) (Estimated)
- [porelo-planner#PL52](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl52) (Idea)
- [porelo-frontend#F484](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f484) (Idea)
- [porelo-ai.github.io#SI08](https://github.com/porelo-ai/porelo-ai.github.io/blob/main/issues/README.md#si08) (Idea)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST317",
  "title": "Builds take outside downloads from a cache",
  "gain": "Every build fetches what it needs from outside - container images, toolchains, packages - from a cache when it can, so an outage of a registry such as Codeberg's no longer turns a build red, and the cache keeps only the newest copy of each thing so it never fills up.",
  "test": "In every repository, a list of each build's outside downloads shows each one cached or named as not cacheable; porelo-host's molecule (on) passes with codeberg.org unreachable once Forgejo's image is cached; after a pinned digest changes, only the new copy stays in the repository's Actions cache.",
  "priority": "Medium",
  "state": "Accepted",
  "issues": [
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
    "porelo-ai.github.io#SI08"
  ],
  "tested": null
}
```
