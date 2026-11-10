# ST293 — Move: Every agent works in a Porelo task, moved one at a time

**Priority:** ⏫ Highest · **State:** Analyzed

**What a user gains.** Each agent of the project works in a Porelo task on the host, moved one at a time in a fixed order, each move checked before the next, all of them in the project's room.

**The test.** Every agent's move story is accepted in the order of doc/moving-an-agent.md; after the last move every agent answers in the project's room from its task and none works outside one.

**Issues:**

- [porelo-message-matrix#MX82](https://github.com/porelo-ai/porelo-message-matrix/blob/main/issues/README.md#mx82) (Analyzed)
- [porelo-host#HO132](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho132) (Review)
- [porelo-host#HO138](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho138) (Review)
- [porelo-host#HO141](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho141) (Review)
- [porelo-host#HO148](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho148) (Review)
- [porelo-message-matrix#MX81](https://github.com/porelo-ai/porelo-message-matrix/blob/main/issues/README.md#mx81) (Review)
- [porelo-message-matrix#MX84](https://github.com/porelo-ai/porelo-message-matrix/blob/main/issues/README.md#mx84) (Review)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST293",
  "title": "Move: Every agent works in a Porelo task, moved one at a time",
  "gain": "Each agent of the project works in a Porelo task on the host, moved one at a time in a fixed order, each move checked before the next, all of them in the project's room.",
  "test": "Every agent's move story is accepted in the order of doc/moving-an-agent.md; after the last move every agent answers in the project's room from its task and none works outside one.",
  "priority": "Highest",
  "issues": [
    "porelo-message-matrix#MX82",
    "porelo-host#HO132",
    "porelo-host#HO138",
    "porelo-host#HO141",
    "porelo-host#HO148",
    "porelo-message-matrix#MX81",
    "porelo-message-matrix#MX84"
  ],
  "tested": null
}
```
