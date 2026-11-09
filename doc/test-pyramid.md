# The test pyramid

Every Porelo repository tests along the pyramid: many fast unit tests at the base, fewer integration tests in the
middle, and only a few end-to-end tests at the top. The shared rule in `AGENTS.md` (*Testing and machines*) says
so in two sentences; this page defines the levels and how each repository's audit measures them.

## The three levels

| Level | Share of all tests | What it tests | Speed and cost |
|---|---|---|---|
| **Unit** | about 70-80 % | the smallest isolated unit - one method or class - with no outside system: no database, network, daemon, container or VM | milliseconds; cheap to write and to keep |
| **Integration** | about 15-20 % | several components together, or the code against a real outside system: a socket, a real git, a container, the daemon | slower: they start a context or use real interfaces |
| **End-to-end** | about 5-10 % | the whole product as its user meets it, from the window or the command line down to the host | slow, brittle against small changes, costly to keep; only for the most critical flows |

A flow - its states, choices, limits and failure paths - belongs at the base: built as plain logic behind small
interfaces, it is proven by unit tests over fakes. What the levels above add is only what the base cannot show.

## The tools per stack

| Stack | Unit | Integration | End-to-end |
|---|---|---|---|
| Java | JUnit 5, AssertJ, Mockito or hand-written fakes | JUnit 5 with real sockets, git and containers (Podman) | Cucumber features on a VM or a rented machine |
| Flutter (Dart) | `flutter_test` unit tests | widget tests against a stand-in backend | `integration_test` against a real porelod |
| Ansible | role logic in Python with pytest, where it has logic | Molecule scenarios in a container | Molecule on a VM |

## The audit

Each repository's audit, one issue per repository under ST296, lists:

- its suites by level, with how many tests each holds and their measured run time, so the shares can be compared
  with the table above;
- every flow tested only through an integration or end-to-end run, by name;
- tests that wait, sleep or reach the network where a fake would do;
- the fixes, each sized.

The story is accepted when every such flow has unit tests over fakes, the unit suite of each module runs in under a
minute, and no plan needs a VM to see a flow work.
