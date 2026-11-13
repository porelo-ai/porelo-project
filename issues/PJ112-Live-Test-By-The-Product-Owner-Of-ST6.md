# PJ112 — Live Test By The Product Owner Of ST6

```json
{
  "$schema": "issue-1.json",
  "id": "PJ112",
  "title": "Live Test By The Product Owner Of ST6",
  "state": "Backlog",
  "size": "S",
  "priority": "Highest",
  "rank": 2,
  "blockedBy": [],
  "worker": "Manual",
  "kind": "Task",
  "covers": "The product owner tests ST6 (porelo-agy and porelo-codex each in its own task) live, by its story's test, and moves the story on to Review or names what failed"
}
```

**Why this size.** One live run of the story's test by the operator, with no code (S).

**What must be true.** The operator has run [ST6](../stories/README.md#st6)'s test live:
Each move issue reaches Review inside its task with Forgejo's build green. Only Claude Code runs in the task: reviews come from new agents started apart, by the host's forge or by hand.
It passed, or each failure is filed as an issue of the repository it falls in.

This issue is worked by hand (`worker: Manual`): no agent starts it, and the story can only reach Review through it.
