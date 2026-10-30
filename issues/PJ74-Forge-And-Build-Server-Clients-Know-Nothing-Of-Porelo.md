# PJ74 — Forge and build server clients know nothing of Porelo

**Status:** Accepted.

**What must be true.** The calls to a forge's or a build server's API - pull requests, reviews and their comments,
checks and builds, webhooks - live in one repository of their own, `porelo-forge-clients`, with one module per forge or
build server, under the LGPL. They know nothing of Porelo, of its contracts or of SARIF; Porelo's adapters in
`porelo-adapters` use them and translate what they return into Porelo's contracts and SARIF.

## Why

Porelo talks to GitHub and Forgejo today and is to talk to GitLab, Bitbucket, Azure DevOps and Jenkins
([PJ36](README.md#pj36), [PJ72](README.md#pj72)). The analyses of those forges' review APIs found no Java client that
is current, covers what is needed and stays small: none is published by the forges themselves, the community ones speak
REST only (GitHub resolves review threads only through GraphQL), cover only one of Bitbucket's two products, or pull in
heavy stacks (Jersey, OkHttp 2, Gson, a `java.time` backport). Today `porelo-adapters` mixes the HTTP calls with the
translation into Porelo's contracts. A client that knows only the forge can be tested against the forge's recorded
answers alone, released on its own, and used by others.

## The shape proposed

```
porelo  <-  porelo-adapters (Build1, Review1, SARIF mapping, contract suite)  <-  porelo-forge-clients (one module per forge)
```

- **One repository, one module per forge or build server:** `github` and `forgejo` first, then `gitlab`, `bitbucket`
  (Cloud and Data Center), `azure-devops`, `jenkins`. One release for all modules.
- **Only what Porelo needs, said in the README:** pull requests, reviews, review comments and threads, suggestions,
  checks and build results, webhooks, the account and its membership (for [PJ73](README.md#pj73)'s source levels).
  Not a complete client of any API.
- **Small:** the JDK's `java.net.http.HttpClient`, Jackson and records; nothing else at run time. Where a forge
  publishes an OpenAPI description (GitHub, Forgejo, GitLab, Azure DevOps), the records are generated from it at build
  time, filtered to the paths used; the calls are written by hand. GraphQL where the forge needs it.
- **Tested on its own:** each module against recorded answers of its forge, with no Porelo running; the contract suite
  every adapter passes ([GH06](https://github.com/porelo-ai/porelo-adapters/blob/main/issues/README.md#gh06)) stays in
  `porelo-adapters`.
- **LGPL-3.0-or-later, as every Java library of the project:** anyone may use it in their own products, closed ones
  included, and changes to the library itself are published. It stays LGPL where `porelo-adapters` links it into a
  native package, since that package's source is open and can be rebuilt with a changed library; only an API that
  others build their own extensions against takes Apache-2.0 ([PJ33](README.md#pj33), operator, 2026-10-30).
- **Agent Gorge owns it,** a new repository agent set up like the others.
- **When:** in release 0.8, while the Forgejo review adapter is written and GitHub's reader is rewritten for reviews;
  GitHub's build reading moves along with it.

## Acceptance

- `porelo-adapters` makes no HTTP call of its own: every call to a forge goes through `porelo-forge-clients`.
- A module's tests pass with no network and no Porelo, against recorded answers; a changed answer of the forge makes
  them fail by the field that changed.
- `porelo-forge-clients` depends on nothing of Porelo; a build that adds such a dependency fails.

## To be checked

- Which of `porelo-adapters`' present code moves, and what the move changes for its published artifacts.
- The OpenAPI descriptions of GitHub, Forgejo, GitLab and Azure DevOps: their license, how complete they are for the
  paths used, and how records are generated from them with the smallest dependencies.
