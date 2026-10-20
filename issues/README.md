# Project requirements

**What belongs here.** A requirement belongs in this repository while it is about the project rather
than one of its repositories: the shape of the product, a decision that spans several repositories,
or something still too unclear to say which repository would build it; and the candidate agents
(`A`) that have no repository yet.

**A requirement leaves.** Once it is clear which repository does the work, it moves there as an
issue, a handover rather than a copy.

Within each group, ordered by what to do next; the number is identity, not sequence.

**How Porelo measures up against security guidelines** is in [security-guidelines.md](security-guidelines.md); every gap to be closed links its issue there.

**How Porelo compares with other tools that isolate or run coding agents** is in [feature-comparison.md](feature-comparison.md); every planned feature links its issue there.

## Review

| # | Size | Blocked by | What it covers |
|---|---|---|---|

## Implementing

| # | Size | Blocked by | What it covers |
|---|---|---|---|
| <a id="pj27"></a>[PJ27](PJ27-A-Contributor-Knows-The-Rules.md) | L | — | One guide for contributors in `porelo-project`'s `doc/`, linked from every repository's README and `CONTRIBUTING.md`: how the work is organised, how a change is made, what it must satisfy. |
| <a id="pj40"></a>[PJ40](PJ40-A-Project-Comes-Up-On-A-Server-At-One-Command.md) | XL | — | Any project of several agents and repositories comes up on a server, owned or rented by the hour, at one command: Porelo writes an Ansible inventory from `project.yml`, the repositories' own files and the person's machine file; Ansible sets up the host from the host itself, `host up` (a Dart package of porelo-frontend, for the interface and the command line) rents it by the hour (Scaleway Elastic Metal for Porelo's own; OpenTofu later for others); following, keys and tasks stay Porelo's; Porelo's own project first. |
| <a id="pj39"></a>[PJ39](PJ39-Porelo-Is-Built-In-Porelo-Tasks.md) | — | [PJ40](#pj40), [PJ45](#pj45), [PJ22](#pj22); `porelo` [B189](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b189) | The agents work in Porelo tasks on one bare-metal host, owned or rented by the hour and set up by a script (at least 8 cores with 16 threads, 64 GB, one SSD of 1 TB): an `online` project whose upstream is a local Forgejo, one task per issue, phase and repository, Forgejo building and testing, the operator approving there, Matrix, `.AGENTS.md` instead of memory, `porelo-all` for the coordinator; a plan in eight phases, the groundwork first. |
| <a id="pj14"></a>[PJ14](PJ14-Work-Starts-Without-A-Project.md) | M | — | Work starts in a checked-out or picked repository without a project, in the project `default`; left: refusals naming the way for a transport or a peer, a `project.yml` named `default`, and the move to a followed project measured. |

## Backlog

| # | Size | Blocked by | What it covers |
|---|---|---|---|
| <a id="pj45"></a>[PJ45](PJ45-Chosen-Data-Outlives-The-Machine.md) | M | — | A short list of data that lives only on a machine - the Matrix room, the token usage records and the Maven cache to start with - copied every hour and at down by restic into the project's S3 store, encrypted on the host, and put back at up; nothing else is kept. |

## Analyzed

| # | Size | Blocked by | What it covers | Open questions |
|---|---|---|---|---|
| <a id="pj53"></a>[PJ53](PJ53-The-Agent-Already-On-The-Machine-Is-The-Default.md) | XL | — | A start without `--agent` and `--provider` takes the agent already installed and signed in on the machine, with its provider: each packaged agent reports what it finds of itself on the host, by path and never a credential's value; `porelo` chooses, a flag still wins, the choice and its source are named, and what is found but not in the vault is offered for `vault import`. | 0 |
| <a id="pj33"></a>[PJ33](PJ33-A-Plugin-May-Carry-Its-Own-License.md) | L | — | An agent, build reader, transport or client may carry its own license: the interface libraries (`porelo-agent-api`, `porelo-build-api`, `porelo-wire`, the varlink definitions) under Apache-2.0, Porelo itself GPL, the boundary written down. | — |
| <a id="pj09"></a>[PJ09](PJ09-A-Gates-Green-Says-Nothing-Until-Its-Reference-Set-Can-Change.md) | L | — | Every gate names its reference set; one that is empty, cannot change or is read by nothing is not counted as coverage. | — |
| <a id="pj16"></a>[PJ16](PJ16-An-Organisation-Decides-Which-Providers-Its-Machines-Use.md) | L | — | A root-owned machine policy names the providers tasks may use, and narrows follows, prompts and the `online` class; a developer cannot widen it. | — |
| <a id="pj03"></a>[PJ03](PJ03-An-Attachment-May-Be-Permitted.md) | XL | — | Whether a message may carry more than text becomes an operator's decision, per direction, project and peer, refused by default. | — |
| <a id="a06"></a>[A06](A06-Agent-Codex-CLI.md) | L | — | Codex CLI as a packaged agent: a candidate, brokering unverified. | — |
| <a id="a07"></a>[A07](A07-Agent-Gemini-CLI.md) | L | — | Gemini CLI as a packaged agent: a candidate, brokering unverified. | — |
| <a id="a09"></a>[A09](A09-Agent-Grok-Build.md) | L | — | Grok Build as a packaged agent: a candidate, brokering unverified. | — |
| <a id="a10"></a>[A10](A10-Agent-OpenCode.md) | L | — | OpenCode as a packaged agent: a base URL configurable per provider. | — |
| <a id="pj25"></a>[PJ25](PJ25-McPorelo-Apple-Containers.md) | XL | — | McPorelo: the same guarantees on Apple Containers, driven by one client through the daemon's contract. | 4 |


## Accepted

| # | Size | Blocked by | What it covers |
|---|---|---|---|
| <a id="pj49"></a>[PJ49](PJ49-A-Test-Names-The-Capability-It-Needs.md) | — | — | A test that needs what a Porelo task does not give - a nested container, `/dev/kvm`, the kernel keyring, a desktop session - carries a tag naming that capability; the tags say only what the agent runs in its task before it pushes; the task is finished when the build its push started, which runs every test, is green; mending a test to run in a task comes first where it is cheap. |
| <a id="pj47"></a>[PJ47](PJ47-A-Known-Vulnerability-Is-Read-And-Answered.md) | — | — | Every advisory against what a repository resolves is read within a week: ships or builds, reached or not, a fix or the reason; a release holds no high one against what ships unless the operator decides. | — |
| <a id="pj34"></a>[PJ34](PJ34-Every-Change-Reaches-Main-Through-A-Pull-Request.md) | — | — | Every change reaches `main` through a pull request with green required checks, so `main` needs no bypass. |
| <a id="pj35"></a>[PJ35](PJ35-An-Agent-Orchestrates-Porelo-Machines.md) | — | — | An MCP server outside Porelo lets an agent steer tasks and machines of one or many Porelo instances, without approving work or opening a vault. |
| <a id="pj36"></a>[PJ36](PJ36-Builds-Read-From-Bitbucket-Data-Center-And-Jenkins.md) | — | — | Builds of a push read from Bitbucket Data Center and Jenkins, the build server separate from the forge. |
| <a id="pj37"></a>[PJ37](PJ37-Work-Reaches-The-Upstream-By-A-Machine-Key-Or-The-Persons-Token.md) | — | — | A machine reaches the upstream by keys of its own or by the person's own token, equal choices per project; the token as narrow as the forge allows, used on the host only, deposited for a time on a rented machine. |
| <a id="pj38"></a>[PJ38](PJ38-An-Estimate-Learns-From-The-Tokens-Spent.md) | — | `porelo` [B148](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b148), [B189](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b189); [PJ39](#pj39) | The new tokens of build and rework, counted per task tagged with its issue and phase, are written beside an issue's estimated size before it is Finished; a velocity per size is kept, and a new estimate is compared with finished issues of its size. |


## Idea

| # | Size | Blocked by | What it covers |
|---|---|---|---|
| <a id="pj51"></a>[PJ51](PJ51-The-Persons-Secrets-Kept-Once-In-A-File-They-Can-Open.md) | — | — | The secrets a host's setup needs, kept once in a KDBX 4 file on the person's drive that KeePassXC opens, unlocked on the desktop only and given to the host on standard input; a wizard in the interface asks how the person works. |
| <a id="pj50"></a>[PJ50](PJ50-A-Host-Mounts-The-Persons-Drives.md) | — | — | A host takes its setup from a tresor of its own or its folder in a shared one, as the person chooses, and mounts the person's private drives for the person's own use; one mechanism for Tresorit and OneDrive, a list of drives in the machine file, and a person's account on the host to be weighed. |
| <a id="pj48"></a>[PJ48](PJ48-GitHub-Does-Not-Run-Scheduled-Workflows-Reliably.md) | — | — | GitHub starts scheduled workflows late or drops them, silently, while the updates, the sweep and the daily rules check must run when nobody develops; ideas: start them from outside by `workflow_dispatch`, catch up only what is overdue, notice a missing run, and where such a timer runs. |


## Estimated

| # | Size | Blocked by | What it covers |
|---|---|---|---|
| <a id="pj52"></a>[PJ52](PJ52-A-Repositorys-Build-Tools-Are-Recognized-And-A-Project-Proposed.md) | XL | `porelo` [B192](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b192); an agent for `porelo-ecosystems` | Drafts proposed from what a checkout and the person's tool settings say: the tools as a `.porelo.yml` the repository never receives, the rules (egress, private repositories, memory) as a `project.yml` for a project repository of the person's own; one plugin per build tool in `porelo-ecosystems`, a native executable of its own spoken to over varlink, that never runs the project's code and reads only local caches (Maven's effective model through MIMA, offline), measured against the Porelo repositories' own `porelo.yml`; credentials named by id and offered into the Porelo-Vault, never copied. |
| <a id="pj46"></a>[PJ46](PJ46-Document-Tests-Run-Only-Where-The-Agent-Works.md) | M | — | The tests that read only issues and documents run on the agent's machine and in the daily Shared rules check, never in a Build: left out by the build tool's own switch, and naming no single issue, so setting an issue Finished touches no test. |
| <a id="a08"></a>[A08](A08-Agent-Copilot-CLI.md) | L | — | Copilot CLI as a packaged agent: brokerable by environment variable (BYOK), which is not the Copilot subscription. |
| <a id="pj15"></a>[PJ15](PJ15-A-Tool-Does-Not-Change-Behind-The-Persons-Back.md) | XL | — | An MCP server's tools are pinned when a person accepts them, a change is held until accepted again, and descriptions written to steer the agent are caught. |
| <a id="pj08"></a>[PJ08](PJ08-An-Unattended-Jobs-Refusal-Reaches-A-Person.md) | L | — | An unattended job's refusal reaches a person. |
| <a id="pj22"></a>[PJ22](PJ22-One-Build-Locally-As-On-The-Central-Forge.md) | XL | — | One build, run locally as on the central forge: the same workflows on a local Forgejo, its registry instead of the hand-over and the public repositories, acceptance legs on a machine rented through one interface (a local VM account or a provider's server), and a task's work built the same way, read through one reader contract by a `github` and a `forgejo` reader. |
| <a id="pj32"></a>[PJ32](PJ32-A-Vulnerability-Has-A-Way-In.md) | M | — | Whoever finds a vulnerability reports it privately through a `SECURITY.md` in every repository and one page in `doc/`; a fix gets a GitHub advisory and a changelog line. |
| <a id="pj24"></a>[PJ24](PJ24-Where-The-Agent-Protocols-Touch-This.md) | M | — | For A2A, MCP, ACP and AG-UI each: adopted, answered otherwise, or refused, with the reason and what would change it. |

## Finished

| # | Title | What was built |
|---|---|---|
| <a id="pj28"></a>[PJ28](README.md#pj28) | Code from outside reaches no secret | The organisation ruleset on `main` with the admin as its only bypass, `CODEOWNERS`, fork approval, `check-actions` refusing `pull_request_target`, and a probe that shows them holding ([decision](../doc/decisions.md#code-from-outside-reaches-no-secret)). |
| <a id="pj29"></a>[PJ29](README.md#pj29) | One code style for the IDE and the build | One shared `.editorconfig` in every repository, Spotless with `google-java-format` (AOSP) in `validate` from `porelo-parent`, Gradle's Spotless in the plugin, `dart format` in the interface, and one reformatting commit per repository named in `.git-blame-ignore-revs`. |
| <a id="pj41"></a>[PJ41](README.md#pj41) | Sokar is renamed Porelo | Every repository, artifact, package, command, path and document is named Porelo under `porelo-ai` and `org.fuin.porelo`, released as Porelo 0.5.0, and installed afresh. |
| <a id="pj42"></a>[PJ42](README.md#pj42) | The forge and Artifactory prepared for Porelo | Every repository transferred to `porelo-ai` and renamed, the organisation's settings and tokens made again, `porelo-dist-*` and the key pair `porelo-packages` at Artifactory. |
| <a id="pj43"></a>[PJ43](README.md#pj43) | sokar-project renamed porelo-project | This repository, its `project.yml` and the Shared Area under the new name. |
| <a id="pj44"></a>[PJ44](README.md#pj44) | The local machine renamed Porelo | The checkouts, local rules, channel and its tools, and the VM accounts with Porelo installed afresh. |
| <a id="pj17"></a>[PJ17](README.md#pj17) | The MVP | Its shape is in [the project chapter](../doc/index.md#the-mvp); which issue belongs to a round is now each index's *Backlog*. |

## What was decided along the way

- **Messaging is not one repository's job.** The format is A2A 1.0, an external standard; what
  remains divides into the handover at the container boundary (`porelo`), what may pass (the filter)
  and the carrying (the transports).
- **An adapter's repository is an ownership question, not an architectural one.** Transports are
  discovered executables speaking a CLI, so nothing compiles against one and moving it breaks nothing.
- **No project-wide message store**: a Matrix room is one.
- **No chat client is shipped.** Any Matrix client will do, and no agent needs one.
- **Room membership is not authorization.** Matrix distributes; Porelo decides, on the signature.
