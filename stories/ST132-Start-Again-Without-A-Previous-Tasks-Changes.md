# ST132 — Start again without a previous task's changes

**Priority:** 🟰 Medium · **State:** Accepted

**What a user gains.** A new task starts clean, inheriting none of an earlier task's Pi settings, extensions or PATH changes.

**The test.** Change Pi settings, extensions and PATH in a task; a new task inherits none of them. Make a continuation fail without a session identifier. The recorded session is discarded and the next start says it is fresh.

**Issues:**

- [porelo-pi#PI37](https://github.com/porelo-ai/porelo-pi/blob/main/issues/README.md#pi37) (Analyzed)
- [porelo#B282](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b282) (Accepted)
- [porelo-pi#PI46](https://github.com/porelo-ai/porelo-pi/blob/main/issues/README.md#pi46) (Review)
- [porelo#B703](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b703) (Backlog)
- [porelo#B691](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b691) (Review)
- [porelo#B690](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b690) (Review)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST132",
  "title": "Start again without a previous task's changes",
  "gain": "A new task starts clean, inheriting none of an earlier task's Pi settings, extensions or PATH changes.",
  "test": "Change Pi settings, extensions and PATH in a task; a new task inherits none of them. Make a continuation fail without a session identifier. The recorded session is discarded and the next start says it is fresh.",
  "priority": "Medium",
  "issues": [
    "porelo-pi#PI37",
    "porelo#B282",
    "porelo-pi#PI46",
    "porelo#B703",
    "porelo#B691",
    "porelo#B690"
  ],
  "tested": null
}
```
