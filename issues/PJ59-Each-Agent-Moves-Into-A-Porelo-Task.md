# PJ59 — Each agent moves into a Porelo task

**Status:** Analyzed.
**Size:** L - crosses every repository over three sprints; its own part here is the move's procedure, its check, the
channel's bridge to the moved agents and the rules table, each agent's move an issue (S) of its own.

**What must be true.** Each agent of the project works in a Porelo task of the project `porelo`, one agent at a time,
in a fixed order, and each move is checked before the next begins; all of them talk in the
project's room, whose homeserver runs on this machine until the last agent has moved.

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

## Plan

Read in today's `project.yml`, porelo's `doc/messages.md` and `doc/commands.md`, and the sprint 5 test on the rented host.

- **`doc/move.md`, the move's procedure**, one section per step, the same for every agent:
  1. *Before:* the agent's repositories have a `porelo.yml` whose image holds its tools and sub-agents (*To be
     checked*); its sign-ins are in the host's vault; its move issue (S) is filed in its own repository.
  2. *The switch:* in `project.yml` the agent's repositories take the host's forge as upstream ([PJ61](README.md#pj61)'s shape,
     until now proven only on a throwaway central repository); one commit here, pushed by the coordinator.
  3. *The start:* `porelo task start --repository <name> --agent <agent>` on the host, attended, its terminal
     opened by the operator; the agent works its move issue to Review inside the task.
  4. *The check* (below), then the agent's session on this machine and its VM account are stopped.
  5. *The way back, at any time* (operator, 2026-10-27): a moved agent can work here again, for a failed move, a
     host given back or lost, or any other reason. The task's open work is fetched from the host's forge into the
     agent's local checkout first (approved work has reached the central forge already). Then the repository's
     upstream switches back in `project.yml`, and the local session resumes with its channel watcher. Moving
     in again is a new start, as in step 3.
- **`tools/move-check.sh <repository>`**, read-only, run on the host over ssh: the task runs; its last push reached
  the forge as `porelo/<task>`; a Build of it was read by the `forgejo` reader; the pull request was opened by the
  gate (porelo [B297](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b297)); the task is in the room's `agent-card.json`. Each line says what it found. **Red first:** run
  against Sluice before its move, every line fails by name.
- **The room replaces the channel file, before the first move** (operator, 2026-10-27). The project's Matrix
  homeserver runs on this machine, which stays on until the last agent has moved. Every agent, local or moved,
  talks in the one room. For the host's tasks it is a remote homeserver, reached over the VPN
  (`mail.transports.matrix.homeserver` and `ca_file` in the host's `project.yml`). The local agents and the
  coordinator read and write the room with a small client, in place of `porelo-channel-read`, `-post` and `-wait`;
  its login stays in the vault. The channel file is read-only from the switch on. No bridge is needed.
- **The room moves to the host last.** The host works on its own only after the last move; then the
  homeserver moves to the host, before this machine may be off.
- **The rules table below** gains one column per agent: a rule is dropped for an agent only once its replacement
  is shown in that agent's task, and the coordinator ticks it in the same commit as the move's check.
- **The host (operator, 2026-10-27):** the host rented for sprint 4 and 5's re-test is kept and becomes the move's host;
  it runs for the whole move, sprints 6 to 8.
- **Order and timing** stay as proposed. One move per working day; the next starts only after the last one's check is
  green and the operator has accepted its move issue.

## Acceptance

- Sluice's move: `move-check.sh sluice` red before, green after, with its move issue in Review from inside the task.
- Every later move the same; the coordinator's own move last, in [PJ58](README.md#pj58)'s `porelo-all`.
- Seen to fail first: the check against an agent that has not moved.

## To be checked

- Today's homeserver is this account's own, on loopback only (`matrix: {}`), and the host's tasks cannot reach it.
  Serving it on the VPN's address with a certificate the host trusts is work for porelo-message-matrix and porelo;
  the issues are filed with Agent Matrix and Agent Core before the switch.
- Where the local agents' room client lives (porelo-message-matrix, beside the transport, is the first guess), and
  that it waits for a message as `porelo-channel-wait` does.
- What each agent needs in its task's image beyond its repository's `porelo.yml`: the agent's own tools, its
  sub-agents (Codex CLI, Antigravity CLI) and their sign-ins.
- Whether `porelo talk tell` reaches an attended task's prompt as the wake does (B-side `wake.feature`).

## Local rules Porelo replaces

A local rule is dropped for an agent only once its replacement is shown in that agent's own task.
The channel file is replaced by the room before the first move (see *Plan*).

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
