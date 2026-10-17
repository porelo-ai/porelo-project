# PJ25 — McPorelo Apple Containers

**Status:** Analyzed; parked: native Porelo on macOS is not planned in the near future, while the interface on macOS with Porelo in a local VM comes first (`porelo-frontend` [F109](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f109)).
**Size:** XL - a second implementation of the guarantees on another platform; it splits into `porelo` [B59](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b59) measured on Linux (L), a reading of Apple Containers' primitives (M), the daemon's contract checked free of Linux primitives (M), McPorelo itself in a repository of its own (several L), and one client and shared acceptance scenarios (L).

**What must be true.** A person on macOS can run tasks with the same guarantees as on Linux, through
a sibling project on Apple Containers, and drive either kind of host from one client without
having to know which is on the other end.

## Why

A sibling project, **McPorelo**, offering the same behavior on Apple Containers so
that macOS is a first-class host rather than an unsupported one. The graphical
client is one codebase and connects to either, without the person using it having to
know which is on the other end.

Today the containment is Linux kernel machinery — a firewall ruleset loaded into the
container's network namespace, runtime hooks, user namespaces, the kernel keyring —
so a second implementation is a re-derivation of the guarantees, not a port of the
code. What must be preserved is the guarantees themselves: default-deny egress that
fails closed, no credential inside the container, and work leaving only through
review.

## The shape

The daemon's varlink contract - built, and the reason its requirement is retired - becomes the
boundary between the two, so what is added to it has to stay free of one platform's primitives. The same
applies to `porelo` [B06](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b06): a person on one host driving tasks on the
other is the normal case, not an edge case.

## Plan

- **First, `porelo` [B59](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b59)** on Linux: what survives a task with its own kernel.
- **Then a reading of Apple Containers on a Mac**: fail-closed egress per container, a host socket in a
  container, the host's loopback mapped in. What is not there is written down as a guarantee not met.
- **The contract**: the varlink definitions in `porelo/daemon/src/main/resources/varlink/`
  (`org.fuin.porelo.Tasks1`) read for anything only Linux has.
- **McPorelo**: a repository of its own, its own issues, its own acceptance suite running the shared
  scenarios.
- **The client** (`porelo-frontend`) drives both hosts through the one contract.
- **Seen to fail first:** a shared scenario in which a task starts although its egress policy could not
  be applied.

## Acceptance

- The same project file runs a task on either host, or says plainly which parts do
  not apply.
- Default-deny egress is enforced by the platform and fails closed: if the policy
  cannot be applied, no task starts.
- The real credential stays outside the container, and the provider's own endpoint
  is unreachable from inside it.
- The client discovers and drives both kinds of host through one contract, with no
  branch on host type in its own screens.
- Each side is verified by its own acceptance suite, running the same scenarios.
- Where a guarantee cannot be met on one platform, the client says so rather than
  presenting an equal-looking task that is less contained.
- **Seen to fail:** the shared acceptance scenarios, run against each host, go red when a task
  starts although its egress policy could not be applied, when the provider's endpoint is reachable
  from inside, or when a guarantee one platform cannot meet is presented as equal; a check of the
  client's screens goes red when one branches on host type.

## Open questions

- **Which isolation primitives actually exist there**, and whether per-container
  egress filtering that fails closed is among them. If it is not, this project can
  offer convenience but not the guarantee, and that has to be said out loud rather
  than discovered by a user. - the operator's to decide, after a reading on a Mac.
- Whether a host socket can be mounted into a container, which is how the credential
  proxy and the signing agent work today. Without it, both need a different shape. - the operator's to
  decide, after a reading on a Mac.
- **Whether the host's loopback can be mapped into a container.** On Linux the git gate binds
  `127.0.0.1` and is reachable from a task only because pasta is told to send the container's
  address for the host there. Without an equivalent, the endpoint a task pushes to is either
  unreachable or on the operator's network, and that has to be said out loud rather than left
  to look like the same guarantee. - the operator's to decide, after a reading on a Mac.
- How much is genuinely shared. If it turns out to be only the contract and the
  client, that is still worth doing — but it should be a decision, not a surprise
  discovered halfway. - the operator's to decide.

## To be checked

- **Measure it on Linux first.** `porelo` [B59](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b59) asks the same questions about a task whose
  kernel is its own - where the ruleset lives, whether a host socket still reaches the workload,
  what happens to the gate's loopback, what replaces the terminal - on a machine where the
  acceptance suite already runs. What survives there is what can be re-derived here; what does not
  is a guarantee this project would have to state it cannot meet. - Agent Core's to measure, in `porelo`
  [B59](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b59).
- Whether the two backends can share one contract without it degrading to the
  weaker platform's capabilities everywhere. - Agent Core's to decide.
