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

## porelo's command line

porelo keeps a higher share of end-to-end tests over its command line than the table gives, since the command line is
what its users meet. They still run last, as their own step before a hand-over. Faults are found earlier, by the unit
tests, and those tests are written first so that they shape the domain classes: a class that is hard to test alone is
designed again, not covered from the top.

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

## The audit of 2026-11-09

Every repository measured its suites the same day, each in its own issue listed in story ST296, by count of tests; a module's unit suite is its unit tests run
alone. Three repositories meet the shares: porelo-forge-clients, porelo-ecosystems and porelo-buildtools.

| Repository | Unit | Integration | End-to-end | Unit suite | Fixes |
|---|---|---|---|---|---|
| porelo-forge-clients | 99.8 % | 1 test | none | 17 s | 2 S |
| porelo-ecosystems | 88 % | 9 % | a corpus run by hand | about 190 s | S, M |
| porelo-buildtools | 71 % | 29 %, three times the unit time | rented machines | 11 s | 10 |
| porelo-agy | 68 % | 23 % | 10 % | under 34 s | XS |
| porelo-claude-code | 62 % | 26 % | 12 % | under 34 s | S |
| porelo-codex | 62 % | 29 % | 9 % | under 34 s | XS |
| porelo-host | 38 %, 61 % once its Python tool is gone | the rest | Molecule, a rehearsal | 2 min 50 s | 8, S or XS |
| porelo-adapters | 57 % | 43 % | the package steps only | 2 s | 3 XS, 2 S, 2 M |
| porelo-message-matrix | 57 % | 43 % | none | 178 s | 2 M, 3 S, XS |
| porelo-pi | 56 % | 33 % | 11 % | under 34 s | M |
| porelo-message-sluice | 54 % | 44 % | 2 % | 16 s | M, 2 S |
| porelo-omp | 54 % | 29 % | 17 % | under 34 s | S |
| porelo | 48 % | 48 %, 3533 s | 3.6 % | 122 s | 14: 3 L, 9 M, 2 S |
| porelo-frontend | 34 % | 65 %, 96 % of the time | 0.6 % | 142 s | L, in slices |
| porelo-mcp | 29 % | 64 % | 7 % | 51 s | 2 XS, 3 S |
| porelo-intellij | 20 % | 73 % | 6 % | 83 s | 4 S, 2 XS |

What the audits share:

- **The middle is too thick.** Flows are proven through real sockets, a homeserver, a mailbox, a started JVM or the
  whole window, where a fake would do.
- **Tests wait for real**: sleeps of one to ten seconds, one of two minutes, real DNS and TCP. An injected clock and
  fakes take them out.
- **Guards proven only from above**: organization trust and writes and the credential exchange in porelo, the methods
  MCP must never carry and the bearer token's refusals in porelo-mcp, Pi's guard against a stored sign-in, the refused
  hosts of porelo-codex and porelo-agy, and the lease and snapshot build of porelo-buildtools.

Two shares stay below the table on purpose: porelo's command-line features (see above), and the five agent adapters,
whose workflow steps and hooks are shell, tested with stand-in tools at their lowest level.

## The order of the fixes

1. The guards proven only from above, moved down first: porelo, porelo-mcp, porelo-pi,
   porelo-codex, porelo-agy, porelo-buildtools.
2. An injected clock and fakes in place of real waits, in every repository.
3. The rest repository by repository, the largest first - porelo, porelo-frontend, porelo-message-matrix,
   porelo-host - as the four running stories free their agents.
