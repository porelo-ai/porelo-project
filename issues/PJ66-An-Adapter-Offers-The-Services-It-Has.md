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
- **A contract marks each function mandatory or optional.** A mandatory one is what makes the service of use at all,
  such as a branch's head and a commit's verdict for `build`; in the Java interface it is an abstract method. An
  optional one makes the service richer, such as starting a failed job again; in the Java interface it is a default
  method that answers "not supported" until an adapter implements it.
- **`describe` names, per service, its contract's version and the optional functions the adapter serves.** An adapter
  that lacks a mandatory function is refused at `describe`, by name and before any task needs it, as an unknown
  version is today. An optional function it lacks is off for that adapter: the interface does not offer it, and a call
  to it is answered "not supported".
- **A contract version or a function can be deprecated** before it is removed: the contract says since which release,
  and in which it goes (in Java `@Deprecated(since = "...", forRemoval = true)`). Porelo still takes a deprecated one,
  says so at `describe` and at every start that uses it, and refuses it only from the release named. So a new contract
  version, such as `Build2` beside `Build1`, needs no window in which adapters are refused.
- **The project file names a service, its adapter and its credential,** for example `builds: { adapter: github,
  credential: github-actions }` and `reviews: { adapter: bitbucket, credential: … }`, so each service signs in with its
  own rights.
- **Adapters are found in one place,** with a directory per adapter rather than per service, and an adapter's package
  installs it there.
- **Repositories follow adapters, not services:** the repository [PJ62](README.md#pj62) makes is named
  `porelo-adapters` (decided), for the adapters it holds - github, forgejo, later jenkins - with every service each
  offers.
- **Agents and transports move to the same `describe` with their next release** (decided), not all at once.

## Not in it

- **Message filters behind the filter:** porelo-message-sluice is to reach further filters of outside providers later;
  that is its own design, inside Sluice.
