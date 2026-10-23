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

## Sprints

### Current: release 0.6, Porelo is built in Porelo tasks

[PJ39](#pj39): the agents move their work into Porelo tasks on one host, in small sprints, each ending in two or
three functions the operator tests by hand. A bar counts the functions tested, not the issues built.

```
Groundwork                                     ██████████████████  done
Sprint 1  An agent works on the rented host    ██████████████████  3 of 3 tested
Sprint 2  Host from the interface, room        ░░░░░░░░░░░░░░░░░░  0 of 2
Sprint 2b The release plan as a page           ░░░░░░░░░░░░░░░░░░  0 of 1
Sprint 3  The build servers read               ░░░░░░░░░░░░░░░░░░  0 of 3
Sprint 4  The local forge builds               ░░░░░░░░░░░░░░░░░░  0 of 3
Sprint 5  From the task's push to approval     ░░░░░░░░░░░░░░░░░░  0 of 2
Sprint 6  The move, first wave                 ░░░░░░░░░░░░░░░░░░  0 of 3
Sprint 7  The move, other toolchains           ░░░░░░░░░░░░░░░░░░  0 of 2
Sprint 8  The move, Core and the coordinator   ░░░░░░░░░░░░░░░░░░  0 of 2
Sprint 9  Clearing up and counting             ░░░░░░░░░░░░░░░░░░  0 of 3
```

| Sprint | The functions tested at its end |
|---|---|
| 1 · An agent works on the rented host | The host rented and given back at one command; Claude working in a task with the operator's subscription; each repository's image and each task's values. |
| 2 · The host from the interface, the agents in the room | The host up and down from the interface; two agents talking in the room, a message waking the resting one. |
| 2b · The release plan as a page | The plan page made from a checked-in plan file and read on the central forge, its check finding a planted fault ([PJ63](#pj63)). |
| 3 · The build servers read | `porelo build status` against GitHub; the same against Forgejo; both adapters passing one suite ([PJ62](#pj62)). |
| 4 · The local forge builds as the central one | Forgejo's registry reached by name from a task; test machines by kind from the VM pool; Sluice green on both forges. |
| 5 · From the task's push to the central forge | The task hearing its build from Forgejo ([PJ61](#pj61)); the mirror only after the operator's approval. |
| 6 · The move, first wave | Sluice; Smith; AGY and Codex ([PJ59](#pj59)). |
| 7 · The move, the other toolchains | Matrix; IntelliJ and Frontend. |
| 8 · The move, last wave | Core with a way back; the coordinator in `porelo-all` ([PJ58](#pj58)). |
| 9 · Clearing up and counting | No channel file any more; the room and the records outliving the host ([PJ45](#pj45)); the tokens counted per task. |

### Next: release 0.7, usability

A developer installs Porelo on their own machine and starts in a repository they already have, with no project
written and no flags to learn. Its core is the Porelo Wizard, [PJ57](#pj57), which comes last and leads a person
through the steps the sprints before it build. An image per repository, porelo
[B192](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b192), comes with sprint 1.

**Sprint 1 of 0.7 · Starting in one's own repository**

- *Work without a project, with plain refusals:* a task starts in a checkout in `default`; a followed project naming
  the repository is offered to take it; a repository with no commit, an unreadable upstream or a failed fetch is named
  as what it is, with the next step. The rest of [PJ14](#pj14); porelo
  [B229](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b229),
  [B33](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b33); porelo-frontend
  [F118](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f118).
- *The agent already on the machine is taken:* without `--agent` and `--provider` the task starts with the Claude Code
  signed in there, and says what it found and where; the interface shows the same choice ([PJ53](#pj53); porelo
  [B224](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b224),
  [B225](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b225); porelo-claude-code
  [CC36](https://github.com/porelo-ai/porelo-claude-code/blob/main/issues/README.md#cc36); porelo-frontend
  [F143](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f143)).
- *Keys and providers without stumbling:* a key pasted at `vault put` is read whole; an agent given a provider it
  does not know is refused before the start (porelo
  [B228](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b228),
  [P09](https://github.com/porelo-ai/porelo/blob/main/issues/providers/README.md#p09)).

**Sprint 2 of 0.7 · A project proposed from the checkout** ([PJ52](#pj52))

- *`porelo project init` proposes tools and rules:* for a Maven repository, a `.porelo.yml` and where needed a
  `project.yml` draft, each value with its source; a project kept in a local repository is read again at `refresh`
  (porelo [B220](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b220),
  [B221](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b221),
  [B227](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b227); *new, `porelo-ecosystems`:* a new
  repository and agent, Maven first, through MIMA).
- *The drafts shown before the first task:* in `default`, the interface shows what the machine proposes (porelo-frontend
  [F142](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f142)).
- *A company's private package repository, with no credential in the task:* `settings.xml` written at the start, the
  credential kept in the vault (porelo
  [B222](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b222),
  [B219](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b219)).

**Sprint 3 of 0.7 · The Porelo Wizard leads** ([PJ57](#pj57); *new, `porelo-wizard`*)

- *Questions, a plan, and taken up again:* the questions first, the whole plan shown before anything runs, and after a
  pause it goes on where the person was; a step done elsewhere counts as done.
- *A step for someone else handed over:* a step for an administrator comes as instructions and as a file to run; the
  wizard waits for its check.

**Sprint 4 of 0.7 · A chat beside the wizard, and a run with nobody there** ([PJ57](#pj57))

- *A chat answers questions about the current step:* with the Claude Code already signed in on the machine; it never
  sees a secret and runs nothing unconfirmed.
- *The same plan from a file of answers:* for many machines; a step that needs a person stops it and says so.

### Later: release 0.8, steering the work

The agents' work chosen, checked and paid for by rule; its plan is `plan/0.8.yml`.

| Sprint | The functions tested at its end |
|---|---|
| 1 · Adapters say what they offer | An adapter's services listed and a lacking one refused; a deprecated contract still taken with a warning ([PJ66](#pj66)). |
| 2 · A task's agent and effort by its work | The choice shown with where it came from; the operator's rule for a time ([PJ64](#pj64)). |
| 3 · A change checked before it leaves the machine | Rounds of check and fix at the gate; the person approves with every round in view ([PJ67](#pj67)). |
| 4 · What is left of each account | The daily accounts read; the accounts in the interface, the low ones first ([PJ65](#pj65)). |

## Review

| # | Size | Blocked by | What it covers |
|---|---|---|---|

## Implementing

| # | Size | Blocked by | What it covers |
|---|---|---|---|
| <a id="pj32"></a>[PJ32](PJ32-A-Vulnerability-Has-A-Way-In.md) | M | — | Whoever finds a vulnerability reports it privately through a `SECURITY.md` in every repository and one page in `doc/`; a fix gets a GitHub advisory and a changelog line. |
| <a id="pj27"></a>[PJ27](PJ27-A-Contributor-Knows-The-Rules.md) | L | — | One guide for contributors in `porelo-project`'s `doc/`, linked from every repository's README and `CONTRIBUTING.md`: how the work is organised, how a change is made, what it must satisfy. |
| <a id="pj40"></a>[PJ40](PJ40-A-Project-Comes-Up-On-A-Server-At-One-Command.md) | XL | — | Any project of several agents and repositories comes up on a server, owned or rented by the hour, at one command: Porelo writes an Ansible inventory from `project.yml`, the repositories' own files and the person's machine file; Ansible sets up the host from the host itself, `host up` (a Dart package of porelo-frontend, for the interface and the command line) rents it by the hour (Scaleway Elastic Metal for Porelo's own; OpenTofu later for others); following, keys and tasks stay Porelo's; Porelo's own project first. |
| <a id="pj39"></a>[PJ39](PJ39-Porelo-Is-Built-In-Porelo-Tasks.md) | — | [PJ40](#pj40), [PJ45](#pj45), [PJ22](#pj22); `porelo` [B189](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b189) | The agents work in Porelo tasks on one bare-metal host, owned or rented by the hour and set up by a script (at least 8 cores with 16 threads, 64 GB, one SSD of 1 TB): an `online` project whose upstream is a local Forgejo, one task per issue, phase and repository, Forgejo building and testing, the operator approving there, Matrix, what an agent learns committed to its `AGENTS.md` instead of memory, `porelo-all` for the coordinator; a plan in nine sprints after the groundwork, each ending in functions the operator tests. |
| <a id="pj14"></a>[PJ14](PJ14-Work-Starts-Without-A-Project.md) | M | — | Work starts in a checked-out or picked repository without a project, in the project `default`; left: refusals naming the way for a transport or a peer, a `project.yml` named `default`, and the move to a followed project measured. |

## Backlog

| # | Size | Blocked by | What it covers |
|---|---|---|---|
| <a id="pj63"></a>[PJ63](PJ63-A-Release-Is-Planned-In-Sprints-Of-Tested-Functions.md) | M | — | A release planned once in a checked-in file - its sprints, each sprint's functions the operator tests and the issues serving them - and a page made from it with every issue's state, kept current by the coordinator and checked against the indexes. |
| <a id="pj45"></a>[PJ45](PJ45-Chosen-Data-Outlives-The-Machine.md) | M | — | A short list of data that lives only on a machine - the Matrix room, the token usage records and the Maven cache to start with - copied every hour and at down by restic into the project's S3 store, encrypted on the host, and put back at up; nothing else is kept. |

## Analyzed

| # | Size | Blocked by | What it covers | Open questions |
|---|---|---|---|---|
| <a id="pj53"></a>[PJ53](PJ53-The-Agent-Already-On-The-Machine-Is-The-Default.md) | XL | — | A start without `--agent` and `--provider` takes the agent already installed and signed in on the machine, with its provider: each packaged agent reports what it finds of itself on the host, by path and never a credential's value; `porelo` chooses, a flag still wins, the choice and its source are named, and what is found but not in the vault is offered for `vault import`. | 0 |
| <a id="pj33"></a>[PJ33](PJ33-A-Plugin-May-Carry-Its-Own-License.md) | L | — | An agent, build reader, transport or client may carry its own license: the interface libraries (`porelo-agent-api`, `porelo-build-api`, `porelo-wire`, the varlink definitions) under Apache-2.0, Porelo itself GPL, the boundary written down. | — |
| <a id="pj09"></a>[PJ09](PJ09-A-Gates-Green-Says-Nothing-Until-Its-Reference-Set-Can-Change.md) | L | — | Every gate names its reference set; one that is empty, cannot change or is read by nothing is not counted as coverage. | — |
| <a id="pj16"></a>[PJ16](PJ16-An-Organisation-Decides-Which-Providers-Its-Machines-Use.md) | L | — | A root-owned machine policy names the providers tasks may use, and narrows follows, prompts and the `online` class; a developer cannot widen it. | — |
| <a id="pj03"></a>[PJ03](PJ03-An-Attachment-May-Be-Permitted.md) | XL | — | Whether a message may carry more than text becomes an operator's decision, per direction, project and peer, refused by default. | — |
| <a id="a09"></a>[A09](A09-Agent-Grok-Build.md) | L | — | Grok Build as a packaged agent: a candidate, brokering unverified. | — |
| <a id="a10"></a>[A10](A10-Agent-OpenCode.md) | L | — | OpenCode as a packaged agent: a base URL configurable per provider. | — |
| <a id="pj25"></a>[PJ25](PJ25-McPorelo-Apple-Containers.md) | XL | — | McPorelo: the same guarantees on Apple Containers, driven by one client through the daemon's contract. | 4 |


## Accepted

| # | Size | Blocked by | What it covers |
|---|---|---|---|
| <a id="pj62"></a>[PJ62](PJ62-The-Forge-Adapters-Live-In-One-Repository.md) | — | — | The forge adapters in one repository, `porelo-adapters`, renamed from `porelo-build-github`: its `github` adapter, a `forgejo` adapter beside it, one contract suite both pass, and `porelo build status` to ask any of them. |
| <a id="pj61"></a>[PJ61](PJ61-The-Project-Porelo-Is-Online-With-The-Local-Forge-Upstream.md) | — | — | The project `porelo` online with the local Forgejo upstream: a task's push built there, its verdict read in the task, the central forge reached through the mirrors after approval; proved on Sluice first. |
| <a id="pj60"></a>[PJ60](PJ60-Every-Workflow-Runs-On-The-Local-Forge-As-On-The-Central-One.md) | — | — | Every repository's `build.yml` runs green on the local Forgejo and the central forge with no edit between: kinds, registry and provider as variables; one issue (S) per repository. |
| <a id="pj59"></a>[PJ59](PJ59-Each-Agent-Moves-Into-A-Porelo-Task.md) | — | — | Each agent moves into a Porelo task, one at a time in a fixed order, each move an issue (S) of its own that the agent works inside its new task; the channel file kept beside Matrix until the last has moved. |
| <a id="pj58"></a>[PJ58](PJ58-The-Coordinator-Works-In-One-Repository-Of-Them-All.md) | — | — | The coordinator reads every repository in `porelo-all` on the local Forgejo and changes only `porelo-project`, split back after the operator's approval. |
| <a id="pj57"></a>[PJ57](PJ57-A-Person-Is-Led-From-Nothing-To-Work.md) | — | — | The Porelo Wizard, in a repository of its own with an agent of its own: questions first, a plan of every step, progress kept and taken up again, hand-overs with instructions to an administrator or a forge's, and a chat beside it in the interface; the core of the usability sprint. |
| <a id="pj55"></a>[PJ55](PJ55-Porelo-Runs-On-arm64.md) | — | — | Porelo and every native package it installs built, tested and published for arm64, so a Linux VM on Apple silicon installs them, for porelo-frontend [F109](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f109): built and checked on GitHub's arm64 runners on every Build; for a release, a Mac rented for the whole test window tests every part, the interface included. |
| <a id="pj54"></a>[PJ54](PJ54-The-ChatGPT-Sign-In-Is-A-Provider.md) | — | — | The ChatGPT sign-in as a provider of its own beside the API key, brokered on the host with its token refresh, for Codex CLI; the undocumented backend accepted as a risk. Waits for `porelo`. |
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
| <a id="pj64"></a>[PJ64](PJ64-A-Task-Chooses-Its-Agent-And-Effort-By-Its-Work.md) | — | — | A task gets the agent, provider, model and effort its work calls for - by its phase (`build`, `check`, `rework`) and its issue's risk - on one effort scale each agent maps to its provider, with a flag, the project's rule, its default and the machine's agent in that order; a `check` task only reads and reports. |
| <a id="pj65"></a>[PJ65](PJ65-What-Is-Left-Of-Each-Providers-Limits-Is-Shown.md) | — | — | Every account the agents spend on - subscriptions by share of a window, API keys by tokens or money, a forge's AI credits, a company's budget per developer, several of a kind told apart - with its meters read by each provider's adapter or estimated from Porelo's own count, shown in one view with what is left and when it comes back. |
| <a id="pj66"></a>[PJ66](PJ66-An-Adapter-Offers-The-Services-It-Has.md) | — | — | Each adapter Porelo finds lists the services it offers - agent, build, review, model limits, transport - each by its own contract and version, answers "not supported" where a service cannot, and a project names adapter and credential per service, so a forge, a build server and a model provider are never mixed up. |
| <a id="pj67"></a>[PJ67](PJ67-A-Change-Is-Checked-Before-It-Leaves-The-Machine.md) | — | — | Work waiting at a task's gate is checked by another agent's `check` task on that very commit; its findings stay with the commit and wake the building task, which fixes and pushes again, in bounded rounds, before the person approves at the gate with every round in view. |
| <a id="pj68"></a>[PJ68](PJ68-Every-Container-Fits-The-Machine-It-Runs-On.md) | — | — | Every container a Porelo part starts - task, image build, the room's homeserver, the host's forge and runner jobs - runs with limits of its own, and a pool sized from the machine sees those limits, so a part that works on a small machine also works on a large rented host. |
| <a id="pj69"></a>[PJ69](PJ69-A-Machine-Reaches-The-Forge-With-The-Persons-Token.md) | — | — | A machine reaches the forge with the person's own token by default, kept in its vault; Porelo no longer makes and removes a deploy key per machine and repository, which a company seldom lets a person create. |
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
