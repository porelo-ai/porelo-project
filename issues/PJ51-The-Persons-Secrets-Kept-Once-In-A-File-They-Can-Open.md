# PJ51 — The person's secrets kept once, in a file they can open

**Status:** Analyzed (2026-10-27), built as porelo-host [HO37](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho37) (L) and porelo-frontend [F198](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f198) (L) and [F199](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f199) (M, blocked by [F198](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f198) and [HO37](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho37)); porelo-host [HO35](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho35) (M) builds on [HO37](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho37). Decided: one `secrets.kdbx`, groups `shared` and `hosts/<name>`, the vault passphrase per host; the master password typed in a terminal, `keepassxc-cli` the only reader (QF64/QH41 a); KeePassXC a package dependency on Linux (QF65), shipped later on Windows and macOS ([F200](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f200)); the desktop signs the forge's certificate (QH40 b); the host's WireGuard key in `/etc/wireguard` (QH42 a).

**What must be true.** The secrets a person needs to put a project on a host are kept once, in one file on the
person's own drive, encrypted in an open format the person can open with a common tool of their own. The interface
unlocks it on the person's desktop, takes from it what a host's stop asks, and gives it to the host on standard input
only. The file is never unlocked on a host, and no secret lies in the clear on the drive.

## Why

Putting a project on a host today takes many secrets, each kept or typed its own way:

| Secret | For | Kept today |
|---|---|---|
| The provider's API key | renting and giving back | the desktop's system store |
| The ssh key `porelo-host` | reaching the host | `~/.ssh` |
| The drive's login (e-mail, password, one-time code) | the host's drive | typed at each `up` |
| Porelo's vault passphrase on the host | the host's vault | typed at each `up`; a new host has a new vault |
| The agents' sign-ins | the agents on the host | a browser flow at each host |
| The WireGuard keys, the host's and the person's | the VPN | a file in the tresor; a file on the desktop |
| The machine file's keys (deploy keys, tokens) | Porelo's vault on the host | files in the tresor |
| The project's signing key | `signed_by` | the desktop |
| An age identity, for a drive not encrypted end to end | the host's secrets on such a drive | the desktop's system store |
| Later, the backup's store key and password | [PJ45](README.md#pj45)'s copies | not yet placed |

A person who works from more than one desktop keeps all of that more than once, and some of it lies on the drive in
the clear, where every host that syncs the tresor can read it ([PJ50](README.md#pj50)).

## The shape proposed

- **KDBX 4**, the KeePass format, at `porelo/secrets.kdbx` on the person's drive: Argon2id and AES-256 or ChaCha20,
  opened by the person at any time with KeePassXC, so the secrets never depend on Porelo to be read.
- **Unlocked by a master password**, optionally together with a hardware key (KeePassXC's YubiKey challenge-response
  is part of KDBX 4's composite key today). Whether a passkey (FIDO2 with `hmac-secret`) can serve as that second part,
  in KeePassXC and in the interface's Dart, is to be measured.
- **Unlocked on the desktop only.** At a host's stop the interface unlocks the file once and gives the host what its
  waiting line names - the drive's login, the vault passphrase, the host's WireGuard key, the machine file's keys - on
  standard input. Nothing in the clear stays on the drive, which also keeps several hosts in one tresor from reading
  each other's secrets ([PJ50](README.md#pj50)).
- **The one-time code stays out of it by default.** A TOTP seed beside its password puts both factors in one place;
  the person types the code from their own app, unless they choose otherwise knowingly.
- **A wizard in the interface** asks how the person works: on this desktop only, or on hosts too; which drive, and
  one tresor per host or one shared ([PJ50](README.md#pj50)); whether secrets stay in the system's store only or also
  in `secrets.kdbx` on the drive, to be had from every desktop. It creates the file or takes an existing one, and
  writes in what it already knows.

## To be checked

- A Dart reader and writer of KDBX 4 that is maintained, or KeePassXC's command line carried by its digest.
- How the file is written while the person may have it open in KeePassXC, without losing either's change.
- Which entries' names the interface relies on, so a person's own file can be used.
- What replaces the age identity of `porelo-frontend`'s [F140](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f140) once the host's secrets come on standard input.
