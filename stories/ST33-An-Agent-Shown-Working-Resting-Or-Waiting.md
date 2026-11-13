# ST33 — An agent shown working, resting or waiting

**Priority:** 🟰 Medium · **State:** Backlog

**What a user gains.** A person sees in the command line and on the task card whether an agent is working, resting or waiting, and both agree.

**The test.** Attach to an agent, let it work, rest and wait, and compare the CLI with the task card. Both show the same state; rest must not appear as ongoing work. Check the Pi activity path too.

**Issues:**

- [porelo#B118](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b118) (Review)
- [porelo-frontend#F99](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f99) (Backlog)
- [porelo-pi#PI33](https://github.com/porelo-ai/porelo-pi/blob/main/issues/README.md#pi33) (Review)
- [porelo#B506](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b506) (Review)
- [porelo#B705](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b705) (Backlog)
- [porelo#B692](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b692) (Backlog)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST33",
  "title": "An agent shown working, resting or waiting",
  "gain": "A person sees in the command line and on the task card whether an agent is working, resting or waiting, and both agree.",
  "test": "Attach to an agent, let it work, rest and wait, and compare the CLI with the task card. Both show the same state; rest must not appear as ongoing work. Check the Pi activity path too.",
  "priority": "Medium",
  "issues": [
    "porelo#B118",
    "porelo-frontend#F99",
    "porelo-pi#PI33",
    "porelo#B506",
    "porelo#B705",
    "porelo#B692"
  ],
  "tested": null
}
```
