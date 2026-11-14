# ST100 — Check allowed destinations

**Priority:** 🔼 High · **State:** Finished (2026-11-14)

**What a user gains.** A person sees whether the machine can check allowed destinations, and a task reaches only the addresses, domains and sets its project allows.

**The test.** Read resolver capability in doctor. Start a project with addresses, domains and sets. Reach an allowed destination; an unallowed one fails and is shown as refused. Allow a CNAME while the task runs; it becomes reachable. An incomplete set must not appear complete.

**Issues:**

- [porelo#B237](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b237) (Finished)
- [porelo#B502](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b502) (Finished)
- [porelo#B706](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b706) (Finished)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST100",
  "title": "Check allowed destinations",
  "gain": "A person sees whether the machine can check allowed destinations, and a task reaches only the addresses, domains and sets its project allows.",
  "test": "Read resolver capability in doctor. Start a project with addresses, domains and sets. Reach an allowed destination; an unallowed one fails and is shown as refused. Allow a CNAME while the task runs; it becomes reachable. An incomplete set must not appear complete.",
  "priority": "High",
  "issues": [
    "porelo#B237",
    "porelo#B502",
    "porelo#B706"
  ],
  "tested": "2026-11-14"
}
```
