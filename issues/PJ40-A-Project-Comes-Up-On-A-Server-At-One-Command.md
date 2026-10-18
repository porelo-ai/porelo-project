# PJ40 — A project comes up on a server at one command

**Status:** Analyzed: renting the host and the cut between the layers are decided; the size is next.

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

Porelo's own project is the first to be brought up this way ([PJ39](README.md#pj39)): it is used there daily, so that
is where the command is tried and refined before anyone else relies on it.

## The shape proposed

- **One command, two directions**: up - prepare the host, follow the project, build, start; and down - back up what
  must outlive the machine, stop, and leave the machine to be given back.
- **Three sources, each saying only its own:**
  - **`project.yml`, the project's:** its repositories, the agent for each, the security class, egress, limits;
    and, where it wants them, a local forge with its registry, a homeserver and its room, and the machine kinds its
    tests run on ([PJ22](README.md#pj22)). Each is optional: a project without a forge or a homeserver comes up
    without them.
  - **Each repository's own files:** its image from its devcontainer file (porelo
    [B170](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b170)), its builds from its
    workflows. Nothing a repository already says is said again in `project.yml`.
  - **A setup file of the person's, for the machine:** its address, how the person reaches it (a VPN), the drive
    with the person's own settings, the hardware it offers. A project's file never names a machine, so one project
    comes up on any of them.
- **Porelo writes the configuration; Ansible sets up the host.** From the three sources Porelo generates an Ansible
  inventory and its variables, and the playbook runs **on the host itself** (decided): `host up` copies the
  collection and the inventory over ssh, installs `ansible-core` there from the distribution's packages and runs
  `ansible-playbook -c local`: operating system packages, the VPN, KVM, the forge, the homeserver, Porelo's package
  and account. So the person's computer, Linux, macOS or Windows, needs only an ssh client and `host up`; Ansible's
  control node runs on no Windows natively, and podman is not assumed there. Ansible changes only what differs on a
  second run and takes it down again; existing roles are used where they are sound (the homeserver, the VPN, KVM)
  rather than rebuilt.
- **Renting is a step before up and after down**, and for Porelo's own project the host is rented by the hour
  (decided 2026-10-18): `porelo-machines` takes it from a provider before up and gives it back after down (see
  *Renting the host* below). A machine of one's own skips the step, and its address goes into the person's setup
  file. OpenTofu, one module per provider with the state kept encrypted with the person, stays a planned extension
  for Porelo as a product for others; it is not needed for this project's own run.
- **Where it lives**: a new repository, a product of its own and not part of Porelo's internal build tooling, holds
  the playbook and its roles, published as an Ansible collection, in versions that match Porelo's. It gets an agent of its own, as every repository has one. What it calls on stays in `porelo`:
  writing the configuration, the follow, the keys, the images and the tasks.
- **What keeps a guarantee stays Porelo's**, and the playbook calls Porelo's own commands for it rather than doing it
  itself:
  - **following the project**, verifying its signature (`porelo project follow --signed-by`); nothing started comes
    from an unsigned file;
  - **depositing keys**: provider tokens and the forge credential - keys or the person's own token - go into the server's vault through `porelo vault`, never
    through an inventory, a variable or a log; on a rented machine for a time ([PJ37](README.md#pj37)), and they
    leave with down;
  - **starting the tasks** (`porelo task start`), so their limits, egress and start values hold.
- **Nothing is restored but what was chosen**: the person's own settings come from the drive the person mounts,
  and the data [PJ45](README.md#pj45) keeps comes back from the project's store; the code comes from the forge, everything else is built again.
- **Two places outlive the machine, kept apart** (decided): what is the person's, and what is the project's.
  - **The person's drive** is mounted at up and unmounted at down: a folder on a shared drive the person already
    uses (a cloud drive with end-to-end encryption is preferred, since a VPN's key may lie there; the operator's
    is Tresorit, which has a command-line client for Linux:
    [Tresorit CLI unter Linux verwenden](https://support.tresorit.com/hc/de/articles/360009330614-Tresorit-CLI-unter-Linux-verwenden)),
    reached with a credential that opens that one folder and nothing else of the person's, deposited like the
    other keys and for a time on a rented machine. It holds the person's own small files, read and changed on
    the host as anywhere else: configuration, notes, the agents' `.AGENTS.md` (handed into each task read-only by
    porelo [B194](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b194)), the VPN's key, the
    person's machine file, and the keys to the project's store. Nothing runs on it: a database or a repository
    on a mounted cloud drive is broken by its delayed, piecewise sync.
  - **The project's store** holds what [PJ45](README.md#pj45) keeps: the room, the usage records, the Maven
    cache. It is S3 object storage, which every provider offers, written by `restic`, which encrypts on the
    host before anything leaves it, deduplicates and keeps a set number of snapshots; so the store's provider
    sees nothing and changes by its address and key alone. It belongs to the project, not to one person.

## Renting the host

**Decided 2026-10-18:** Porelo's own project rents its host by the hour from a provider of bare metal, through
`porelo-machines` extended by `host up` and `host down`. The reasons: it already rents, labels, waits on a provider's
limits, deletes by name and builds images; renting the host and renting a test machine use the same code, while each
keeps a provider project, a token and a quota of its own, so a host never takes a test run's room. Hetzner Cloud stays
the provider of the CI's test machines.

**A provider behind an interface.** `porelo-machines` gains one interface for a provider, with one adapter per provider
([PJ22](README.md#pj22)'s machine kinds, taken earlier for this): create a server with tags and a cloud-init
`user_data`, read its state, give it back, and say what the provider offers beyond that. Two adapters:

- **Hetzner Cloud**, as today: own images, volumes, primary IPs, firewalls.
- **Scaleway Elastic Metal** for the host: bare metal with hardware virtualisation, so the VM pool runs on it.

**Scaleway Elastic Metal's API**, read from its documentation and OpenAPI schema
([API](https://www.scaleway.com/en/developers/api/elastic-metal),
[schema](https://www.scaleway.com/en/developers/api/elastic-metal/v1/schema.yml)):

- `https://api.scaleway.com/baremetal/v1/zones/{zone}/…`, zones `fr-par-1/2`, `nl-ams-1/2`, `pl-waw-2/3`; the key is
  sent as `X-Auth-Token`.
- **Billed by the minute** from delivery to deletion; `price_per_hour` pays the next 60 minutes ahead.
- **Up:** `GET …/offers?subscription_period=hourly` (price, `stock`, `fee`), then `POST …/servers` with `offer_id`,
  `project_id`, `name`, `tags`, `install{os_id, hostname, ssh_key_ids}`, `user_data` for cloud-init and `protected`;
  `GET …/servers/{id}` until `ready` and the install `completed` (the operating system's install takes about ten
  minutes).
- **Down:** `DELETE …/servers/{id}`. `POST …/servers/{id}/migrate-offer-monthly` moves a server used most of a month
  to the monthly price.
- **What fits:** cloud-init, so a host key made per run reaches it as on Hetzner (porelo-buildtools
  [BT11](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt11)); tags, so the provider's
  labels stay the state; `protected` against a delete by mistake.
- **What is missing against Hetzner Cloud, and what follows:**
  - no images of one's own, only the provider's operating systems: every up installs afresh, then cloud-init and the
    playbook; no host image is baked;
  - no volumes: what outlives the machine ([PJ45](README.md#pj45)) is copied off at down and put back at up, which
    makes that copy part of every rental, so its speed matters;
  - a fixed address only through Flexible IPs, a separate API;
  - an offer can be out of stock (`stock`, the status `out_of_stock`): up names another offer or zone, or says why
    it cannot.

**Read from the account's API** (offers and operating systems, with a read-only key):

- **The one-time `fee` is 0 for every hourly offer**, so a host can be given back each day at no extra cost.
- The hourly offers that meet [PJ39](README.md#pj39)'s minimum (AVX2 rules out the older Xeon offers), prices in EUR
  without VAT:

  | Offer | CPU | Memory | Disk | €/h |
  |---|---|---|---|---|
  | EM-B320E-NVME | EPYC 7232P, 8 cores, 16 threads | 128 GB ECC | 4 TB NVMe | 0.417 |
  | EM-B420E-NVME | EPYC 7272, 12 cores, 24 threads | 128 GB ECC | 2 TB NVMe | 0.444 |
  | EM-I220E-NVME | EPYC 8124P, 16 cores, 32 threads | 128 GB ECC | 1.92 TB NVMe | 0.630 |
  | EM-I320E-NVME | EPYC 8224P, 24 cores, 48 threads | 192 GB ECC | 3.84 TB NVMe | 0.959 |
  | EM-I420E-NVME | EPYC 8324P, 32 cores, 64 threads | 256 GB ECC | 3.84 TB NVMe | 1.233 |

  Stock differs by zone and changes; EM-I220E-NVME was available in most zones, so it is the first choice.
- **Operating systems with cloud-init:** Ubuntu 22.04, 24.04 and 26.04, Debian 12 and 13, Rocky Linux 8; no Fedora.
  The host runs Ubuntu 26.04; Fedora's test machines are VMs on it.
- **A new account's quota for Elastic Metal is 0** and cannot be raised in the console: the first order is refused
  with "quota(s) exceeded for this resource" until the provider's support raises it. A guide for others names this
  step.
- The key is an application's with a policy limited to the project: `ElasticMetalFullAccess` and
  `SSHKeysReadOnly`; it never has the person's own rights.

**Measured on a first rental** (EM-I220E-NVME in `fr-par-1`, Ubuntu 26.04):

- From the order to `ready` 32 s, to the installed system 8 minutes, to `ssh` 13 minutes: the machine reboots once
  after the install.
- It offers AVX2, AMD-V (`svm`) and `/dev/kvm`, 124 GB of memory and two 960 GB NVMe disks, installed as RAID 1.
- `ci/leg-build.sh`, the native build of a leg, took 4:00 minutes, against 5:17 on a Hetzner `ccx33` (8 dedicated
  vCPUs); each native image built in about two thirds of the time.
- The delete took 11 s, and every zone listed no server after it.

## Plan: the cut between the three layers

**No provider's own images, volumes or snapshots for the host**, with any provider: a host is a fresh install of
the operating system, cloud-init `user_data`, labels and a delete, which every provider of bare metal offers. What
outlives it is in the person's drive and the project's store, never at the provider; so a change of provider is a
new adapter and a word in the person's machine file. Hetzner's snapshots stay for the CI's test machines.

```
porelo-machines host up / host down      the one command the person types
 1. the machine         porelo-machines (Java), one interface, one adapter per provider
 2. the system          the playbook (Ansible), run on the host itself, started over ssh
 3. the guarantees      porelo's own commands, called by the playbook
```

**1. `porelo-machines` rents and gives back, and nothing else:**

```java
interface HostProvider {
    List<Offer> offers(Requirements minimum);   // price per hour, stock, zone, one-time fee
    Host create(HostRequest request);           // name, offer, zone, operating system, labels (run,
                                                // porelo-expires), user_data (host key, ssh key)
    Host await(HostId id, Duration limit);      // until installed and reachable over ssh
    List<Host> list(Labels labels);
    void delete(HostId id);                     // and waits until it is gone
}
```

- **up:** an offer that meets the minimum, in another zone when one is out of stock; `create` with a host key
  made for this rental (porelo-buildtools [BT11](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt11));
  `await`; the playbook's inventory written.
- **down:** `delete`, then `list` shows nothing of the project's left.
- The person's machine file names the provider, the offer and the zone; the provider's key is read from a file
  only.

**2. The playbook sets up and takes down the system:**

| up, in this order | down |
|---|---|
| packages, KVM, podman, the VPN | the last copy of [PJ45](README.md#pj45)'s list into the project's store |
| the person's drive mounted, its one folder only | the services stopped |
| Porelo's package, the account, `porelo setup` | the drive unmounted |
| the keys into the vault through `porelo vault`, never through a variable | |
| [PJ45](README.md#pj45)'s list restored from the project's store, before anything that reads it starts | |
| the forge with its registry, the homeserver, the VM pool | |
| `porelo project follow --signed-by`, `porelo task start` | |
| a timer that copies the list every hour | |

**3. Porelo's own commands keep the guarantees:** following a signed project, depositing keys, starting tasks,
and each list entry's copy and restore (the homeserver's in `porelo-message-matrix`, the usage records' in
`porelo`).

**The interface drives it too** (decided): the person runs `host up` and `host down` from porelo-frontend as from
the command line, and when `up` stops for the vault, the interface asks for the passphrase and opens it, so a
person needs no terminal for any step. The interface calls the same commands; it does no step of its own.

**Who builds what:** `porelo-machines`' interface and the Scaleway adapter in `porelo-buildtools`; the playbook in a
new repository with an agent of its own; the list's entries in `porelo-message-matrix` and `porelo`
([PJ45](README.md#pj45)).

**Red first:** `host up` on a rented host, a room message and a Maven build made, `host down`, then `host up` on a
new machine of another provider: the message is in the room, the build finds its cache, and the first provider
lists nothing.

## To be checked

- How fast [PJ45](README.md#pj45)'s store gives the room and the Maven cache back at up, measured on the first rental.
