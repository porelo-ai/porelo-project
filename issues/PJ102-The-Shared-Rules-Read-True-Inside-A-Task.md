# PJ102 — The Shared Rules Read True Inside A Task

```json
{
  "$schema": "issue-1.json",
  "id": "PJ102",
  "title": "The Shared Rules Read True Inside A Task",
  "state": "Idea",
  "size": "-",
  "priority": "Low",
  "rank": 2,
  "blockedBy": [],
  "covers": "Every rule of the shared block can be followed as written by an agent inside a task, and still outside one."
}
```

**What must be true.** Every rule of the shared block of `AGENTS.md` can be followed as written by an agent inside a
Porelo task, and still by one working outside a task.

## Why

Some rules name things a task does not have: commands marked for the operator's console, a push hand-over given as a
`git push` command, "`.AGENTS.md` names you", "rules go into `.AGENTS.md`", and "Implementing is set on `main`".

## The shape

- Each such rule is stated generally, so it holds both ways: a request to the gate instead of a push command, a
  project parameter instead of a line of `.AGENTS.md`, the task's branch instead of `main`.
- A rule that needs a local setting names it as the setup's, not as `.AGENTS.md`'s.
- The change goes through the shared block's channel and reaches every copy; `check-shared` holds them equal.

## Acceptance

- A reading of every rule of the shared block against what a task holds finds none that a task cannot follow.
- Every copy of the shared block carries the new text with the same hash.
