# PJ92 — Every Forge Call Behind One Contract

**Status:** Idea.

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
| `ForgeCollaborators.checkAdministration` | token, repository | nothing; refused without Administration |
| `ForgeCollaborators.grantRead` | token, repository, login | `already has read access`, `invited` or `can read` |
| `ForgeCollaborators.revokeRead` | token, repository, login | nothing; removes access and a pending invitation |
| `ForgeCollaborators.readAccess` | token, repository, logins | each login's state of read access |

### Host, on the central forge

| Name | Input | Output |
|---|---|---|
| list deploy keys, inside `porelo-host-project` | token, repository | the repository's deploy keys: id, key, read-only |
| add a deploy key, inside `porelo-host-project` | token, repository, public key, title | the key's id, read-only |
| `POST /repos/migrate` on the host's own forge | the central address, token | the local copy, cloned by `x-access-token` |

### Knowledge that is no call

| Where | What it knows |
|---|---|
| Core, `IdentityFacts` | the web page where a person adds a key |
| Frontend, `GitHub.apiOf` | where the API of a GitHub address is |
| Frontend, `onGitHub` | which upstream addresses are on `github.com` |
| Frontend, `commit_signing.dart` | the author address `<login>@users.noreply.github.com` |
| Core, `ForgeRepositoryMaker`, `HttpForgeDirectory`, `ForgeReadKey`; host, `Central` | the choice of forge by host name |

## Open questions

- The list of keys decides whom Porelo trusts, and the organization's adapter is linked into Porelo so that nothing must be trusted
  first. May keys and ownership stand behind an executable adapter as builds do, or does that part ship with Porelo?
- Does the host call the adapter too, or does the window or Core do its central calls, as no token should lie on a host?

## To be checked

- What each adapter says where its forge has no such function: Forgejo keeps no separate list of signing keys.
- Whether `porelo-forge-clients` covers these calls, or only review and build.
