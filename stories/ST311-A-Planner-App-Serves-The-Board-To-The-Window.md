# ST311 — A planner app serves the board to the window

**Priority:** 🔼 High · **State:** Backlog

**What a user gains.** The window reads and changes stories and issues through porelo-planner, a Spring Boot GraalVM native app running beside it, over a REST API described in OpenAPI; the app reads and writes the stories and issues in Git, and porelo keeps only its task functions.

**The test.** Start porelo-planner on the computer the window runs on and open Planning: every story shows in its state's column by priority, a story and one of its issues open, a story moved and saved is in porelo-project's Git, a story put into a state its issues do not fit keeps that state after a warning naming those issues, and the OpenAPI description names every call the window makes.

**Issues:**

- [porelo-buildtools#BT46](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt46) (Review)
- [porelo-buildtools#BT54](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt54) (Review)
- [porelo-buildtools#BT55](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt55) (Review)
- [porelo-buildtools#BT56](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt56) (Rejected)
- [porelo-buildtools#BT59](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt59) (Rejected)
- [porelo#B566](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b566) (Review)
- [porelo-frontend#F446](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f446) (Review)
- [porelo-frontend#F447](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f447) (Review)
- [porelo-frontend#F448](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f448) (Review)
- [porelo-frontend#F449](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f449) (Review)
- [porelo-frontend#F467](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f467) (Rejected)
- [porelo-project#PJ104](https://github.com/porelo-ai/porelo-project/blob/main/issues/README.md#pj104) (Rejected)
- [porelo-project#PJ105](https://github.com/porelo-ai/porelo-project/blob/main/issues/README.md#pj105) (Review)
- [porelo#B604](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b604) (Review)
- [porelo-planner#PL01](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl01) (Finished)
- [porelo-planner#PL02](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl02) (Finished)
- [porelo-planner#PL03](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl03) (Finished)
- [porelo-planner#PL04](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl04) (Finished)
- [porelo-planner#PL05](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl05) (Finished)
- [porelo-planner#PL06](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl06) (Finished)
- [porelo-planner#PL07](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl07) (Finished)
- [porelo-planner#PL08](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl08) (Finished)
- [porelo-planner#PL09](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl09) (Finished)
- [porelo-planner#PL10](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl10) (Review)
- [porelo-planner#PL11](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl11) (Finished)
- [porelo-planner#PL12](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl12) (Review)
- [porelo-planner#PL16](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl16) (Finished)
- [porelo-frontend#F471](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f471) (Review)
- [porelo-buildtools#BT61](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt61) (Review)
- [porelo-buildtools#BT62](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt62) (Review)
- [porelo-planner#PL17](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl17) (Finished)
- [porelo-planner#PL18](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl18) (Finished)
- [porelo-planner#PL19](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl19) (Finished)
- [porelo-planner#PL20](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl20) (Finished)
- [porelo-planner#PL21](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl21) (Finished)
- [porelo-planner#PL22](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl22) (Rejected)
- [porelo-planner#PL23](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl23) (Finished)
- [porelo-planner#PL24](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl24) (Finished)
- [porelo-planner#PL25](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl25) (Review)
- [porelo-planner#PL26](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl26) (Review)
- [porelo-planner#PL27](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl27) (Review)
- [porelo-buildtools#BT68](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt68) (Review)
- [porelo-planner#PL87](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl87) (Backlog)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST311",
  "title": "A planner app serves the board to the window",
  "gain": "The window reads and changes stories and issues through porelo-planner, a Spring Boot GraalVM native app running beside it, over a REST API described in OpenAPI; the app reads and writes the stories and issues in Git, and porelo keeps only its task functions.",
  "test": "Start porelo-planner on the computer the window runs on and open Planning: every story shows in its state's column by priority, a story and one of its issues open, a story moved and saved is in porelo-project's Git, a story put into a state its issues do not fit keeps that state after a warning naming those issues, and the OpenAPI description names every call the window makes.",
  "priority": "High",
  "state": "Backlog",
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
    "porelo#B604",
    "porelo-planner#PL01",
    "porelo-planner#PL02",
    "porelo-planner#PL03",
    "porelo-planner#PL04",
    "porelo-planner#PL05",
    "porelo-planner#PL06",
    "porelo-planner#PL07",
    "porelo-planner#PL08",
    "porelo-planner#PL09",
    "porelo-planner#PL10",
    "porelo-planner#PL11",
    "porelo-planner#PL12",
    "porelo-planner#PL16",
    "porelo-frontend#F471",
    "porelo-buildtools#BT61",
    "porelo-buildtools#BT62",
    "porelo-planner#PL17",
    "porelo-planner#PL18",
    "porelo-planner#PL19",
    "porelo-planner#PL20",
    "porelo-planner#PL21",
    "porelo-planner#PL22",
    "porelo-planner#PL23",
    "porelo-planner#PL24",
    "porelo-planner#PL25",
    "porelo-planner#PL26",
    "porelo-planner#PL27",
    "porelo-buildtools#BT68",
    "porelo-planner#PL87"
  ],
  "tested": null
}
```
