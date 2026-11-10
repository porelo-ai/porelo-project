# PJ103 — The Coordinator Works From A Task

```json
{
  "$schema": "issue-1.json",
  "id": "PJ103",
  "title": "The Coordinator Works From A Task",
  "state": "Idea",
  "size": "-",
  "priority": "Medium",
  "rank": 1,
  "blockedBy": [],
  "covers": "The coordinator runs in a task like every agent, mostly without a shell: it starts, follows and stops the tasks it started through an MCP endpoint Porelo offers, within limits the signed project file sets."
}
```

**What must be true.** The coordinator runs in a Porelo task like every other agent, with no shell for its ordinary
work, and still does everything its role needs: it starts a task per issue and phase, follows and stops the tasks it
started, reads every repository, talks with the agents and the person in the project's room, and hands work out only
through the gate.

## Why

Today the coordinator is a session on the person's own computer with a shell, a set of scripts of its own and the
person's ssh agent. Agents are to work in tasks, mostly without a shell, each task doing one thing: filing an issue as
an Idea, or taking an issue to its next state. Someone has to start those tasks, see them end and stop one that runs
past its time. Starting, listing and stopping tasks exist in Porelo already; what is missing is a way for an agent
inside a task to use them, within limits it cannot widen itself.

## The shape

- **Porelo offers a task an MCP endpoint**, on loopback as the gate is reached, backed by the daemon's existing
  methods: start a task (repository, issue, phase, agent, minutes), list tasks, a task's state and its protocol, stop a
  task. The endpoint keeps no rules of its own; every refusal is the daemon's. Built in `porelo` as
  [B507](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b507) (Analyzed, L): served in the person's own
  account with no root, a `porelo task serve-mcp` process per allowed task bound to loopback like the gate, calling
  `porelod`, a systemd user unit, over the user's own varlink socket.
- **Only a task the signed project file allows gets it**, and the same file sets its limits: how many tasks at once,
  the longest time a task may run, which agents and models it may start. The coordinator cannot widen them, since it
  cannot sign the file.
- **Decided by the operator (2026-11-08):** within those limits the coordinator starts tasks without asking; it stops
  only tasks it started itself, and stopping everything stays the person's.
- **A task started this way names where it came from**, the starting task, in the event journal and in the window.
- **Work still leaves only through the gate**, on the person's approval, and the conversation runs in the project's
  room.
- **Reading every repository** is [PJ58](README.md#pj58)'s `porelo-all`.

Each part the coordinator does today is placed in one of: a Porelo function, the host, a script in a repository, or
dropped. The list is made when this issue is analyzed, from the coordinator's present work: waking agents in the room,
pushing, reading builds and job logs, the state table and velocity, cleaning up machines, memory across sessions.

## Acceptance

- A coordinator task starts a task for an issue and phase, sees it end, and stops one it started; a start past the
  project file's limits, and a stop of a task it did not start, are refused by the daemon with their reasons.
- A task the project file does not allow has no such endpoint.
- Every start and stop stands in the event journal with the task that asked for it.

## To be checked

- How a harness without MCP (pi, omp) reaches the same methods.
