# PJ86 — A hard bound on the agents a task starts

**Status:** Idea.

**What must be true.** The number of agents a task runs at once is bounded by Porelo itself, not only by the agent
CLI's own switch: an agent that starts another copy of itself through its shell, as `claude -p` or `codex exec`,
counts against the same bound, and a task that reaches it is refused the next agent, with the bound named.

## Why

The agent interface's subagent limit (default none, operator 2026-10-31) is carried out by each adapter through the
CLI's own switch: a denied tool, a disabled feature or a hook. These govern only the CLI's built-in subagents. Every
agent has a shell and can start itself again, so the switch is soft. A hard bound would sit where Porelo holds the
task: a process limit in the task's container, or a cap on concurrent requests at the provider proxy.

Agent Smith's survey of the five CLIs: `~/.porelo/handover/porelo-claude-code/subagent-limit-survey.md`.
