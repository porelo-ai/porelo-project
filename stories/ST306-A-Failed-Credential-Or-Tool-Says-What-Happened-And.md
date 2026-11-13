# ST306 — A failed credential or tool says what happened and what to do

**Priority:** 🟰 Medium · **State:** Backlog

**What a user gains.** When a credential or a required tool fails, porelo says which one, what happened and what the person can do, instead of a bare failure.

**The test.** Refuse a push for a missing credential, start with an expired one and run with an OpenSSH below the floor: each failure names the credential or tool and the step that helps.

**Issues:**

- [porelo#B440](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b440) (Review)
- [porelo#B458](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b458) (Backlog)
- [porelo#B459](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b459) (Implementing)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST306",
  "title": "A failed credential or tool says what happened and what to do",
  "gain": "When a credential or a required tool fails, porelo says which one, what happened and what the person can do, instead of a bare failure.",
  "test": "Refuse a push for a missing credential, start with an expired one and run with an OpenSSH below the floor: each failure names the credential or tool and the step that helps.",
  "priority": "Medium",
  "issues": [
    "porelo#B440",
    "porelo#B458",
    "porelo#B459"
  ],
  "tested": null
}
```
