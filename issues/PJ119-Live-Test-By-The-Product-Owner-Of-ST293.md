# PJ119 — Live Test By The Product Owner Of ST293

```json
{
  "$schema": "issue-1.json",
  "id": "PJ119",
  "title": "Live Test By The Product Owner Of ST293",
  "state": "Backlog",
  "size": "S",
  "priority": "Highest",
  "rank": 9,
  "blockedBy": [],
  "worker": "Manual",
  "kind": "Task",
  "covers": "The product owner tests ST293 (Every agent works in a Porelo task, moved one at a time) live, by its story's test, and moves the story on to Review or names what failed"
}
```

**Why this size.** One live run of the story's test by the operator, with no code (S).

**What must be true.** The operator has run [ST293](../stories/ST293-Every-Agent-Works-In-A-Porelo-Task-Moved-One.md)'s test live:
Every agent's move story is accepted in the order of doc/moving-an-agent.md; after the last move every agent answers in the project's room from its task and none works outside one.
It passed, or each failure is filed as an issue of the repository it falls in.

This issue is worked by hand (`worker: Manual`): no agent starts it, and the story can only reach Review through it.
