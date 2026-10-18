# PJ45 — Chosen data outlives the machine

**Status:** Analyzed.
**Size:** M - a small contract, `restic` to a store, two repositories' parts (`porelo-message-matrix`, `porelo`), the playbook's
timer, and a round trip measured on a rented host.

**What must be true.** A short list of data that lives only on a machine and is worth keeping is copied off it
regularly, and put back when the machine is set up again; everything else on the machine is thrown away with it.
To start with the list holds three things: the conversation in the project's Matrix room, the tasks' token usage
records and the Maven cache. More can be added to the list later without a change to how it is copied.

## Why

A machine that runs a project ([PJ39](README.md#pj39), [PJ40](README.md#pj40)) is set up again whenever it is
needed and given back when the work stops; the code is safe in the forge. Two things are not in the forge: the room
where the agents and the person talk - the record of hand-overs, questions and answers - and the usage records that
[PJ38](README.md#pj38)'s velocity is computed from. Losing them with every machine loses the history of the work.

## The shape proposed

- **A list of what is kept**, each entry a kind of data with how it is read consistently while it is in use: the
  homeserver's database (Tuwunel's, in its podman volume), the usage records (`usage/<task>.jsonl`, appended
  line by line) and the Maven cache (`~/.m2/repository`), whose download every new machine would otherwise repeat.
- **Copied regularly and at down** to the project's store ([PJ40](README.md#pj40)): S3 object storage written by
  `restic`, encrypted on the host and deduplicated, its address and keys on the person's drive. Nothing is
  copied anywhere the person did not name.
- **Put back at up**, before the homeserver and the tasks start, so a new machine continues the same room and the
  same records.
- **Only consistent copies:** a database is copied by its own means of a backup or while it is stopped, never as files
  a running database is writing; an append-only record may be copied as it stands.
- **Nothing secret is added to it:** the vault is not on the list; its entries are deposited again at up.
- **Nothing more than needed:** what the forge holds, what is built again (images, caches, the registry's
  snapshots) and the tasks themselves are not on the list.

## Plan

Read in today's code and in Tuwunel's documentation
([backups](https://matrix-construct.github.io/tuwunel/backups.html)).

- **The homeserver, by Tuwunel's own online backup.** Tuwunel keeps its database in RocksDB, in the
  podman volume `porelo-matrix-homeserver` (`TUWUNEL_DATABASE_PATH=/data`, set by
  `porelo-matrix-homeserver.service` in `porelo-message-matrix`). It makes consistent backups while it
  runs: `database_backup_path` names a directory, `database_backups_to_keep` how many it keeps, and the
  admin command `!admin server backup-database` makes one. A backup's files are written once and never
  changed, so the backup directory may be copied as it stands.
  Restore: with the homeserver stopped, its binary started once with `--restore-backup` puts the newest
  backup into `database_path`. Media are not in a backup and are left out.
- **48 restore points are kept**, two working days of hourly backups: `database_backups_to_keep = 48`.
  The store keeps the same 48 of the backup directory; a backup shares
  its unchanged files with the ones before it, so 48 cost little more than one.
- **`porelo-message-matrix` builds the homeserver's part:** the unit mounts a second volume as
  `TUWUNEL_DATABASE_BACKUP_PATH`, and the transport gains `backup <dir>`, which gives the admin command in
  the admin room it already uses (`AdminRoom`), waits for the answer and copies the new backup into
  `<dir>`, and `restore <dir>`, which with the unit stopped copies `<dir>` back and runs the restore once.
- **`porelo` builds the usage records' part,** where [PJ38](README.md#pj38) writes them under the
  account's state directory: an append-only record is copied as it stands, so `porelo keep <dir>` copies
  them, and `porelo keep --restore <dir>` puts them back before a task starts.
- **The Maven cache** is copied at down only, since it is large and changes little, and one snapshot of it is
  kept; it is put back at up before the first build.
- **`restic` does the copying for every entry:** each entry's command writes its consistent copy into a local
  directory, and `restic backup` sends the directories to the store, `restic forget --keep-last 48` (one for
  the cache) thins it, and `restic restore` brings them back at up. The keys come from the vault.
- **One contract for the list,** so a new entry changes nothing in how it is copied: each entry is a
  command that writes its consistent copy into a directory it is given, and one that puts it back, run
  in the order the list names. The two above are its first entries. The vault is never one.
- **The schedule and the target are the playbook's** ([PJ40](README.md#pj40)): a systemd user timer runs
  the list every hour while the machine runs, and once more at down, into the project's store; up runs the
  restores before the homeserver and the tasks start. Plain systemd and `restic` are enough; nothing of
  Porelo's own schedules it.
- **Red first:** a room with messages, the machine given back, a new one set up from the copy, and the
  same messages read there; without the restore they are gone.

## Acceptance

- On a rented host, a room's messages and the usage records written before down are there after up on a
  new machine, read by the person and by `porelo` alike.
- A backup made while the homeserver is busy loads; a copy of the live database files is never taken.
- Seen to fail first: the same round trip without the restore step loses the room.

## To be checked

- Whether a backup made by one Tuwunel version restores into the next one pinned (the documentation says
  nothing); measured once when the pin moves.
- Whether anything Porelo sends into a room is media rather than text (an attachment, an image), which a
  backup leaves out.
- How long a backup and its copy take on the mounted drive, with a room of a few weeks' messages.
