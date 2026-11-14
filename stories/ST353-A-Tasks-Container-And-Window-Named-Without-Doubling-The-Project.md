# ST353 — A task's container and window named without doubling the project

**Priority:** 🟰 Medium · **State:** Accepted

**What a user gains.** A task's container is named porelo-pi, not porelo-porelo-pi, tasks made before keep working and projects do not clash, and a window going back into an existing task names its project and task.

**The test.** Start a task in project porelo: the container is porelo-pi; a task made before still starts and ends; the same task name in a second project does not clash; going back into the task, the window reads project/task.

**Issues:**

- [porelo#B538](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b538) (Backlog)
- [porelo#B608](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b608) (Accepted)

## Notes

- Gathered on 2026-11-13 from issues that stood in no story, or moved out of a High story, by the operator's word.

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST353",
  "title": "A task's container and window named without doubling the project",
  "gain": "A task's container is named porelo-pi, not porelo-porelo-pi, tasks made before keep working and projects do not clash, and a window going back into an existing task names its project and task.",
  "test": "Start a task in project porelo: the container is porelo-pi; a task made before still starts and ends; the same task name in a second project does not clash; going back into the task, the window reads project/task.",
  "priority": "Medium",
  "issues": [
    "porelo#B538",
    "porelo#B608"
  ],
  "tested": null
}
```
