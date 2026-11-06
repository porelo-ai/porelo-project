# PJ58 — The coordinator works in one repository of them all

**Status:** Analyzed.
**Size:** L - crosses porelo-project (the two workflows and their scripts) and porelo-host (the repository on the
forge and two identities), with a signed `project.yml` change and an end-to-end run on a forge.

**What must be true.** The coordinator's task reads every repository of the project in one checkout, `porelo-all`, a
private repository on the local Forgejo, and can change only `porelo-project`: a change anywhere else is refused by
construction, not by the coordinator's care.

From [PJ39](README.md#pj39), sprint 8: "*new, `porelo-project`:* `porelo-all` with its two workflows".

## Why

The coordinator reads across all repositories today: the issues it plans, the commits it pushes, the workflows whose
Builds it reads. On the host it does so with a checkout of each and the right to push to each. In a Porelo task it has
one workspace and one upstream, and [PJ39](README.md#pj39) keeps every other repository read-only to it. Without one repository of them
all, its task would either hold an upstream per repository or see only `porelo-project`.

## The shape proposed

- **`porelo-all` holds every repository of the project as a `git subtree`**, one directory each, named as the
  repository: the read-only ones with `--squash`, so a rebuild takes their tree and not their history;
  `porelo-project` with its history, so `git subtree split` hands its changes back unchanged. No tool of our own
  replaces what `git subtree` does.
- **The first workflow rebuilds it at every merge into a `main`** of any repository on the local Forgejo, so it never
  holds work that is not on a `main`.
- **The coordinator's task follows `porelo-all`** and changes only `porelo-project/`.
- **The second workflow, after the operator's approval, splits `porelo-project/` back** into `porelo-project` and refuses a
  change to any other directory, so every other repository is read-only to the coordinator by construction.
- **Pushes to the central forge stay as they are:** the coordinator does not push other repositories from here; that
  is the gathered push's work.

## Analysis

Read in porelo-project, porelo-host and porelo; nothing run on a forge. `estimate=148 velocity median=148` (L).

**What exists today.**

- `porelo-all` exists nowhere: no repository, workflow or script names it outside this issue,
  [PJ39](README.md#pj39), [PJ59](README.md#pj59) and the release plan (`plan/0.6/plan.yml`, sprint 8b, whose test is
  "in `porelo-all` every repository is there; a change outside `porelo-project/` is refused").
- `project.yml` names 17 repositories besides this one, each with its central upstream; the project is still
  `guarded` and declares no repository on the host's forge.
- porelo-host's forge helper (`roles/forge/files/porelo-host-project`) migrates only the repositories the inventory
  names in `forge_repositories`, each private, from the central forge, and protects each `main` so that it takes no
  direct push and a reviewed pull request reaches it by fast-forward. It makes no repository of its own and no
  identity other than the person's, the gate's and the runner's (`roles/forge/tasks/accounts.yml`).
- A task has one repository and one upstream; its gate pushes to `porelo/<task>` and opens the pull request
  ([PJ59](README.md#pj59)'s check). So the coordinator's task on `porelo-all` can already push nowhere but a branch of
  `porelo-all`; what is missing is the repository, its rebuild and the split back.
- `.github/workflows/plan-pages.yml` already reads every repository's `main` on a schedule, because states change
  elsewhere: the same pattern the rebuild needs.
- porelo-host's rehearsal script (porelo-host's [HO132](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho132), measured at 38 minutes) and the rehearsal plan for a move on a
  local VM give a forge to run the acceptance on without a rented host.

**The design, decided where the agent can decide it.**

- **The sources live in `porelo-project`**, under `tools/porelo-all/`: `rebuild.sh`, `split.sh`, the two workflows
  and `porelo.yml` for the coordinator's image. The rebuild copies them to `porelo-all`'s root, so they are reviewed
  like any change here and the coordinator cannot change them from inside `porelo-all`.
- **The rebuild is incremental**, so `porelo-all`'s `main` only moves forward: the first run adds each repository with
  `git subtree add` (`--squash` for the read-only ones, the full history for `porelo-project`); later runs
  `git subtree pull` only the directories whose `main` moved, and do nothing when none did. Only the rebuild's
  identity may push `porelo-all`'s `main`; no pull request is merged there.
- **The split runs on a push to a `porelo/*` branch of `porelo-all`.** It lists the paths changed since the branch's
  base on `main`, refuses with their names if any lies outside `porelo-project/` (the root's own files included), then
  runs `git subtree split --prefix=porelo-project` and pushes the result to a branch of `porelo-project` on the host's
  forge, where it opens a pull request. Because `porelo-project` was added with its history, the split commit's parent
  is `porelo-project`'s own `main`, so the change arrives as one fast-forward.
- **Two identities, each able to do one thing**: the rebuild's reads every repository of the organization and writes
  only `porelo-all`; the split's writes branches of `porelo-project` alone and can merge nothing, since `main` is
  protected there. Forgejo's token scopes are per user, not per repository, so the bound is each user's team rights.

**Steps, each safe on its own.**

1. Red tests in porelo-project, git only, on local bare repositories (no forge): a split of a change touching
   `porelo/README.md` or `.forgejo/` is refused naming the path; a split of a change under `porelo-project/` gives a
   commit whose parent is `porelo-project`'s `main`; a rebuild after one repository moved changes only its directory;
   a second rebuild with nothing moved makes no commit; a read-only repository's history is not in `porelo-all`.
2. `rebuild.sh` and `split.sh` until those pass, with the workflows calling them. Nothing runs yet: no forge has the
   repository.
3. porelo-host: the forge helper makes `porelo-all` private in the project's organization when the inventory asks
   for it, protects its `main` for the rebuild's identity alone, makes both identities and puts their tokens in
   `porelo-all`'s action secrets; a Molecule check that the split's token cannot write another repository or merge
   into `porelo-project`'s `main`. An issue (S) of porelo-host, asked of its agent in the room.
4. `project.yml` names `porelo-all` with the host's forge as its upstream: prepared by the coordinator, signed by
   the operator.
5. On the rehearsal VM: the rebuild fills `porelo-all`; a coordinator's task on it pushes one change inside
   `porelo-project/` (a pull request appears in `porelo-project`) and one outside (refused by name).

**Waits, apart from the estimate:** porelo-host's step (S, 38 minutes of its agent); the operator's signature of
`project.yml`; the VM or host run of step 5, 3.5 to 4.5 hours of wall time by the rehearsal plan, mostly guesses; and
the coordinator's own move, which [PJ59](README.md#pj59) puts after the reviewing tasks of release 0.8. Sprint 8b's
test needs only `porelo-all` and the refusal, not that move.

## Open questions

Both stay open by the operator's word (2026-11-06): discussed when the coordinator's move is due.

- **Who approves the split.** Recommended: the pull request the split opens in `porelo-project` on the host's forge,
  approved by the operator like any other repository's, so no new approval exists and nothing in `porelo-all` is ever
  merged. The other way, the gate of the coordinator's task, would approve before the refusal has run.
- **How fresh `porelo-all` must be.** A workflow in `porelo-all` cannot see a merge in another repository, so "at
  every merge" means changing every repository's workflows to start it. Recommended: a scheduled rebuild every five
  minutes and on demand, a no-op when no `main` moved, so `porelo-all` lags a merge by minutes and no other
  repository changes.

## To be checked

- How long a rebuild of `porelo-all` takes with `--squash` for the read-only repositories, first and incremental.
- Whether the forgejo reader of [PJ22](README.md#pj22) reads `porelo-all`'s workflows like any other.
- Whether the gate's pull request on `porelo-all`, which is never merged, can be left closed by the split or must be
  kept from opening.
- Whether a host's forge runs scheduled workflows while it is up for a few hours, and runs a missed one at start.
