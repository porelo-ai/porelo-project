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

## To be decided

- What of `roles/forge` belongs to the host's setup and what to putting a project on it, and whether the latter is a
  playbook of its own in porelo-host.
- How the interface shows the two: the host's setup under *Machines*, and *Put this project on a server…* choosing an
  existing host.
- What becomes of PJ40's one command, porelo-host HO08, porelo-frontend F145, and sprints 6e to 6h.
- Whether one host holds several projects, and how they are kept apart on it.
