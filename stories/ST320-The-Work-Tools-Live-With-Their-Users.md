# ST320 — The work tools live with their users

**Priority:** 🔼 High · **State:** Accepted

**What a user gains.** The issue and story tooling (stage records, stats, the stories and issues index, check-commits and citations) moves from the build tools to the planner, the native-image checks to Core, and dead release-plan code goes. Each part then lives with the agent who uses and changes it, so a change to the work format is made by its owner, not by Machines.

**The test.** Each moved part is built, published and used from its new home, and porelo-buildtools keeps only CI, machines, pins and publishing. Every repository's shared rules check still runs check-commits and check-citations green. A stage line and a planner board move are written and checked against the planner's format. No module or command is left that nobody calls.

**Issues:** none yet

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST320",
  "title": "The work tools live with their users",
  "gain": "The issue and story tooling (stage records, stats, the stories and issues index, check-commits and citations) moves from the build tools to the planner, the native-image checks to Core, and dead release-plan code goes. Each part then lives with the agent who uses and changes it, so a change to the work format is made by its owner, not by Machines.",
  "test": "Each moved part is built, published and used from its new home, and porelo-buildtools keeps only CI, machines, pins and publishing. Every repository's shared rules check still runs check-commits and check-citations green. A stage line and a planner board move are written and checked against the planner's format. No module or command is left that nobody calls.",
  "priority": "High",
  "state": "Accepted",
  "issues": [],
  "tested": null
}
```
