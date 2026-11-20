# ST384 — Builds fail only for a fault

**Priority:** 🔼 High · **State:** Backlog

**What a user gains.** Whoever pushes to Porelo can trust a red Build: it fails only for a fault in what was pushed, never by chance of timing, a cache or a runner, so no Build is re-run to get past it.

**The test.** Each test or step that failed by chance before passes ten Builds in a row on every system it runs on, and where its cause was a bound, the start, cache or memory it guarded is measured below that bound in the log.

**Issues:**

- [porelo-planner#PL188](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl188) (Implementing)
- [porelo-frontend#F631](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f631) (Backlog)
- [porelo#B818](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b818) (Backlog)
- [porelo-pi#PI75](https://github.com/porelo-ai/porelo-pi/blob/main/issues/README.md#pi75) (Backlog)
- [porelo-message-matrix#MX110](https://github.com/porelo-ai/porelo-message-matrix/blob/main/issues/README.md#mx110) (Backlog)

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
    "porelo-frontend#F631",
    "porelo#B818",
    "porelo-pi#PI75",
    "porelo-message-matrix#MX110"
  ]
}
```
