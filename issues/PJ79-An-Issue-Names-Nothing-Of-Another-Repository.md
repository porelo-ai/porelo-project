# PJ79 — An issue names nothing of another repository

**Status:** Accepted (operator, 2026-10-29), to be done now.

**What must be true.** An issue in a repository's `issues/` is self-contained: it states the contract it builds against
in words - a command, a key, a file format, a version - and names no issue, sprint, release or `porelo-project`
requirement of another repository. Planning is top down: only `porelo-project` - its requirements and
`plan/<release>/plan.yml` - names the issues of the other repositories, their order and what each waits on. A change of
plan then changes `porelo-project` alone, and no repository's checks fail because another repository moved, split or
renumbered an issue.

## Why

- **Replanning edits every repository.** Issues name the requirement or sprint they are planned under ("for PJ<nn>",
  "from PJ<nn>, wave 7a", "in sprint 6i", "after PJ<nn>"), so a move in the plan is a commit in each repository that
  mentions it.
- **A citation couples the checks.** `porelo-release check-citations` reads every linked issue of another repository
  from that repository's index and refuses a link whose anchor is missing, in each repository's *Shared rules check*
  and in several builds. A renumbered, moved or never-published row elsewhere fails a repository that changed nothing.
- **The relation is kept twice, and one copy goes stale.** Where a requirement is split, the parts point back at it
  while the requirement does not always name its parts.

## The shape

Read in the fourteen repositories with issues (`porelo-parent` has none), at their checked-out `main`:

- **745 citations of another repository's issue** in 220 issue files and index rows: 300 of `porelo-project`
  requirements, 445 of other repositories' issues. 147 stand in an index's *Blocked by* column, 66 in a *Status* or
  *Blocks* line, 532 in the text.
- **What they say**, from a sample of the text: the contract the issue builds against, cited by its issue instead of
  by its content ("B<nnn> adds an `agent` key"); a wait ("until B<nnn> is published"); the counterpart in another
  repository ("the transport's side is MX<nn>"); the requirement or sprint it was planned under; where a measurement was
  taken. None needs the number: the contract can be stated, the wait and the counterpart are the plan's, the origin
  belongs in the handover, a measurement names its commit.
- **The plan tools do not read *Blocked by*.** `plan check` and `plan render` take the states from the indexes and the
  order from `plan.yml`; a dependency across repositories lives today only in the issues' text.
- **No repository's own rules ask for these citations**; the shared rules do: an issue "names a dependency on another
  repository's issue by repository and number", and a requirement handover includes "the commit it came from".

Every citation, read in context by each repository's agent, is one of these:

- **A - an origin or a sibling** ("from PJ<nn>", "accepted with PJ<nn>", "for sprint 7", the counterpart in another
  repository, an issue long finished): deleted; what it carried is mostly in the issue already.
- **B - an order only** ("after PJ<nn>", "in sprint 6i beside ...", "blocks PJ<nn>"): moved into `plan.yml`.
- **C - a contract that exists**: named in words ("the nickname in `project.yml`", "`porelo gate try` in a fresh
  container").
- **D - a wait on a planned contract not yet built**: the issue states the contract's shape in words; the wait is kept
  in `plan.yml`.
- **E - a wait on a contract not yet decided** (a signing key, a schema, a profile's bounds, a policy file): the issue
  says in words what it waits for; the wait is kept in `plan.yml`.
- **F - a contract defined only in a `porelo-project` requirement** (the variables per forge, the move and its way
  back, the source levels' defaults, a host's acts between porelo-host and porelo): written into a document, and the
  issue names the document's path.

Decided:

- **This issue alone plans and tracks the change**: no repository files an issue or gives an estimate for its part;
  each part is asked for in the channel when its step is due.
- **Nothing of it is pushed until every repository's part is done**; then all go out together.
- **A wait across repositories is kept in `plan.yml`** as an issue's `after:`, read by `plan check`; the issue says in
  words what it waits for, never by number.
- **A contract defined only in a requirement is stated in words in the issue that builds it**, and the issues relying
  on it describe it in words; it becomes a document of the repository that owns it once it is built, since a document
  states only what holds (the source levels and risk classes in `porelo`, a host's acts in `porelo-host`). The variables per forge are porelo-host's `doc/local-forge.md`, which
  sets them; no second copy is kept. The move's procedure is planning, not a contract: it stays in
  [PJ59](README.md#pj59), and a move issue states only what is particular to its repository.
- **`check-citations` refuses a citation of another repository's issue outside `porelo-project`**, once the cleanup is
  done, so none comes back and no check outside `porelo-project` reads another repository's index.
- **`plan check` reads each index's *Blocked by* column** as waits inside that repository, beside `after.yml`, and
  refuses a wait on a later sprint or release, on an issue planned nowhere, in a cycle, or on a requirement a plan
  names under `covers`; a requirement named only under `covers` may be Implementing while its parts run.
- **A requirement is waited for only while it is not split**; afterwards a wait names the part, and the plan names the
  requirement under `covers` alone.
- **Sprints of a release not yet started are renumbered without gaps**; a letter marks only a sprint inserted into
  the running release.
- **All of it lands in one local commit per repository**, amended while the change runs.

The change, in this order:

1. **Every requirement that is split names its parts** in `porelo-project`, in the requirement or under its function in
   `plan.yml`, before any repository drops its citation.
2. **`plan.yml` takes `after:`** and `plan check` reads it (porelo-buildtools); the waits of D and E move there.
3. **The F contracts are written out** in the issue that builds each.
4. **The shared rules change**, agreed in the channel: an issue names nothing of another repository and states its
   contract itself; a wait across repositories and a counterpart are kept in `porelo-project`; the origin of a
   handover goes into the handover. Every copy of the shared block carries the new hash.
5. **Each repository's agent rewrites its issues** in one planning commit: A deleted, B, D and E left to the plan, C
   and F named in words or by a document's path.
6. **`check-citations` refuses** a citation of another repository's issue outside `porelo-project` (porelo-buildtools,
   in its one commit), its test seen red first.
7. **Before any push, the new check runs on every repository's local commit**, built from porelo-buildtools' local
   commit and given the local checkouts (`check-citations --checkouts <directory>`), so links to rows not yet
   published are read too; with `check-shared` and each repository's `documents` tests.
8. **One push of all, in order**: porelo-buildtools first, so the published check is the new one; the other
   repositories next; porelo-project last, since it links to their rows.

## Acceptance

- Outside `porelo-project`, no file under `issues/` cites another repository's issue, sprint or release, counted by a
  complete search over every repository's tracked issues that finds a known citation before the change.
- A row renumbered in one repository's index fails no check in another repository.
- The new check, run on every repository's local commit before the push, passes, and fails on a planted citation.
- Every split requirement, and every wait across repositories, can be read in `porelo-project` alone.

## To be checked

- Which split requirements name their parts today, and which parts each lacks; [PJ78](README.md#pj78) names its own.
- Three waits point at work no repository has filed, to be placed by the operator after this change: a transport saying
  that a received line is addressed to the whole room; an agent's `@label`, its agent card and the label handed to the
  transport, which the interface waits for; porelo-parent's own Build on the host's forge, which deploys its
  snapshot to the forge's registry (porelo-parent keeps no issues).
- `check-citations`' behaviour on another repository's index, measured rather than read: an index that cannot be read,
  a row without its anchor, a row that was removed.
- Per repository, which cited issues stand for a contract that no document states yet, with each repository's agent.
