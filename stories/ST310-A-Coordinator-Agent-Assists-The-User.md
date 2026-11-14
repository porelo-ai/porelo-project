# ST310 — A coordinator agent assists the user

**Priority:** 🟰 Medium · **State:** Backlog

**What a user gains.** While agents work on a project's stories, one coordinator agent oversees the story, the tasks' progress and the findings, and is the user's one session to talk to across repositories; it starts and stops nothing itself.

**The test.** Start work on a story: the coordinator starts with the first participant, is told of each story and state change, answers about the work, cannot start or stop a task, and stops after the last participant.

**Issues:**

- [porelo#B568](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b568) (Backlog)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST310",
  "title": "A coordinator agent assists the user",
  "gain": "While agents work on a project's stories, one coordinator agent oversees the story, the tasks' progress and the findings, and is the user's one session to talk to across repositories; it starts and stops nothing itself.",
  "test": "Start work on a story: the coordinator starts with the first participant, is told of each story and state change, answers about the work, cannot start or stop a task, and stops after the last participant.",
  "priority": "Medium",
  "issues": [
    "porelo#B568"
  ],
  "tested": null
}
```
