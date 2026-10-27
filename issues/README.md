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

**The plan of each release, its sprints and the functions tested at their end**, is in [plan/](../plan/README.md).

## Review

| # | Size | Blocked by | What it covers |
|---|---|---|---|

## Implementing

| # | Size | Blocked by | What it covers |
|---|---|---|---|
| <a id="pj45"></a>[PJ45](PJ45-Chosen-Data-Outlives-The-Machine.md) | M | — | A short list of data that lives only on a machine - the Matrix room, the token usage records and the Maven cache to start with - copied every hour and at down by restic into the project's S3 store, encrypted on the host, and put back at up; nothing else is kept. |
| <a id="pj32"></a>[PJ32](PJ32-A-Vulnerability-Has-A-Way-In.md) | M | — | Whoever finds a vulnerability reports it privately through a `SECURITY.md` in every repository and one page in `doc/`; a fix gets a GitHub advisory and a changelog line. |
| <a id="pj27"></a>[PJ27](PJ27-A-Contributor-Knows-The-Rules.md) | L | — | One guide for contributors in `porelo-project`'s `doc/`, linked from every repository's README and `CONTRIBUTING.md`: how the work is organised, how a change is made, what it must satisfy. |
| <a id="pj40"></a>[PJ40](PJ40-A-Project-Comes-Up-On-A-Server-At-One-Command.md) | XL | — | Any project of several agents and repositories comes up on a server, owned or rented by the hour, at one command: Porelo writes an Ansible inventory from `project.yml`, the repositories' own files and the person's machine file; Ansible sets up the host from the host itself, `host up` (a Dart package of porelo-frontend, for the interface and the command line) rents it by the hour (Scaleway Elastic Metal for Porelo's own; OpenTofu later for others); following, keys and tasks stay Porelo's; Porelo's own project first. |
| <a id="pj39"></a>[PJ39](PJ39-Porelo-Is-Built-In-Porelo-Tasks.md) | — | [PJ40](#pj40), [PJ45](#pj45), [PJ22](#pj22) | The agents work in Porelo tasks on one bare-metal host, owned or rented by the hour and set up by a script (at least 8 cores with 16 threads, 64 GB, one SSD of 1 TB): an `online` project whose upstream is a local Forgejo, one task per issue, phase and repository, Forgejo building and testing, the operator approving there, Matrix, what an agent learns committed to its `AGENTS.md` instead of memory, `porelo-all` for the coordinator; a plan in nine sprints after the groundwork, each ending in functions the operator tests. |
| <a id="pj14"></a>[PJ14](PJ14-Work-Starts-Without-A-Project.md) | M | — | Work starts in a checked-out or picked repository without a project, in the project `default`; left: refusals naming the way for a transport or a peer, a `project.yml` named `default`, and the move to a followed project measured. |

## Backlog

| # | Size | Blocked by | What it covers |
|---|---|---|---|
| <a id="pj61"></a>[PJ61](PJ61-The-Project-Porelo-Is-Online-With-The-Local-Forge-Upstream.md) | M (five repositories, about 4 h) | — | The project `porelo` online with the local Forgejo upstream: a task's push built there, its verdict read in the task, the central forge reached by the gathered push after approval; proved on Sluice first. |
| <a id="pj37"></a>[PJ37](PJ37-Work-Reaches-The-Upstream-By-A-Machine-Key-Or-The-Persons-Token.md) | — | — | A machine reaches the upstream by keys of its own or by the person's own token, equal choices per project; the token as narrow as the forge allows, used on the host only, deposited for a time on a rented machine. | 0 |

## Analyzed

| # | Size | Blocked by | What it covers | Open questions |
|---|---|---|---|---|
| <a id="pj59"></a>[PJ59](PJ59-Each-Agent-Moves-Into-A-Porelo-Task.md) | L | — | Each agent moves into a Porelo task, one at a time in a fixed order, each move an issue (S) of its own that the agent works inside its new task; the channel file kept beside Matrix until the last has moved. | 2 |
| <a id="pj53"></a>[PJ53](PJ53-The-Agent-Already-On-The-Machine-Is-The-Default.md) | XL | — | A start without `--agent` and `--provider` takes the agent already installed and signed in on the machine, with its provider: each packaged agent reports what it finds of itself on the host, by path and never a credential's value; `porelo` chooses, a flag still wins, the choice and its source are named, and what is found but not in the vault is offered for `vault import`. | 0 |
| <a id="pj33"></a>[PJ33](PJ33-A-Plugin-May-Carry-Its-Own-License.md) | L | — | An agent, build reader, transport or client may carry its own license: the interface libraries (`porelo-agent-api`, `porelo-build-api`, `porelo-wire`, the varlink definitions) under Apache-2.0, Porelo itself GPL, the boundary written down. | — |
| <a id="pj09"></a>[PJ09](PJ09-A-Gates-Green-Says-Nothing-Until-Its-Reference-Set-Can-Change.md) | L | — | Every gate names its reference set; one that is empty, cannot change or is read by nothing is not counted as coverage. | — |
| <a id="pj16"></a>[PJ16](PJ16-An-Organisation-Decides-Which-Providers-Its-Machines-Use.md) | L | — | A root-owned machine policy names the providers tasks may use, and narrows follows, prompts and the `online` class; a developer cannot widen it. | — |
| <a id="pj03"></a>[PJ03](PJ03-An-Attachment-May-Be-Permitted.md) | XL | — | Whether a message may carry more than text becomes an operator's decision, per direction, project and peer, refused by default. | — |
| <a id="a09"></a>[A09](A09-Agent-Grok-Build.md) | L | — | Grok Build as a packaged agent: a candidate, brokering unverified. | — |
| <a id="a10"></a>[A10](A10-Agent-OpenCode.md) | L | — | OpenCode as a packaged agent: a base URL configurable per provider. | — |
| <a id="pj25"></a>[PJ25](PJ25-McPorelo-Apple-Containers.md) | XL | — | McPorelo: the same guarantees on Apple Containers, driven by one client through the daemon's contract. | 4 |
| <a id="pj60"></a>[PJ60](PJ60-Every-Workflow-Runs-On-The-Local-Forge-As-On-The-Central-One.md) | S (each of parent, buildtools, Sluice) | — | Every repository's `build.yml` runs green on the local Forgejo and the central forge with no edit between: kinds, registry and provider as variables; one issue (S) per repository. | — |


## Accepted

| # | Size | Blocked by | What it covers |
|---|---|---|---|
| <a id="pj68"></a>[PJ68](PJ68-Every-Container-Fits-The-Machine-It-Runs-On.md) | — | — | Every container a Porelo part starts - task, image build, the room's homeserver, the host's forge and runner jobs - runs with limits of its own, and a pool sized from the machine sees those limits, so a part that works on a small machine also works on a large rented host. |
| <a id="pj70"></a>[PJ70](PJ70-A-Machine-Nobody-Sits-At-Tells-Its-Person-What-Needs-Them.md) | — | — | A machine nobody sits at watches what it needs to go on - credentials and their expiry, the vault, its services, memory and disk, a rented host's running time - and tells its person what needs them, wherever they are. |
| <a id="pj58"></a>[PJ58](PJ58-The-Coordinator-Works-In-One-Repository-Of-Them-All.md) | — | — | The coordinator reads every repository in `porelo-all` on the local Forgejo and changes only `porelo-project`, split back after the operator's approval. |
| <a id="pj57"></a>[PJ57](PJ57-A-Person-Is-Led-From-Nothing-To-Work.md) | — | — | The Porelo Wizard, in a repository of its own with an agent of its own: questions first, a plan of every step, progress kept and taken up again, hand-overs with instructions to an administrator or a forge's, and a chat beside it in the interface; the core of the usability sprint. |
| <a id="pj55"></a>[PJ55](PJ55-Porelo-Runs-On-arm64.md) | — | — | Porelo and every native package it installs built, tested and published for arm64, so a Linux VM on Apple silicon installs them, for porelo-frontend [F109](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f109): built and checked on GitHub's arm64 runners on every Build; for a release, a Mac rented for the whole test window tests every part, the interface included. |
| <a id="pj54"></a>[PJ54](PJ54-The-ChatGPT-Sign-In-Is-A-Provider.md) | — | — | The ChatGPT sign-in as a provider of its own beside the API key, brokered on the host with its token refresh, for Codex CLI; the undocumented backend accepted as a risk. Waits for `porelo`. |
| <a id="pj49"></a>[PJ49](PJ49-A-Test-Names-The-Capability-It-Needs.md) | — | — | A test that needs what a Porelo task does not give - a nested container, `/dev/kvm`, the kernel keyring, a desktop session - carries a tag naming that capability; the tags say only what the agent runs in its task before it pushes; the task is finished when the build its push started, which runs every test, is green; mending a test to run in a task comes first where it is cheap. |
| <a id="pj47"></a>[PJ47](PJ47-A-Known-Vulnerability-Is-Read-And-Answered.md) | — | — | Every advisory against what a repository resolves is read within a week: ships or builds, reached or not, a fix or the reason; a release holds no high one against what ships unless the operator decides. | — |
| <a id="pj34"></a>[PJ34](PJ34-Every-Change-Reaches-Main-Through-A-Pull-Request.md) | — | — | Every change reaches `main` through a pull request with green required checks, so `main` needs no bypass. |
| <a id="pj35"></a>[PJ35](PJ35-An-Agent-Orchestrates-Porelo-Machines.md) | — | — | An MCP server outside Porelo lets an agent steer tasks and machines of one or many Porelo instances, without approving work or opening a vault. |
| <a id="pj36"></a>[PJ36](PJ36-Builds-Read-From-Bitbucket-Data-Center-And-Jenkins.md) | — | — | Builds of a push read from Bitbucket Data Center and Jenkins, the build server separate from the forge. |
| <a id="pj38"></a>[PJ38](PJ38-An-Estimate-Learns-From-The-Tokens-Spent.md) | — | `porelo` [B148](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b148); [PJ39](#pj39) | The new tokens of build and rework, counted per task tagged with its issue and phase, are written beside an issue's estimated size before it is Finished; a velocity per size is kept, and a new estimate is compared with finished issues of its size. |
| <a id="pj71"></a>[PJ71](PJ71-Who-Reaches-A-Host-And-By-Which-Way.md) | — | — | Setting a machine up, admitting or removing a person, and taking it down kept apart from normal work as roles the interface is started with (`user` by default, `host-admin`, `access-admin`); a person reaches a machine with keys of their own through an access request and an access file; which way into a host is ssh and which the VPN, written down. |


## Idea

| # | Size | Blocked by | What it covers |
|---|---|---|---|
| <a id="pj64"></a>[PJ64](PJ64-A-Task-Chooses-Its-Agent-And-Effort-By-Its-Work.md) | — | — | A task gets the agent, provider, model and effort its work calls for - by its phase (`build`, `check`, `rework`) and its issue's risk - on one effort scale each agent maps to its provider, with a flag, the project's rule, its default and the machine's agent in that order; a `check` task only reads and reports. |
| <a id="pj65"></a>[PJ65](PJ65-What-Is-Left-Of-Each-Providers-Limits-Is-Shown.md) | — | — | Every account the agents spend on - subscriptions by share of a window, API keys by tokens or money, a forge's AI credits, a company's budget per developer, several of a kind told apart - with its meters read by each provider's adapter or estimated from Porelo's own count, shown in one view with what is left and when it comes back. |
| <a id="pj66"></a>[PJ66](PJ66-An-Adapter-Offers-The-Services-It-Has.md) | — | — | Each adapter Porelo finds lists the services it offers - agent, build, review, model limits, transport - each by its own contract and version, answers "not supported" where a service cannot, and a project names adapter and credential per service, so a forge, a build server and a model provider are never mixed up. |
| <a id="pj67"></a>[PJ67](PJ67-A-Change-Is-Checked-Before-It-Leaves-The-Machine.md) | — | — | Work waiting at a task's gate is checked by another agent's `check` task on that very commit; its findings stay with the commit and wake the building task, which fixes and pushes again, in bounded rounds, before the person approves at the gate with every round in view. |
| <a id="pj72"></a>[PJ72](PJ72-Every-Review-Seen-As-One-Area.md) | — | — | Every issue about reviewing work - by the person at the gate, by a checking agent, by comments on a forge's pull request - listed in one place by theme, so the order and the gaps are decided for the area as a whole; Porelo reads and writes review data only as SARIF, the adapters convert to and from each forge, IntelliJ reuses what it ships. |
| <a id="pj73"></a>[PJ73](PJ73-Who-Wrote-Something-Decides-What-It-May-Do.md) | — | — | Every pull request, commit and review comment gets a source level from authenticated data (external unknown, external known, internal, agent) and its code a risk class by what it touches; the weaker decides which operations Porelo performs - delivery to an agent, suggestions, reviewers, builds, secrets, forge replies, approvals. |
| <a id="pj74"></a>[PJ74](PJ74-Forge-And-Build-Server-Clients-Know-Nothing-Of-Porelo.md) | — | — | The calls to forges' and build servers' APIs in a repository of their own, `porelo-forge-clients`, one module per forge, LGPL, knowing nothing of Porelo; `porelo-adapters` translates what they return into Porelo's contracts and SARIF; owned by Agent Gorge; started in 0.8 with GitHub and Forgejo. |
| <a id="pj75"></a>[PJ75](PJ75-A-Task-Fetches-A-Snapshot-From-Its-Hosts-Forge.md) | — | — | A task on a host with a local forge fetches a snapshot from the forge's registry by its declared name without a credential put into the project, and still reaches nothing else on the host; the private organization refuses it today with `401`, a public organization and a read-only credential through the Porelo-Vault to be weighed. |
| <a id="pj76"></a>[PJ76](PJ76-A-Pull-Requests-Commits-Checked-Alike-On-Both-Forges.md) | — | — | The *Shared rules check* of a pull request reads its commits without a credential in the job and tells a member from an outsider by one rule on both forges, since the host's private forge refuses the second fetch and Forgejo sends no `author_association`; in every repository's `shared-rules.yml`. |
| <a id="pj56"></a>[PJ56](PJ56-A-Release-Is-Tested-Together-On-One-Host.md) | — | — | Every part's release candidate installed and tested together on one host rented for the release's test window, a VM per operating system and an account per part, the arm64 Mac of [PJ55](#pj55) beside it; the per-push legs stay. |
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
| <a id="pj24"></a>[PJ24](PJ24-Where-The-Agent-Protocols-Touch-This.md) | M | — | For A2A, MCP, ACP and AG-UI each: adopted, answered otherwise, or refused, with the reason and what would change it. |

## Finished

| # | Title | What was built |
|---|---|---|
| <a id="pj69"></a>[PJ69](README.md#pj69) | A machine reaches the forge with the person's own credentials | The person's token kept in the vault and used for git and the forge's API, no deploy key per machine and repository: `porelo` [B269](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b269), `porelo-frontend` [F153](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f153) (sprint 2c). |
| <a id="pj62"></a>[PJ62](README.md#pj62) | The forge adapters live in one repository | `porelo-adapters` with the `github` and `forgejo` adapters, one contract suite both pass, and `porelo build status` asking either (sprint 3: [GH06](https://github.com/porelo-ai/porelo-adapters/blob/main/issues/README.md#gh06), [GH07](https://github.com/porelo-ai/porelo-adapters/blob/main/issues/README.md#gh07), [B253](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b253), [B256](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b256), [B275](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b275)). |
| <a id="pj63"></a>[PJ63](README.md#pj63) | A release is planned in sprints of tested functions | `plan/<release>.yml` holds each release's goal, sprints, functions the operator tests and their issues; `porelo-release plan render` makes `plan/<release>.md` with a progress image and `plan check` refuses a faulty plan, built in porelo-buildtools. |
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
