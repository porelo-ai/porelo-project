# PJ39 — Sokar is built in Sokar tasks

**Status:** Accepted.

**What must be true.** The agents that analyse, build and rework Sokar's issues do that work in Sokar tasks of the
project `sokar`, not as sessions on the host. Each task's work is built and tested on the local forge as it would be
on the central one before the operator sees it, and reaches the central forge only after the operator approved it.

## Why

What the agents spend is counted only where it passes Sokar's broker (sokar
[B148](https://github.com/sokar-ai/sokar/blob/main/issues/base/README.md#b148)); [PJ38](README.md#pj38)'s
velocity needs that count. And Sokar's own work is the hardest daily use there is: what does not work for it will not
work for a person either.

## The shape proposed

- **Everything runs on one bare-metal host**: Sokar with its daemon, gates, broker and vault; the tasks; Forgejo with
  its registry and runner; the VM pool; the Matrix homeserver; the images and caches. Whether that machine stands
  in the operator's office or is rented by the hour makes no difference to the setup:
  - **It is set up from nothing by a script**, and everything that must outlive it - Forgejo's repositories and
    registry, the vault, `.AGENTS.md`, the Matrix room - is backed up off the machine and restored onto a new one.
    A machine given back is not missed.
  - **Keys deposited on a rented one are deposited for a time** ([PJ37](README.md#pj37)) and forgotten at its end;
    the package signing key is never on it, and releases stay the operator's.
  - **Nothing on it is reachable from the internet**: the operator reaches Forgejo, Matrix and Sokar's ssh through a
    VPN. Outgoing: the model providers through the broker, the dependency repositories, and the central forge for
    the mirrors only.
  - **The VM pool runs on its own KVM**, so a run gets a fresh VM rather than a reset account, and the scenarios that
    reboot a machine run locally too. A machine without AVX2 is a machine kind reached from outside, not part of the
    host.
- **The project `sokar` becomes `online`, its upstream the local Forgejo** of [PJ22](README.md#pj22). A task's push
  goes to its gate, which passes the branch `sokar/<task>` on to Forgejo at once; nothing of it is public.
- **Forgejo builds it with the same workflows as the central forge**, the acceptance legs on an account of the local
  VM pool, and the task reads the verdict and the logs of failed jobs through the `forgejo` reader (`builds:` in
  `project.yml`). This replaces the agents' own test on a VM before a hand-over. The pool's size is the local limit.
- **A snapshot one task built is what the next task resolves**: every Forgejo build publishes into Forgejo's
  registry, which a task reaches by a declared name on port 443. It replaces the hand-over directory and the split
  Maven repository.
- **The operator tests and approves each pull request on Forgejo**; the coordinator then merges it through Forgejo's
  API. Each repository's push mirror to the central forge runs only when the coordinator starts it, through the same
  API, in the order and staggered as today's gathered pushes; the token for that API stays on the host and the
  coordinator's task holds a broker's token only. The limit on rented servers concerns those mirrors only.
- **One task per issue, phase and repository**, started with sokar
  [B189](https://github.com/sokar-ai/sokar/blob/main/issues/base/README.md#b189)'s values `issue` and `phase`. A
  task works on one repository only; an issue that changes several is built in one task per repository.
- **An image per repository**, from its devcontainer file (sokar [B170](https://github.com/sokar-ai/sokar/blob/main/issues/base/README.md#b170)), each with the toolchain its repository needs (GraalVM and Maven, Flutter, Gradle,
  Python), rather than one image for the whole project.
- **Downloaded dependencies are cached across tasks**, shared and read-only, as `~/.m2/cached/` is today; what a
  task installs stays its own.
- **`.AGENTS.md` replaces the agents' memory.** It is the one local, uncommitted file for what holds on this
  machine and for the operator's preferences; the agents' own memory is switched off. It is handed into every task
  read-only at its start; an agent that wants it changed leaves the changed file as a proposal, and Sokar writes it
  on the host once the operator approved it - nothing a task wrote reaches the next task unseen.
- **The agents talk over Matrix** instead of the channel file on the host: the project's room in which its tasks
  already talk, through the Matrix transport and the message filter. Nothing new is built for the room; the
  homeserver runs on the host.
- **The coordinator works in `sokar-all`**, a private repository on Forgejo that holds every repository as a subtree
  and is rebuilt by a workflow at every merge into a `main`. It reads everything there and changes only
  `sokar-project/`: after the operator's approval a second workflow splits that directory back into `sokar-project`
  and refuses a change anywhere else, so every other repository is read-only to it by construction.

## The hardware

Derived from what runs at once, not measured; the analysis measures it on today's machines and corrects it.

| What runs at once | Cores | Memory | Disk |
|---|---|---|---|
| 8 tasks (seven agents, and one more while an issue spans repositories), 2 cores and 8 GB each | 16 | 64 GB | 160 GB |
| VM pool: 4 VMs of 4 vCPUs and 8 GB, each with its disk | 16 | 32 GB | 240 GB |
| Forgejo's runner: 2 jobs at once, 4 cores and 8 GB each | 8 | 16 GB | 50 GB |
| Forgejo, its registry (snapshots kept for a time), Matrix, Sokar | 2 | 4 GB | 150 GB |
| Images, one per repository, and the dependency caches | - | - | 100 GB |
| **Sum** | **42** | **116 GB** | **700 GB** |

**So the host needs:** x86_64 with hardware virtualisation (VT-x or AMD-V) and AVX2; **at least 16 cores with 32
threads**; **128 GB of ECC memory**; **two NVMe disks of at least 1.92 TB each**; 1 Gbit/s. A machine of that class is
a common dedicated server.

**How it is used, as decided:**

- **Rented by the hour** and given back when the work stops; the provider caps the hours at its monthly price.
- **One disk for the state, one for what can be thrown away**: Forgejo, the vault, the Matrix room and the local
  agent files on the first; the VMs, the images, the caches and the builds on the second. Neither is mirrored, so the
  state is backed up off the machine not only at down but during a session, after every merge on Forgejo, and a
  failed disk loses at most the work since then.

**To be checked before the first rental:** whether the provider's one-time setup fee is charged again for every
rental by the hour; if it is, a machine is kept for a working period rather than given back each day.

## Plan

In this order; within a phase the items can run side by side. *New* marks an issue that does not exist yet and the
repository it is meant for.

0. **The groundwork, done first, in this order:** what is running is finished and pushed - sokar
   [B76](https://github.com/sokar-ai/sokar/blob/main/issues/base/README.md#b76)'s findings already made, and the open
   round; then, in a window with no other work open, the rename [PJ41](README.md#pj41) and the one code style of
   [PJ29](README.md#pj29); then every repository's code read against its skills (the modules the first reading left out, and its
   counterparts in the other repositories); last the rules for contributors from outside,
   [PJ27](README.md#pj27) with [PJ28](README.md#pj28) and [PJ32](README.md#pj32), which describe the result.
1. **The host:** [PJ40](README.md#pj40) brings the project up on the bare-metal host at one command - VPN, Sokar,
   its account, Forgejo, the Matrix homeserver, KVM, the images, the agents' tasks - with its state backed up off
   the machine and restored onto a new one; the same on a machine of one's own and on one rented by the hour.
2. **What Sokar must add:** sokar [B189](https://github.com/sokar-ai/sokar/blob/main/issues/base/README.md#b189)
   (values at the start); sokar [B170](https://github.com/sokar-ai/sokar/blob/main/issues/base/README.md#b170) (the image from a devcontainer file) and, *new, `sokar`:* that image chosen per repository; *new, `sokar`:* a dependency cache shared across
   tasks; *new, `sokar`:* a file handed in read-only at every start of an agent's task, and its changed copy
   written on the host after approval; *new, `sokar-claude-code`:* the agent's own memory switched off in the task.
3. **The local forge, [PJ22](README.md#pj22)**, in its five parts: machine kinds in `sokar-machines`, the VM pool
   (a fresh VM per run on the host's KVM, rather than accounts on a VM),
   Forgejo with its registry running the same workflows, the `forgejo` reader, a task's build on a declared kind;
   then *new, `sokar-buildtools`:* the push mirrors to the central forge, started through Forgejo's API.
4. **Talking and coordinating:** the project's room as it is; an agent in a task reached by a message as the
   channel's watcher reaches it today, if checking finds that missing; *new, `sokar-project`:* `sokar-all` with its
   two workflows.
5. **The move, one agent at a time**, the others working as today and the channel kept beside Matrix until the last
   has moved: Sluice first (one repository, one snapshot from the registry); then Smith (snapshots from `sokar`, three
   repositories); Matrix; IntelliJ and Frontend (other toolchains); Core last of the builders, with a way back to the
   host, since a fault in Sokar stops its own work; the coordinator last of all.
6. **Clearing up:** *new, every repository:* `AGENTS.md` and `.AGENTS.md` rewritten for Matrix, Forgejo and the gate;
   the channel file, the hand-over directory and the agents' accounts on the VMs retired.
7. **Then** sokar [B148](https://github.com/sokar-ai/sokar/blob/main/issues/base/README.md#b148) counts what the
   tasks spend, and [PJ38](README.md#pj38) learns from it. The counting can be built earlier; it counts nothing of this work
   before phase 4.

## To be checked

- Whether Sokar already hands a file into a task at its start, or only to a running one (`sokar task give`).
- Whether the broker can hold a credential for Forgejo's API, or only for model providers.
- Whether the agent in a task is woken by a message as the channel's watcher wakes it, or something is missing.
- Whether the agent's own memory can be switched off by a setting in the container.
