# ST321 — The citations check dropped

**Priority:** 🟰 Medium · **State:** Accepted

**What a user gains.** The citations check leaves every repository's build and the push gate: a wrong or dead reference in an issue or a document is a text problem, and no push is held up by it. porelo-buildtools drops the command and its exemption list, so nobody keeps a check that guards nothing a build needs.

**The test.** No workflow of any porelo repository and no push gate runs check-citations, and every repository's Build stays green through each step of the removal. porelo-buildtools has no check-citations command and no citations-exempt.txt. A push whose issue text names a missing issue goes through.

**Issues:** none yet

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST321",
  "title": "The citations check dropped",
  "gain": "The citations check leaves every repository's build and the push gate: a wrong or dead reference in an issue or a document is a text problem, and no push is held up by it. porelo-buildtools drops the command and its exemption list, so nobody keeps a check that guards nothing a build needs.",
  "test": "No workflow of any porelo repository and no push gate runs check-citations, and every repository's Build stays green through each step of the removal. porelo-buildtools has no check-citations command and no citations-exempt.txt. A push whose issue text names a missing issue goes through.",
  "priority": "Medium",
  "state": "Accepted",
  "issues": [],
  "tested": null
}
```
