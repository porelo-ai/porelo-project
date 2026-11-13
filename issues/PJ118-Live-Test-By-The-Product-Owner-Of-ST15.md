# PJ118 — Live Test By The Product Owner Of ST15

```json
{
  "$schema": "issue-1.json",
  "id": "PJ118",
  "title": "Live Test By The Product Owner Of ST15",
  "state": "Backlog",
  "size": "S",
  "priority": "Highest",
  "rank": 8,
  "blockedBy": [],
  "worker": "Manual",
  "kind": "Task",
  "covers": "The product owner tests ST15 (The website builds in its task) live, by its story's test, and moves the story on to Review or names what failed"
}
```

**Why this size.** One live run of the story's test by the operator, with no code (S).

**What must be true.** The operator has run [ST15](../stories/README.md#st15)'s test live:
Run the full website check inside its task; it passes after the Debian-image and repository-name blockers are fixed.
It passed, or each failure is filed as an issue of the repository it falls in.

This issue is worked by hand (`worker: Manual`): no agent starts it, and the story can only reach Review through it.
