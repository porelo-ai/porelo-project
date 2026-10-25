# PJ60 — Every workflow runs on the local forge as on the central one

**Status:** Analyzed for sprint 4 (porelo-parent, porelo-buildtools, porelo-message-sluice); the later repositories are analysed with their sprints.

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
- **The workflows run 1:1 on both forges; only the values of variables and secrets differ.** A setting that must
  differ is a variable present on both forges, set to fit each, never a variable set on one and missing on the other,
  and never a branch in the workflow: publishing to Artifactory and Maven Central, and GitHub's Windows runner, are
  switched by such variables.

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
| `runs-on: ubuntu-24.04` (`build.yml`), `ubuntu-26.04` (the other three) | the forge's runner offers only the label `porelo-host` (`roles/forge/defaults/main.yml`), so those jobs wait for ever | porelo-host [HO08](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho08): each label mapped to an existing GitHub-like runner image, pinned by digest |
| JDK 25 from the image's `JAVA_HOME_25_X64`, and the package tools (`gcc`, `zlib1g-dev`, `rpmbuild`, `rpm2cpio`, `cpio`, `dpkg-deb`, `python3-yaml`) | a GitHub-like image need not carry them | porelo-message-sluice: `actions/setup-java` for the JDK and a step installing what is missing, the same on both forges |
| `actions/checkout`, `actions/cache` by GitHub digest | Forgejo looks actions up on `data.forgejo.org` unless `DEFAULT_ACTIONS_URL` says otherwise, and porelo-host sets none | porelo-host [HO08](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho08): `DEFAULT_ACTIONS_URL` set to github.com; each action is pinned by commit, so a job fetches the same state as on GitHub |
| Publish (`vars.JF_URL`, `secrets.JF_ACCESS_TOKEN`, `if: github.ref == 'refs/heads/main'`) | neither exists on the local forge | porelo-message-sluice: Publish switched by a variable present on both forges (`true` on GitHub, `false` on the forge), not by a branch |
| `delete-runs.yml` (`gh api …/actions/runs`) | GitHub's API; dispatched by hand only | porelo-message-sluice: switched by the same variable |

**Snapshots on the forge come from the forge.** Local stacks depend on each other, so on the local Forgejo the
snapshots are deployed to the forge's Maven registry and read from there; on GitHub they go to Sonatype and are read
from there, as today. porelo-parent and porelo-buildtools deploy (parent first); porelo-message-sluice deploys no Maven
artifact and only reads the parent and the buildtools' jars.

| Variable or secret | On GitHub | On the local Forgejo |
|---|---|---|
| `vars.PORELO_DEPLOY_PROFILE` | `central-sonatype-release` | `forge-release` |
| `vars.MAVEN_SNAPSHOTS_URL` | `https://central.sonatype.com/repository/maven-snapshots/` | the forge's registry, `https://<forge>/api/packages/porelo/maven` |
| `secrets.PORELO_PUBLISHER_TOKEN` | a placeholder: Sonatype's snapshots are read without one | `porelo-publisher`'s token, which porelo-host [HO08](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho08) creates; reading needs it too, as the `porelo` organisation is private |
| `vars.PORELO_PUBLISH` | `true` | `false` |

- **porelo-parent:** a second profile `forge-release` beside `central-sonatype-release`, deploying with
  `maven-deploy-plugin` to `MAVEN_SNAPSHOTS_URL` with no signing and no Central plugin. The deploy step runs
  `deploy -P${{ vars.PORELO_DEPLOY_PROFILE }}`. The deploy dry run and its check stay on `central-sonatype-release` on
  both forges.
- **porelo-buildtools:** the same deploy step, and `settings.xml` reading `MAVEN_SNAPSHOTS_URL` with the repository's id
  equal to the server's that carries `PORELO_PUBLISHER_TOKEN`.
- **porelo-message-sluice:** `settings.xml` reading the same way.
- **porelo-host [HO08](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho08):** the variables and the
  secret set on the forge, and the forge's CA reaching every JVM in a job (`JAVA_TOOL_OPTIONS` with a trust store), as Java
  ignores `SSL_CERT_FILE`.

**Before Sluice can be green there:** [HO08](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho08) with the runner labels, the actions' source, the variables above and the JVM trust store set on the forge; then porelo-parent's and porelo-buildtools' snapshots deployed to it.

**The issue for porelo-message-sluice** (size S, about 45 to 60 minutes): its four workflows run unchanged on the
local Forgejo and on GitHub. The JDK comes from `actions/setup-java` and missing tools are installed in a step. Publishing and deleting old
runs are switched by `PORELO_PUBLISH`, present on both forges, never by a branch; `settings.xml` reads the snapshots
from `MAVEN_SNAPSHOTS_URL`. Seen to fail first: today's
`build.yml` on the local Forgejo.

**Not in sprint 4:** publishing Sluice's packages to the local forge's registry (with porelo-buildtools [BT23](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt23)'s helper,
an Idea), a `porelo-machines` acceptance leg in `build.yml`, and building without internet (mirrored actions).

## Open questions

None for sprint 4.
