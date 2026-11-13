# PJ95 — Where A Person May Not Add A Deploy Key

```json
{
  "$schema": "issue-1.json",
  "id": "PJ95",
  "title": "Where A Person May Not Add A Deploy Key",
  "state": "Idea",
  "size": "-",
  "priority": "Low",
  "rank": 6,
  "blockedBy": [],
  "covers": "A person who may not add a machine's deploy key at the central forge still brings a project to a machine: Porelo hands them what to ask an administrator for, and no token comes to lie on a server."
}
```

**What must be true.** A person who may not add a deploy key to a repository at the central forge can still bring their
project to a machine: Porelo says what is missing and hands them, ready to send, what an administrator has to do. No
token comes to lie on a server for it.

## Why

Machines fetch from the central forge with a read key per repository. In a larger organization often only an
administrator may add such a key, so the person's project waits until someone with those rights sits at the machine,
and nothing says so or helps. An owner of the organization does not meet this, so a person trying Porelo alone will not.

This is what remains of [PJ37](README.md#pj37). It offered the person's own token as an equal choice per project,
deposited on a machine for a time; that choice is gone, as no token lies on a server.

## Open

- What is handed over: a text and a link for the administrator, naming the repository, the public key and the read
  right asked for. How the person learns it was done.
- Whether any other way is wanted for an organization that adds no keys at all, one that leaves no token on a server.
