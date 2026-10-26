# PJ61 — The project porelo is online with the local forge upstream

**Status:** Estimated for sprint 5.

**What must be true.** The project `porelo`'s file names the local Forgejo as its upstream: a task's push passes through
its gate to the branch `porelo/<task>` on Forgejo at once, Forgejo builds it, the task reads the verdict through the
`forgejo` reader, and the work reaches the central forge only by the gathered push after the operator approved it.

From [PJ39](README.md#pj39): "The project `porelo` becomes `online`, its upstream the local Forgejo of
[PJ22](README.md#pj22). A task's push goes to its gate, which passes the branch `porelo/<task>` on to Forgejo at once;
nothing of it is public."

## Why

This is the switch that makes the local forge the agents' forge. Everything it needs is built elsewhere; what is left
is this project's `project.yml` and the proof that the whole way works for one repository before the first agent
moves ([PJ59](README.md#pj59)).

## The shape proposed

- **`project.yml`:** `online`, each repository's upstream on the local Forgejo, `builds:` read by the `forgejo` reader
  (porelo [B253](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b253)), the reader's token a
  destination through the broker, which trusts the host's authority (porelo-host
  [HO17](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho17)).
- **To the central forge only after approval:** the gathered push (porelo-buildtools
  [HO32](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho32)), a plain `git push` without
  force, carries a task's work once the operator approved it.
- **Proved on porelo-message-sluice first:** a task pushes, Forgejo builds it on its own runner, the task reads the verdict, the
  operator approves, the gathered push reaches the central forge.

## Acceptance

- A task's push of porelo-message-sluice reaches Forgejo as `porelo/<task>`, is built there, and its verdict and the
  log of a failed job are in the task's `/porelo/files`.
- Nothing of it reaches the central forge before the operator's approval; after it, the gathered push does.
- Seen to fail first: the same push with the project `offline` reaches no forge.

## Sprint 5 (operator's decisions)

- **The approval** is the operator merging the pull request `porelo/<task>` → `main` in Forgejo's interface. `main`
  on the forge is protected: only a pull request the operator approved reaches it, never a direct push.
- **The gathered push** ([HO32](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho32)) is
  started by hand on the host over ssh in sprint 5; started from a task through the broker later, when the agents move.
- **The central forge's credential** is the operator's fine-grained token (`Contents` and `Workflows` read and write,
  only the project's repositories, with an expiry). In sprint 5 it is stored nowhere: the push asks for it hidden in the
  ssh terminal and forgets it.
- **A moved central forge** (the operator's own merges there, Dependabot's among them) refuses the push, which names
  the commits; the central `main` is brought to the forge as the branch `central/main`, merged in a task and approved
  like any other work. One person writes on the central forge today; more people there are not handled now.
- **One repository at a time;** waiting for each Build before the next comes later, as sprint 5 pushes only
  porelo-message-sluice.
- **`offline` is tested with a second project file,** as an `offline` project may name no `builds:`.
- **One forge token for the gate and the reader:** `project.yml` names no `builds.credential`; both take the default vault entry `git.token.<forge-host>`, as [PJ37](README.md#pj37)'s sprint 5 places the gate's credential.
- **No VM pool:** the first repositories to move build on the forge's own runner, as porelo-message-sluice's
  `build.yml` did on a rented host in sprint 4; the pool comes with the repositories that need one.

**What is missing, read on the pushed heads of 2026-10-25:**

| Where | What |
|---|---|
| porelo-adapters | built in [GH08](https://github.com/porelo-ai/porelo-adapters/blob/main/issues/README.md#gh08) (Review): `porelo-adapter-forgejo` reads the account's `ca-certificates.pem` |
| porelo | built in [B286](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b286) (Review): the gate's host `git` trusts that bundle through `GIT_SSL_CAINFO`; `porelo-setup.sh` installs no build reader ([B287](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b287), an Idea) |
| porelo-host | [HO31](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho31): the forge's CA and name for the host's `git`, the build reader installed, a forge token for the gate and the reader in the account's vault, porelo-message-sluice seeded on the forge, `main` protected |
| porelo-host | [HO29](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho29): the operator's own login on the forge, with which the pull request is approved |
| porelo-host | [HO32](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho32): the gathered push |
| porelo-project | `project.yml` `online`, porelo-message-sluice's upstream on the forge, `builds:` read by `forgejo` |

## To be checked

- Whether the project file's signature and `follow --signed-by` need anything new for an upstream on the host.
