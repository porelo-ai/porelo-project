# porelo

<img src="doc/images/early-bird.svg" width="350" alt="Early bird - work in progress">

> **Early bird - work in progress.** Porelo is not stable yet: until release 1.0.0, its code, commands
> and file formats can change without notice.

**The project.** Porelo is a hardened box an agent works in, and a gate its work leaves through.
This repository is not part of it: it is where the project is *defined and planned*, and it holds
no product code.

The documentation of all of Porelo is one site, **<https://porelo-ai.github.io>**; this
repository's chapter is <https://porelo-ai.github.io/porelo-project/>.

## What is in here

| | |
|---|---|
| [`project.yml`](project.yml) | The project definition. What the repositories are, what class of trust a task runs under, what it may reach. |
| `issues/` | The requirements that belong to the project rather than to one of its repositories. |

## What a project is, and why this repository exists

**A project is a named unit of work over one or more git repositories.** It is not a second name
for one of them. Porelo's own work is this repository, which holds the planning, and
the ones the work happens in.

| Name | Repository | What it is |
|---|---|---|
| `porelo` | [porelo-project](https://github.com/porelo-ai/porelo-project) | This one. The project's own repository. |
| `core` | [porelo](https://github.com/porelo-ai/porelo) | The CLI, the daemon, the gate and the guarantees they make. |
| `frontend` | [porelo-frontend](https://github.com/porelo-ai/porelo-frontend) | The interface, which reaches the daemon over the socket and never the filesystem. |
| `sluice` | [porelo-message-sluice](https://github.com/porelo-ai/porelo-message-sluice) | The message filter: what may pass between tasks. |
| `matrix` | [porelo-message-matrix](https://github.com/porelo-ai/porelo-message-matrix) | The Matrix transport: a project's room, where tasks talk. |
| `claude` | [porelo-claude-code](https://github.com/porelo-ai/porelo-claude-code) | The packaged agent: Claude Code. |
| `pi` | [porelo-pi](https://github.com/porelo-ai/porelo-pi) | The packaged agent: pi. |
| `omp` | [porelo-omp](https://github.com/porelo-ai/porelo-omp) | The packaged agent: oh-my-pi. |
| `codex` | [porelo-codex](https://github.com/porelo-ai/porelo-codex) | The packaged agent: Codex CLI. |
| `buildtools` | [porelo-buildtools](https://github.com/porelo-ai/porelo-buildtools) | Build and test tooling: rented test machines, release checks and package checks. |
| `host` | [porelo-host](https://github.com/porelo-ai/porelo-host) | The host playbook: brings a project up on a server and takes it down again, owned or rented by the hour. |
| `site` | [porelo-ai.github.io](https://github.com/porelo-ai/porelo-ai.github.io) | The documentation site: every repository's `doc/` collected into one site. |

The names in the first column are what a person types. They say what a repository *is* rather than
what it happens to be called on GitHub - which is also why the core repository is not called
`porelo`: **the project's own repository is named after the project**, so that name is taken.

## A task works on exactly one repository

```sh
porelo task start review --repository core
```

A project that names several repositories never guesses which one is meant: a start without one
is refused, naming the repositories it has. The project's own repository, this one, holds the
planning and is not where code is written.

**Where two repositories have to agree, two tasks agree** - by message, with a record of what was
said. The tasks of one project can address each other by task name without anybody writing a peer
list. A task that changed three repositories at once would have to be paid for at the gate, where
*"this task's work is waiting for review"* would have three answers and a person could approve a
third of it.

## Planning happens here, work happens there

A requirement starts here as markdown, in `issues/`. Once it is clear enough to say which
repository does what, it **moves into that repository as an issue** - and from then on it is that
repository's, reviewed through that repository's gate like anything else.

In Porelo's own terms that is an agent with a task on this repository handing over to an agent with a
task on a work repository: a `handover` message carrying the repository, the ref and the commit.
Work is named by commit and travels through the gate, never inside a message.

## A machine can follow this repository

A machine told to follow it fetches, verifies that the commit is signed by a key it was given out
of band, and only then moves its working tree - so a repository decides what a machine does only
after proving who wrote it. A signed commit that is not a descendant of the one in force is refused
rather than applied, because somebody without the key can still re-serve an older signed
configuration to put back a rule that was taken away.

```sh
porelo project follow porelo git@github.com:porelo-ai/porelo-project.git --signed-by <key>
```

## Where the documentation is

The documentation is at <https://porelo-ai.github.io>, one chapter per repository, built from each
repository's `doc/`. Everything `project.yml` can carry is in
[The project file](https://porelo-ai.github.io/core/project-file/).

How to change this repository is in [`CONTRIBUTING.md`](CONTRIBUTING.md), and how to report a vulnerability in
[`SECURITY.md`](SECURITY.md).

## Licence

GNU General Public License v3.0 or later — see [LICENSE](LICENSE).
