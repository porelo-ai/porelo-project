# PJ110 — The Coordinator's Changes Split Back From porelo-all

```json
{
  "$schema": "issue-1.json",
  "id": "PJ110",
  "title": "The Coordinator's Changes Split Back From porelo-all",
  "state": "Analyzed",
  "size": "M",
  "priority": "Medium",
  "rank": 3,
  "blockedBy": [
    "PJ58"
  ],
  "covers": "A change a task pushes to a `porelo/*` branch of `porelo-all` is split back: refused by name when any path lies outside `porelo-project/`, else `git subtree split --prefix=porelo-project` pushed to a branch of `porelo-project` on the host's forge as a pull request, by an identity that writes only branches of `porelo-project`.",
  "openQuestions": 1
}
```

**Why this size.** Split from [PJ58](README.md#pj58) by the operator (2026-11-11): `split.sh` with its red tests, the
second workflow, the split's identity on the host's forge and the run on the rehearsal VM, on top of [PJ58](README.md#pj58)'s
`porelo-all`. To be estimated anew; [PJ58](README.md#pj58) and this issue together were L (148).

**What must be true.** A task on `porelo-all` changes only `porelo-project`: a change anywhere else is refused by
construction, not by the coordinator's care, and a change inside `porelo-project/` reaches `porelo-project` as one
pull request that fast-forwards its `main`.

## Why

[PJ58](README.md#pj58) gives a task one checkout of every repository, read only. The coordinator also writes: its
issues, stories and plans live in `porelo-project`. Its task on `porelo-all` can push only to a `porelo/*` branch of
`porelo-all`, which is never merged; this issue carries such a change back into `porelo-project`.

## The shape

As analyzed in [PJ58](README.md#pj58) before the split:

- **The split runs on a push to a `porelo/*` branch of `porelo-all`.** It lists the paths changed since the branch's
  base on `main`, refuses with their names if any lies outside `porelo-project/` (the root's own files included), then
  runs `git subtree split --prefix=porelo-project` and pushes the result to a branch of `porelo-project` on the host's
  forge, where it opens a pull request. Because `porelo-project` was added with its history, the split commit's parent
  is `porelo-project`'s own `main`, so the change arrives as one fast-forward.
- **The split's identity writes branches of `porelo-project` alone and can merge nothing**, since `main` is protected
  there.
- **Sources** in `porelo-project` under `tools/porelo-all/`: `split.sh` and its workflow, beside [PJ58](README.md#pj58)'s rebuild.

## Steps

1. Red tests, git only, on local bare repositories: a split of a change touching `porelo/README.md` or `.forgejo/` is
   refused naming the path; a split of a change under `porelo-project/` gives a commit whose parent is
   `porelo-project`'s `main`.
2. `split.sh` and its workflow until those pass.
3. porelo-host: the split's identity and its token in `porelo-all`'s action secrets; a Molecule check that it cannot
   write another repository or merge into `porelo-project`'s `main`.
4. On the rehearsal VM: a task on `porelo-all` pushes one change inside `porelo-project/` (a pull request appears in
   `porelo-project`) and one outside (refused by name).

## Open questions

Open by the operator's word (2026-11-06): discussed when the coordinator's move is due.

- **Who approves the split.** Recommended: the pull request the split opens in `porelo-project` on the host's forge,
  approved by the operator like any other repository's, so no new approval exists and nothing in `porelo-all` is ever
  merged. The other way, the gate of the coordinator's task, would approve before the refusal has run.

## To be checked

- Whether the gate's pull request on `porelo-all`, which is never merged, can be left closed by the split or must be
  kept from opening.
