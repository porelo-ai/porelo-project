# PJ115 — Live Test By The Product Owner Of ST9

```json
{
  "$schema": "issue-1.json",
  "id": "PJ115",
  "title": "Live Test By The Product Owner Of ST9",
  "state": "Backlog",
  "size": "S",
  "priority": "Highest",
  "rank": 5,
  "blockedBy": [],
  "worker": "Manual",
  "kind": "Task",
  "covers": "The product owner tests ST9 (porelo-intellij and porelo-frontend each in its own task) live, by its story's test, and moves the story on to Review or names what failed"
}
```

**Why this size.** One live run of the story's test by the operator, with no code (S).

**What must be true.** The operator has run [ST9](../stories/ST9-Porelo-Intellij-And-Porelo-Frontend-Each-In-Its.md)'s test live:
Gradle and Flutter build on Forgejo; the Windows job runs centrally only, named by a variable.
It passed, or each failure is filed as an issue of the repository it falls in.

This issue is worked by hand (`worker: Manual`): no agent starts it, and the story can only reach Review through it.
