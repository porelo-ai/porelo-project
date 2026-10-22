# PJ59 — Each agent moves into a Porelo task

**Status:** Accepted.

**What must be true.** Each agent of the project works in a Porelo task of the project `porelo`, one agent at a time,
in a fixed order, and each move is checked before the next begins; the channel file stays beside Matrix until the last
agent has moved.

From [PJ39](README.md#pj39), phase 5: "The move, one agent at a time, the others working as today and the channel kept
beside Matrix until the last has moved".

## Why

Phases 1 to 4 give the host, the local forge and the room. Nothing moves an agent by itself: each one has its own
repositories, toolchain, VM account and habits, and a fault found in the first move must be fixed before the next.

## The shape proposed

**The order:**

1. **Agent Sluice** first: one repository, one snapshot from the registry.
2. **Agent Smith:** snapshots from `porelo`, three repositories.
3. **Agent AGY and Agent Codex:** an adapter repository each, shaped like Smith's.
4. **Agent Matrix.**
5. **Agent IntelliJ and Agent Frontend:** other toolchains.
6. **Agent Core**, last of the builders, with a way back to the host, since a fault in Porelo stops its own work.
7. **The coordinator** last of all, in [PJ58](README.md#pj58)'s `porelo-all`.

**Each move is done when:**

- the agent's task follows its repositories through the gate, its pushes reach the local Forgejo, and it reads its
  builds through the `forgejo` reader;
- its move issue is taken from start to Review inside the task, with the local forge's build green: each move
  has a small issue (S) of its own in the agent's repository, filed when the move begins, and the agent works it
  inside the new task to show the move done;
- the agent is reached in the room and asks the operator in the operator's own channel;
- its session on the host and its VM account are no longer used.

**A moved agent runs attended in its task:** Porelo wakes an agent resting at its prompt when a message names it,
as the channel's watcher wakes it today; an unattended run that has ended has no terminal to wake. Only an agent whose
definition declares both its resting and its waiting screen is woken; Pi's does not yet, so a Pi in a task is woken
only after porelo-pi [PI32](https://github.com/porelo-ai/porelo-pi/blob/main/issues/README.md#pi32) and
[PI33](https://github.com/porelo-ai/porelo-pi/blob/main/issues/README.md#pi33).

**Before the first move:** porelo-claude-code
[CC24](https://github.com/porelo-ai/porelo-claude-code/blob/main/issues/README.md#cc24), since the Claude agents
work there with the operator's subscription.

## To be checked

- What each agent needs in its task's image beyond its repository's `porelo.yml`: the agent's own tools, its
  sub-agents (Codex CLI, Antigravity CLI) and their sign-ins.
