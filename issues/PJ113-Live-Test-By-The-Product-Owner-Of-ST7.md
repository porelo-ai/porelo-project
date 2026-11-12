# PJ113 — Live Test By The Product Owner Of ST7

```json
{
  "$schema": "issue-1.json",
  "id": "PJ113",
  "title": "Live Test By The Product Owner Of ST7",
  "state": "Backlog",
  "size": "S",
  "priority": "Highest",
  "rank": 3,
  "blockedBy": [],
  "worker": "Manual",
  "kind": "Task",
  "covers": "The product owner tests ST7 (porelo-buildtools in its task) live, by its story's test, and moves the story on to Review or names what failed"
}
```

**Why this size.** One live run of the story's test by the operator, with no code (S).

**What must be true.** The operator has run [ST7](../stories/ST7-Porelo-Buildtools-In-Its-Task.md)'s test live:
Its move issue reaches Review inside the task with Forgejo's build green.
It passed, or each failure is filed as an issue of the repository it falls in.

This issue is worked by hand (`worker: Manual`): no agent starts it, and the story can only reach Review through it.
