# ST311 — A planner app serves the board to the window

**Priority:** 🔼 High · **State:** Idea

**What a user gains.** The window reads and changes stories and issues through porelo-planner, a Spring Boot GraalVM native app running beside it, over a REST API described in OpenAPI; the app reads and writes the stories and issues in Git, and porelo keeps only its task functions.

**The test.** Start porelo-planner on the computer the window runs on and open Planning: every story shows in its state's column by priority, a story and one of its issues open, a story moved and saved is in porelo-project's Git, and the OpenAPI description names every call the window makes.

**Issues:**

- [porelo-buildtools#BT46](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt46) (Review)
- [porelo-buildtools#BT54](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt54) (Review)
- [porelo-buildtools#BT55](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt55) (Review)
- [porelo-buildtools#BT56](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt56) (Analyzed)
- [porelo-buildtools#BT59](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt59) (Backlog)
- [porelo#B566](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b566) (Implementing)
- [porelo-frontend#F446](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f446) (Rework)
- [porelo-frontend#F447](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f447) (Rework)
- [porelo-frontend#F448](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f448) (Rework)
- [porelo-frontend#F449](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f449) (Rework)
- [porelo-frontend#F467](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f467) (Backlog)
- [porelo-project#PJ104](https://github.com/porelo-ai/porelo-project/blob/main/issues/README.md#pj104) (Accepted)
- [porelo-project#PJ105](https://github.com/porelo-ai/porelo-project/blob/main/issues/README.md#pj105) (Accepted)
- [porelo#B604](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b604) (Analyzed)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST311",
  "title": "A planner app serves the board to the window",
  "gain": "The window reads and changes stories and issues through porelo-planner, a Spring Boot GraalVM native app running beside it, over a REST API described in OpenAPI; the app reads and writes the stories and issues in Git, and porelo keeps only its task functions.",
  "test": "Start porelo-planner on the computer the window runs on and open Planning: every story shows in its state's column by priority, a story and one of its issues open, a story moved and saved is in porelo-project's Git, and the OpenAPI description names every call the window makes.",
  "priority": "High",
  "state": "Idea",
  "issues": [
    "porelo-buildtools#BT46",
    "porelo-buildtools#BT54",
    "porelo-buildtools#BT55",
    "porelo-buildtools#BT56",
    "porelo-buildtools#BT59",
    "porelo#B566",
    "porelo-frontend#F446",
    "porelo-frontend#F447",
    "porelo-frontend#F448",
    "porelo-frontend#F449",
    "porelo-frontend#F467",
    "porelo-project#PJ104",
    "porelo-project#PJ105",
    "porelo#B604"
  ],
  "tested": null
}
```
