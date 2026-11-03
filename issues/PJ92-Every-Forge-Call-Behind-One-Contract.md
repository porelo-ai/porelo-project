# PJ92 — Every Forge Call Behind One Contract

**Status:** Idea. Taken up when the next forge is to be implemented; only then do its open questions matter. Nothing is built before.

**What must be true.** A person can use Porelo on any forge that offers what Porelo needs, by installing that forge's adapter: the
window asks only Core, Core asks only the adapter, and only the adapter knows a forge's addresses, paths and answers.

## Why

Builds and pull requests already work this way, through `org.fuin.porelo.Build2` and the packages of `porelo-adapters`. Everything
around an organization and a start does not. Core decides by `github.com` or "any other host is Forgejo or Gitea", the frontend
calls GitHub itself with its only implementation of `Forge`, and the host has a branch of its own. A third forge would be a change
in three languages, and a GitLab host is asked as Forgejo today. Core and the frontend also read a person's keys with separate code,
so the two can answer differently, and the frontend is a second place that uses the person's token.

## What is built in today

Read from `porelo` at `1d83713d`, `porelo-frontend` at `21706c11` and `porelo-host` at `e5ced67`. A repository is `owner/name`.

### Core

| Name | Input | Output |
|---|---|---|
| `IdentitySource.keys` | login | all keys listed for the login, whether the list is complete; or empty: could not ask |
| `IdentitySource.keys` | login, fingerprint | the same, and may stop at the first list holding that key |
| `IdentitySource.owns` | organization, login, the reader's token | whether the login is an owner; or empty: cannot say |
| `HttpForgeDirectory.account` | the reader's token | the token's login, name, email; or empty |
| `HttpForgeDirectory.profile` | login | login, name, email; or empty |
| `HttpForgeDirectory.signingKeys` | login | signing keys; or empty |
| `HttpForgeDirectory.authenticationKeys` | login | authentication keys; or empty |
| `ForgeRepositoryMaker.make` | forge, token, organization, name | nothing; refused as `not-allowed`, `exists` or `cannot-say` |
| `ForgeReadKey.add` | repository, token, public key, title | whether it was added; refused as `not-allowed` or `cannot-say` |
| `ForgeReadKey.revision` | repository, token | the latest commit's name; or null |

### Frontend

| Name | Input | Output |
|---|---|---|
| `Forge.whoAmI` | token | login |
| `Forge.repositories` | token | every repository reached: name, ssh URL, https URL, default branch, admin, push, private |
| `Forge.repository` | token, repository | one such repository |
| `Forge.hasProjectFile` | token, repository | whether `project.yml` stands at the root of its default branch |
| `Forge.branches` | token, repository | branch names, in the forge's order |
| `Forge.hostKeyFingerprints` | token | the forge's own SSH host key fingerprints |
| `Forge.signingKeys` | token, login | signing keys: title, key |
| `CentralForgeReviews` (`central_reviews.dart`) | token, repository | a central forge's reviews: read, create, submit |

### Host, on the central forge

| Name | Input | Output |
|---|---|---|
| list deploy keys, inside `porelo-host-project` | token, repository | the repository's deploy keys: id, key, read-only |
| add a deploy key, inside `porelo-host-project` | token, repository, public key, title | the key's id, read-only |
| delete a stale deploy key, inside `porelo-host-project` | token, repository, key id | nothing |
| Git over SSH by the read key | the central address, the read key | the follow's reads |

`POST /repos/migrate` is a call on the host's own forge, not on a central one, but it carries a central address and the token's Git
user `x-access-token`, which differs by forge.

### Knowledge that is no call

| Where | What it knows |
|---|---|
| Core, `IdentityFacts` | the web page where a person adds a key |
| Frontend, `GitHub.apiOf` | where the API of a GitHub address is |
| Frontend, `onGitHub` | which upstream addresses are on `github.com` |
| Frontend, `commit_signing.dart` | the author address `<login>@users.noreply.github.com` |
| Core, `ForgeRepositoryMaker`, `HttpForgeDirectory`, `ForgeReadKey`; host, `Central` | the choice of forge by host name |
| Core, `IdentityProposeCommand` | the greeting of `ssh -T` that names a login, and a noreply address |
| Frontend, `project_workspace.dart` | the same author address as `commit_signing.dart` |
| Frontend, `tokenPage` | the page where a person makes a token |
| Frontend, `forge_connection.dart` `_keptBefore` | `github.com` as the name of a token kept earlier |
| Frontend, `machine_binding.dart` | the forms of an address |
| Frontend, some 15 places | that a repository's name has two parts, `owner/name` |
| Frontend, `forge_connection.dart` | the window's own Git operations, which hold the token |
| Everywhere a token is sent | the form of the `Authorization` header and the token's Git user |

Also read today: `/installation/repositories` for an app's token, and the public `.keys` page of a login.

## Design result

Design only; nothing was built and no forge was called for it. Reading: the adapter draft, the table of forges, the window's needs and
a reading of the draft against Core at `1d83713d` and the host's reply. Forge facts are as sure as their marks.

### The contract

The window asks only Core. Core alone starts an adapter. Same executable and start as `Build2`, two new interfaces beside it, found
by varlink's `GetInfo`.

| Interface | Methods |
|---|---|
| `Forge1`, no call | `Recognize`, `ParseUpstream`, `Facts` |
| `Forge1`, calls | `Account`, `Profile`, `Repositories`, `Repository`, `MakeRepository`, `FileExists`, `Branches`, `CheckRight`, `GrantRead`, `RevokeRead`, `ReadAccess`, `DeployKeys`, `AddDeployKey`, `DeleteDeployKey` |
| `Identity1` | `Keys`, `Owns`, `HostKeys` |
| `Review1`, later | not drawn yet |

Every call carries `Forge(address, api?, token?)`; no token means anonymous. A repository is an opaque handle only the adapter parses.
The token travels in the call's parameters over an owner-only socket, and Core alone chooses which token goes to which address.

Every answer is one of four: an answer; `Cannot`, this forge has no such thing; refused (`CredentialRefused`, `NotAllowed(needs)`,
`NoSuchRepository`, `NoSuchAccount`, `Exists`); could not ask (`RateLimited`, `Unreachable`, `CannotSay`). Only what a forge said plainly
is an answer, and every list says `complete`.

**Settled:** opaque handles; the window holds no token and starts no adapter; the four outcomes, and a failure is never a no; `complete`
on lists; keys come with a usage that may be `unknown`; the rule for key types stays in Core; the kind of forge is stored and confirmed,
a probe is never believed alone, and an inconclusive probe never says no adapter exists; what the host does to its own Forgejo over its
CLI stays out; no token lies on a host; a forge's list carries no trust by itself beyond the stated exposure.

### What the draft must still change

Against Core's behavior today:

1. `AddDeployKey` answers read-only: a matching key with write access is refused today (`ForgeReadKey.java:98`), and `id, added` would
   let a writable key on a host pass.
2. `MakeRepository` promises private and empty on `main`, and says how a retry knows its own earlier creation.
3. `ParseUpstream` also gives the owning organization and the SSH port, which choose a token. A sibling's address needs a call too.
4. `Keys` keeps two meanings: authentication keys with `complete: false` when the signing list failed, so a listed key stays trusted
   under a rate limit; and an account's 404 as an empty complete list. `about` is the `SHA256:` fingerprint.
5. Bounds move with the code: 10 s and 1 MiB per identity request, 20 pages of deploy keys, against 120 s per call of the build reader.
6. Core's CA file for a private forge has a way into `Forge`.
7. An adapter does not inherit Core's environment, so an exported token cannot reach it; redaction covers every string returned.
8. Methods for what has none: `ssh -T` to find a login with no token, the page to add a key and the login's key page, the test for a
   noreply address, the page to take back a token, and a missing repository told from Git's words.
9. The path `builds/` is fixed by acceptance tests, and Core's tests need a stub adapter whose answers change between calls.
10. A host's own forge is `http://127.0.0.1:<port>/`, while `address` is drawn as `https`. A window on a host will need an answer.

For the window:

1. All four outcomes pass through Core as distinct values: the window hides a feature on `Cannot`.
2. Central reviews cannot stay a bare "later": their shapes stand in `central_reviews.dart`, and create and submit need an operation id
   so a retry after a lost answer finds its result.
3. `Repositories` has pages with an opaque continuation; `Repository` has a display name and web address apart from the handle; an
   unknown `push`, `admin`, `private` or default branch stays unknown.
4. `FileExists` is one batched question over many handles, answering yes, no or cannot-say each. A hidden repository's 404 proves nothing.
5. `Facts` carries kind, display name and a resolved noreply address or none.
6. Handles replace the two-part name, and the window's Git operations end at Core.
7. No forge call while typing. One exists today: a run's name can ask for host key fingerprints (`start_work.dart:626`).

From the forges: `RevokeRead` promises only direct access, as inherited, project and global rights stay on GitLab and Bitbucket.
`CheckRight` tells the person's right, not the token's. `Facts.gitUser` needs the login or the token's kind on Bitbucket. Owner is
defined by what it promises.

### What each forge can offer

P is the pinned description, R recorded, D documentation only, K memory only.

| Function | GitHub | Forgejo | GitLab | Bitbucket Data Center |
|---|---|---|---|---|
| Repository name | `owner/name` | `owner/name` | any depth, or a numeric id (D) | `projectKey`, `slug`; `~user` (K) |
| A login's keys, no token | yes (P R) | open instance (K) | yes (D) | assume not, until measured |
| Signing keys | own list (P R) | no list; `verified` (P) | one list, `usage_type` (D) | unknown |
| Owner | org role, needs a member's token (P R) | `is_owner` (P R) | level 50 on a group, inherited (P) | no organization; `PROJECT_ADMIN`, only an admin may ask (P) |
| Who holds this token | `/user` (P R) | `/user` (P R) | `/user` (D) | no call found; project tokens have no person (D) |
| Make a repository | org (P R) | org (P R) | namespace (P) | project (P) |
| Deploy keys: list, add, delete | yes (P); a key on one repository only | yes (P); scope unread | yes (P); shared, `enable` (D) | yes (P); right K |
| Grant read | may be an invitation (P) | at once (P) | level 20 (P, K) | at once (P) |
| Revoke read | also invitations (P) | direct (P) | direct only, inherited stays (D) | this repository only (P) |
| All repositories reached | `/user/repos` (P) | summary says owns: to check (P) | `membership=true` (P) | one query per right (P) |
| SSH host fingerprints | `/meta` (P) | none (P) | web page only (D) | none (P) |
| Which forge is this, no token | by name | `/version` (R, K) | no plain way (K) | yes (P) |
| Git user for a token | `x-access-token` (K) | any (K) | any (D) | by token's kind (D) |
| How a list ends | `Link` (P R) | `Link` (K) | `Link`, `x-next-page` (D) | `isLastPage` (P) |

`porelo-forge-clients` covers two forges and only part of these calls. To measure: Bitbucket's key rights and where its signing keys
live, which decides whether it can be an identity source (needs an evaluation licence); Forgejo's `/user/repos` and its deploy-key
scope; and every K.

### What it touches

| Repository | What |
|---|---|
| `porelo-adapters` | contract suite and recordings, GitHub, Forgejo |
| `porelo-forge-clients` | missing calls for Forgejo and GitHub, recorded |
| `porelo` | interfaces in the wire server; window-facing commands; moving the three classes, with admission, stub adapter and acceptance; forge facts |
| `porelo-frontend` | drop `Forge`, ask Core, handles, Git behind Core |
| `porelo-host` | key handover, filling the forge by read key, `org refresh` without a token |

Not sized here. Size it anew when taken up, by the parts then chosen.

## Open questions

### May keys and ownership stand behind an executable adapter, or ship with Porelo?

Four positions stand: keys and ownership ship with Porelo, with linked-in readers and no executable adapter on a host; an adapter is acceptable if it and the directories above it are as protected as the Porelo that asks; ship with
Porelo for the forges it vouches for, and a third party's only after a person chose to trust that package in the organization; and a
protected path shows who installed an adapter, not that its answers are true. A bad adapter can name an attacker's key for a login and
answer `Owns=true`, admitting a forged founding history on a fresh machine with no pin (`TreeWalk.java:542`). Trust declared in the
organization is circular, so admission must come before the first execution, including `GetInfo` and `Recognize`. `doc/decisions.md`
records today's answer as linked, and names what would change it: an adapter that cannot ship with Porelo.

**Proposed:** the same `Identity1` contract, with the code out of Core, accepted only from an adapter whose forge name Porelo's own
release lists (GitHub and Forgejo today), at a path as protected as the Porelo that asks, checked before it runs at all. `porelo` depends
on those two packages. Another adapter serves `Forge1` and `Build2` and is never asked whom to trust.

**Against it:** with no owner answer the first read ends undecided (`TreeWalk.java:557`), so on a third forge a person's machine cannot
establish an organization until a release lists that forge, unless a pin is added. A trust-deciding call crosses a process boundary, and
a host's `org fetch` then hangs on a second package; staying linked avoids both and costs nothing to build, but keeps Java that names
forges. Wanting a company's own forge without a release would change this: a list kept by the machine's root is the small addition.

### Does the host call an adapter, or do the window and Core make its central calls?

Two proposals stand.

**A, split:** host scripts never call an adapter. `porelo` on the host asks anonymously through the adapter for what it already asks.
Everything with a token runs from Core on the person's machine, as `org add-read-key` does today.

**B, from the host's side:** no adapter runs on a host at all, as it runs Porelo as root's unit on what it fetches. The host makes its read
keys and answers their public halves, Core adds them through the adapter, and the host clones by read key and fills its own forge. The host
then knows Git and SSH, nothing of a forge, and no token reaches it for this. Reading by read key already runs. Forgejo's migration takes
no read key, so the host pushes into its own forge and the push hook must take that as migrated: new work, unproved. The gathered push stays
the exception: a person's write token, in the host's memory for one run.

**Against both:** nothing unattended can add a deploy key, so a new project waits for a person's computer, as `waiting-for-token` does
today. **Against A:** the adapter's package belongs on every host. A host's `org fetch` needs no token only because it holds a pin, and it still asks
anonymously about other first cards; on Bitbucket, if the measurement goes as assumed, it cannot ask at all.

## To be checked

- How many keys a walk asks per person: up to sixteen, by a reading, so one process per question may cost real time. A served call has
  not been measured.
- `TreeRepository` writes `@users.noreply.invalid`, and `ForgeReadKey` always sends `token ` on every forge; both differ from what the
  inputs assumed.
