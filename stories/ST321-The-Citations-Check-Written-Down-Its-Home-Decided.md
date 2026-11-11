# ST321 — The citations check written down, its home decided later

**Priority:** 🟰 Medium · **State:** Accepted

**What a user gains.** Every rule the citations check enforces today is written down in one place: what it refuses, why, and which repositories and gates run it. With that, how and where such checks are done later (in CI, as a clean-up task in the planner, or not at all) is decided knowingly. Until then no Build or push is held up by it.

**The test.** One issue lists each of the check's rules (exemptions, links to issue files, pointers to gone issues, numbers outside the issues, unlinked or rowless numbers, briefs, index anchors), with its reason and its callers in every repository's workflows and the push gate. The operator decides from that list how and where it is done.

**Issues:** none yet

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST321",
  "title": "The citations check written down, its home decided later",
  "gain": "Every rule the citations check enforces today is written down in one place: what it refuses, why, and which repositories and gates run it. With that, how and where such checks are done later (in CI, as a clean-up task in the planner, or not at all) is decided knowingly. Until then no Build or push is held up by it.",
  "test": "One issue lists each of the check's rules (exemptions, links to issue files, pointers to gone issues, numbers outside the issues, unlinked or rowless numbers, briefs, index anchors), with its reason and its callers in every repository's workflows and the push gate. The operator decides from that list how and where it is done.",
  "priority": "Medium",
  "state": "Accepted",
  "issues": [],
  "tested": null
}
```
