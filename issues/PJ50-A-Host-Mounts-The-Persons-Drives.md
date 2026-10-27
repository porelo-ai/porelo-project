# PJ50 — A host mounts the person's drives

**Status:** Accepted (operator, 2026-10-27). The agents weigh the shapes below before anything is built.

**What must be true.** A host takes what it needs from the person's drives, in two roles. **Its own setup** - the
machine file, its VPN key, the keys it puts into Porelo's vault - comes either from a tresor of its own or from its
own folder in a tresor several hosts share, as the person chooses per host. **The person's private drives** - notes,
how-tos and other files the person needs when working on any host - are mounted for the person's own use there, as
many as the person names. Both work the same for Tresorit and for a drive with no tresors, such as OneDrive, where a
folder takes a tresor's place.

## Why

The host's drive is built today as exactly one tresor, `PORELO_HOST`, whose `porelo-host/machine.yml` and
`porelo-host/wireguard.key` serve one host. A person may work on several hosts at once, and may have files they need
on every one of them. One tresor per host keeps the hosts apart but is work to keep; one tresor for all hosts is
easy to keep, but with Tresorit a host's client syncs the whole tresor, so every host would see every other host's
keys. And the host has no account of the person's own: there is `ubuntu`, which administers it, and Porelo's account,
in which the tasks run, so a private drive has no place to go.

## Shapes to weigh

- **One list of drives in the machine file**, each naming its kind (Tresorit, OneDrive), its tresor or folder, an
  optional subfolder, whose it is (the host's setup, or the person's), and where it is mounted. The host's setup
  drive is the one entry marked so.
- **Several hosts in one tresor:** a folder per host, `hosts/<name>/`, beside a `shared/` folder every host reads;
  the host's name comes from its inventory (today the project's tag). Where the client syncs the whole tresor, each
  host's secrets either sit in a tresor of their own or are encrypted to that host, so the others see only
  ciphertext; [porelo-frontend](https://github.com/porelo-ai/porelo-frontend)'s [F140](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f140) already plans age encryption with
  the key given only at the stop.
- **One tresor per host** stays possible as it is today, for the person who wants hosts kept apart.
- **The person's account on the host:** whether there is one, how the person reaches it (through the VPN, by ssh),
  what it may do, and that the person's private drives are mounted there and never in Porelo's account, where the
  tasks run.
- **One mechanism for every drive:** the same client, login at the stop, sync, wait at `down` and `noexec` mount as
  the host's drive today, with only the owner and the place differing.
- **OneDrive:** a folder, not a tresor; whether its client can sync a subfolder alone, which would keep other hosts'
  folders off a host without encryption.

## To be checked

- How a host is named, and how the name survives renting it again.
- What `down` waits for when several drives are mounted, and which of them keep a host back under the decision that a
  failed copy keeps the host.
- Whether the person's account is a requirement of this issue or one of its own.
