# PJ58 — The coordinator works in one repository of them all

**Status:** Accepted.

**What must be true.** The coordinator's task reads every repository of the project in one checkout, `porelo-all`, a
private repository on the local Forgejo, and can change only `porelo-project`: a change anywhere else is refused by
construction, not by the coordinator's care.

From [PJ39](README.md#pj39), sprint 8: "*new, `porelo-project`:* `porelo-all` with its two workflows".

## Why

The coordinator reads across all repositories today: the issues it plans, the commits it pushes, the workflows whose
Builds it reads. On the host it does so with a checkout of each and the right to push to each. In a Porelo task it has
one workspace and one upstream, and [PJ39](README.md#pj39) keeps every other repository read-only to it. Without one repository of them
all, its task would either hold thirteen upstreams or see only `porelo-project`.

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
  is the push mirrors' work.

## Open questions

- Who approves the split: the operator in Forgejo, or the gate the coordinator's task pushes through.

## To be checked

- How long a rebuild of `porelo-all` takes with `--squash` for the read-only repositories.
- Whether the forgejo reader of [PJ22](README.md#pj22) reads `porelo-all`'s workflows like any other.
