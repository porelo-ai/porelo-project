# PJ120 — Live Test By The Product Owner Of ST28

```json
{
  "$schema": "issue-1.json",
  "id": "PJ120",
  "title": "Live Test By The Product Owner Of ST28",
  "state": "Backlog",
  "size": "S",
  "priority": "Highest",
  "rank": 10,
  "blockedBy": [],
  "worker": "Manual",
  "kind": "Task",
  "covers": "The product owner tests ST28 (The setup, move and recovery proven together) live, by its story's test, and moves the story on to Review or names what failed"
}
```

**Why this size.** One live run of the story's test by the operator, with no code (S).

**What must be true.** The operator has run [ST28](../stories/README.md#st28)'s test live:
Bring up the project, run the local builds, move each agent and restore the room and usage after giving the host back. Compare the results with every setup and move criterion; a missing local-build or recovery prerequisite keeps the parent acceptance open.
It passed, or each failure is filed as an issue of the repository it falls in.

This issue is worked by hand (`worker: Manual`): no agent starts it, and the story can only reach Review through it.
