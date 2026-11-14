# ST104 — Keep accounts and projects apart

**Priority:** 🔼 High · **State:** Backlog

**What a user gains.** Accounts and projects stay apart, so a transport reaches only a declared destination and one project cannot reach another's.

**The test.** Run a transport against a declared and an undeclared destination; only the first works. Try reading Porelo data and review directories as a second account; access fails. Use project/task pairs a-b/c and a/b-c; state and credentials stay separate. Change PATH; privileged hooks still use their fixed programs.

**Issues:**

- [porelo#B199](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b199) (Review)
- [porelo#B50](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b50) (Review)
- [porelo#B246](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b246) (Review)
- [porelo-host#HO188](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho188) (Review)
- [porelo#B735](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b735) (Review)
- [porelo#B741](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b741) (Backlog)
- [porelo#B742](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b742) (Review)
- [porelo#B743](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b743) (Backlog)

## Notes

- The move acceptance in release 0.6 must be complete before this sprint starts.

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST104",
  "title": "Keep accounts and projects apart",
  "gain": "Accounts and projects stay apart, so a transport reaches only a declared destination and one project cannot reach another's.",
  "test": "Run a transport against a declared and an undeclared destination; only the first works. Try reading Porelo data and review directories as a second account; access fails. Use project/task pairs a-b/c and a/b-c; state and credentials stay separate. Change PATH; privileged hooks still use their fixed programs.",
  "priority": "High",
  "issues": [
    "porelo#B199",
    "porelo#B50",
    "porelo#B246",
    "porelo-host#HO188",
    "porelo#B735",
    "porelo#B741",
    "porelo#B742",
    "porelo#B743"
  ],
  "tested": null
}
```
