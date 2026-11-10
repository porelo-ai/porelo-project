# ST26 — A changed collection refused

**Priority:** ⏫ Highest · **State:** Review

**What a user gains.** A host collection that has been changed after publishing is refused, so a person installs only what was actually released.

**The test.** Install the host collection through the interface, then offer a changed collection tarball with the original digest; installation is refused before its contents run.

**Issues:**

- [porelo-frontend#F137](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f137) (Review)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST26",
  "title": "A changed collection refused",
  "gain": "A host collection that has been changed after publishing is refused, so a person installs only what was actually released.",
  "test": "Install the host collection through the interface, then offer a changed collection tarball with the original digest; installation is refused before its contents run.",
  "priority": "Highest",
  "issues": [
    "porelo-frontend#F137"
  ],
  "tested": null
}
```
