# ST377 — An idea discussed on a rented host comes through

**Priority:** 🔼 High · **State:** Backlog

**What a user gains.** A person who discusses an idea on a rented host that carries only some of the project's repositories starts the discussion without fixing anything on the host by hand, the agent sees no errors for repositories that are not there, and the idea it writes down is saved the first time.

**The test.** On a rented host that carries some of a project's repositories and has no mirror of the project's own repository, two discussions are started one after the other. Both start; the agent's output names the repositories left out in one line and holds no failed clone; the order names each repository's name and real folder; the idea the agent writes is saved as a story with its issues.

**Issues:**

- [porelo#B798](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b798) (Backlog)
- [porelo-planner#PL163](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl163) (Backlog)
- [porelo#B797](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b797) (Backlog)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST377",
  "title": "An idea discussed on a rented host comes through",
  "gain": "A person who discusses an idea on a rented host that carries only some of the project's repositories starts the discussion without fixing anything on the host by hand, the agent sees no errors for repositories that are not there, and the idea it writes down is saved the first time.",
  "test": "On a rented host that carries some of a project's repositories and has no mirror of the project's own repository, two discussions are started one after the other. Both start; the agent's output names the repositories left out in one line and holds no failed clone; the order names each repository's name and real folder; the idea the agent writes is saved as a story with its issues.",
  "tested": null,
  "priority": "High",
  "state": "Backlog",
  "issues": [
    "porelo#B798",
    "porelo-planner#PL163",
    "porelo#B797"
  ]
}
```
