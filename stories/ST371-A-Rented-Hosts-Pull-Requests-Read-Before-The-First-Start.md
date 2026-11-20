# ST371 — A rented host's pull requests read before the first start

**Priority:** 🔼 High · **State:** Implementing

**What a user gains.** A person whose project a rented host carries sees that project's open pull requests in Needs you before starting any work there, and where they cannot be read, is told the machine's reason instead of being told that it stopped answering.

**The test.** On a rented host that carries a project, with the forge token stored and no work started there yet: Needs you shows no 'cannot be read' item for the project, and an open pull request on the host's forge shows as waiting for the person's merge. A machine that refuses the watch is shown with its own reason and as Refused.

**Issues:**

- [porelo#B796](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b796) (Review)
- [porelo-frontend#F608](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f608) (Review)
- [porelo#B816](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b816) (Implementing)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST371",
  "title": "A rented host's pull requests read before the first start",
  "gain": "A person whose project a rented host carries sees that project's open pull requests in Needs you before starting any work there, and where they cannot be read, is told the machine's reason instead of being told that it stopped answering.",
  "test": "On a rented host that carries a project, with the forge token stored and no work started there yet: Needs you shows no 'cannot be read' item for the project, and an open pull request on the host's forge shows as waiting for the person's merge. A machine that refuses the watch is shown with its own reason and as Refused.",
  "tested": null,
  "priority": "High",
  "state": "Implementing",
  "issues": [
    "porelo#B796",
    "porelo-frontend#F608",
    "porelo#B816"
  ]
}
```
