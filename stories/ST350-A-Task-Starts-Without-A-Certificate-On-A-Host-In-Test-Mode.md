# ST350 — A task starts without a certificate on a host in test mode

**Priority:** 🟰 Medium · **State:** Finished (2026-11-14)

**What a user gains.** A person on a measuring host whose root switched on test mode can start an uncertified task after a clear warning, and no other host accepts such a start.

**The test.** As root, set the test switch through the role on a measuring host; porelo task start warns and asks, and starts only after a yes or --yes; with the switch off, or taken away at down, the same start is refused.

**Issues:**

- [porelo#B717](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b717) (Finished)
- [porelo-host#HO187](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho187) (Finished)

## Notes

- Gathered on 2026-11-13 from issues that stood in no story, or moved out of a High story, by the operator's word.

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST350",
  "title": "A task starts without a certificate on a host in test mode",
  "gain": "A person on a measuring host whose root switched on test mode can start an uncertified task after a clear warning, and no other host accepts such a start.",
  "test": "As root, set the test switch through the role on a measuring host; porelo task start warns and asks, and starts only after a yes or --yes; with the switch off, or taken away at down, the same start is refused.",
  "priority": "Medium",
  "issues": [
    "porelo#B717",
    "porelo-host#HO187"
  ],
  "tested": "2026-11-14"
}
```
