# PJ90 — Several organizations on one machine

```json
{
  "$schema": "issue-1.json",
  "id": "PJ90",
  "title": "Several organizations on one machine",
  "state": "Idea",
  "size": "-",
  "priority": "Low",
  "rank": 9,
  "blockedBy": ["PJ87"],
  "covers": "One machine works with several organizations at once, each holding only its own people, projects and hosts and answered by its own identity source; a person keeps one card, filed in each organization, and the interface shows them side by side."
}
```

**Severity.** Low; a nice to have.

**What must be true.** One machine works with several organizations at once, each kept apart: each holds only its
own people, projects and hosts, and its revocations and key checks are answered by its own identity source. A person
keeps one card, filed in each organization they work in. The interface shows all of them side by side, and an
organization is added and removed in the interface.

## Why

[PJ87](README.md#pj87) gives a machine one organization, set when Porelo is set up there;
the interface never asks which organization. A person who works for several organizations needs more than one on the
same machine.

## Found in the same test

- **Several organizations or forges.** A machine holds one organization: `porelo org create` and `setup` answer
  `exists` for another, and `--replace` puts the new one in its place. Whether the forge lists a person's key is
  asked of that one organization's identity source alone.

## The idea

- **Kept apart.** Each organization holds only its own people, projects and hosts; its revocations and its key
  checks are answered by its own identity source.
- **Discovery.** Each installed adapter lists the organizations it can reach (`available`: id, name, a short
  summary); `open` takes such an id.
- **The list.** *Organizations* in the rail, with its count: the explanation block on top, then the filter and *Add
  an organization*, then one expandable row per organization. Folded, the row shows the name, a short state (my card
  filed or not, people, projects, hosts) and the one action due, such as *File my card*. Unfolded it shows, without
  opening the organization: where it is kept, who vouches, my card, owners, people, projects, hosts, and when it was
  read.
- **Add an organization.** A dialog with a search field over the list of every organization the adapters can reach,
  several picked at once; ones already added are shown and cannot be picked. It names no adapter.
- **Removing an organization removes it from this machine only.** Porelo stops reading it, and its people, projects
  and hosts leave the interface. The organization itself, the person's card in it and the hosts stay as they are.
  Withdrawing one's card is a revocation of its own. It is added again from the same list. *Remove from Porelo…* in
  an organization's menu asks for confirmation, naming the projects and hosts leaving the interface and warning of
  work running on them.

Until then the interface has no list of organizations and no *Add an organization*; the design canvas of
[PJ87](README.md#pj87) shows the one organization's page only.
