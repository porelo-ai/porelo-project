# ST341 — A task's records reach a collector over OpenTelemetry

**Priority:** 🟰 Medium · **State:** Idea

**What a user gains.** An organization's OpenTelemetry collector receives its people's task records, read from the local journal, never instead of it: off by default, chosen per kind of record and destination in the CLI, only allowed fields leave, so prompts, tool output and agent output stay home unless chosen and secrets never leave; a failed export never blocks a task and is shown.

**The test.** With a local collector, run a task exporting lifecycle and numbers only: log records carry porelo.task.id, porelo.run.id, sequence and kind, and no prompt, tool output or secret. Stop the collector mid-run: the task ends, the journal is whole, the CLI names the gap, and after restart the export resumes without duplicates.

**Issues:**

- [porelo#B516](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b516) (Idea)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST341",
  "title": "A task's records reach a collector over OpenTelemetry",
  "gain": "An organization's OpenTelemetry collector receives its people's task records, read from the local journal, never instead of it: off by default, chosen per kind of record and destination in the CLI, only allowed fields leave, so prompts, tool output and agent output stay home unless chosen and secrets never leave; a failed export never blocks a task and is shown.",
  "test": "With a local collector, run a task exporting lifecycle and numbers only: log records carry porelo.task.id, porelo.run.id, sequence and kind, and no prompt, tool output or secret. Stop the collector mid-run: the task ends, the journal is whole, the CLI names the gap, and after restart the export resumes without duplicates.",
  "priority": "Medium",
  "issues": [
    "porelo#B516"
  ],
  "tested": null
}
```
