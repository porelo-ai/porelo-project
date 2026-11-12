# ST342 — The agents' own telemetry kept with Porelo's records

**Priority:** 🟰 Medium · **State:** Idea

**What a user gains.** The OpenTelemetry an agent writes itself (Claude Code, Codex, Gemini, omp natively, pi through an extension) is received inside Porelo on the person's machine and kept in the task's journal under its run, its content switches set off unless chosen, so a person reads tokens, tool calls and errors beside Porelo's own records and no agent sends telemetry anywhere else.

**The test.** Run a short task with each agent that can export: its spans, logs and metrics appear in the task's timeline under the right run, with the vendor's ids mapped and no token or cost counted twice; prompt and response content is absent until chosen; with the network to every other host closed, nothing leaves the machine.

**Issues:** none yet

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST342",
  "title": "The agents' own telemetry kept with Porelo's records",
  "gain": "The OpenTelemetry an agent writes itself (Claude Code, Codex, Gemini, omp natively, pi through an extension) is received inside Porelo on the person's machine and kept in the task's journal under its run, its content switches set off unless chosen, so a person reads tokens, tool calls and errors beside Porelo's own records and no agent sends telemetry anywhere else.",
  "test": "Run a short task with each agent that can export: its spans, logs and metrics appear in the task's timeline under the right run, with the vendor's ids mapped and no token or cost counted twice; prompt and response content is absent until chosen; with the network to every other host closed, nothing leaves the machine.",
  "priority": "Medium",
  "state": "Idea",
  "issues": [],
  "tested": null
}
```
