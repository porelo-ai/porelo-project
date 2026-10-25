# PJ60 — Every workflow runs on the local forge as on the central one

**Status:** Analyzed for sprint 4 (porelo-message-sluice); the later repositories are analysed with their sprints.

**What must be true.** Every repository of the project that builds runs the same `build.yml` green on the local Forgejo
and on the central forge, with no edit between them: the machines it asks for by kind, the registry and the provider
given as variables of the setup.

From [PJ39](README.md#pj39), sprints 4 and 6 to 8, and [PJ22](README.md#pj22) part 3: "every repository's workflows take registry
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
- **In the order of the move:** porelo-message-sluice first (sprint 4), then Smith's three repositories, porelo-agy
  and porelo-codex (sprint 6), porelo-message-matrix, porelo-intellij and porelo-frontend (sprint 7), porelo last
  (sprint 8).
- **What runs only centrally is named by a variable**, never by a branch in the workflow: publishing to Artifactory and
  Maven Central, and GitHub's Windows runner.

## Acceptance

- Each repository's `build.yml` runs green on the local Forgejo and on the central forge on the same commit.
- Seen to fail first: the repository's workflow before its change, on the local Forgejo.
- The kinds' check finds no provider's name in any repository's workflow.

## Sprint 4: porelo-message-sluice

Read on porelo-message-sluice `7cca2c2` and porelo-host `56d4d13`. Sluice's workflows name no provider and ask for no
machine: `build.yml` builds and checks its packages inside the runner. So sprint 4 needs neither [BT25](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt25)'s kinds nor the
VM pool in Sluice. [BT25](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt25) stays compatible, its provider call kept until sprint 9.

**What breaks on the local Forgejo today, and where it is changed:**

| What | Why it breaks | Changed in |
|---|---|---|
| `runs-on: ubuntu-24.04` (`build.yml`), `ubuntu-26.04` (the other three) | the forge's runner offers only the label `porelo-host` (`roles/forge/defaults/main.yml`), so those jobs wait for ever | porelo-host [HO08](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho08): a label per runner kind, backed by an image with what the jobs take (Node.js for the actions, JDK 25 at `JAVA_HOME_25_X64`, `gcc`, `zlib1g-dev`, `rpmbuild`, `rpm2cpio`, `cpio`, `dpkg-deb`, `python3-yaml`) |
| `actions/checkout`, `actions/cache` by GitHub digest | Forgejo looks actions up on `data.forgejo.org` unless `DEFAULT_ACTIONS_URL` says otherwise, and porelo-host sets none | porelo-host [HO08](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho08): `DEFAULT_ACTIONS_URL` set, or both actions mirrored on the forge |
| the snapshot repository in `settings.xml` | it names Sonatype's snapshots; on the local forge the parent and buildtools snapshots come from the forge's Maven registry | porelo-message-sluice: the address as a variable of the setup; porelo-host sets it on the forge's organisation |
| Publish (`vars.JF_URL`, `secrets.JF_ACCESS_TOKEN`, `if: github.ref == 'refs/heads/main'`) | neither exists on the local forge | porelo-message-sluice: Publish runs where the central variable is set, not by a branch |
| `delete-runs.yml` (`gh api …/actions/runs`) | GitHub's API; dispatched by hand only | porelo-message-sluice: central only, by the same variable |

**Before Sluice can be green there:** [HO08](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho08) with the runner labels and the actions' source, and porelo-parent and
porelo-buildtools snapshots in the forge's Maven registry.

**The issue for porelo-message-sluice** (size S, about 45 to 60 minutes): its four workflows run unchanged on the
local Forgejo and on GitHub. The snapshot repository's address is a variable of the setup. Publishing and deleting old
runs run only where the central variable is set, named by it and never by a branch. Seen to fail first: today's
`build.yml` on the local Forgejo.

**Not in sprint 4:** publishing Sluice's packages to the local forge's registry (with porelo-buildtools [BT23](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt23)'s helper,
an Idea), and a `porelo-machines` acceptance leg in `build.yml`.

## Open questions

- The variables' names that porelo-host sets on the forge's organisation, for the snapshot repository and for "central";
  porelo-host names them with [HO08](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho08), and Sluice takes them.
