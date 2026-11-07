# PJ96 — What A Host Builds Is Used On The Host First

**Status:** Analyzed; Accepted by the operator.
**Size:** L - crosses `porelo-host` (what the host's forge keeps and serves), `porelo` (how a task reaches it) and the
repositories whose builds publish packages; three issues of S or M once split.

**What must be true.** What a host's own builds produce - Maven snapshots, the skill packages, installable packages -
is usable by every other task on that host as soon as it is built, without waiting for the central build to publish it
to Maven Central's snapshots or the project's Artifactory; a task reaches it on the host, not on the internet, and
what reaches the central repositories still comes only from the central build.

## Why

It is what the agents do by hand today on one machine: an agent that needs another repository's work to test it
locally takes that agent's local build - its package with its digest, or the snapshot it installed into a shared local
Maven repository - long before the central build publishes it. In tasks on a host the same exchange has no shared
directory to go through, and a guarded task reaches the skills only by naming the remote Artifactory in its egress.
The host's own build has made the artifact already; its consumers should not wait for a round trip through the
central forge.

## Plan

Read in today's `porelo-host` (`doc/local-forge.md`) and `porelo` (`doc/project-file.md`, `doc/decisions.md`):

- **Maven snapshots are mostly there.** With the forge on, `up` makes a package-only publisher, and the local
  workflows deploy snapshots to the forge's registry (`/api/packages/<project>/maven`) even with `PORELO_PUBLISH=false`.
  Each task's gate token also reads, never writes, its project's packages. Missing: how a task's own Maven inside the
  container reaches that registry (tasks get no forge socket), and a settings file that resolves it before Sonatype.
- **Installable packages and skills are not.** What goes to Artifactory (`.deb`, `.rpm`, the skill packages) is a
  central-only job that `PORELO_PUBLISH=false` skips, so a host keeps no copy. Forgejo has generic, Debian and RPM
  registries that could take them from the local build, under the same publisher.
- **The way in exists in porelo:** `egress.host_services` names services on the task's own host; each resolves to the
  gate's host address on TCP 443, in every class, offline included. The forge's registry served under such a name,
  read only, gives a task its project's artifacts without any external egress.
- **Steps, each an issue:** (1) `porelo-host`: the local builds deploy every kind of artifact to the forge's registry,
  and the registry is served read only under a host-service name; (2) `porelo`: a task's tools are pointed at that
  name (Maven settings, the skills' base address) when the project declares it, with no credential in the task; (3)
  the skills: the packages a host's build makes, or copies checked against their digests, live in that registry.
- **Red first:** a task on a host resolves a snapshot that another task's build deployed minutes before, with Sonatype
  and Artifactory unreachable; today that fails.

## Acceptance

- A task on a host builds against a snapshot another task's build on the same host made minutes before, with nothing
  published centrally in between; the same for a skill package and an installable package.
- A guarded task reaches the host's copy without any egress beyond its own host's services, and cannot write to it.
- A release resolves from the central repositories alone; a snapshot made on the host is never mistaken for a
  published one.

## Open questions

- Where do the skill packages come from on a host: built there from their sources, or copied from the project's
  Artifactory and checked against their digests? The second keeps one source of skills and still needs the egress.

## To be checked

- How a task's Maven reaches the forge's registry today, if at all, measured in a task on the rehearsal host.
- Whether Forgejo's Debian and RPM registries take what the packaging builds make, unchanged.
