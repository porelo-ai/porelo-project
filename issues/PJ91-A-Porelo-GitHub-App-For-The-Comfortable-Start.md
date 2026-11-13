# PJ91 — A Porelo GitHub App for the comfortable start

```json
{
  "$schema": "issue-1.json",
  "id": "PJ91",
  "title": "A Porelo GitHub App for the comfortable start",
  "state": "Estimated",
  "size": "XL",
  "priority": "Medium",
  "rank": 4,
  "blockedBy": [],
  "covers": "A person starts at GitHub by installing Porelo's app and signing in from the window with a device code, with no token made by hand, no private key shipped and no token on a host; beside the token way and the manual way, the host's deploy keys staying."
}
```

**Severity.** Medium; nothing fails without it, but the token is the hardest step of a start.

**What must be true.** A person who wants it comfortable starts with Porelo at GitHub without making a token by hand: they
install Porelo's app, choose the repositories and sign in from the window with a code. No private key of Porelo's ships in a
package, no token lies on a host, and the token way and the manual way stay.

**The answer in short.** Worth building, as a third way beside the two others: a public GitHub App with no server, used only
through the device flow and user access tokens, never through installation tokens. It saves the repeated steps and the wrong
rights, hardly any step of the first time. The host's deploy keys stay. [B270](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b270)
decided the opposite kind of application, so that must be settled first.

**How this was read.** GitHub's rules from its public documentation; Porelo's from the code on `main`. Nothing was registered,
called or run at GitHub, so nothing about GitHub here is measured. What only a trial can settle is under *To be checked*.

## 1. Which uses of today's token it replaces

A user access token has only what both the person and the app may, and only in an account where the app is installed.

| Use | Where | The app's permission | With the app |
|---|---|---|---|
| Making the project's repository | `ForgeRepositoryMaker`, `porelo` | Administration: write, or Repository creation: write; which suffices is to be checked | Replaced. It takes an organization, see 2 |
| Adding each read deploy key, and the organization's | `porelo-host-project`, `porelo-host-person add_read_key` | Administration: write | Replaced. The window gives the token on standard input as today |
| Migrating once to the host's forge | `porelo-host-project`, `POST /repos/migrate` | Contents: read | Replaced, if the forge's clone takes a user token, to be checked |
| Reading an owner's membership | `HttpForgeDirectory`, `porelo` | Members: read, an organization permission | Not asked for. [B414](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b414), an idea so far, moves the first read to a repository's collaborator permission, Metadata: read |
| Reading `ssh_signing_keys` | `HttpForgeDirectory` sends no token | None: GitHub serves it to anyone | Nothing to replace |
| Adding and removing a member at a repository | `ForgeCollaborators`, `porelo-frontend`: nothing calls it, as a project's members stand in the organization and there is no access repository | Administration: write | Nothing to replace |
| Listing repositories, reading `project.yml` | `GitHub`, `porelo-frontend` | Metadata: read, Contents: read | Replaced. It lists only where the app is installed |
| Pushing approved commits back | `porelo-host-push` | Contents: write, and Workflows: write for a change under `.github/workflows/` | Replaced, given per run as today |

**So the app asks for one set:** Metadata: read, Contents: write, Administration: write, Workflows: write, and no organization
permission. An app's permissions are one list, accepted whole, so the two wide rights cannot be left to whoever needs them, as
[B270](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b270) leaves `workflow` to the login and [F349](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f349)
leaves Administration to the person. Leaving out every organization permission matters: a repository's admin can install an app
in an organization only where it asks for none of certain organization permissions. A token is still bound by the person's own
rights, so a developer with write gets no Administration from it.

**The host's deploy keys are still needed.** The follow reads the central repositories every five minutes, and removing a project
compares with them, with no person there. Without a deploy key the host would need a user token or a refresh token, which is a
token lying on the host, or an installation token, which needs the app's private key on the host. A public repository needs
neither, and that is no general way. So the app replaces the token that adds the key, not the key.

## 2. What a person does

The steps are counted by reading, not by walking them.

| | Token way | App |
|---|---|---|
| **First start** | 1 open the token page, 2 choose owner and expiry, 3 choose repositories, 4 add the rights, 5 generate and copy, 6 store it in the secrets file, 7 *Give it my GitHub token* | 1 the window opens the install page, 2 choose the account, 3 choose repositories, 4 install, 5 the window shows a code and opens GitHub, 6 enter it and authorize |
| **A new repository** | Edit the token's repositories, unless it has all of them | Add it to the installation, unless all were chosen; whether one the app makes itself joins is to be checked |
| **A wrong right** | A refusal naming the right, then a token again | Cannot happen: the list is the app's |
| **It expires** | Make it again, at the end the person chose | Renewed unasked while it is used within six months, otherwise the code again |
| **A second person, app installed** | The same seven steps | Steps 5 and 6 |

The first start is hardly shorter, six steps against seven. What goes is the copying, the choice of rights and every later round.

**A person who owns no organization.** Anyone can install an app on their own account, so that fits, but only partly today:

- `project open` makes the repository with `POST /orgs/{org}/repos`, which is the organization's call. Their own account needs
  `POST /user/repos` as well, with either kind of token. That gap is today's, not the app's.
- **Someone working in an organization they do not own cannot install there.** They can only ask, and GitHub tells an owner. Until
  then the app reaches nothing there, and they stay on the token way. A repository's admin can install it for the repositories
  they administer.
- An organization's own rules on apps can hold it up as they can a fine-grained token.

## 3. How a window with no server gets a token

| | Device flow, user access token | Installation token |
|---|---|---|
| **Needs** | The client id only; GitHub says no client secret is needed. Device flow is switched on in the app's settings | A token signed with the app's private key |
| **Lives** | Eight hours, with a refresh token for six months. Renewing a device-flow token needs no secret. Each renewal replaces both tokens | One hour |
| **Acts as** | The person, within their own rights | The app, on every repository of the installation, with no person's rights to bound it |
| **Who would hold the key** | Nobody | A server of ours, which we do not have, or a key in a package or on a host, which Porelo's rule forbids and GitHub says never to do for a native app |

So: **device flow only.** Nobody needs the private key. If GitHub wants one to exist at all, it keeps only the public half, so it can
be generated and not kept; the last one cannot be deleted without a new one. Whether one must exist is to be checked at the
registration. Porelo's `DeviceGrant` already runs this flow.

- **Where the token lies.** On the person's own computer, never on a host. The flow runs there, and the window's terminal hands the
  access token over on standard input per use, as it does today, so the host's helpers do not change. Run on a host, the flow would
  leave the token there.
- **The refresh token is written back at every renewal**, since the old one stops working. That means writing to the person's
  secrets file, where a token is only read today. Two computers sign in separately, as one's renewal would end the other's.
- **The limits.** A code must be entered within 15 minutes. GitHub allows 50 code submissions an hour **per application**, so all
  of Porelo's people share them, which is one more reason to renew rather than ask again; and ten tokens per person, app and scope.
- **The client id is public, and anyone can sign in with it.** A program posing as Porelo can show a person a real code on GitHub's
  real page and get a token with these rights. Today's pasted token has its own ways to be stolen, but this one is new, and the
  window's words must say what is being granted.

## 4. What running it costs

- **Registration and owner.** It is registered once, public, by an organization or person; here that is outward and the operator's.
  Whoever owns it can change it and is who people see they trust. No webhook and no callback are needed, so nothing runs.
- **A permission change asks every installer anew.** Added repository permissions wait until each account approves, and GitHub
  writes to each owner; a removal holds at once. So the set above is right from the first day or expensive after it.
- **An open-source fork brings its own app.** The id is a setting, as `client_id` already is on a vault entry, with Porelo's as the
  default. A fork that keeps it gets its people's grants under Porelo's name. A GitHub Enterprise Server needs its own registration.
- **Forgejo and the others stay on the token way.** Forgejo's documentation offers the authorization code grant only, and no app in
  GitHub's sense exists there. The host's own forge is untouched: its credentials are made by the host, and its OAuth is off. Each
  further forge is its own question.
- **It stands beside the others and replaces neither.** The token way serves every other forge and everyone whose owner has not
  installed the app; the manual way serves whoever will grant no Administration at all, which this app does ask for.

## 5. Recommendation and size

Build it after [B270](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b270) is settled, in this order, with the trial below first.

| Repository | Size | What |
|---|---|---|
| `porelo-project` | XS | The decision, this issue's split |
| `porelo-frontend` | L | Install page, device flow with its code, renewal and writing it back, the third choice beside the two ways, the refusals, a walk |
| `porelo` | S | The default client id, `doc/credentials.md` ("Porelo ships none of its own"), a decision. Up to M if personal accounts come with it |
| `porelo-host` | XS | None in the code if the token on standard input holds; the words in `doc/local-forge.md` |
| `porelo-forge-clients`, `porelo-adapters` | none | A token is a token to them |


## The build and review adapters' part (Agent Adapters, 2026-11-12)

Read in porelo-adapters `main` (6213f20) and porelo `main` (`apps/app-task/.../BuildsWiring.java`). Nothing was run
at GitHub; what GitHub grants is from its documentation.

### 1. The table of uses misses the build and review reads

Proposed rows for section 1, "Which uses of today's token it replaces":

| Use | Where | The app's permission | With the app |
|---|---|---|---|
| Reading a branch's head, a commit's runs, their jobs and a failed job's log | `GitHubReader`, `porelo-adapters`: `git/ref/heads/{branch}`, `actions/runs?head_sha=`, `actions/runs/{id}/jobs`, `actions/jobs/{id}/logs` | Actions: read, Contents: read, Metadata: read | Not replaced while the reads run on the host, see 2 |
| Reading a pull request's review comments and writing a released one | the GitHub adapter's `Review1`, not built yet | Pull requests: read, and write for a released comment | As the build reads, see 2 |

**So the app's set lacks Actions: read**, and Pull requests: read and write once reviews ship. The set in "So the app
asks for one set" grows by those two; as section 4 says, a permission added later asks every installer anew, so they
belong in it from the first day if the app is to serve the builds or the reviews at all.

### 2. The build reads run on the host, with a token of the host's vault

`BuildsWiring` starts the build reader on the host for a task's whole life, with the credential `project.yml`'s
`builds` names, read from the vault of the person's account on the host ("run porelo host forge-token on this host").
That is a token lying on a host, which [PJ91](README.md#pj91)'s "no token on a host" excludes for the app's token, and a user access
token lives eight hours, shorter than many tasks, with a refresh that writes back.

So either:

- the builds keep their own read token on the host, by the token way, holding only Actions: read, Contents: read and
  Metadata: read - the app then does not touch the builds, and the window's words say so; or
- the app's refresh token lies on the host for the builds, against [PJ91](README.md#pj91)'s rule.

The proposal is the first: a read-only token for the builds, made by the token way. It adds one question to [PJ91](README.md#pj91)'s
open ones for the operator: **may the builds keep a read-only token on the host beside the app?**

### 3. What porelo-adapters changes

Nothing in its code: `GitHubReader` sends `Authorization: Bearer <token>`, which GitHub's documentation names for
user access tokens as for the others, and the log request after the redirect carries none. Size here: none, as [PJ91](README.md#pj91)
says. To be checked in [PJ91](README.md#pj91)'s trial: one `actions/runs?head_sha=` and one job log read with a user access token of the
test app holding Actions: read.

## Decided by the operator (2026-11-12)

- **Builds keep a read-only token on the host beside the app:** porelo reads a task's builds for its whole life with a read-only token made the token way; the app does not replace it.

## Open questions

- **Which kind of application?** [B270](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b270) decided an OAuth App, not a GitHub App, with `repo` and no expiry, and a token in each machine's
  vault. It is the shorter way: no install, only steps 5 and 6 of the table in 2. But it reaches everything the person can, never
  ends, cannot be held to chosen repositories, and its token in a machine's vault no longer agrees with no token on a host. The
  proposal is this app, with that issue rewritten to it. What an organization's rules do to an OAuth App was not read.
- **Who owns the registration**, and does the operator accept one app carrying Administration and Workflows, against two apps and more
  steps? The proposal is one.

## To be checked

These need a trial with a registered test app, which is outward and waits for its go-ahead.

- Whether `POST /orgs/{org}/repos` takes Repository creation alone, without Administration, and whether that permission counts
  as an organization permission for a repository admin's install.
- Whether a repository the app makes joins an installation on selected repositories.
- Whether the forge's migration clone and `git push` take a user token as `x-access-token`.
- Whether a registration needs a private key before it can be installed.
- With the frontend's agent: how a rotated refresh token is written to the secrets file, or whether a person gives the code each time.
