# ST385 — Review in IntelliJ on Windows through WSL

**Priority:** 🔼 High · **State:** Review

**What a user gains.** A person on Windows whose Porelo runs in a WSL distribution reads and opens a waiting push from IntelliJ as on Linux, without changing their own git configuration.

**The test.** On Windows with Porelo in WSL, the person opens a push waiting at the gate from IntelliJ's review, reads its diff and opens it in a project; git raises no dubious-ownership refusal and the person's global git configuration is unchanged.

**Issues:**

- [porelo-intellij#IJ34](https://github.com/porelo-ai/porelo-intellij/blob/main/issues/README.md#ij34) (Review)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST385",
  "title": "Review in IntelliJ on Windows through WSL",
  "gain": "A person on Windows whose Porelo runs in a WSL distribution reads and opens a waiting push from IntelliJ as on Linux, without changing their own git configuration.",
  "test": "On Windows with Porelo in WSL, the person opens a push waiting at the gate from IntelliJ's review, reads its diff and opens it in a project; git raises no dubious-ownership refusal and the person's global git configuration is unchanged.",
  "priority": "High",
  "tested": null,
  "issues": [
    "porelo-intellij#IJ34"
  ]
}
```
