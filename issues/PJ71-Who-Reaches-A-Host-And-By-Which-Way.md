# PJ71 — Who reaches a host, and by which way

**Status:** Idea.

**What must be true.** Setting a machine up, admitting a person to it or removing them, and taking it down are kept
apart from normal work, as roles the interface is started with: without a role given it shows normal work only. A
person who did not set a machine up reaches it with keys of their own, handed over by public key only, and for every
way into a host it is written down who uses it, for what, and over which channel: ssh or the VPN.

## Why

- **Three procedures, one person assumed.** Everything built assumes that the person who rents a host also sets it
  up, works on it and takes it down ("a person who can rent a machine is trusted with root on it", porelo-frontend's
  `doc/decisions.md`). In a company, an administrator sets machines up and takes them down, perhaps entirely outside
  Porelo, and admits people over ssh; the person who works has no root.
- **Setup sits beside daily work.** The interface already keeps *Work* and *Needs you* apart from *Set up*, but
  renting and setting up a host (*Put on a server*), clearing and taking it down are offered to everyone.
- **Nobody can be admitted.** A host's VPN knows one peer, the person who set it up (`vpn_peers` in porelo-host);
  nothing adds or removes a second person's ssh key, VPN peer or account. A Porelo node is one OS user with its own
  vault, so a second person needs an account of their own, not the first person's keys.
- **Two channels, no stated split.** A host is reached over its public ssh while it is set up and at the stop, and
  over the WireGuard VPN for its services afterwards; the interface also raises its own ssh forward to the room's
  homeserver. Which function takes which channel follows from how each was built, not from a rule. Whether ssh stays
  public after `up` is porelo-host's Idea "ssh reached only through the VPN once it is up".

## The shape proposed

- **Roles given at the start of the interface** (decided): for example `--roles user,host-admin`, with no check; a role
  only shows or hides functions, and what a person may really do stays with the operating system, ssh and the keys.
  Without the parameter only `user` is active.

  | Role | What it shows |
  |---|---|
  | `user` (always) | normal work: projects, tasks, review, the room; adding a machine by its address or an access file |
  | `host-admin` | setting a machine up (renting it, `up`) and taking it down (`down`, giving it back, clearing it) |
  | `access-admin` | admitting a person to a machine and removing them: account, ssh key, VPN peer |

- **The hand-over between administrator and person:** the person's computer makes their ssh key and, only where the
  machine's own VPN is needed, their WireGuard key; the private halves never leave it. The interface writes an
  **access request** with the person's name and public keys; the administrator admits it and returns an **access
  file**: the machine's address, the account, the host key's fingerprint, and whether a VPN is needed. On a machine in
  the company's network the access file says it is reached directly, and no WireGuard key is asked for.
- **Setting up and taking down may happen outside Porelo**: by `porelo-host` for a rented host, by an OpenTofu module
  per provider (the extension [PJ40](README.md#pj40) names, porelo-host's Idea "A Machine Rented And Given Back By
  OpenTofu"), or by a company's own tools. The person's side is only the access file.

## What is mixed today

`up` does both roles' work in one run, which stays right for a person who holds every role, such as this project's
own rented host; nothing of it changes before the roles are built.

- **The person's part inside `up`:** it creates and fills Porelo's vault (its passphrase at the stop) and follows the
  project. With roles apart, that is the person's first start in their own account, so that no administrator learns
  the person's passphrase or forge token.
- **The machine file holds both:** the host's part (drive, VPN, forge, pool) is the administrator's; the project and
  the credentials for the vault are the person's, and reach them through the access file and following the project.
- **The host's drive** (its WireGuard key and setup files, porelo-host's role `drive`) is a `host-admin` tool for a
  rented host, which a company's own means may replace; a person's private drives
  ([PJ50](README.md#pj50)) are the `user` role's and are mounted in that person's own account.
- **Removing and taking down:** removing a person (`access-admin`) clears that person's account and vault; taking
  the machine down (`host-admin`) clears the rest. Today `down` clears the one vault there is.

## Open questions

- The split itself: which functions go over ssh (setting up before the VPN exists, the stop's terminal, the
  interface's room forward) and which over the VPN (the forge, the room, the daemon, the VM pool, a task's view).
- What an admitted person gets: an OS account and Porelo node of their own, the room, the local forge.
- The form of the access request and the access file, and whether the command line offers the same.
