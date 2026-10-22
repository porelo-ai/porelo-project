# PJ60 — Every workflow runs on the local forge as on the central one

**Status:** Accepted.

**What must be true.** Every repository of the project that builds runs the same `build.yml` green on the local Forgejo
and on the central forge, with no edit between them: the machines it asks for by kind, the registry and the provider
given as variables of the setup.

From [PJ39](README.md#pj39), phase 3, and [PJ22](README.md#pj22) part 3: "every repository's workflows take registry
addresses and the machine provider as variables of the setup. Seen to fail first: a `build.yml` that runs only
centrally."

## Why

porelo-buildtools [BT25](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt25) lets
`porelo-machines` be asked for a kind and lists every workflow and build file that names the provider or a server type
today: eight repositories. The module changing is not enough: each of those workflows must ask for a kind, and take the
registry it publishes to and reads from as a variable, before it runs on the local forge. Until then an agent moved into
a task ([PJ59](README.md#pj59)) has no build to read for its push.

## The shape proposed

- **One issue per repository, filed by its agent when the kinds are built**, from their table: the workflow asks for kinds,
  names no provider, and takes the registry's address as a variable; size S each.
- **In the order of the move:** porelo-message-sluice first, then Smith's three repositories, porelo-agy and
  porelo-codex, porelo-message-matrix, porelo-intellij and porelo-frontend, porelo last.
- **What runs only centrally is named by a variable**, never by a branch in the workflow: publishing to Artifactory and
  Maven Central, and GitHub's Windows runner.

## Acceptance

- Each repository's `build.yml` runs green on the local Forgejo and on the central forge on the same commit.
- Seen to fail first: the repository's workflow before its change, on the local Forgejo.
- The kinds' check finds no provider's name in any repository's workflow.

## To be checked

- Whether Forgejo's runner reads every action the workflows use today (`actions/checkout`, `actions/cache`, the jdk
  action), or a mirror of each is needed on the local forge.
