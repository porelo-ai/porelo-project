# PJ122 — A Commit Names Its Issue After The Cut-Over

```json
{
  "$schema": "issue-1.json",
  "id": "PJ122",
  "title": "A Commit Names Its Issue After The Cut-Over",
  "state": "Accepted",
  "size": "-",
  "priority": "High",
  "rank": 2,
  "blockedBy": [],
  "covers": "From the day the issues move to the tracker, every commit made for an issue carries one trailer per issue with the tracker's reference, so the tracker shows the commits on the issue; the shared rules and check-commits allow and check it."
}
```

**What must be true.** From the cut-over on, a person who opens an issue in the tracker sees every commit made for
it, and a person who reads a commit sees which issue it served, by the tracker's own reference. Until the cut-over
nothing changes.

## Why

Today a commit names no issue: the shared rules forbid a requirement number in a commit message, and `check-commits`
refuses one and allows only `Assisted-by`, `Signed-off-by`, `Porelo-Change-Id` and `Porelo-Signs-Anew` below the
subject. The reason was that an issue's file is deleted once it is finished, so a number would point nowhere. In the
tracker a closed issue stays, so the reason is gone, and without a reference the link between an issue and its
commits is lost.

## The shape

- One trailer per issue a commit serves, below the subject with the other trailers:
  `Porelo-Issue: <tracker reference>`, for GitHub `Porelo-Issue: porelo-ai/porelo#123`. GitHub links a commit that
  names `<owner>/<repository>#<number>` into that issue's timeline, so no code is needed for the link.
- No Porelo id: a new issue has only the tracker's number. A carried-over issue keeps its old Porelo id only as a
  fixed alias, never given again, so old references still resolve; a commit names it by the tracker's reference.
- The subject stays in words with no number; code, changelog and anything that ships still cite no issue.
- No closing keyword (`Fixes`, `Closes`, `Resolves`): the tracker would close the issue on the push, and Finished is
  the person's to set.
- The tracker reference is written in the form the tracker links, so another tracker gets its own form later.

## Parts

- **porelo-project**: the shared rules (`porelo-commits`, and the shared block where it speaks of issue numbers)
  changed through the room, effective on the cut-over day.
- **porelo-buildtools**: `check-commits` allows the trailer and checks its form, and still refuses an issue number
  in the subject.
- **porelo**: a commit Porelo makes for a task's work carries the trailer, since the task knows its issue.

## Acceptance

- On the cut-over day a commit with the trailer passes `check-commits` and appears in its issue's timeline on
  GitHub; one with a number in the subject or a closing keyword is refused.

## To be checked

- Whether GitHub links a reference in a trailer line the same as one in the body; measured in the test organization.
