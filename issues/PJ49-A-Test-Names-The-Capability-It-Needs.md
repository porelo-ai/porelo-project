# PJ49 — A test names the capability it needs

**Status:** Accepted.

**What must be true.** A test that needs something a Porelo task does not give - a nested container, `/dev/kvm`, the
kernel keyring, a desktop session - says so by a tag naming that capability. Each place a build runs names the
capabilities it lacks and leaves out exactly the tests tagged with them. The tags say only what an agent runs inside
its task **before it pushes**: every untagged test, green. They do not say when the work is done. In an `online`
project every push of a task starts a build the agent sees - the local Forgejo's, or the central forge's where there is
no Forgejo in between - and that build runs every test, the tagged ones too. A task is finished only when that build
is green.

## Why

Each repository's whole local check was run inside its draft `porelo.yml` image, as a task would run it: rootless
podman, its default seccomp, no `--privileged`, no `/dev/kvm`, no D-Bus. Most were green. What failed failed for want
of a capability, not for a fault of the code:

- porelo-message-matrix: 44 of 50 integration tests start the homeserver in a container, which cannot start inside
  the task's container;
- porelo-pi: the package's tree is built by `npm ci` inside a pinned Node image, the same nested container;
- porelo-host: Molecule makes a libvirt VM and needs `/dev/kvm`;
- porelo: the vault's tests use the kernel keyring, whose system calls the task's seccomp refuses
  ([B211](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b211) makes the code see that).

Without a rule, an agent in a task either cannot get a green build or leaves such tests out by hand, each repository
its own way, and nobody can see which tests ran where.

## The shape proposed

- **A tag names a capability, never a place.** For example `needs-nested-container`, `needs-kvm`,
  `needs-kernel-keyring`, `needs-desktop-session`. What a task, a task class, the forge or GitHub can do may change;
  the tests then stay as they are and only the list of what a place lacks changes.
- **One mechanism per language, the build tool's own:** JUnit's `@Tag` with Maven Surefire and Failsafe groups, Dart's
  `@Tags` with `dart test -x`, pytest markers with `-m "not …"`, Gradle's test filters. Excluding is a build-tool
  switch, as [PJ46](README.md#pj46) does for the document tests.
- **Each place names what it lacks**, in one shared list: a Porelo task leaves out every `needs-*` tag; the forge and
  GitHub leave out none.
- **A tag is no way around a test.** It is set only for a capability that is really missing, with the reason in a
  comment, and a change to a tag is seen in review like any change to a test.
- **Mending comes first where it is cheap.** A test that can run in a task at small cost is changed to run there -
  matrix's homeserver started as its own binary, pi's `npm ci` run with the pinned Node directly - because the agent
  should see the most telling tests itself. The tag is for what remains.
- **A rule in the shared block** once the shape is settled: before a push, the agent's task runs every test its place
  does not leave out; the task is finished when the build its push started is green.

## To be checked

- The list of capabilities, gathered from every repository's run in its draft image.
- Whether a task class may one day give a capability (KVM for porelo-host, say); the tags then stay and only that
  class's list changes.
