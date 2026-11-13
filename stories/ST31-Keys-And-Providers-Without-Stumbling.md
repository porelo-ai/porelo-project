# ST31 — Keys and providers without stumbling

**Priority:** 🔼 High · **State:** Backlog

**What a user gains.** A person can paste a key into vault put and have it read whole, and an agent given an unknown provider is refused with a clear message.

**The test.** A key pasted at `vault put` is read whole; an agent given a provider it does not know is refused before the start.

**Issues:**

- [porelo#B228](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b228) (Backlog)
- [porelo#P09](https://github.com/porelo-ai/porelo/blob/main/issues/providers/README.md#p09) (Backlog)
- [porelo#B316](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b316) (Backlog)
- [porelo#B686](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b686) (Backlog)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST31",
  "title": "Keys and providers without stumbling",
  "gain": "A person can paste a key into vault put and have it read whole, and an agent given an unknown provider is refused with a clear message.",
  "test": "A key pasted at `vault put` is read whole; an agent given a provider it does not know is refused before the start.",
  "priority": "High",
  "issues": [
    "porelo#B228",
    "porelo#P09",
    "porelo#B316",
    "porelo#B686"
  ],
  "tested": null
}
```
