# ST319 — Discuss an idea with an agent in the planner

**Priority:** 🟰 Medium · **State:** Implementing

**What a user gains.** "Discuss an idea" in the planner starts, through the usual Start dialog, a task that reads all of the project's repositories as one. The person discusses the idea with its agent, who writes it to a file. When the task ends, the path returns to the planner, which makes a story in Idea with sub-issues per repository; the task's staged changes are dropped, and the next stage's agents start on them.

**The test.** Click Discuss an idea, pick an agent and start: the task can read every repository of the project. Discuss an idea and let the agent write it. End the task: the planner shows a new story in Idea, with its gain, test and one issue per repository named, and the task's changes reach no repository. Move the story on: each issue's agent starts on its issue.

**Issues:**

- [porelo-host#HO170](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho170) (Implementing)
- [porelo#B620](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b620) (Implementing)
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
- [porelo#B635](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b635) (Backlog)
- [porelo#B639](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b639) (Review)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST319",
  "title": "Discuss an idea with an agent in the planner",
  "gain": "\"Discuss an idea\" in the planner starts, through the usual Start dialog, a task that reads all of the project's repositories as one. The person discusses the idea with its agent, who writes it to a file. When the task ends, the path returns to the planner, which makes a story in Idea with sub-issues per repository; the task's staged changes are dropped, and the next stage's agents start on them.",
  "test": "Click Discuss an idea, pick an agent and start: the task can read every repository of the project. Discuss an idea and let the agent write it. End the task: the planner shows a new story in Idea, with its gain, test and one issue per repository named, and the task's changes reach no repository. Move the story on: each issue's agent starts on its issue.",
  "priority": "Medium",
  "state": "Implementing",
  "issues": [
    "porelo-host#HO170",
    "porelo#B620",
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
    "porelo#B635",
    "porelo#B639"
  ],
  "tested": null
}
```
