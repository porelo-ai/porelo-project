# PJ59 — Each agent moves into a Porelo task

**Status:** Accepted.

**What must be true.** Each agent of the project works in a Porelo task of the project `porelo`, one agent at a time,
in a fixed order, and each move is checked before the next begins; the channel file stays beside Matrix until the last
agent has moved.

From [PJ39](README.md#pj39), sprints 6 to 8: "The move, one agent at a time, the others working as today and the channel kept
beside Matrix until the last has moved".

## Why

Sprints 1 to 5 give the host, the room, the build servers read and the local forge. Nothing moves an agent by itself: each one has its own
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

## Local rules Porelo replaces

A local rule is dropped for an agent only once its replacement is shown in that agent's own task.
The channel file stays beside Matrix until the last agent has moved.

Partial coverage is not a complete replacement: [B148](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b148) and [PJ38](README.md#pj38) do not cover all timing fields.
[B254](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b254) adds an explicit build request from a task; it is not required for the move because a task push can already start the forge workflow.

| Rule short title | Replaced by | Issue |
|---|---|---|
| Freeze handed-over commits | Approval of the exact checked gate commit; a new review round after a new push | [B136](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b136); [PJ67](README.md#pj67) |
| Gather document pushes | Task push to the gate, bound approval and PR to main; the permanent link-publication order remains | [B136](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b136); [PJ34](README.md#pj34); [PJ59](README.md#pj59) |
| Push the exact commit | Commit-bound gate approval and the protected PR route to main | [B136](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b136); [PJ34](README.md#pj34) |
| One VM run per stack | Task checks according to capabilities; the full forge workflow with pool machines selected by kind | [PJ22](README.md#pj22); [PJ49](README.md#pj49); [PJ59](README.md#pj59); [HO12](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho12); [BT25](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt25) |
| Targeted VM retest | Task checks and a full forge build of the new working state | [PJ22](README.md#pj22); [PJ49](README.md#pj49); [PJ59](README.md#pj59); [HO12](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho12); [BT25](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt25) |
| Remember a push deadline | A scheduled gate/PR reminder for agreed publication times | No replacement issue yet. |
| Render local plan previews | A release-plan panel showing current plan and work states; the script/HEADS preview stays until the display is equivalent | [F149](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f149); [PJ63](README.md#pj63); [PJ59](README.md#pj59) |
| Evaluate local measurement files | Task usage and issue velocity for tokens; automatic timing and time-based reporting are also required | [B148](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b148) and [PJ38](README.md#pj38); No issue yet for the complete timing portion. |
| Poll local RAM | Machine monitoring and notifications, container limits and a suitably sized pool | [PJ70](README.md#pj70); [PJ68](README.md#pj68); [B266](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b266); [HO20](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho20) |
| Channel-file read markers | Matrix delivery and task mailbox instead of manually moved file markers | [PJ59](README.md#pj59); [B14](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b14) |
| Channel-post headings | Message identity and addressing in Matrix and the task mailbox | [PJ59](README.md#pj59); [B14](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b14) |
| Hand over a VELOCITY line | Automatic task records of start, readiness, wait, VM, sub-agent and rework times; task usage supplies tokens | [B148](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b148) and [PJ38](README.md#pj38); No issue yet for the complete time fields. |
| Account for a stack once | Unique task/issue token attribution and allocation of shared time and VM effort; the permanent ban on double counting remains | [B148](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b148) and [PJ38](README.md#pj38); No issue yet for shared time and VM allocation. |
| Local sub-agent reading | A read-only reviewer task with agent/effort selection and documented gate review rounds | [B172](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b172); [PJ64](README.md#pj64); [PJ67](README.md#pj67) |
| Resume in the worktree | A dedicated task with its assigned workspace and task continuation | [PJ59](README.md#pj59); [PJ64](README.md#pj64) |
| Prepare local invocations | Task containers, declared egress, dependency caches and per-task settings | [B10](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b10); [B193](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b193); [PJ59](README.md#pj59); [PJ64](README.md#pj64) |
| Close agy standard input | Dedicated Porelo tasks instead of manually started agy sub-agents | [PJ59](README.md#pj59); [PJ64](README.md#pj64) |
| Harness Maven boundary | A task-owned Maven write area, shared read-only cache and checks according to capabilities | [B193](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b193); [PJ49](README.md#pj49); [PJ59](README.md#pj59) |
| Clean up local rentals | Attributed leases, return and VM reset through the shared rental tool; the general cleanup duty remains | [HO12](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho12); [BT24](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt24); [BT25](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt25); [PJ59](README.md#pj59) |
| Arrange a VM slot in the channel | Lease locking, pool limits and controlled waiting or refusal | [HO12](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho12); [BT24](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt24); [BT25](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt25) |
| Check Frontend on host and VM | Task checks according to capabilities and full forge workflows with machines selected by kind | [PJ22](README.md#pj22); [PJ49](README.md#pj49); [PJ59](README.md#pj59); [HO12](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho12); [BT25](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt25) |
| Fixed frontend test account | A dedicated task and isolated test leases; the general test-vault authority remains | [PJ59](README.md#pj59); [HO12](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho12); [BT24](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt24); [BT25](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt25) |
| Local rpm2cpio workaround | A prepared task/test image with rpm2cpio for the package-fixture run | [PJ59](README.md#pj59); No dedicated issue yet; capture it during the move. |
