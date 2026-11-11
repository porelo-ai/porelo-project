# ST319 — Discuss an idea with an agent in the planner

**Priority:** 🟰 Medium · **State:** Backlog

**What a user gains.** "Discuss an idea" in the planner starts, through the usual Start dialog, a task that reads all of the project's repositories as one. The person discusses the idea with its agent, who writes it to a file. When the task ends, the path returns to the planner, which makes a story in Idea with sub-issues per repository; the task's staged changes are dropped, and the next stage's agents start on them.

**The test.** Click Discuss an idea, pick an agent and start: the task can read every repository of the project. Discuss an idea and let the agent write it. End the task: the planner shows a new story in Idea, with its gain, test and one issue per repository named, and the task's changes reach no repository. Move the story on: each issue's agent starts on its issue.

**Issues:**

- [porelo-project#PJ58](https://github.com/porelo-ai/porelo-project/blob/main/issues/README.md#pj58) (Analyzed)
- [porelo-planner#PL57](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl57) (Idea)
- [porelo-planner#PL58](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl58) (Idea)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST319",
  "title": "Discuss an idea with an agent in the planner",
  "gain": "\"Discuss an idea\" in the planner starts, through the usual Start dialog, a task that reads all of the project's repositories as one. The person discusses the idea with its agent, who writes it to a file. When the task ends, the path returns to the planner, which makes a story in Idea with sub-issues per repository; the task's staged changes are dropped, and the next stage's agents start on them.",
  "test": "Click Discuss an idea, pick an agent and start: the task can read every repository of the project. Discuss an idea and let the agent write it. End the task: the planner shows a new story in Idea, with its gain, test and one issue per repository named, and the task's changes reach no repository. Move the story on: each issue's agent starts on its issue.",
  "priority": "Medium",
  "state": "Backlog",
  "issues": [
    "porelo-project#PJ58",
    "porelo-planner#PL57",
    "porelo-planner#PL58"
  ],
  "tested": null
}
```
