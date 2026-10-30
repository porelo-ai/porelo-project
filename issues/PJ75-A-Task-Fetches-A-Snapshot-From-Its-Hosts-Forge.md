# PJ75 — A task fetches a snapshot from its host's forge

**Status:** Idea.

**What must be true.** A task on a host with a local forge fetches a snapshot from the forge's package registry by the
name its project declares, without the person putting a credential into the project; and it still reaches nothing else
on the host.

## Why

The host's forge makes its organization and repositories private, and a task gets no forge token, so a task reaching
the registry by its declared name is refused with `401`.

The shared building blocks (porelo-parent, porelo-buildtools) live in their own organization on the host's forge, which
is public there: everyone on the host, every person and every task, reads their snapshots without a token. They are
open source and public on Sonatype already. A project's own snapshots stay private.

## To be checked

- Where a downstream build on the local forge takes porelo-parent's pom from: porelo-buildtools' Build there downloaded
  the parent's `maven-metadata.xml` from `porelo-forge`, and its log names no download of the pom.
