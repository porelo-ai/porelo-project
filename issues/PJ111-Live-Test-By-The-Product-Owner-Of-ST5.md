# PJ111 — Live Test By The Product Owner Of ST5

```json
{
  "$schema": "issue-1.json",
  "id": "PJ111",
  "title": "Live Test By The Product Owner Of ST5",
  "state": "Backlog",
  "size": "S",
  "priority": "Highest",
  "rank": 1,
  "blockedBy": [],
  "worker": "Manual",
  "kind": "Task",
  "covers": "The product owner tests ST5 (porelo-pi, porelo-omp and porelo-claude-code each in its own task, with snapshots of porelo from the registry) live, by its story's test, and moves the story on to Review or names what failed"
}
```

**Why this size.** One live run of the story's test by the operator, with no code (S).

**What must be true.** The operator has run [ST5](../stories/ST5-Porelo-Pi-Porelo-Omp-And-Porelo-Claude-Code.md)'s test live:
Each of the three repositories has its own agent and task, builds on Forgejo and takes porelo from the local registry.
It passed, or each failure is filed as an issue of the repository it falls in.

This issue is worked by hand (`worker: Manual`): no agent starts it, and the story can only reach Review through it.
