# PJ117 — Live Test By The Product Owner Of ST13

```json
{
  "$schema": "issue-1.json",
  "id": "PJ117",
  "title": "Live Test By The Product Owner Of ST13",
  "state": "Backlog",
  "size": "S",
  "priority": "Highest",
  "rank": 7,
  "blockedBy": [],
  "worker": "Manual",
  "kind": "Task",
  "covers": "The product owner tests ST13 (porelo and porelo-host each in its task, with a way back) live, by its story's test, and moves the story on to Review or names what failed"
}
```

**Why this size.** One live run of the story's test by the operator, with no code (S).

**What must be true.** The operator has run [ST13](../stories/ST13-Porelo-And-Porelo-Host-Each-In-Its-Task.md)'s test live:
porelo's agent builds porelo in a task and porelo-host's agent its collection; each works on this machine again if a fault in Porelo or the host's setup stops it.
It passed, or each failure is filed as an issue of the repository it falls in.

This issue is worked by hand (`worker: Manual`): no agent starts it, and the story can only reach Review through it.
