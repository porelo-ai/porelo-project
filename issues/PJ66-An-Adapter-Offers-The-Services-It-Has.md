# PJ66 — An adapter offers the services it has

**Status:** Idea.

**What must be true.** Every program Porelo finds to reach something outside itself - an agent, a build server, a
forge's reviews, a model provider's limits, a transport - says which services it offers, each by its own contract and
version, and answers "not supported" to what a service of it cannot do. A project names the adapter and the credential
for each service it uses, so one company's offer, such as GitHub's, is several services with their own rights, and a
forge, a build server and a model provider are never mixed up because one company happens to offer all three.

## Why

Porelo reaches outside through several kinds of plug-ins today, each found its own way:

| Service | Found as | Contract |
|---|---|---|
| agent | a program under `/usr/libexec/porelo/agents/<name>` | `Agent1` |
| model provider | a data file `providers/<name>.yaml`, no program | none |
| build | a program under `/usr/libexec/porelo/builds/<forge>` | `Build1`, `Build2` coming |
| review (planned) | the same program as build | `Review1` |
| transport | a program under `/usr/libexec/porelo/transports/<name>` | its verbs |
| build tool (planned) | a program | `Ecosystem1` |

Three things are mixed up:

- **A build server is found and named as a forge:** `builds/<forge>` and `builds.forge: github` in the project file,
  though Jenkins builds for Bitbucket. The repository being made for the build adapters ([PJ62](README.md#pj62)) carries
  the same mix in its name.
- **A program's `describe` names one forge and one protocol version,** not the services it offers, so build and
  review behind one program cannot be told apart or asked for separately.
- **A model provider is only a data file,** so nothing can read its limits ([PJ65](README.md#pj65)).

## The shape proposed

- **An adapter is an installed program; a service is a contract.** `describe` answers the adapter's name and a list
  of services, each with its contract and version, for example a GitHub adapter: `build` (`Build2`), `review`
  (`Review1`), `model-limits` (a new `Limits1`). Jenkins offers only `build`, Bitbucket only `review`.
- **Each service is one contract,** a Java interface in Porelo's API kit and a varlink interface on the wire, as
  `Agent1` and `Build1` are today, with its own version.
- **"Not supported" is an answer of its own** for a call a service of that adapter cannot serve, never an empty
  result read as nothing found: the rule porelo
  [B224](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b224) sets for agents, for every service.
- **The project file names a service, its adapter and its credential,** for example `builds: { adapter: github,
  credential: github-actions }` and `reviews: { adapter: bitbucket, credential: … }`, so each service signs in with its
  own rights.
- **Adapters are found in one place,** with a directory per adapter rather than per service, and an adapter's package
  installs it there.
- **Repositories follow adapters, not services:** the repository [PJ62](README.md#pj62) makes would be named for the
  adapters it holds (github, forgejo, later jenkins), not for one service.

## Not in it

- **Message filters behind the filter:** porelo-message-sluice is to reach further filters of outside providers later;
  that is its own design, inside Sluice.

## Open questions

- What the repository [PJ62](README.md#pj62) makes is named, before sprint 3 of release 0.6 renames
  `porelo-build-github`. Proposed: `porelo-adapters`.
- Whether agents and transports move to the same `describe` now, or as each is next released.
