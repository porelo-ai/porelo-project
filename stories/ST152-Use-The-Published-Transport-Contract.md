# ST152 — Use the published transport contract

**Priority:** 🔽 Low · **State:** Estimated

**What a user gains.** A developer can build a transport against only the published API and wire libraries and use a stub to pass messages between tasks.

**The test.** Build the stub against only the API and wire libraries and transfer a message between tasks. Offer an unknown protocol version; it is refused by name before use.

**Issues:**

- [porelo#B123](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b123) (Estimated)
- [porelo#B559](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b559) (Backlog)
- [porelo#B509](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b509) (Review)
- [porelo#B510](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b510) (Review)

## Notes

- Publish The Transport Contract; Provide A Stub Transport. This parent also covers sprints 5 and 6.

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST152",
  "title": "Use the published transport contract",
  "gain": "A developer can build a transport against only the published API and wire libraries and use a stub to pass messages between tasks.",
  "test": "Build the stub against only the API and wire libraries and transfer a message between tasks. Offer an unknown protocol version; it is refused by name before use.",
  "priority": "Low",
  "issues": [
    "porelo#B123",
    "porelo#B559",
    "porelo#B509",
    "porelo#B510"
  ],
  "tested": null
}
```
