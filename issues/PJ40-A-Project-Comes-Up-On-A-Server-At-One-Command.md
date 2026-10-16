# PJ40 — A project comes up on a server at one command

**Status:** Accepted.

**What must be true.** A person who works with several agents on a project of several repositories puts the whole
project on a server and starts all of it together with one command, from the project's `project.yml` and the setup
files its repositories already carry (a devcontainer file, the workflows): the host prepared, the images built, and,
where the project asks for them, a local forge, a homeserver and machines for its tests in place, and an agent's
task started for each repository that names one. The same command works on a server of the person's own and on one
rented by the hour; a second run changes only what differs, and taking it down leaves nothing the next start would
miss.

## Why

Setting up such a project is many manual steps on one machine, written down in a local file nobody else has; a
second machine, a rented one, or the next person's project means doing them again by hand. Anyone who runs several
agents on several repositories meets this, and a laptop is the wrong place for it once the agents work for hours.

Sokar's own project is the first to be brought up this way ([PJ39](README.md#pj39)): it is used there daily, so that
is where the command is tried and refined before anyone else relies on it.

## The shape proposed

- **One command, two directions**: up - prepare the host, follow the project, build, start; and down - back up what
  must outlive the machine, stop, and leave the machine to be given back.
- **Three sources, each saying only its own:**
  - **`project.yml`, the project's:** its repositories, the agent for each, the security class, egress, limits;
    and, where it wants them, a local forge with its registry, a homeserver and its room, and the machine kinds its
    tests run on ([PJ22](README.md#pj22)). Each is optional: a project without a forge or a homeserver comes up
    without them.
  - **Each repository's own files:** its image from its devcontainer file (sokar
    [B170](https://github.com/sokar-ai/sokar/blob/main/issues/base/README.md#b170)), its builds from its
    workflows. Nothing a repository already says is said again in `project.yml`.
  - **A setup file of the person's, for the machine:** its address, how the person reaches it (a VPN), the drive
    with the person's own settings, the hardware it offers. A project's file never names a machine, so one project
    comes up on any of them.
- **Sokar writes the configuration; Ansible sets up the host.** From the three sources Sokar generates an Ansible
  inventory and its variables, and the person runs the playbook from their own machine over ssh: operating system
  packages, the VPN, KVM, the forge, the homeserver, Sokar's package and account. Ansible changes only what differs
  on a second run and takes it down again; existing roles are used where they are sound (the homeserver, the VPN,
  KVM) rather than rebuilt. Ansible is a tool the person brings, not part of Sokar.
- **Renting is a step before and after, and optional**: where the machine is rented, OpenTofu takes it from the
  provider before up and gives it back after down, its address going straight into the inventory. A machine of
  one's own skips it. One module per provider, the provider named in that module only; the state stays with the
  person and is encrypted, since it can hold the new machine's secrets. Renting a project's host for hours or days
  is not renting a test machine for one run ([PJ22](README.md#pj22)'s `sokar-machines`, internal to Sokar's own
  builds); the two stay apart.
- **Where it lives**: a new repository, a product of its own and not part of Sokar's internal build tooling, holds
  the playbook and its roles, published as an Ansible collection, and the OpenTofu modules beside them, in versions
  that match Sokar's. It gets an agent of its own, as every repository has one. What it calls on stays in `sokar`:
  writing the configuration, the follow, the keys, the images and the tasks.
- **What keeps a guarantee stays Sokar's**, and the playbook calls Sokar's own commands for it rather than doing it
  itself:
  - **following the project**, verifying its signature (`sokar project follow --signed-by`); nothing started comes
    from an unsigned file;
  - **depositing keys**: provider tokens and the forge credential - keys or the person's own token - go into the server's vault through `sokar vault`, never
    through an inventory, a variable or a log; on a rented machine for a time ([PJ37](README.md#pj37)), and they
    leave with down;
  - **starting the tasks** (`sokar task start`), so their limits, egress and start values hold.
- **Nothing is restored but what was chosen**: the person's own settings come from the drive the person mounts,
  and the data [PJ45](README.md#pj45) keeps is put back; the code comes from the forge, everything else is built again.
- **The person's drive** is mounted at up and unmounted at down: a folder on a shared drive the person already uses
  (a cloud drive with end-to-end encryption is preferred, since a VPN's key may lie there), reached with a
  credential that opens that one folder and nothing else of the person's, deposited like the other keys and for a
  time on a rented machine. It holds small things that are read, not worked in: configuration, notes, the agents'
  `.AGENTS.md` (handed into each task read-only by sokar
  [B194](https://github.com/sokar-ai/sokar/blob/main/issues/base/README.md#b194)), the VPN's key, so the person's
  devices need not be set up again, and the copies [PJ45](README.md#pj45) makes. Nothing runs on it: a database or a
  repository on a mounted cloud drive is broken by its delayed, piecewise sync.
