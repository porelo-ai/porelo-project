# ST22 — Machines asked for by kind only

**Priority:** ⏫ Highest · **State:** Idea

**What a user gains.** Machines are requested only by kind, so a call naming a specific provider or server type is refused with a message naming the kind to use.

**The test.** A call to `porelo-machines` naming a provider or a server type is refused, naming the kind to ask for; no workflow or build file of any repository names one.

**Issues:**

- [porelo-buildtools#BT25](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt25) (Review)
- [porelo#B667](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b667) (Idea)
- [porelo-buildtools#BT83](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt83) (Analyzed)

## Notes

- removing BT25's compatible provider call in porelo-buildtools, after every repository's PJ60 issue

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST22",
  "title": "Machines asked for by kind only",
  "gain": "Machines are requested only by kind, so a call naming a specific provider or server type is refused with a message naming the kind to use.",
  "test": "A call to `porelo-machines` naming a provider or a server type is refused, naming the kind to ask for; no workflow or build file of any repository names one.",
  "priority": "Highest",
  "issues": [
    "porelo-buildtools#BT25",
    "porelo#B667",
    "porelo-buildtools#BT83"
  ],
  "tested": null
}
```
