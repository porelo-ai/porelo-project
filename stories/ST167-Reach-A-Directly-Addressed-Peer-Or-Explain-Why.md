# ST167 — Reach a directly addressed peer or explain why not

**Priority:** 🔽 Low · **State:** Idea

**What a user gains.** A message to a directly addressed peer arrives, or the sender is told plainly why it cannot.

**The test.** Send to a peer with a valid direct transport address. Remove the required account and start or send again; the operation is refused with the missing requirement named rather than silently losing the message.

**Issues:**

- [porelo#B257](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b257) (Idea)
- [porelo-message-matrix#MX100](https://github.com/porelo-ai/porelo-message-matrix/blob/main/issues/README.md#mx100) (Review)
- [porelo-message-matrix#MX98](https://github.com/porelo-ai/porelo-message-matrix/blob/main/issues/README.md#mx98) (Review)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST167",
  "title": "Reach a directly addressed peer or explain why not",
  "gain": "A message to a directly addressed peer arrives, or the sender is told plainly why it cannot.",
  "test": "Send to a peer with a valid direct transport address. Remove the required account and start or send again; the operation is refused with the missing requirement named rather than silently losing the message.",
  "priority": "Low",
  "issues": [
    "porelo#B257",
    "porelo-message-matrix#MX100",
    "porelo-message-matrix#MX98"
  ],
  "tested": null
}
```
