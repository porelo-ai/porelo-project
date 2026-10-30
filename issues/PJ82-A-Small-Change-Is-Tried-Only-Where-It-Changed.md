# PJ82 — A small change is tried only where it changed

**Status:** Idea.

**What must be true.** On a host with a local forge, a bugfix or other small change made in a task is tried on the
host's VM only in the area it changed, so that runs on the local VM get shorter, and the second agent's review of it
is limited to that same area. Both only show that nothing there is broken; the full test runs afterwards on the
central forge. A project with only the central forge and no local one on its host is not affected.

## Why

The operator asked on 2026-10-30 to shorten the run times on the local VM: a bugfix or small change is tried there
only in the area where it changed, and the second agent's review is limited to the same area. It is only meant to show
that nothing is broken; the full test runs afterwards on the central forge.

## To be checked

- Whether a task can choose a part of an acceptance run on the host's VM today.
- How the area is marked: area tags on tests (such as JUnit 5 tags), the Java packages a change touches, or another
  way per kind of repository; every agent is asked for ideas for its own repositories.
- How the area of a change is found (changed files, modules, roles) and passed on, both to the try on the VM and to the
  second agent's review ([PJ67](README.md#pj67)).
- What makes a change small enough for this, and who says so: the task, the issue's size or the person.
- What the local forge's runner runs on a push from a task, and whether that run stays complete or follows the same
  limit, given that the central forge runs the full test afterwards.

## What each repository proposes

Asked of every agent on 2026-10-30, each for its own repositories. Common ground: the saving lies in the slow parts
(native image, integration and acceptance legs, VM runs, Molecule, IDE verification); where a path no map names, a pom
or parent change, or a contract read by another repository is touched, the run is full. Where a module's unit suite is
cheap (matrix, sluice, host, the adapters) it stays whole. Java packages alone were judged too weak by porelo (they call
each other freely), porelo-message-sluice (its verdict tests sit outside the changed package), porelo-forge-clients and
the adapters; porelo-intellij, whose packages depend on each other in a fixed order, uses them together with every
package depending on them.

| Repository | The area is | Cost | Where it fails |
|---|---|---|---|
| porelo | the Maven modules a diff touches, run with `-pl <modules> -amd`; acceptance legs tagged with the modules they drive | S, plus an `affected-modules` command in porelo-release | root pom, settings, shared test resources, wire's JSON read by other repositories, native-image configuration |
| porelo-forge-clients | the Maven modules a diff touches, with `-amd`, and a short map for the rest; the live check only when a client or its fixture changed | about 40 lines of script | openapi-extract reaches the clients as a plugin dependency, which `-amd` may not see (to be measured); a pinned version or generator snapshot in the root pom changes every generated record; a re-recording changes only resources yet must run that module's replay |
| porelo-frontend | the tests that import a changed file, transitively, from Dart's import graph; no hand-kept tags | S | effects that pass no import: keys the walks find by string, JSON checked against the mock, screenshots, shell scripts; full run on pubspec, analysis_options, test/support, linux/ or windows/, or over about 40 affected tests; wire and Key changes always add test/wire and walks_test |
| porelo-message-matrix | JUnit 5 area tags on the slow integration tests, and a map from paths to tags | S | its core lifecycle and client sit under every area; the contract with Porelo |
| porelo-message-sluice | legs instead of tests: the native image and the VM acceptance only when main code, a pom or a packaging file changed; a path-to-legs map in one committed file, a documents test fails on a tracked path no entry matches, an unmatched path means the full run (fail closed) | S | a detector change alters every verdict, seen only by the corpus tests; native-only failures; a pom or parent bump reaches everything |
| porelo-host | Ansible tags per area on verify and side effect, from a path map; converge stays whole, since the host must stand | M; the gain is uncertain, so measure converge against verify first; if converge dominates (likely most of the 11 min), skip roles in converge as FORGE=off does today | steps depend on what earlier steps made; helpers meet through timers and locks across areas |
| porelo-intellij | the changed packages and those depending on them, read from imports; IDE verification only when plugin.xml, gradle.properties, libs.versions.toml or a public API used by IntelliJ changed | S | plugin registrations, the wire version and the verification metadata reach everything; a live-test change needs the daemon |
| adapters (claude-code, pi, omp, codex, agy) | a Cucumber area tag per feature, chosen by a shared path map; the agent definition, the pom and the acceptance glue mean the full suite (fail closed) | S each, S/M once in porelo-release | most changes touch the agent definition or the pin, which reach every scenario; a change to how Porelo starts the container, or an image change, is caught only by the forge's full run |

Proposed by several: a committed map from paths to areas (matrix, sluice, host, intellij, the adapters), a check that
fails when a path or a test has no area (fail closed; matrix, sluice, host, intellij, the adapters), a shared
porelo-release command that turns a diff into the area list (porelo, the adapters), and the same list handed to the
second agent's review (porelo, frontend, host). porelo-forge-clients and porelo-frontend each propose a script of their
own in the repository.
