# Decisions

The choices the project as a whole is built on, each with why it holds and, for an accepted risk, the exposure, why
it stays and what would change the answer.

| Subject | What holds | Link |
|---|---|---|
| The old name keeps its addresses and holds nothing new | `sokar-ai` keeps only its profile, `org.fuin.sokar` stays at Maven Central without a relocation, released changelog entries keep the old name | [entry](#the-old-name-keeps-its-addresses-and-holds-nothing-new) |
| Porelo is installed afresh | nothing of a machine that ran Sokar is read, kept or migrated | [entry](#porelo-is-installed-afresh) |
| The RPM repository indexes one folder deep | `porelo-dist-rpm` has the *YUM Metadata Folder Depth* 1 | [entry](#the-rpm-repository-indexes-one-folder-deep) |
| A library's license follows how it is used | Java libraries LGPL-3.0-or-later, even where a native package links them; an API others build their own extensions against Apache-2.0; Porelo itself GPL-3.0 | [entry](#a-librarys-license-follows-how-it-is-used) |
| Code from outside reaches no secret | one organisation ruleset on `main` (no deletion, no force push, a pull request with the code owner's review), its only bypass the organisation admin; `CODEOWNERS` for `.github/`, build files and `AGENTS.md`; a fork's workflow waits for approval | [entry](#code-from-outside-reaches-no-secret) |
| Work not yet sent by the gathered push is lost with a failed machine | the host keeps no backup of the local forge; a person who wants one backs it up with means of their own | [entry](#work-not-yet-sent-by-the-gathered-push-is-lost-with-a-failed-machine) |
| A pull request's checks inform and never block | no repository requires a status check to merge; the *Workflow check* runs only on a pull request touching `.github/**` | [entry](#a-pull-requests-checks-inform-and-never-block) |
| Only ssh reaches a host in normal work | a developer and a project admin reach a host by ssh with their own key, never by a VPN; the VPN is the installation's alone, and a VPN per person is allowed only while the project's own work moves onto its hosts | [entry](#only-ssh-reaches-a-host-in-normal-work) |
| The project file alone needs the project admin's signature | a follow checks every commit that changes the project file, not the top of `main`; developers change the rest of the project's repository on their own; each repository says whether a merge needs a second person's review; an agent never merges | [entry](#the-project-file-alone-needs-the-project-admins-signature) |

## A library's license follows how it is used

**What holds:** a Java library of the project - used as a jar by whoever depends on it - is under the
LGPL-3.0-or-later: anyone may build it into their own products, closed ones included, and a change to the library
itself is published. This holds where one of the project's own native packages (`.deb`, `.rpm`) links it, as
`porelo-adapters` links `porelo-forge-clients`: that package's source is open, so anyone can rebuild it with a changed
library, which is what the LGPL asks. An API that others build their own extensions against, such as an adapter's or a
plugin's interface library, is under Apache-2.0, because such an extension may be closed and shipped as a native
image, where the LGPL would ask that the library can be replaced. Porelo itself is under the GPL-3.0 (operator,
2026-10-30: "Für allgemeine Java Libraries gilt der Grundsatz LGPL zu benutzen"). **What would change the answer:** a
library that turns out to be an API for others' extensions, or an extension API that is to be used as a plain library.

## Code from outside reaches no secret

The repositories are public and their builds rent machines and publish with secrets GitHub holds. **What holds:**
one organisation ruleset protects `main` in every repository - no deletion, no force push, and a change only through
a pull request with one approval that is the code owner's, re-asked after each push, merged by squash. Its only bypass
is the organisation admin, which is how the operator's own pushes reach `main`; no app, team or deploy key bypasses
it. `CODEOWNERS` names the operator for `.github/`, the build files and `AGENTS.md`. A fork's pull request runs no
workflow until approved ("Require approval for all external contributors"), and `check-actions` refuses
`pull_request_target`. **How it is checked:** `tools/forge-rules-probe.sh OWNER_TOKEN_FILE OTHER_TOKEN_FILE` makes a
throwaway repository, sees a second account's direct push and force push refused, its fork's pull request waiting for
approval and asking for the code owner, and removes everything again. It needs a token of the operator's
(`repo`, `workflow`, `delete_repo`, `admin:org`) and one of a second account (`public_repo`, `delete_repo`), read from
files only. **What would change the answer:** a second maintainer, which makes the bypass a team, or a bot that must
merge, which this rule set lets through only as a bypass.

## Work not yet sent by the gathered push is lost with a failed machine

The host the agents work on is set up from nothing and given back with nothing kept on it: the code is in the
forge, the person's own settings on a drive the person mounts, and a short list of chosen data is copied off it.
The local forge is not backed up. **The exposure:** work merged on the local forge but not yet sent to the central
forge by the gathered push, and every branch not yet merged, is lost when the machine fails or is given back too
early. **Why it stays:** a backup of the forge would be a second copy of the code with its own schedule, target and
restore to keep working, for a loss bounded by the time between two gathered pushes, and the agents can build the work again. A person
who wants it covered backs up the local forge elsewhere with means of their own, of which Porelo knows nothing. **What
would change the answer:** a loss that costs more than the work since the last gathered push can be redone in, or
gathered pushes so far apart that a failed machine regularly takes more than a working day with it.

## The old name keeps its addresses and holds nothing new

The product was called Sokar before it was called Porelo. The organisation `sokar-ai` stays and keeps only its
profile (`.github`), which says where Porelo is: the forge redirects every transferred repository's old address only
while no repository of that name exists there, and a kept organisation cannot be taken by somebody else, so no
repository is made in it again. The artifacts under `org.fuin.sokar` stay at Maven Central as they were released,
without a relocation. Released changelog entries keep the name they were
released under; every repository's test that refuses the old name excepts them.

## Porelo is installed afresh

A machine that ran Sokar gets Porelo as a new install: no state, command, path, setting or vault of Sokar is read,
kept running or migrated, and no `sokar` command remains. Projects are set up again and credentials entered again.
Nothing has to carry two names, and a test refusing the old name can hold everywhere outside the released history.

## The RPM repository indexes one folder deep

`porelo-dist-rpm` at Artifactory has the *YUM Metadata Folder Depth* 1, so each channel (`snapshots`, `releases`)
is indexed in its own folder. A YUM repository made by hand starts at 0 and indexes beside the channel instead of in
it.

## A pull request's checks inform and never block

**What holds:** no repository's ruleset requires a status check before a merge. Each pull request runs its checks,
the *Build* when code changes and the *Workflow check* only when it touches `.github/**` (an action's pin, its
version comment, each workflow loading with triggers and jobs); the code owner reads their result before merging.
Measured on 2026-10-26 on all 15 repositories: none requires a check. **Why it stays:** a required check would
have to report on every pull request, so the path-filtered *Workflow check* would run on all of them, and a check
that cannot pass on one forge (such as `shared-rules.yml` on the local forge) would block a merge there; the code
owner already reviews every merge. **What would change the answer:** a merge by anyone other than the code owner, or
a red check found merged on `main`.

## Only ssh reaches a host in normal work

**What holds:** a developer and a project admin reach a host only by ssh with a key of their own: their account, the
forge (Git, pull requests, its web pages, the registry), the project's room and the daemon, through ssh's own
forwarding where a service is not ssh. The VPN belongs to installing the host, its host admin alone. While the
project's own repositories move onto their hosts, a VPN peer per person is allowed; it is taken out before others are
admitted. **Why:** an access file a person can be given then needs only an ssh key, on any machine and any network, and
a host offers one way in to secure. **What would change the answer:** a service that cannot be forwarded over ssh.

## The project file alone needs the project admin's signature

**What holds:** a machine following a project applies a new `main` when every commit that changes the project file, or
another file deciding what the machines do, is signed by a key in `signers`; other commits need no signature.
Developers change the rest of the project's repository on their own; a change to
the project file is the project admin's, signed, and a developer reviews it. Each repository says in the project file
whether a pull request on the host's local forge needs another person's approval or its author may merge it; only
people merge, never an agent. **Why:** checking only the top commit refused every
change a developer brought in by a pull request, even one the project admin approved, since the forge's approval is no
signature and `main` takes no direct push; and what the signature protects is the project file - the security class,
`egress`, the agents, `signers` - not the plans and documents beside it. Not every project wants a second person's
review of each change (operator, 2026-10-30). **What would change the answer:** a file outside the project file that
decides what the machines do and cannot be listed as protected.

