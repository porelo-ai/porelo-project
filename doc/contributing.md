# Contributing

How Porelo is worked on, for someone who wants to change it. The rules themselves are kept in one
place, the shared block of each repository's [`AGENTS.md`](https://github.com/porelo-ai/porelo-project/blob/main/AGENTS.md#shared-across-the-porelo-repositories):
it is written for the agents that work on Porelo, and the same rules hold for a person. This page
explains them and links each to its section there; where the two seem to differ, the shared block
is right.

## How the work is organised

Porelo is one project over several repositories. Each holds one part, and a change belongs in the
repository of the part it changes; the [table in the project's README](https://github.com/porelo-ai/porelo-project#what-a-project-is-and-why-this-repository-exists)
says what each one holds. Every repository has one responsible agent, and the operator decides as
product owner. A requirement that belongs to the project as a whole, or is not yet placed, lives in
[porelo-project](https://github.com/porelo-ai/porelo-project).

## Issues

Every open task is a file in its repository's `issues/`, listed in that folder's `README.md`. Each
repository has its own prefixes, named in [`project.yml`](https://github.com/porelo-ai/porelo-project/blob/main/project.yml)
(`B` for the core, `F` for the interface, and so on). An issue says what must be true and how it is
judged done, and moves through states of which the operator sets the deciding ones
([Issues](https://github.com/porelo-ai/porelo-project/blob/main/AGENTS.md#issues)).

**From outside, a change starts as a GitHub issue** in the repository it belongs to: what should be
true, and why. Once it is agreed there, it becomes an issue file, and a pull request for it is
welcome.

## Making a change

- **Build and test locally first.** Each repository's `doc/build.md` says how, and its
  `CONTRIBUTING.md` names what is particular to it. A change is ready only when every step its
  build workflow runs has passed locally.
- **A fix starts with a test seen to fail**, and tests guard what a change could break, not its
  wording or layout ([Testing and machines](https://github.com/porelo-ai/porelo-project/blob/main/AGENTS.md#testing-and-machines)).
- **One finished task is one commit.** Its message is one line of at most 72 characters saying in
  words what changed, never an issue number; the reasons go into the issue or a decision
  ([Commits and pushes](https://github.com/porelo-ai/porelo-project/blob/main/AGENTS.md#commits-and-pushes)).
- **A change to what ships gets its line in `CHANGELOG.md`**, under `[Unreleased]`, in the same
  commit.
- **Every commit carries a `Signed-off-by:` line** (`git commit -s`), by which its author certifies
  under the [Developer Certificate of Origin](https://developercertificate.org/) that they may submit
  it.
- **Work written with an AI's help is welcome, and says so.** A person vouches for every commit with
  their sign-off, never the agent, and the commit names the help in an `Assisted-by: <tool, model>`
  line. Porelo's own agents' commits follow the same rule.

## What a change must satisfy

Dependencies, tools and actions are pinned to exact versions. No secret ever appears in a file, a
command line or a log. Documentation describes the current state only. A decision that outlives its
issue goes into the repository's `doc/decisions.md`, a rule into the shared block. The full list is
in [Security and tools](https://github.com/porelo-ai/porelo-project/blob/main/AGENTS.md#security-and-tools),
[Claims and writing](https://github.com/porelo-ai/porelo-project/blob/main/AGENTS.md#claims-and-writing)
and [Code and builds](https://github.com/porelo-ai/porelo-project/blob/main/AGENTS.md#code-and-builds).

## What the build checks

Every push and every pull request that changes code runs the repository's `Build` workflow:
compiling, the tests, the code style, and the shared checks of links, citations and the shared
block; a change only to documentation or issues is checked locally. The acceptance suites
that rent test machines run only on `main`, on a release tag or when the operator starts them, so a
pull request from a fork builds without reaching any machine or secret.

## Pull requests and review

The operator reviews every pull request, and a change under `.github/` also needs the code owner's
review. A pull request from a fork runs its workflows only after the operator approves them. A pull
request that arrives without an agreed issue is closed with a pointer to this page. An accepted one
is squashed into one commit.

## Releases

Porelo is published in versions, as packages in two channels: `releases` for released versions and
`snapshots` for each build of `main`. Only the operator makes a release.

## Reporting a vulnerability

Never in a public issue: see [Reporting a vulnerability](security.md).

## Code of conduct

Everyone taking part follows the [Contributor Covenant 2.1](https://www.contributor-covenant.org/version/2/1/code_of_conduct/).
Conduct that breaks it is reported to michael@fuin.org.

## Licence

Porelo's code is under the GNU General Public License, version 3 or later. A contribution comes in
under that licence and stays under it: no rights are transferred, and there is no contributor
agreement.
