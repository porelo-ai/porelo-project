# PJ59 — Each agent moves into a Porelo task

**Status:** Backlog.
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

## Plan

The move happens twice. **A trial move per repository**, in the sprint that prepares it: the repository runs in a task
on the host rented for that sprint until its check is green, then goes the way back and is worked on the development
machine again. **The real move of all of them at once**, once every repository has passed its trial: one switch in
`project.yml` for all, then each repository's check on the host.

Every repository's move follows these steps; a repository's own move issue states only what is particular to it, and
the coordinator gives its agent this procedure when its move is due.

### Who moves, and in which order

A task holds one repository, so each repository moves with an agent of its own, named after the repository or the
nickname its entry in `project.yml` gives it. The trial moves go one at a time, also within one stage, in this order:
the next starts only after the last one's check is green and the operator has accepted it.

1. `porelo-message-sluice`.
2. `porelo-pi`, `porelo-omp` and `porelo-claude-code`.
3. `porelo-agy` and `porelo-codex`.
4. `porelo-buildtools`.
5. `porelo-message-matrix`.
6. `porelo-intellij` and `porelo-frontend`.
7. `porelo-adapters` and `porelo-ai.github.io`.
8. `porelo` and `porelo-host`, last of the builders.
9. The coordinator, once tasks that review work exist; until then it reads the moved agents' work from outside, and
   stays on the development machine after the real move.

`porelo-parent` has no agent and does not move: a change to it is a task on that repository, started when one is
needed. After the real move, an agent's session on the development machine and its VM accounts stop.

### Before the first trial

- **The room is reachable from the host**: `project.yml` names the development machine's published homeserver by a
  name the host resolves to the machine's VPN address, with its CA and its registration token file.
- **A repository whose snapshots another one resolves builds on the host's forge first**: it is named in
  `forge_repositories` and its Build, deploying with `forge-release`, is green on the sprint's host before the first
  trial whose build resolves it. That holds for `porelo-parent` and `porelo-buildtools` before every trial, and for
  `porelo` before every adapter's.

### Before each trial

- **The dry run passed on the development machine**: a task for the repository, online with the central forge as its
  upstream and the room on the machine's own homeserver, takes a change through the gate to a `porelo/…` branch, is
  woken by a message in the room, and reads its build. A person opens the pull request there.
- **The repository builds on the host's forge as on the central one**: its workflows run unchanged on both, with the
  values of [the local registry and publication settings](https://github.com/porelo-ai/porelo-host/blob/main/doc/local-forge.md#the-local-registry-and-publication-settings).
- **The host's inventory names the repository in `forge_repositories`**: the forge migrates a repository, protects
  its `main` and makes the gate's identity only for those named.
- **The forge's registry holds the snapshots the build resolves**, no older than the central forge's on the day of
  the trial.
- **The repository has a `porelo.yml`** whose image holds the agent's tools; the agent's sign-ins are in the host's
  vault. A task has no sub-agent of its own.
- **The task's egress reaches what the build and the agent fetch**: Maven Central, Sonatype's snapshots, GitHub's
  release downloads and API, and the skills' store. The task's own build reads the snapshots from the forge's
  registry by their declared name, as [PJ75](README.md#pj75) makes possible before the first adapter's trial.
- **The skills the repository names are in the task** where its harness reads them, checked against their digests.

### The steps

The same for a trial and for the real move, which takes step 1 for every repository in one commit.

1. **The switch:** in `project.yml` the repository takes the host's forge as its upstream; one commit in
   porelo-project.
2. **The start:** `porelo task start --repository <name> --agent <agent>` on the host, attended, its terminal opened
   by the operator.
3. **The work:** the agent takes its move's own small change from start to review inside the task, through the gate,
   with the forge's build green.
4. **The check** (below).
5. **After a trial, the way back** (below): the repository is worked on the development machine again until the real
   move.

### The check

Read-only, on the host. Each line says what it found, and each fails by name before the trial:

- the task runs;
- its last push reached the forge as `porelo/<task>`;
- a Build of that push was read by the forge's build reader;
- the pull request was opened by the gate;
- the task is listed in the room's `agent-card.json`;
- a message naming the agent in the room wakes it, and its answer appears there.

### Working in a task

- **A moved agent runs attended**: Porelo wakes an agent resting at its prompt when a message names it. Only an agent
  whose definition declares both its resting and its waiting screen is woken; a Pi in a task is woken only after
  porelo-pi [PI33](https://github.com/porelo-ai/porelo-pi/blob/main/issues/README.md#pi33).
- **What a task cannot test runs in the forge's Build**: an acceptance leg on a machine from the host's pool. A
  hand-over names those legs in place of a VM run on the development machine.
- **An adapter moves before the pool is there** (operator, 2026-10-29): during its move the adapter's checks that rent a
  machine from the host's pool are switched off. porelo's Build moves to the forge before the adapters, so they build
  against its snapshots there, and its acceptance job is off on the forge the same way. Each adapter switches them on again in its own issue of release 0.7,
  planned once the pool and machines asked for by kind are done.
- **The reading before a hand-over is done from outside**: the coordinator has the pull request's diff read against
  the repository's skills by a sub-agent on the development machine and posts the findings in the room.
- **A fix after a reading amends the task's commit** and is pushed with `--force` to the task's own unmerged branch,
  which the gate lets through; the work stays one commit. `main` is never pushed with force.
- **A revoked sign-in** is renewed with `porelo vault login <agent> --force` and a restart of the task, which keeps
  the token it read at its start.
- **The task changes nothing on the host.** Only the host admin installs a new Porelo there, deliberately; if the
  installed Porelo is broken, the way back is the remedy.

### What the agent is given in place of `.AGENTS.md`

`.AGENTS.md` is not committed, so it is not in the task. At the start, the task's context gives the agent:

- **its name**, the one it signs with;
- **its commit attribution**, `Assisted-by: <tool>, <model>` (the harness, such as `Claude Code`, never the agent's
  name), and no other trailer of its own;
- **which forge its upstream is**: the host's forge, and the central forge only through the gathered push;
- **the room in place of the channel**: it reads and writes the project's room, not the channel file;
- **the operator's language and time zone**, as the development machine's local rules state them;
- **every local rule Porelo does not yet replace in the task**, until its replacement is shown in that agent's own
  task.

What the coordinator finds missing in a task's context is said before the start.

### The room

Every agent, in a task or not, talks in the project's one room. Its homeserver runs on the development machine,
reached by the host's tasks over the VPN; the agents on the development machine use a room client in place of the
channel's commands, and the channel file is read-only from the first trial on. After the real move the project's room
is made anew on the host's homeserver and `project.yml` names it; the old room is cleared, and its history is not
carried over.

### The way back

Every trial ends with it, and a moved agent can take it at any time - for a failed move, a host given back or lost,
or any other reason:

1. What the host's forge holds of the task's work is fetched into the agent's local checkout.
2. The repository's upstream switches back in `project.yml`, one commit in porelo-project.
3. The local session resumes, with its watcher.

Work that only the host held is lost with the host, as for any work on it; the host's backup is what protects it.
Moving in again is a new start, from *The steps*.

### Open

- **The guided walks of the interface** - the walk's folder on the operator's laptop and the walk first done on a
  test machine - are settled with `porelo-frontend`'s move.
- **Testing against another repository's work before it is published**: whether a moved agent tests only against
  snapshots another repository's Build published, or where such a hand-over lies for a task.
- **A guarded project's gate**: the gate passes a task's push on to the forge, with `--force` onto the task's own
  branch, only in an `online` project; in `porelo`'s class, `guarded`, the push waits at the gate for approval. Where
  the reading from outside reads that waiting work, and what an amended push does to it, is to be measured.

## Acceptance

- Sluice's move: `move-check.sh sluice` red before, green after, with its move issue in Review from inside the task.
- Every later move the same; the coordinator's own move last, in [PJ58](README.md#pj58)'s `porelo-all`.
- Seen to fail first: the check against an agent that has not moved.

## To be checked

- The release plan's sprints 7 to 8b of 0.6 follow the *Plan* as decided: each wave a trial move on the sprint's
  rented host and back, then one real move of all repositories, and the coordinator's move after the reviewing tasks
  of 0.8; to be replanned after the cleanup of issue citations.

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
