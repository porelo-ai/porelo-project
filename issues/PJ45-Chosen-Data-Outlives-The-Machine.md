# PJ45 — Chosen data outlives the machine

**Status:** Idea.

**What must be true.** A short list of data that lives only on a machine and is worth keeping is copied off it
regularly, and put back when the machine is set up again; everything else on the machine is thrown away with it.
To start with the list holds two things: the conversation in the project's Matrix room and the tasks' token usage
records. More can be added to the list later without a change to how it is copied.

## Why

A machine that runs a project ([PJ39](README.md#pj39), [PJ40](README.md#pj40)) is set up again whenever it is
needed and given back when the work stops; the code is safe in the forge. Two things are not in the forge: the room
where the agents and the person talk - the record of hand-overs, questions and answers - and the usage records that
[PJ38](README.md#pj38)'s velocity is computed from. Losing them with every machine loses the history of the work.

## The shape proposed

- **A list of what is kept**, each entry a kind of data with how it is read consistently while it is in use: the
  homeserver's database (Tuwunel's, in its podman volume) and the usage records (`usage/<task>.jsonl`, appended
  line by line).
- **Copied regularly and at down** to where the person's own settings are kept: a folder on a drive the person
  mounts on the machine, named in the person's setup file for the machine ([PJ40](README.md#pj40)). Nothing is
  copied anywhere the person did not name.
- **Put back at up**, before the homeserver and the tasks start, so a new machine continues the same room and the
  same records.
- **Only consistent copies:** a database is copied by its own means of a backup or while it is stopped, never as files
  a running database is writing; an append-only record may be copied as it stands.
- **Nothing secret is added to it:** the vault is not on the list; its entries are deposited again at up.
- **Nothing more than needed:** what the forge holds, what is built again (images, caches, the registry's
  snapshots) and the tasks themselves are not on the list.

## To be checked

- What Tuwunel offers for a backup of its database while it runs (a backup path and a number of backups to keep, or
  an admin command), and whether a backup of one version loads into the next.
- Whether the operating system's means suffice - a systemd timer and a copy - or something of Porelo's own is needed.
- Which repository builds it: the homeserver's part belongs to `porelo-message-matrix`, the usage records' to `porelo`,
  the schedule and the target perhaps to the deploy repository of [PJ40](README.md#pj40).
