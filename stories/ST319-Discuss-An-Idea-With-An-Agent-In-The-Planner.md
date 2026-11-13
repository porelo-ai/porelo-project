# ST319 — Discuss an idea with an agent in the planner

**Priority:** 🔼 High · **State:** Implementing

**What a user gains.** "Discuss an idea" in the planner starts, through the usual Start dialog, a task that reads all of the project's repositories as one. The person discusses the idea with its agent, who writes it to a file. When the task ends, the path returns to the planner, which makes a story in Idea with sub-issues per repository; the task's staged changes are dropped, and the next stage's agents start on them.

**The test.** Click Discuss an idea, pick an agent and start: the task can read every repository of the project. Discuss an idea and let the agent write it. End the task: the planner shows a new story in Idea, with its gain, test and one issue per repository named, and the task's changes reach no repository. Move the story on: each issue's agent starts on its issue.

**Issues:**

- [porelo-project#PJ58](https://github.com/porelo-ai/porelo-project/blob/main/issues/README.md#pj58) (Rejected)
- [porelo-planner#PL57](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl57) (Finished)
- [porelo-planner#PL58](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl58) (Review)
- [porelo-frontend#F487](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f487) (Review)
- [porelo-frontend#F488](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f488) (Review)
- [porelo-planner#PL46](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl46) (Finished)
- [porelo-planner#PL41](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl41) (Finished)
- [porelo-planner#PL67](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl67) (Review)
- [porelo#B619](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b619) (Review)
- [porelo#B631](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b631) (Review)
- [porelo#B634](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b634) (Review)
- [porelo#B639](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b639) (Review)
- [porelo#B668](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b668) (Review)
- [porelo-frontend#F503](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f503) (Backlog)
- [porelo-planner#PL96](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl96) (Review)
- [porelo-frontend#F532](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f532) (Review)
- [porelo#B709](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b709) (Review)
- [porelo-frontend#F535](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f535) (Review)
- [porelo-frontend#F537](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f537) (Backlog)
- [porelo#B725](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b725) (Review)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST319",
  "title": "Discuss an idea with an agent in the planner",
  "gain": "\"Discuss an idea\" in the planner starts, through the usual Start dialog, a task that reads all of the project's repositories as one. The person discusses the idea with its agent, who writes it to a file. When the task ends, the path returns to the planner, which makes a story in Idea with sub-issues per repository; the task's staged changes are dropped, and the next stage's agents start on them.",
  "test": "Click Discuss an idea, pick an agent and start: the task can read every repository of the project. Discuss an idea and let the agent write it. End the task: the planner shows a new story in Idea, with its gain, test and one issue per repository named, and the task's changes reach no repository. Move the story on: each issue's agent starts on its issue.",
  "priority": "High",
  "state": "Implementing",
  "issues": [
    "porelo-project#PJ58",
    "porelo-planner#PL57",
    "porelo-planner#PL58",
    "porelo-frontend#F487",
    "porelo-frontend#F488",
    "porelo-planner#PL46",
    "porelo-planner#PL41",
    "porelo-planner#PL67",
    "porelo#B619",
    "porelo#B631",
    "porelo#B634",
    "porelo#B639",
    "porelo#B668",
    "porelo-frontend#F503",
    "porelo-planner#PL96",
    "porelo-frontend#F532",
    "porelo#B709",
    "porelo-frontend#F535",
    "porelo-frontend#F537",
    "porelo#B725"
  ],
  "tested": null
}
```
