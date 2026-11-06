# PJ75 — A task fetches a snapshot from its host's forge

**Status:** Analyzed.
**Size:** M + S - Porelo's package route, Maven answers and settings (M, porelo), the task token's `read:package` scope (S, porelo-host).

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

## Analysis

Read in the code of porelo and porelo-host, nothing run on a forge.

**The host.** A task's gate pushes as the person's forge user, which the host's follow keeps in the project's
`developers` team, and that team may read the organization's packages. The task's token cannot: it is made with
`write:repository` alone, and Forgejo checks a token's scope on the package API apart from the team's rights. So the
existing task token gains `read:package`; no second token is made, and the task start keeps its one token. A Molecule
check proves that the token reads its organization's Maven packages, cannot write them, and reads nothing of another
organization. The host's gates already pass the package routes with a token and change nothing.

**Porelo.** What exists: the host's task token, kept on the host and used only for the gate's git forwarding; the broker
that hands a task a worthless token for a credential it holds; and `Configure` carrying a tool's repositories and its
adapter block. What is left:

1. A package route through the task's broker: `GET` and `HEAD` only, below `/api/packages/<organization>/maven` of the
   task's own project. Another organization, another path, a traversal, also encoded, a redirect and every write are
   refused before an authenticated request leaves. Today the broker checks host and port, not the path. The token
   cannot keep itself to one project, since the person's forge user is in every project they join, so this route is
   the bound.
2. Maven's answers on that route alone: POMs, metadata, checksums and jars pass byte for byte, by a policy of that route,
   not by loosening what the broker passes elsewhere.
3. The broker reads the task's own host-issued token by a narrow way of its own, never by widening the credential view,
   and the start makes the token before the broker.
4. The repository's `porelo.yml` names the tool repository and the credential by name and kind
   (the repository's own settings kept in Default, then a tool's repositories placed in a task), and `Configure` writes Maven's
   settings with the broker's address and the worthless token. A build run with `-s settings.xml` ignores the
   person's settings, so the shared settings file reads the same variable, as porelo's Build on the host's forge does.

**Red first:** a package request outside the organization's Maven path is refused before upstream; a jar and a POM
round-trip unchanged; the real token is never in the container, its environment or its settings; a failed start revokes
it. Only a host with Porelo's task start and the forge together shows a real task resolving a private snapshot by its
declared name.

**Order.** The host's scope stands alone. Porelo's part follows the repository's own settings in Default and the tool's
repositories placed in a task.

**Estimates.** The host's scope 60 minutes; Porelo's part 180 minutes once those two have landed.

**Open.** Whether removing a task revokes its token at once or its expiry is enough; the shared rule for the newest
snapshot and the filter of private names, shared with porelo's Build on the host's forge.

## To be checked

- Where a downstream build on the local forge takes porelo-parent's pom from: porelo-buildtools' Build there downloaded
  the parent's `maven-metadata.xml` from `porelo-forge`, and its log names no download of the pom.
