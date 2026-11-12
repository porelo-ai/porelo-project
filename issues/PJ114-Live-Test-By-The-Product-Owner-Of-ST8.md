# PJ114 — Live Test By The Product Owner Of ST8

```json
{
  "$schema": "issue-1.json",
  "id": "PJ114",
  "title": "Live Test By The Product Owner Of ST8",
  "state": "Backlog",
  "size": "S",
  "priority": "Highest",
  "rank": 4,
  "blockedBy": [],
  "worker": "Manual",
  "kind": "Task",
  "covers": "The product owner tests ST8 (porelo-message-matrix in its task) live, by its story's test, and moves the story on to Review or names what failed"
}
```

**Why this size.** One live run of the story's test by the operator, with no code (S).

**What must be true.** The operator has run [ST8](../stories/ST8-Porelo-Message-Matrix-In-Its-Task.md)'s test live:
Its move issue reaches Review inside the task with Forgejo's build green.
It passed, or each failure is filed as an issue of the repository it falls in.

This issue is worked by hand (`worker: Manual`): no agent starts it, and the story can only reach Review through it.
