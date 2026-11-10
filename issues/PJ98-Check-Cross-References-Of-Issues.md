# PJ98 — Check Cross References of Issues

```json
{
  "$schema": "issue-1.json",
  "id": "PJ98",
  "title": "Check Cross References of Issues",
  "state": "Accepted",
  "size": "-",
  "priority": "Medium",
  "rank": 2,
  "blockedBy": [],
  "covers": "Citations between the repositories' issues and documents are checked in one place that sees every repository; no repository's build or task reads another repository's files for it."
}
```

**What must be true.** The citations between the repositories' issues and documents are checked in one place that
sees every repository of the project: a citation of another repository's issue where only words belong, and a link
into another repository's issue index whose anchor is gone. No repository's own build and no agent's task reads another
repository's files to do it, so one repository stays one agent's work in one task.

## Why

The citations check of each repository read other repositories' files at `main` to check text references: the project
file for the issue prefixes, and the issue indexes a page links to. It took them from a checkout beside it, from a
named directory, or else straight from the central forge. In a task none of these is there, and the task's egress
refuses the central forge, so the check failed in the first trial move of an agent onto a rented host (2026-11-07).

Making the files reachable in the task would have put every repository's tree into every task. That softens the rule
that one repository is one agent's work in one task. The operator decided on 2026-11-07: the repository's check reads
nothing outside its own repository any more, and checking across repositories needs a solution of its own.

## What is decided

- The repository's own citations check reads only its own repository. What needs another repository's files is
  skipped there, and the check says so in one line.
- This issue covers the check across repositories.

## Open questions

- Where the check runs: as a job of the project's own repository over every repository at `main`, on a schedule or
  after each merge, or on the machine that follows the project, which holds a mirror of every repository it carries.
- Who is told of a stale citation, and how: the repository's agent, through an issue or a message in the project's
  conversation.
- Whether it may also block a merge, which would need it to run before the merge and so to read across repositories
  at that point.
