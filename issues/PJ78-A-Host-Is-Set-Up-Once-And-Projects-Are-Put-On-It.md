# PJ78 — A host is set up once, and projects are put on it

**Status:** Accepted (operator, 2026-10-28).

**What must be true.** Setting up a host and putting a project on it are two separate acts. A host is set up once,
with no project: the machine, the VPN, the person's account, and its forge, with the person's login, lasting password
and a certificate signed by the person's lasting CA. Then a project is put on an existing host, which must already
have a forge: its repositories are brought into that forge, `main` is protected, Porelo's gate and the agents get
their forge identities, and the gathered push back to the central forge is set up. A second project on the same host
needs no new host setup, and taking a project off the host leaves the host and its forge standing.

## Why

Today [PJ40](README.md#pj40) brings a project up on a server at one command, and porelo-host's `forge` role does both
acts in one run. Everything a person needs from the forge (their login, the password script, the gate's identity,
the protection of `main`, the agents' accounts) is made only when repositories are named, so a host set up without a
project has an empty forge nobody can sign in to. The interface writes no forge switch at all
(porelo-frontend [F145](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f145)), so
porelo-frontend [F202](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f202), the forge's
certificate and password, has nothing to work on. The operator, 2026-10-28: "Setup des Host" and "Pack ein Projekt
auf einen bestehenden Host (der dann eine Forge haben muss)" are two different acts.

## Decided

- **Three roles, each in their own account.** The *host admin* (root, one person) prepares the host, admits project
  admins by hand, registers projects and takes them off, purges locked accounts and owns `down`. A *project admin*
  brings their project onto the host. A *developer* joins, works, approves into `main` and runs the gathered push
  with their own token. Porelo runs only in a person's own account; the interface shows each command only for the
  role it was started with.
- **The host is shared.** The forge, its runner, the VM pool and the Matrix homeserver belong to the host, not to a
  project; their users are one organization and trust each other's builds. One host holds several projects, each a
  forge organization of its own with its own publisher.
- **Preparing a host makes no project and no person**: the VPN on `10.73.<n>.0/24`, the shared forge, runner, pool
  and homeserver under the host's names, their certificates signed by the host admin's lasting CA, constrained to
  the host's names and network. A laptop reaches several hosts, one VPN each; a colliding network is refused.
- **Who may work on a project is signed, not handed over.** A project names a private repository whose signed
  `access.yml` holds its `host:` block, its developers with their public keys, and its transports' settings. The
  host follows that list: a developer added is admitted, one dropped is locked at once; nothing is admitted when the
  `host:` block is not the host's own.
- **[PJ40](README.md#pj40)'s one command** stays one button: the first time it prepares the host and brings the project; a second
  project is brought alone. The host's forge runs whether or not a project names repositories.
- **Sprints 6e to 6h stand as tested**; what they built moves with the parts below. The interface's switch for a host
  without a forge is a later issue of its own.

## Parts

Each part states its contract itself; the order between them is this list's, and the waits are named per part.

| Repository | Part | Size | Waits for |
|---|---|---|---|
| porelo-host | [HO42](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho42) the host prepared with no project or person | L | - |
| porelo-host | [HO43](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho43) `porelo-host-person`: a person admitted, locked and purged | L | [HO42](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho42), [MX44](https://github.com/porelo-ai/porelo-message-matrix/blob/main/issues/README.md#mx44), [B312](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b312) |
| porelo-host | [HO44](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho44) `porelo-host-project`: a project registered and taken off | M | [HO42](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho42) |
| porelo-host | [HO45](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho45) `bring.yml` and `join.yml` in the person's own account | L | [HO43](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho43), [HO44](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho44), [B310](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b310), [B320](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b320) |
| porelo-host | [HO46](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho46) `sync`: developers kept to the signed `access.yml` | L | [HO45](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho45), [B311](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b311) |
| porelo-host | [HO47](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho47) the gathered push run by any developer | S | [HO45](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho45) |
| porelo-host | [HO48](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho48) every role tested on one host | L | [HO46](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho46), [HO47](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho47) |
| porelo | [B310](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b310) a project names a private, signed access file | M | - |
| porelo | [B311](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b311) `porelo project verify --json` | S | [B310](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b310) |
| porelo | [B312](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b312) a transport's machine named `<host>-<account>` | S | - |
| porelo | [B320](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b320) the inventory's `files` read from the access file | S | [B310](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b310), [B311](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b311) |
| porelo | [B314](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b314) the project admin's Porelo keeps the room to the developer list | S | [B310](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b310), [B312](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b312), [MX45](https://github.com/porelo-ai/porelo-message-matrix/blob/main/issues/README.md#mx45) |
| porelo | [B315](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b315) a person locked out without a terminal | XS | - |
| porelo-message-matrix | [MX44](https://github.com/porelo-ai/porelo-message-matrix/blob/main/issues/README.md#mx44) the shared homeserver gives each person a token | M | - |
| porelo-message-matrix | [MX45](https://github.com/porelo-ai/porelo-message-matrix/blob/main/issues/README.md#mx45) the room made and kept on a central homeserver | M | [B312](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b312) |
| porelo-frontend | [F208](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f208) roles given at the start | M | - |
| porelo-frontend | [F209](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f209) the VPN kept per host | M | [F208](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f208) |
| porelo-frontend | [F210](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f210) the secrets file's entries per host and per project | S | - |
| porelo-frontend | [F212](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f212) one lasting CA per host | M | [F210](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f210) |
| porelo-frontend | [F214](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f214) the setup files in the person's own home | M | [HO42](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho42), [HO45](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho45) |
| porelo-frontend | [F211](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f211) a server prepared by its host admin | L | [F208](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f208), [F209](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f209), [F210](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f210), [F212](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f212), [HO42](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho42), [HO43](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho43), [HO44](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho44) |
| porelo-frontend | [F213](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f213) a project brought onto a prepared host | L | [F211](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f211), [F214](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f214), [HO45](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho45), [B310](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b310) |
| porelo-frontend | [F215](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f215) the developers kept in the access file | L | [F213](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f213), [HO46](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho46), [B310](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b310) |
| porelo-frontend | [F216](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f216) a developer joins from the access file | L | [F209](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f209), [F212](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f212), [F214](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f214), [F215](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f215), [HO45](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho45), [B310](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b310) |
