# ST355 — Snapshots and keys kept tidy

**Priority:** 🟰 Medium · **State:** Backlog

**What a user gains.** A new CI snapshot removes the older ones of its system and keeps one before it, the agent repositories read only their own groups' snapshots, a kept start that never ran keeps its caller's key across a reboot, and an allowed-signers file that is not valid UTF-8 is read line by line instead of refused whole.

**The test.** After a new snapshot only it and the one before remain, each deletion said; an agent repository's build runs the snapshot filter; a --keep start that never ran finds its key after a reboot; a signers file with one invalid byte still gives its other lines.

**Issues:**

- [porelo-buildtools#BT03](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt03) (Review)
- [porelo-buildtools#BT48](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt48) (Backlog)
- [porelo#B680](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b680) (Backlog)
- [porelo#B711](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b711) (Backlog)

## Notes

- Gathered on 2026-11-13 from issues that stood in no story, or moved out of a High story, by the operator's word.

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST355",
  "title": "Snapshots and keys kept tidy",
  "gain": "A new CI snapshot removes the older ones of its system and keeps one before it, the agent repositories read only their own groups' snapshots, a kept start that never ran keeps its caller's key across a reboot, and an allowed-signers file that is not valid UTF-8 is read line by line instead of refused whole.",
  "test": "After a new snapshot only it and the one before remain, each deletion said; an agent repository's build runs the snapshot filter; a --keep start that never ran finds its key after a reboot; a signers file with one invalid byte still gives its other lines.",
  "priority": "Medium",
  "issues": [
    "porelo-buildtools#BT03",
    "porelo-buildtools#BT48",
    "porelo#B680",
    "porelo#B711"
  ],
  "tested": null
}
```
