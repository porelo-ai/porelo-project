# PJ83 — A person joins with one click

**Status:** Accepted (operator, 2026-10-30).

**What must be true.** Every person has one identity, a key pair they keep themselves. Who exists, which hosts exist and
who may do what lies signed in Git on the central forge, where every person already has access. The host admin admits a
project admin by picking them from a list; the project admin adds a developer the same way; each of them sees on their
own machine what they were admitted to and joins with one click. Nothing is sent from person to person, no public value
or key is copied by hand, no person's machine is named anywhere, and everything between a person and a host runs over
SSH, with no VPN.

## Why

Setting up one host and one project with a project admin and a developer took 119 steps across a laptop, two VMs and a
rented server: ten wizards with about 45 steps, secrets in five places, six kinds of password, and at least six values
or keys copied by hand from one machine to another. That is far too complicated. With one key per person, information
gathered and signed where it arises, and lists read from Git, the long wizards go.

## Building block 1: one identity per person

- Each person has **one Ed25519 SSH key**. It does everything a person signs or proves:

  | Use | How |
  |---|---|
  | Git commits | SSH signature (`gpg.format ssh`), namespace `git` |
  | person cards, host cards | SSH signature (SSHSIG), namespace `porelo` |
  | reaching a host | SSH authentication, from any of the person's machines |
  | a task's key | certified by the person's key as an SSH certificate (building block 4) |
  | the host vault's unlock | SSH signature, namespace `porelo-vault` (see below) |

- **No OpenPGP and no gpg.** Checking a signature needs only `ssh-keygen -Y verify` or the same in Java; nothing parses
  OpenPGP, and no free signature fields reach past Sluice.
- The person keeps the private key themselves, for example in their KeePassXC file, which serves it as SSH agent once
  unlocked: one unlock per session. KeePassXC can unlock without a password by a YubiKey, Windows Hello or Touch ID.
  The agent's socket is never forwarded to a host and never reaches a task.
- The same key is entered in the person's account on the central forge, so that the forge's public key list names it.
- **Gone:** the forge password on the host (Git over SSH, the forge's web login through the tunnel); the project's own
  signing key (a project's signers are its project admins' keys); every per-machine key.
- **Changing the key:** the person makes a new key and a new card that names the old key as its predecessor, signed by
  both the new and the old key. Porelo commits it to the registry and brings it to each host the person is on.
- **Losing the key:** a project admin (or for the host the host admin) puts the person's new key in the access file and
  revokes the old one there; the identity is the person's login, not the key. An admin's own key is replaced by another
  admin, or by the backup key. Each host keeps the revoked keys in a KRL.
- **A stolen key** is revoked by an admin first, who also locks the person's host accounts at once. Once revoked, a
  successor card signed by it is refused, so a thief cannot rotate it away. The person's host vault is deleted and set
  up again, and their provider sign-ins are renewed.
- **Old commits stay verifiable:** the old key stays in Git's allowed signers with `valid-before` set to the change,
  for reading history only. Since the signer sets a commit's time, a commit is judged by when it arrives: its first
  accepted push to the host's forge, which the host records with its verdict, so later readings of history do not judge
  it again. One that arrives after the change is checked against the signers in force without any `valid-before` key,
  and against the KRL.
- **Encryption,** once a secret is kept in Git, uses `age` to the receivers' `ssh-ed25519` keys.
- **Later, if wanted:** a seldom used main key that certifies short-lived working keys, as SSH certificates. This is
  the same mechanism as the task keys and needs no change of format.

## Building block 2: person card and host card

**Person card:** a small YAML file, signed by the person's own key:

| Field | Meaning |
|---|---|
| `login`, `name` | the person's login and display name |
| `email` | optional; Porelo offers it where a person may not do something, to write to those who may |
| `key` | the person's public `ssh-ed25519` key |
| `created`, `expires` | the card's validity |
| `predecessor` | the key this one replaces, if any |

It names **no machine**.

**Host card:** made when the host admin sets up a server, signed by the host admin:

| Field | Meaning |
|---|---|
| host name | for example `walk9server` |
| address and SSH port | for example `195.154.103.7:22` |
| SSH host key | so Porelo knows the real host; `age` can encrypt to it if a token is ever kept on the host |
| services | the forge (web port, Git SSH port and its own SSH host key) and the homeserver (port) |

The service ports are the same local ports on every person's machine.

**Everything over SSH.** Porelo opens one SSH tunnel per host with the person's key. Git runs over it; the forge's web
interface and Matrix are forwarded to `localhost`. On the host they listen on Unix sockets, reachable only by the
admitted persons' group, not on TCP, and without TLS, since the tunnel encrypts. On the person's machine the forwards
bind `127.0.0.1` only. The host's only open port is SSH. Today's return path to the messenger on the person's machine,
a short-lived crutch, runs over `ssh -R` to that one socket only, until it goes. No VPN, no WireGuard, no host CA and no
`sudo` in daily use.

## Building block 3: the state lies in Git on the central forge

**Given:** every person's machine reaches the central forge, by SSH (`git@…`) or a personal access token (`https://…`).
In a company the company's admin grants that access; on GitHub the person makes their account and the forge's admin
admits them to the organisation. This is the way in, and Porelo builds on it.

| Where | What | Written by |
|---|---|---|
| the organisation's **registry repository**, `owners.yml` | the registry's owners and the host admins | a registry owner |
| the registry repository, `people/<login>.card` | each person's card | whoever may write there |
| the registry repository, `hosts/<host>/card` | each host's card; added at setup, deleted at give-back | its host admin |
| the registry repository, `hosts/<host>/access.yml` | the project admins and projects admitted there, each project with its access repository's address | its host admin |
| each project's **access repository** (as today) | the access file: the project's persons, roles and hosts | the project admins |

Whether each person files their own card or chosen persons take cards and file them does not matter to Porelo.

- Every commit is signed, every card is signed by its owner, and the history shows who set up, removed, admitted or
  locked what and when. The state is eventually consistent: Porelo shows what Git says beside what the host reports.
- **Porelo reads instead of asking.** It gathers the lists and drop-downs from these repositories: the persons to admit
  or add, the hosts, the projects on a host, and on each person's own machine what they were admitted to.
- **Trust at first read:** Porelo accepts a new person card only if its key is also one of that forge account's own
  public keys (on GitHub `https://github.com/<login>.keys`), so nobody can file a card under another person's login
  first. On a forge with no public key list, an admin confirms the fingerprint out of band. The first `owners.yml` is
  accepted only if its signer is an owner of the forge organisation whose key is on their forge account's key list;
  later changes are signed by a registry owner named in it. Porelo shows the fingerprints, and a host's key
  at the first connection; comparing them out of band is possible, not required.
- **Each path has its own signer,** since write access to the registry is wide: `owners.yml` by a registry owner;
  `people/<login>.card` by that card's key (and its predecessor on a change); `hosts/<host>/…` by a host admin named in
  `owners.yml`, the one who signed the host card first or their successor named there; anything else is ignored. A
  commit that breaks this keeps the last good state and is named.
- **The host never talks to the central forge on its own.** After each change, the Porelo of the admin who made it
  brings the signed state to the host through the tunnel (as the access bundle goes today); the host checks the
  signatures and syncs.
- **Secrets,** if one is ever kept in Git, are encrypted with `age` to the keys of the persons, or the host, needing it.

**The central forge's token does not lie on the host,** unless a project opts in (below). The gathered push, which takes
an approved main from the host's forge to the central one, is never automatic: a person admitted to push, whatever their
role, starts it on purpose, for example at the end of a sprint once everything on the host's forge is green, and so sets
off the next snapshot or release. Their Porelo sends their own token through the SSH tunnel on standard input, without
asking, since their vault is unlocked; the host uses it once and keeps it nowhere. The same holds the other way: taking
the central forge's state into the host's forge is started on purpose by an admitted person, with their own token, never
by the host on its own. A per-project option to keep a token on the host, encrypted to the host's key, stays open for
projects that must publish unattended; such a token is limited to pushing to that one repository.

## Building block 4: each task's own key

- Every task Porelo starts gets **its own key pair**. Porelo holds it outside the task's container and signs for the
  task on request, so the agent never holds the key and cannot give it away. The key is destroyed when the task ends.
- The person who starts the task certifies that key with their own key as an **SSH certificate**: valid for this task's
  lifetime only, naming the task, who started it and, where there is one, its project and repository. A task with no
  issue and no project works the same way, as long as a person signs. Porelo records each task's certificate on the
  host when the task starts, so a signature by the task's key is traced to its certificate by the key's fingerprint; a
  verifier elsewhere fetches the certificate from the host by that fingerprint.
- The agent's commits and messages are signed with the task's key; a message as SSHSIG in the namespace
  `porelo-message`, carrying the plain `ssh-ed25519` key and no certificate. Each namespace (`git`, `porelo`,
  `porelo-vault`, `porelo-message`) is checked as such, so a signature made for one never stands for another.
- A project's signers list its admitted persons' keys as `cert-authority` in Git's allowed signers, limited to the
  namespaces and principals of tasks, so every task key one of them certified is accepted. A task's commit or message is
  judged by when it arrives on the host, not by the time it claims; an expired certificate is then worth nothing, and no
  revocation is needed for a task's key. Removing a person removes their `cert-authority` line, and with it every
  certificate they issued.
- The person's key never enters a task, and Porelo needs no key per machine to sign what a task sends.
- Later, an agent charged to start other agents needs a key of its own, certified by a person with the right to issue
  further certificates and bounded by its own `cert-authority` entry; that is a later issue.

## Secrets the host keeps

- **The forge's and homeserver's own tokens** for persons and tasks are made by the host's sync itself, through
  Forgejo's admin command and the homeserver's account; none of them travels between persons.
- **An agent's provider sign-in** (a subscription or an API key) stays, as today, in the vault of the person's account
  on the host: the user-mode Porelo there renews it while the person is away.
- **Unlocking that vault without a passphrase.** An Ed25519 signature is deterministic. The vault's key is derived
  (HKDF) from the person's SSH signature (namespace `porelo-vault`) over a fixed text naming host key and account. When
  the person's Porelo opens the tunnel it has that text signed by the local SSH agent (KeePassXC), derives the share and
  sends it through the tunnel. The host's Porelo keeps it in locked memory only (no swap, no core dump), until the host
  restarts or the person is locked, since it renews the sign-ins while the person is away; root on the host can read it
  there, as root can read the vault's content today. No agent forwarding, no stop, no prompt; after a host reboot the
  vault waits, locked, for the person's next connection. The share is the only keyslot of a person's host vault; no
  passphrase is kept for it. Hardware keys (`sk-ed25519`) do not sign deterministically and take the vault's planned way
  for hardware keys. A changed key means enrolling the new key's slot while the old one still works.
- **A build's secrets**, a project's and not a person's, are kept encrypted in the host's forge as its Actions secrets,
  as GitHub keeps them; a project admin deposits them through the tunnel. Later a central vault (OpenBao, AWS Secrets
  Manager and the like) can take their place and change them on a schedule.

## The flow

1. **Each person, once:** installs Porelo, which reaches the central forge as given; their key is made, entered in
   their forge account, and their card is filed under `people/`.
2. **Host admin:** sets up the server, the one wizard left, kept short; its card is filed under `hosts/`.
3. **Host admin:** picks the project admin from the persons and clicks *Admit*; `hosts/<host>/access.yml` is committed
   and brought to the host.
4. **Project admin:** Porelo shows "admitted on host X"; they click *Register the project*, which brings it to the host.
5. **Project admin:** picks the developer from the persons and clicks *Add to the project*; the access file is committed
   and brought to the host, which syncs.
6. **Developer:** Porelo shows "in project P on host X"; they click *Join*: following the project, the tunnel to the
   host, ready to work.
7. **Removing, locking, purging:** chosen from the person lists of project and host.

## Decided

- One Ed25519 SSH key per person signs, authenticates and certifies; no OpenPGP and no gpg.
- The person card is a small YAML file signed by the person's key; it holds no machine.
- A changed key is announced by a card signed with the new and the old key; a lost or stolen key is replaced by an
  admin in the access file, and the old one is revoked there and in the host's KRL.
- No machine card: a person reaches the host with their key from any machine.
- A person's accounts on the host and its homeserver are per person, whatever machine they sit at, later perhaps a
  phone; a task's Matrix account is named by the task and the person's login.
- Every task has its own key pair, held by Porelo outside the task and certified as an SSH certificate by the person
  who starts it, for that task's lifetime; tasks without an issue or a project included.
- No VPN; SSH carries everything.
- Access to the central forge, by SSH or a personal access token, is given on each person's machine.
- No package is sent between persons: the state lies signed in Git on the central forge, in the organisation's registry
  repository (`owners.yml`, `people/`, `hosts/`) and in each project's access repository; Porelo builds its lists from
  there.
- Whoever has write access to the registry repository may commit cards; Porelo accepts them only by the rules of
  building block 3.
- The project admin registers their project on the host themselves, once the host admin has admitted them.
- The central forge's token does not lie on the host unless a project opts in. The gathered push is started on purpose
  by a person admitted to push, never automatically, and sends that person's own token through the tunnel. The pull
  from the central forge into the host's forge works the same way.
- Pull requests and reviews on the central forge stay needed, for example for contributors from outside; Porelo reads
  and makes them with the person's own token, started by that person, without webhooks.
- A person who lost their key loses their host vault with it: the vault is deleted and set up again, and their agents'
  provider sign-ins are made once more.
- A project with a single project admin, a single host admin and a registry with a single owner each list a second,
  offline backup key, until a main key with certified working keys exists. The backup key may only replace the lost
  key's entry among the signers or in `owners.yml`.

## Acceptance

- A developer joins a project on a host with one click after their card is filed, and a project admin is admitted and
  registers their project with one click each, with no value or key copied by hand.
- A card filed under another person's login, a host card signed by someone not named in `owners.yml`, and a successor
  card signed by a revoked key are each refused, naming why.
- The host's only open port is SSH, and no person needs a password beyond unlocking their own key.

## To be checked

- The vault unlock above in detail, and how a provider sign-in reaches that vault over the tunnel.
- The registry repository's exact layout and name, and the format of `owners.yml` and `hosts/<host>/access.yml`.
- The forwards on a person's machine bind `127.0.0.1`, which other local users of that machine also reach; where the
  browser allows it, a socket private to the person is better.
- SSHSIG in Java (Bouncy Castle) or through `ssh-keygen -Y`; `age` in Java or as a tool.
- How each repository changes: porelo (key, cards, registry reading, tunnel), porelo-frontend (lists instead of
  wizards), porelo-host (accounts from person cards, KRL, SSH only, no WireGuard), porelo-message-matrix and
  porelo-message-sluice (Matrix over the tunnel, the return path by `ssh -R`).
- Which held GUI findings of the walk this replaces.
