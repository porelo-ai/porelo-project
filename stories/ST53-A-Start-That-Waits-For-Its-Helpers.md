# ST53 — A start that waits for its helpers

**Priority:** 🔼 High · **State:** Backlog

**What a user gains.** A start waits until both the gate and the relay are up, and ends with a clear code if either does not come up.

**The test.** A start whose gate or relay does not come up ends with a code; a start waits for both; two starts of one name never stop each other's task.

**Issues:**

- [porelo#B384](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b384) (Review)
- [porelo#B730](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b730) (Review)
- [porelo#B728](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b728) (Review)
- [porelo#B699](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b699) (Review)
- [porelo#B698](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b698) (Review)
- [porelo#B697](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b697) (Review)
- [porelo#B694](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b694) (Review)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST53",
  "title": "A start that waits for its helpers",
  "gain": "A start waits until both the gate and the relay are up, and ends with a clear code if either does not come up.",
  "test": "A start whose gate or relay does not come up ends with a code; a start waits for both; two starts of one name never stop each other's task.",
  "priority": "High",
  "state": "Backlog",
  "issues": [
    "porelo#B384",
    "porelo#B730",
    "porelo#B728",
    "porelo#B699",
    "porelo#B698",
    "porelo#B697",
    "porelo#B694"
  ],
  "tested": null
}
```
