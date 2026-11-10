# ST309 — A story takes the state the operator gives it

**Priority:** 🔼 High · **State:** Backlog

**What a user gains.** The operator puts a story into any state, on the story board or in its head, and it keeps that state whatever its issues' states are; where an issue does not fit that state by the automatic rule, a warning names it and asks to go on anyway, and it is never refused.

**The test.** Set ST25 to Backlog while one of its issues is Implementing and one Finished: the index keeps Backlog and warns about the issues that do not fit; a story with no state set still takes the earliest open state of its issues.

**Issues:**

- [porelo-buildtools#BT60](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt60) (Review)
- [porelo#B603](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b603) (Rejected)
- [porelo-frontend#F470](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f470) (Backlog)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST309",
  "title": "A story takes the state the operator gives it",
  "gain": "The operator puts a story into any state, on the story board or in its head, and it keeps that state whatever its issues' states are; where an issue does not fit that state by the automatic rule, a warning names it and asks to go on anyway, and it is never refused.",
  "test": "Set ST25 to Backlog while one of its issues is Implementing and one Finished: the index keeps Backlog and warns about the issues that do not fit; a story with no state set still takes the earliest open state of its issues.",
  "priority": "High",
  "issues": [
    "porelo-buildtools#BT60",
    "porelo#B603",
    "porelo-frontend#F470"
  ],
  "tested": null
}
```
