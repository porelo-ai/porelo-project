# Project requirements

**What belongs here.** A requirement belongs in this repository while it is about the project rather
than one of its repositories: the shape of the product, a decision that spans several repositories,
or something still too unclear to say which repository would build it; and the candidate agents
(`A`) that have no repository yet.

**A requirement leaves.** Once it is clear which repository does the work, it moves there as an
issue, a handover rather than a copy.

Within each group, ordered by what to do next; the number is identity, not sequence.

**How Sokar measures up against security guidelines** is in [security-guidelines.md](security-guidelines.md); every gap to be closed links its issue there.

## Implementing

| # | Size | Blocked by | What it covers |
|---|---|---|---|
| <a id="pj14"></a>[PJ14](PJ14-Work-Starts-Without-A-Project.md) | M | — | Work starts in a checked-out or picked repository without a project, in the project `default`; left: refusals naming the way for a transport or a peer, a `project.yml` named `default`, and the move to a followed project measured. |
| <a id="pj28"></a>[PJ28](PJ28-Code-From-Outside-Reaches-No-Secret.md) | S | — | Before the repositories are public: `main` protected with the operator as the only bypass, `CODEOWNERS` for workflows, build files and rules, a fork's workflow waits for approval, and `check-actions` refuses `pull_request_target`. |

## Analyzed

| # | Size | Blocked by | What it covers | Open questions |
|---|---|---|---|---|
| <a id="pj33"></a>[PJ33](PJ33-A-Plugin-May-Carry-Its-Own-License.md) | L | — | An agent, build reader, transport or client may carry its own license: the interface libraries (`sokar-agent-api`, `sokar-build-api`, `sokar-wire`, the varlink definitions) under Apache-2.0, Sokar itself GPL, the boundary written down. | — |
| <a id="pj09"></a>[PJ09](PJ09-A-Gates-Green-Says-Nothing-Until-Its-Reference-Set-Can-Change.md) | L | — | Every gate names its reference set; one that is empty, cannot change or is read by nothing is not counted as coverage. | — |
| <a id="pj16"></a>[PJ16](PJ16-An-Organisation-Decides-Which-Providers-Its-Machines-Use.md) | L | — | A root-owned machine policy names the providers tasks may use, and narrows follows, prompts and the `online` class; a developer cannot widen it. | — |
| <a id="pj03"></a>[PJ03](PJ03-An-Attachment-May-Be-Permitted.md) | XL | — | Whether a message may carry more than text becomes an operator's decision, per direction, project and peer, refused by default. | — |
| <a id="a06"></a>[A06](A06-Agent-Codex-CLI.md) | L | — | Codex CLI as a packaged agent: a candidate, brokering unverified. | — |
| <a id="a07"></a>[A07](A07-Agent-Gemini-CLI.md) | L | — | Gemini CLI as a packaged agent: a candidate, brokering unverified. | — |
| <a id="a09"></a>[A09](A09-Agent-Grok-Build.md) | L | — | Grok Build as a packaged agent: a candidate, brokering unverified. | — |
| <a id="a10"></a>[A10](A10-Agent-OpenCode.md) | L | — | OpenCode as a packaged agent: a base URL configurable per provider. | — |
| <a id="pj25"></a>[PJ25](PJ25-McSokar-Apple-Containers.md) | XL | — | McSokar: the same guarantees on Apple Containers, driven by one client through the daemon's contract. | 4 |


## Idea

| # | Size | Blocked by | What it covers |
|---|---|---|---|
| <a id="pj34"></a>[PJ34](PJ34-Every-Change-Reaches-Main-Through-A-Pull-Request.md) | — | — | Every change reaches `main` through a pull request with green required checks, so `main` needs no bypass. |
| <a id="pj35"></a>[PJ35](PJ35-An-Agent-Orchestrates-Sokar-Machines.md) | — | — | An MCP server outside Sokar lets an agent steer tasks and machines of one or many Sokar instances, without approving work or opening a vault. |
| <a id="pj36"></a>[PJ36](PJ36-Builds-Read-From-Bitbucket-Data-Center-And-Jenkins.md) | — | — | Builds of a push read from Bitbucket Data Center and Jenkins, the build server separate from the forge. |
| <a id="pj37"></a>[PJ37](PJ37-Work-Reaches-The-Upstream-Where-No-Machine-Key-May-Be-Added.md) | — | — | Where no machine key may be added: an administrator asked, or the person's own token used on the host only. |

## Estimated

| # | Size | Blocked by | What it covers |
|---|---|---|---|
| <a id="pj29"></a>[PJ29](PJ29-One-Code-Style-For-IDE-And-Build.md) | XL | — | One shared `.editorconfig` with the Google style in every repository, followed by the IDE and checked by the build with Spotless and `google-java-format` (AOSP: four spaces, 100 columns) in `validate`; IntelliJ with the `google-java-format` plugin. |
| <a id="a08"></a>[A08](A08-Agent-Copilot-CLI.md) | L | — | Copilot CLI as a packaged agent: brokerable by environment variable (BYOK), which is not the Copilot subscription. |
| <a id="pj27"></a>[PJ27](PJ27-A-Contributor-Knows-The-Rules.md) | L | — | One guide for contributors in `sokar-project`'s `doc/`, linked from every repository's README and `CONTRIBUTING.md`: how the work is organised, how a change is made, what it must satisfy. |
| <a id="pj15"></a>[PJ15](PJ15-A-Tool-Does-Not-Change-Behind-The-Persons-Back.md) | XL | — | An MCP server's tools are pinned when a person accepts them, a change is held until accepted again, and descriptions written to steer the agent are caught. |
| <a id="pj08"></a>[PJ08](PJ08-An-Unattended-Jobs-Refusal-Reaches-A-Person.md) | L | — | An unattended job's refusal reaches a person. |
| <a id="pj22"></a>[PJ22](PJ22-One-Build-Locally-As-On-The-Central-Forge.md) | XL | — | One build, run locally as on the central forge: the same workflows on a local Forgejo, its registry instead of the hand-over and the public repositories, acceptance legs on a machine rented through one interface (a local VM account or a provider's server), and a task's work built the same way, read through one reader contract by a `github` and a `forgejo` reader. |
| <a id="pj32"></a>[PJ32](PJ32-A-Vulnerability-Has-A-Way-In.md) | M | — | Whoever finds a vulnerability reports it privately through a `SECURITY.md` in every repository and one page in `doc/`; a fix gets a GitHub advisory and a changelog line. |
| <a id="pj24"></a>[PJ24](PJ24-Where-The-Agent-Protocols-Touch-This.md) | M | — | For A2A, MCP, ACP and AG-UI each: adopted, answered otherwise, or refused, with the reason and what would change it. |

## Finished

| # | Title | What was built |
|---|---|---|
| <a id="pj17"></a>[PJ17](README.md#pj17) | The MVP | Its shape is in [the project chapter](../doc/index.md#the-mvp); which issue belongs to a round is now each index's *Backlog*. |

## What was decided along the way

- **Messaging is not one repository's job.** The format is A2A 1.0, an external standard; what
  remains divides into the handover at the container boundary (`sokar`), what may pass (the filter)
  and the carrying (the transports).
- **An adapter's repository is an ownership question, not an architectural one.** Transports are
  discovered executables speaking a CLI, so nothing compiles against one and moving it breaks nothing.
- **No project-wide message store**: a Matrix room is one.
- **No chat client is shipped.** Any Matrix client will do, and no agent needs one.
- **Room membership is not authorization.** Matrix distributes; Sokar decides, on the signature.
