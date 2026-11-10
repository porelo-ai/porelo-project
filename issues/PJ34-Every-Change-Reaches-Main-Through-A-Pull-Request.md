# PJ34 — Every change reaches main through a pull request

```json
{
  "$schema": "issue-1.json",
  "id": "PJ34",
  "title": "Every change reaches main through a pull request",
  "state": "Accepted",
  "size": "-",
  "priority": "Medium",
  "rank": 11,
  "blockedBy": [],
  "covers": "Every change reaches `main` through a pull request with green required checks, so `main` needs no bypass."
}
```

**What must be true.** Every change, the agents' and the operator's included, reaches `main` through a
pull request whose required checks are green, so `main` is protected with no bypass at all, and a
change from outside takes the same way as one from inside.
