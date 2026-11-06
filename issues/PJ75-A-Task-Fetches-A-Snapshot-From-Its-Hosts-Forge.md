# PJ75 — A task fetches a snapshot from its host's forge

**Status:** Accepted (operator, 2026-11-06).
**Size:** M - a read token for the task on the host, a destination for the registry at a host's start, and the task's Maven reading both sources.

**What must be true.** A task on a host with a local forge fetches a snapshot from the forge's package registry by the
name its project declares, without the person putting a credential into the project; and it still reaches nothing else
on the host.

## Why

The host's forge makes its organization and repositories private, and a task gets no forge token, so a task reaching
the registry by its declared name is refused with `401`.

The shared building blocks (porelo-parent, porelo-buildtools) live in their own organization on the host's forge, which
is public there: everyone on the host, every person and every task, reads their snapshots without a token. They are
open source and public on Sonatype already. A project's own snapshots stay private.

## After the snapshot rule

Snapshots come in principle from the central source; the host's registry holds only what was built locally and has not gone through the central forge ([BT42](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt42)). A task reads Sonatype already, so a trial move builds without this issue. It is needed only for a snapshot built on the host and not yet central, and for a private project's own artifacts. Read from the code, not run on a forge.

## Plan

1. A read token for the task, made as the forge helper's `task` start makes its forge token, so that removing the task ends it. Whether that token gains `read:package` or a second one is made depends on whether the task's forge user may read the organization's packages: measured with Forgejo on a host.
2. At a host's start, a destination for the registry, its upstream limited to `/api/packages/<organization>/maven`, with that token, and `MAVEN_SNAPSHOTS_URL` set in the task. The task holds only a worthless token; the host's proxy adds the credential.
3. The task's Maven reads both sources in the shape of the design above, with the same filter: a private project's names are not asked outside from a task either.

**Red first:** a task's fetch of a private snapshot answers `401` today. The acceptance adds that any other path of the forge is still refused through the destination. Only a host can run that end to end.

## To be checked

- Where a downstream build on the local forge takes porelo-parent's pom from: porelo-buildtools' Build there downloaded
  the parent's `maven-metadata.xml` from `porelo-forge`, and its log names no download of the pom.
