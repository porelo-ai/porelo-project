# ST331 — Antigravity CLI kept current by the weekly update job

**Priority:** 🔼 High · **State:** Backlog

**What a user gains.** The weekly update job follows Antigravity CLI as porelo-claude-code's follows Claude Code: it finds a new release, pins it, runs the unit suite and both acceptance legs and proposes the change, so the agent stays current without hand work.

**The test.** After a new Antigravity CLI release, the next weekly job proposes a change pinning it, with the suite and both legs green.

**Issues:**

- [porelo-agy#AG19](https://github.com/porelo-ai/porelo-agy/blob/main/issues/README.md#ag19) (Estimated)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST331",
  "title": "Antigravity CLI kept current by the weekly update job",
  "gain": "The weekly update job follows Antigravity CLI as porelo-claude-code's follows Claude Code: it finds a new release, pins it, runs the unit suite and both acceptance legs and proposes the change, so the agent stays current without hand work.",
  "test": "After a new Antigravity CLI release, the next weekly job proposes a change pinning it, with the suite and both legs green.",
  "priority": "High",
  "state": "Backlog",
  "issues": [
    "porelo-agy#AG19"
  ],
  "tested": null
}
```
