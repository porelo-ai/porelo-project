# PJ39 — Porelo is built in Porelo tasks

**Status:** Accepted.

**What must be true.** The agents that analyse, build and rework Porelo's issues do that work in Porelo tasks of the
project `porelo`, not as sessions on the host. Each task's work is built and tested on the local forge as it would be
on the central one before the operator sees it, and reaches the central forge only after the operator approved it.

## Why

What the agents spend is counted only where it passes Porelo's broker (porelo
[B148](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b148)); [PJ38](README.md#pj38)'s
velocity needs that count. And Porelo's own work is the hardest daily use there is: what does not work for it will not
work for a person either.

## The shape proposed

- **The work runs in sprints** (decided 2026-10-18): the operator rents the host, it is set up at one command, a
  sprint of a chosen scope from the backlog runs for some hours, the operator reviews what Forgejo built green, the
  work goes to the central forge in one gathered push in dependency order, and the host is given back once all of it
  is there.
- **Everything runs on one bare-metal host**: Porelo with its daemon, gates, broker and vault; the tasks; Forgejo with
  its registry and runner; the VM pool; the Matrix homeserver; the images and caches. Whether that machine stands
  in the operator's office or is rented by the hour makes no difference to the setup. Porelo's own host is rented by
  the hour from Scaleway Elastic Metal through `porelo-machines` ([PJ40](README.md#pj40)'s *Renting the host*):
  - **It is set up from nothing by a script** and given back with nothing kept on it: the code is in the forge,
    the person's own settings - configuration, notes, `.AGENTS.md`, small files - are on a drive the person mounts
    there, and the room's conversation and the usage records are copied off it as [PJ45](README.md#pj45) says.
    Work not yet mirrored to the central forge is lost with a failed machine, an accepted risk
    ([decision](../doc/decisions.md#work-not-yet-mirrored-is-lost-with-a-failed-machine)).
  - **Keys deposited on a rented one are deposited for a time** ([PJ37](README.md#pj37)) and forgotten at its end;
    the package signing key is never on it, and releases stay the operator's.
  - **Nothing on it is reachable from the internet**: the operator reaches Forgejo, Matrix and Porelo's ssh through a
    VPN. Outgoing: the model providers through the broker, the dependency repositories, and the central forge for
    the mirrors only.
  - **Tests run in accounts on two long-lived VMs**, one Ubuntu and one Fedora, as [PJ22](README.md#pj22) plans and
    as today: a run rents an account of the pool, which is reset when it is given back; no VM is started for a run.
    The scenarios that reboot a machine run centrally only. A machine without AVX2 is a machine kind reached from
    outside, not part of the host.
- **The project `porelo` becomes `online`, its upstream the local Forgejo** of [PJ22](README.md#pj22). A task's push
  goes to its gate, which passes the branch `porelo/<task>` on to Forgejo at once; nothing of it is public.
- **Forgejo builds it with the same workflows as the central forge**, the acceptance legs on an account of the local
  VM pool, and the task reads the verdict and the logs of failed jobs through the `forgejo` reader (`builds:` in
  `project.yml`). This replaces the agents' own test on a VM before a hand-over. The pool's size is the local limit.
- **A snapshot one task built is what the next task resolves**: every Forgejo build publishes into Forgejo's
  registry, which a task reaches by a declared name on port 443. It replaces the hand-over directory and the split
  Maven repository.
- **The operator reviews what Forgejo built green, gathered at the sprint's end**, and approves it on Forgejo; the
  coordinator then merges it through Forgejo's API. Each repository's push mirror to the central forge runs only when the coordinator starts it, through the same
  API, in the order and staggered as today's gathered pushes; the token for that API stays on the host and the
  coordinator's task holds a broker's token only. The mirrors push with the person's own token
  ([PJ37](README.md#pj37)), so a new host needs no key added at the central forge. The limit on rented servers
  concerns those mirrors only.
- **One task per issue, phase and repository**, started with porelo
  [B189](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b189)'s values `issue` and `phase`. A
  task works on one repository only; an issue that changes several is built in one task per repository.
- **An image per repository**, each with the toolchain its repository needs (GraalVM and Maven, Flutter, Gradle,
  Python), rather than one image for the whole project (porelo
  [B192](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b192)): the repository names it in a
  checked-in `porelo.yml` (the image and its tools only, never egress or limits), read from its default branch; a
  `.porelo.yml` that is not checked in overrides it locally; `project.yml` overrides both.
- **Downloaded dependencies are cached across tasks**, shared and read-only, as `~/.m2/cached/` is today; what a
  task installs stays its own (porelo [B193](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b193)).
- **`.AGENTS.md` replaces the agents' memory.** It is the one local, uncommitted file for what holds on this
  machine and for the operator's preferences, kept on the drive the person mounts ([PJ40](README.md#pj40)); the
  agents' own memory is switched off (porelo-claude-code
  [CC30](https://github.com/porelo-ai/porelo-claude-code/blob/main/issues/README.md#cc30)). It is handed into every
  task read-only at its start (porelo [B194](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b194));
  an agent that wants it changed leaves the changed file as a proposal, and Porelo writes it back to that drive once
  the operator approved it - nothing a task wrote reaches the next task unseen.
- **The agents talk over Matrix** instead of the channel file on the host: the project's room in which its tasks
  already talk, through the Matrix transport and the message filter. Nothing new is built for the room; the
  homeserver runs on the host. An agent that needs something of the operator asks in the operator's own channel, not
  in the room.
- **The coordinator works in `porelo-all`**, a private repository on Forgejo that holds every repository as a subtree
  and is rebuilt by a workflow at every merge into a `main`. It reads everything there and changes only
  `porelo-project/`: after the operator's approval a second workflow splits that directory back into `porelo-project`
  and refuses a change anywhere else, so every other repository is read-only to it by construction.

## The hardware

**Measured on the machine the agents use today:** 8 cores with 16 threads (a current laptop CPU), 53 GB of memory with
15 GB in use, the Ubuntu VM at 6 vCPUs and 12 GB, the Fedora VM at 2 vCPUs and 4 GB, each agent's session about
0.4 GB. All seven agents, their builds and the tests on the VM run there. What the host adds is the work the central
forge's rented machines do today: the runner's builds, the native ones among them.

| What runs at once | Memory |
|---|---|
| Seven agents' tasks, two or three of them building | 8-12 GB |
| The Ubuntu VM, and the Fedora VM when a test needs it | 12 GB, 16 GB with Fedora |
| Forgejo's runner, one or two jobs, a native build among them | 8-16 GB |
| Forgejo, its registry, Matrix, Porelo | 4 GB |
| **Sum** | **32-48 GB** |

A task's memory limit is a ceiling, not a reservation, so the limits may add up to more than the host has; a limit
per repository (high for `porelo`, low for the small ones) is the project file's `limits:` under each entry of
`repositories:` ([the project file](https://porelo-ai.github.io/core/project-file/)), which exists.

**So the host needs at least:** x86_64 with hardware virtualisation (VT-x or AMD-V) and AVX2, bare metal; **8 cores
with 16 threads**; **64 GB of memory**, ECC where it is offered; **one SSD of at least 1 TB**, NVMe where it is
offered; 1 Gbit/s. More cores make the builds faster, they are not needed for them to run. The first working period
measures each agent's peak and corrects this.

**How it is used, as decided:**

- **Rented by the hour** and given back when the work stops; where the provider does not cap the hours at its
  monthly price, a machine used most of the month is rented by the month instead.
- **One disk**: nothing on it needs to outlive the machine.

**To be checked before the first rental:** whether the provider's one-time setup fee is charged again for every
rental by the hour; if it is, a machine is kept for a working period rather than given back each day. And for the
machine chosen, what its offer leaves unsaid: whether VAT and a setup fee come on top, whether its memory is ECC and
its disks NVMe, how many CPUs it has.

## Plan

In this order; within a phase the items can run side by side. *New* marks an issue that does not exist yet and the
repository it is meant for.

0. **The groundwork, done first, in this order:** what is running is finished and pushed - porelo
   [B76](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b76)'s findings already made, and the open
   round; then the one code style of [PJ29](README.md#pj29); then every repository's code read against its skills
   (the modules the first reading left out, and its counterparts in the other repositories); last the rules for
   contributors from outside,
   [PJ27](README.md#pj27) with [PJ28](README.md#pj28) and [PJ32](README.md#pj32), which describe the result.
   **This order holds for `porelo`.** The other repositories take the code style and their reading beside it, once
   [PJ29](README.md#pj29)'s shared part is in `porelo-parent` and `porelo-buildtools`: each is reformatted in one
   commit and cleaned up after its reading in another, both pushed together, and neither changes an interface
   another repository reads; a finding that would is named in the channel instead.
1. **The host:** [PJ40](README.md#pj40) brings the project up on the bare-metal host at one command - VPN, Porelo,
   its account, Forgejo, the Matrix homeserver, KVM, the images, the agents' tasks - and [PJ45](README.md#pj45)
   keeps the room and the usage records; the same on a machine of one's own and on one rented by the hour. *New,
   `porelo-buildtools`:* one provider interface in `porelo-machines` with an adapter each for Hetzner Cloud and
   Scaleway Elastic Metal, and `host up` / `host down` on it.
2. **What Porelo must add:** porelo [B189](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b189)
   (values at the start); porelo [B192](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b192)
   (an image per repository from its `porelo.yml`); porelo
   [B193](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b193) (a dependency cache shared across
   tasks); porelo [B194](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b194) (a file handed in
   read-only at every start of an agent's task, and its changed copy written after approval); porelo-claude-code
   [CC30](https://github.com/porelo-ai/porelo-claude-code/blob/main/issues/README.md#cc30) (the agent's own memory
   switched off in the task).
3. **The local forge, [PJ22](README.md#pj22)**, in its five parts: machine kinds in `porelo-machines`, the VM pool
   (run accounts on the two VMs),
   Forgejo with its registry running the same workflows, the `forgejo` reader, a task's build on a declared kind;
   then *new, `porelo-buildtools`:* the push mirrors to the central forge, started through Forgejo's API.
4. **Talking and coordinating:** the project's room as it is; an agent in a task reached by a message as the
   channel's watcher reaches it today, if checking finds that missing; the operator's own channel for an agent's
   question; *new, `porelo-project`:* `porelo-all` with its two workflows.
5. **The move, one agent at a time**, the others working as today and the channel kept beside Matrix until the last
   has moved: Sluice first (one repository, one snapshot from the registry); then Smith (snapshots from `porelo`, three
   repositories); Matrix; IntelliJ and Frontend (other toolchains); Core last of the builders, with a way back to the
   host, since a fault in Porelo stops its own work; the coordinator last of all.
6. **Clearing up:** *new, every repository:* `AGENTS.md` and `.AGENTS.md` rewritten for Matrix, Forgejo and the gate;
   the channel file, the hand-over directory and the agents' own accounts on the VMs retired, the pool's run
   accounts in their place.
7. **Then** porelo [B148](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b148) counts what the
   tasks spend, and [PJ38](README.md#pj38) learns from it. The counting can be built earlier; it counts nothing of this work
   before phase 4.

## To be checked

- Whether the broker can hold a credential for Forgejo's API, or only for model providers.
- Whether the agent in a task is woken by a message as the channel's watcher wakes it, or something is missing.
