# PJ106 — Each host sees only the drive areas chosen for it

```json
{
  "$schema": "issue-1.json",
  "id": "PJ106",
  "title": "Each host sees only the drive areas chosen for it",
  "state": "Backlog",
  "size": "M",
  "priority": "Low",
  "rank": 3,
  "blockedBy": [],
  "covers": "Each host sees only the drive areas the person chose for it, and OneDrive is mounted as Tresorit is."
}
```

**Why this size.** the part of [PJ50](README.md#pj50) not built in 0.6; [PJ50](README.md#pj50) built the mount itself (porelo-host HO36, porelo-frontend F197).

**How it stands.** Set by the operator, 2026-11-09.

**What must be true.** A person chooses, per host, which areas of their drive that host may see, and the host mounts
only those; OneDrive is mounted the way Tresorit is.

## Why

[PJ50](README.md#pj50) mounted the person's whole Tresorit drive in their own account on the host. A rented host for one project then
sees every other project's files of that person, and a person whose files are on OneDrive gets no drive at all.

## To be checked

- How a host is named in the choice, so the same areas follow it to its next rental.
- What `down` waits for before it unmounts.
- Whether the person's account on the host is an issue of its own.
