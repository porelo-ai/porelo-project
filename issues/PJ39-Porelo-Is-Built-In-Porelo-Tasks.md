# PJ39 — Porelo is built in Porelo tasks

**Status:** Implementing; its sprints are planned in `plan/0.6/plan.yml`, where each stands is on the plan's page.

**What must be true.** The agents that analyse, build and rework Porelo's issues do that work in Porelo tasks of the
project `porelo`, not as sessions on the host. Each task's work is built and tested on the local forge as it would be
on the central one before the operator sees it, and reaches the central forge only after the operator approved it.

## Why

What the agents spend is counted only where it passes Porelo's broker (porelo
[B148](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b148)); [PJ38](README.md#pj38)'s
velocity needs that count. And Porelo's own work is the hardest daily use there is: what does not work for it will not
work for a person either.

## The shape proposed

- **The work runs in sprints**: the operator rents the host, it is set up at one command, a
  sprint of a chosen scope from the backlog runs for some hours, the operator reviews what Forgejo built green, the
  work goes to the central forge in one gathered push in dependency order, and the host is given back once all of it
  is there.
- **Everything runs on one bare-metal host**: Porelo with its daemon, gates, broker and vault; the tasks; Forgejo with
  its registry and runner; the VM pool; the Matrix homeserver; the images and caches. Whether that machine stands
  in the operator's office or is rented by the hour makes no difference to the setup. Porelo's own host is rented by
  the hour from Scaleway Elastic Metal through `porelo-machines` ([PJ40](README.md#pj40)'s *Renting the host*):
  - **It is set up from nothing by a script** and given back with nothing kept on it: the code is in the forge,
    the person's own settings - configuration, notes, small files - are on a drive the person mounts
    there, and the room's conversation and the usage records are copied off it as [PJ45](README.md#pj45) says.
    Work not yet sent to the central forge by the gathered push is lost with a failed machine, an accepted risk
    ([decision](../doc/decisions.md#work-not-yet-sent-by-the-gathered-push-is-lost-with-a-failed-machine)).
  - **Keys deposited on a rented one are deposited for a time** ([PJ37](README.md#pj37)) and forgotten at its end;
    the package signing key is never on it, and releases stay the operator's.
  - **Nothing on it is reachable from the internet**: the operator reaches Forgejo, Matrix and Porelo's ssh through a
    VPN. Outgoing: the model providers through the broker, the dependency repositories, and the central forge for
    the gathered push and repository migration.
  - **Tests run in a VM pool**, with Ubuntu and Fedora kinds, as [PJ22](README.md#pj22) plans:
    each VM has one run account, and the whole VM is reset after each run.
    The scenarios that reboot a machine run centrally only. A machine without AVX2 is a machine kind reached from
    outside, not part of the host.
  - **porelo-host is the one exception** (decided): its playbook sets up a whole machine as root, which no pool
    account allows, so its Molecule tests run in its Forgejo build on a throwaway VM per run, made and deleted by
    the runner, which sits outside every task and may use KVM; the host's bare metal runs it nested. Its agent's task
    checks only what needs no machine (lint, the tarball, the shared checks), with the Ansible tools in its own
    image, and reads the verdict through the `forgejo` reader. A task never reaches libvirt or `/dev/kvm`.
- **The project `porelo` becomes `online`, its upstream the local Forgejo** of [PJ22](README.md#pj22). A task's push
  goes to its gate, which passes the branch `porelo/<task>` on to Forgejo at once; nothing of it is public.
- **Forgejo builds it with the same workflows as the central forge**, the acceptance legs on an account of the local
  VM pool, and the task reads the verdict and the logs of failed jobs through the `forgejo` reader (`builds:` in
  `project.yml`). This replaces the agents' own test on a VM before a hand-over. The pool's size is the local limit.
  **The packages and the pin checks run there, not in the task**: the runner sits outside every task, so an agent's
  refused domains do not reach it, and a task needs only its repository's quick check (unit tests and the shared
  checks). porelo-claude-code is the case that needs it: its package build and its pin check reach the host the
  pinned CLI comes from, which agent `claude` refuses in every task.
- **A snapshot one task built is what the next task resolves**: every Forgejo build publishes into Forgejo's
  registry, which a task reaches by a declared name on port 443. It replaces the hand-over directory and the split
  Maven repository.
- **The person reviews what Forgejo built green, gathered at the sprint's end**, and approves each task by merging
  its pull request `porelo/<task>` into the protected `main` on the host's forge. Only the person merges it.
  The person starts the gathered push (porelo-buildtools
  [BT06](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt06)), a plain `git push` without
  force from the host's forge to the central forge, in dependency order and staggered to respect the limit on rented
  build servers. It asks for the person's fine-grained central token hidden and stores it nowhere
  ([PJ37](README.md#pj37)). A moved central forge refuses the push; its `main` comes to the host's forge as
  `central/main`, merged in a task and approved like any other work ([PJ61](README.md#pj61)).
- **One task per issue, phase and repository**, started with porelo
  [B189](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b189)'s values `issue` and `phase`. A
  task works on one repository only; an issue that changes several is built in one task per repository.
- **An image per repository**, each with the toolchain its repository needs (GraalVM and Maven, Flutter, Gradle,
  Python), rather than one image for the whole project (porelo
  [B192](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b192)): the repository names it in a
  checked-in `porelo.yml` (the image and its tools only, never egress or limits), read from its default branch; a
  `.porelo.yml` that is not checked in overrides it locally; `project.yml` overrides both.
- **Downloaded dependencies are cached across tasks later**, shared and read-only, as `~/.m2/cached/` is today; what a
  task installs stays its own (porelo [B193](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b193), sprint 9: until then each task downloads its own).
- **What an agent learns goes into its repository's `AGENTS.md`, as a commit.** Nothing an agent needs is private
  any more: the machines, the accounts and the tools are named by `project.yml`, the `porelo.yml` files and the
  host's scripts, and the secrets stay in the vault behind the broker. So there is no local, uncommitted
  `.AGENTS.md`: what holds on the host and the operator's preferences are committed, built by Forgejo and approved
  with the sprint's other work, and nothing a task wrote reaches the next task unseen. The agents' own memory is
  switched off (porelo-claude-code
  [CC30](https://github.com/porelo-ai/porelo-claude-code/blob/main/issues/README.md#cc30)).
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

**The work runs in small sprints, each ending in two or three functions the operator tests by hand.** A function
is done when the operator has tried it as written under it, not when its issues are; the issues are grouped by the
function they serve. Within a sprint the functions can be built side by side; a sprint begins when the one it needs
is tested, not when the previous one is finished. *New* marks an issue that does not exist yet and the repository it
is meant for.

**Done first: the groundwork**, in this order: what was running finished and pushed (porelo
[B76](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b76)'s findings and the open round), the one
code style of [PJ29](README.md#pj29), every repository's code read against its skills, and the rules for contributors
from outside, [PJ27](README.md#pj27) with [PJ28](README.md#pj28) and [PJ32](README.md#pj32).

1. **An agent works on the rented host.** No local forge, pool or room yet; the task follows the central forge as
   today.
   - *The host rented and given back at one command:* `porelo-host up porelo` rents from Scaleway Elastic Metal and
     sets it up, the operator reaches it only through the VPN with the drive mounted, and `down` leaves nothing at
     the provider ([PJ40](README.md#pj40): porelo-frontend
     [F131](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f131),
     [F132](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f132),
     [F134](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f134); porelo-host
     [HO02](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho02),
     [HO05](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho05),
     [HO06](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho06),
     [HO09](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho09)).
   - *Claude works in a task, signed in with the operator's subscription:* signed in by hand at the stop
     `agent-login:claude`, the task holds only a short-lived token and no memory of the agent's own, and Sluice works
     a small issue in it (porelo-claude-code
     [CC24](https://github.com/porelo-ai/porelo-claude-code/blob/main/issues/README.md#cc24),
     [CC30](https://github.com/porelo-ai/porelo-claude-code/blob/main/issues/README.md#cc30); porelo
     [B255](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b255); porelo-message-sluice
     [SL29](https://github.com/porelo-ai/porelo-message-sluice/blob/main/issues/README.md#sl29)).
   - *Each repository brings its image, and each task its values:* the task starts with `issue` and `phase`, its
     image made from the repository's `porelo.yml` (porelo
     [B189](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b189),
     [B192](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b192)).
2. **The host from the interface, the agents in the room.**
   - *The host up and down from the interface, then a task started there:* *Put on a server* shows the steps and
     asks at the stop for the drive's login and the vault's passphrase; it writes the machine file (project and keys
     only) and the host's VPN key into the person's drive and offers the person's tunnel as a file. The machine
     installs every agent and starts no task (decided): the operator then starts a task on the host as on any machine,
     and its agent is signed in on the way. A failed step's line names the command's own words (porelo
     [B258](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b258); porelo-host
     [HO10](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho10), [HO18](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho18), [HO19](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho19);
     porelo-frontend [F135](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f135),
     [F140](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f140),
     [F141](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f141)).
   - *Two agents talk in the room, and a message wakes the resting one:* two tasks on the host write to each other
     in the project's room, the operator reads along through the VPN, a message naming a resting agent wakes it, and
     a question for the operator comes in the operator's own channel (porelo-host
     [HO11](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho11); porelo-message-matrix
     [MX12](https://github.com/porelo-ai/porelo-message-matrix/blob/main/issues/README.md#mx12), [MX31](https://github.com/porelo-ai/porelo-message-matrix/blob/main/issues/README.md#mx31), [MX32](https://github.com/porelo-ai/porelo-message-matrix/blob/main/issues/README.md#mx32), [MX33](https://github.com/porelo-ai/porelo-message-matrix/blob/main/issues/README.md#mx33)).
3. **The build servers read.**
   - *A build server asked from the command line:* `porelo build status --project=<project>
     --repository=<repository> --branch=<branch>` (or `--commit=<sha>`, `--logs=none|failure|all`, `--json`) shows
     the commit, the verdict, the jobs and the failed jobs' logs, the project and the repository named by their keys,
     the reader, its address and its credential taken from the project file (*new, `porelo`*).
   - *The same command reads Forgejo:* against a Forgejo run in podman, answered in the same shape as GitHub
     (*new, `porelo-adapters`:* the `forgejo` adapter).
   - *Both adapters pass one contract suite:* every case from recorded answers, a deliberately broken adapter
     failing it ([PJ62](README.md#pj62); porelo
     [B253](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b253), moved there).
4. **The local forge builds as the central one.**
   - *Forgejo with its registry, a task fetching a snapshot by name:* the operator opens Forgejo through the VPN; a
     task reaches its registry by a declared name on 443, trusts its certificate and fetches a snapshot, and
     reaches nothing else on the host (porelo-host
     [HO08](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho08),
     [HO17](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho17); porelo
     [B233](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b233),
     [B234](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b234)).
   - *Test machines by kind from the VM pool:* a run asks for the kind `ubuntu` and gets a VM with one run account;
     the whole VM is reset afterwards, and the check finds no machine provider's name in any workflow (porelo-host
     [HO12](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho12); porelo-buildtools
     [BT24](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt24),
     [BT25](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt25)).
   - *Sluice green on both forges on the same commit:* the same `build.yml` of porelo-message-sluice, registry and
     machines as variables of the setup ([PJ60](README.md#pj60), its first repository).
5. **From the task's push to the central forge, after the operator's approval.** Shown on porelo-message-sluice.
   - *The task hears its build from Forgejo:* the task pushes through its gate to `porelo/<task>` on Forgejo, which
     builds it, and the verdict and a failed job's log are in the task's `/porelo/files` ([PJ61](README.md#pj61)).
   - *Only the person's merge approves the work:* the person merges `porelo/<task>` into the protected `main` on the
     host's forge, then starts the gathered push to the central forge; the same task push with the project `offline`
     reaches no forge (porelo-buildtools
     [BT06](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt06);
     [PJ37](README.md#pj37)).
6. **The move, first wave** ([PJ59](README.md#pj59)), the others working as today and the channel kept beside Matrix
   until the last has moved; each move a small issue of its own in the agent's repository, worked inside the new
   task to Review with the local forge's build green.
   - *Sluice works wholly in its task:* reached in the room, its session and VM account no longer used.
   - *Smith in its task, with snapshots of `porelo` from the registry:* its three repositories build on Forgejo
     ([PJ60](README.md#pj60) for each).
   - *AGY and Codex in their tasks, their sub-agents signed in from the vault:* (porelo
     [P12](https://github.com/porelo-ai/porelo/blob/main/issues/providers/README.md#p12); porelo-codex
     [CX01](https://github.com/porelo-ai/porelo-codex/blob/main/issues/README.md#cx01),
     [CX02](https://github.com/porelo-ai/porelo-codex/blob/main/issues/README.md#cx02)).
7. **The move, second wave: the other toolchains.**
   - *Matrix in its task.*
   - *IntelliJ and Frontend in their tasks:* Gradle and Flutter build on Forgejo; the Windows job runs centrally
     only, named by a variable.
8. **The move, last wave.**
   - *Core in its task, with a way back:* Core builds `porelo` in a task, and works on the host again if a fault in
     Porelo stops it.
   - *The coordinator reads everything and changes only `porelo-project`:* in [PJ58](README.md#pj58)'s
     `porelo-all`, a change outside `porelo-project/` refused.
9. **Clearing up and counting.**
   - *No channel file and no hand-over directory any more:* every repository's `AGENTS.md` describes Matrix, Forgejo
     and the gate; the channel file, the hand-over directory and the agents' own VM accounts are retired, the pool's
     run accounts in their place (*new, every repository*).
   - *The room and the usage records outlive the host:* after `down` and a new `up` the room is there with its
     messages, and so are the records ([PJ45](README.md#pj45); porelo-message-matrix
     [MX24](https://github.com/porelo-ai/porelo-message-matrix/blob/main/issues/README.md#mx24); porelo-host
     [HO07](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho07); porelo
     [B231](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b231)).
   - *The tokens counted per task, the dependencies shared:* each issue shows what its tasks spent, and a second
     Maven build downloads nothing again (porelo
     [B148](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b148),
     [B193](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b193);
     [PJ38](README.md#pj38)).

## To be checked

- Whether Matrix delivers a message for an agent in a task into its mailbox; Porelo's half is there.
- Whether the host's build reader returns the local Forgejo's verdict and failed-job logs to the task. The reader
  runs on the host and reads the account's `ca-certificates.pem`; a task reaches only the services it is declared
  to use, with its separate task CA bundle.
