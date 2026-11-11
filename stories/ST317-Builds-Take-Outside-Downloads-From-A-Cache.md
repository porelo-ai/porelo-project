# ST317 — Builds take outside downloads from a cache

**Priority:** 🟰 Medium · **State:** Accepted

**What a user gains.** Every build fetches what it needs from outside - container images, toolchains, packages - from a cache when it can, so an outage of a registry such as Codeberg's no longer turns a build red, and the cache keeps only the newest copy of each thing so it never fills up.

**The test.** In every repository, a list of each build's outside downloads shows each one cached or named as not cacheable; porelo-host's molecule (on) passes with codeberg.org unreachable once Forgejo's image is cached; after a pinned digest changes, only the new copy stays in the repository's Actions cache.

**Issues:** none yet

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
  "issues": [],
  "tested": null
}
```
