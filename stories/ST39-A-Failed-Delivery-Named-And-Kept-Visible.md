# ST39 — A failed delivery named and kept visible

**Priority:** 🔼 High · **State:** Finished (2026-11-14)

**What a user gains.** When a delivery to the forge fails, a person gets a named reason within a short time and the failure stays visible rather than disappearing.

**The test.** Make the forge stop answering and trigger other delivery refusals. Each answer ends within the configured bound with a distinct reason code; the error remains visible. The card names its repository, and a project push made by the person is picked up.

**Issues:**

- [porelo#B179](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b179) (Finished)
- [porelo#B197](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b197) (Finished)
- [porelo-frontend#F117](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f117) (Finished)
- [porelo#B714](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b714) (Finished)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST39",
  "title": "A failed delivery named and kept visible",
  "gain": "When a delivery to the forge fails, a person gets a named reason within a short time and the failure stays visible rather than disappearing.",
  "test": "Make the forge stop answering and trigger other delivery refusals. Each answer ends within the configured bound with a distinct reason code; the error remains visible. The card names its repository, and a project push made by the person is picked up.",
  "priority": "High",
  "state": "Finished",
  "issues": [
    "porelo#B179",
    "porelo#B197",
    "porelo-frontend#F117",
    "porelo#B714"
  ],
  "tested": "2026-11-14"
}
```
