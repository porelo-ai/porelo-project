# PJ116 — Live Test By The Product Owner Of ST11

```json
{
  "$schema": "issue-1.json",
  "id": "PJ116",
  "title": "Live Test By The Product Owner Of ST11",
  "state": "Backlog",
  "size": "S",
  "priority": "Highest",
  "rank": 6,
  "blockedBy": [],
  "worker": "Manual",
  "kind": "Task",
  "covers": "The product owner tests ST11 (porelo-adapters and porelo-ai.github.io each in its own task) live, by its story's test, and moves the story on to Review or names what failed"
}
```

**Why this size.** One live run of the story's test by the operator, with no code (S).

**What must be true.** The operator has run [ST11](../stories/ST11-Porelo-Adapters-And-Porelo-Ai-Github-Io-Each.md)'s test live:
Each move issue reaches Review inside its task with Forgejo's build green.
It passed, or each failure is filed as an issue of the repository it falls in.

This issue is worked by hand (`worker: Manual`): no agent starts it, and the story can only reach Review through it.
