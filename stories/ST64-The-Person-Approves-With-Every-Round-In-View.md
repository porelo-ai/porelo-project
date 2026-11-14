# ST64 — The person approves with every round in view

**Priority:** 🟰 Medium · **State:** Finished (2026-11-14)

**What a user gains.** A person approving at the gate or in the interface sees the diff with the latest findings and all the rounds that led to it.

**The test.** `porelo gate review` and the interface show the diff with the last findings and the rounds before it, compared by `baselineState`; a finding the agent marked suppressed still counts until a person clears it.

**Issues:**

- [porelo#B480](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b480) (Finished)
- [porelo#B482](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b482) (Finished)

## Notes

- findings shown at the gate in porelo and the interface (from PJ67)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST64",
  "title": "The person approves with every round in view",
  "gain": "A person approving at the gate or in the interface sees the diff with the latest findings and all the rounds that led to it.",
  "test": "`porelo gate review` and the interface show the diff with the last findings and the rounds before it, compared by `baselineState`; a finding the agent marked suppressed still counts until a person clears it.",
  "priority": "Medium",
  "state": "Finished",
  "issues": [
    "porelo#B480",
    "porelo#B482"
  ],
  "tested": "2026-11-14"
}
```
