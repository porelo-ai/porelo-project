# PJ101 — A Task's Commits Name Their Harness And Model

```json
{
  "$schema": "issue-1.json",
  "id": "PJ101",
  "title": "A Task's Commits Name Their Harness And Model",
  "state": "Idea",
  "size": "-",
  "priority": "Low",
  "rank": 3,
  "blockedBy": [],
  "covers": "Every commit an agent makes in a task names the harness and model that drove it, and a commit without it is refused."
}
```

**What must be true.** Every commit an agent makes in a task carries the `Assisted-by: <harness>, <model>` trailer of
the harness and model that drove it, and a commit without it is refused before it is handed over.

## Why

The shared rules require the trailer, but inside a task nothing tells the agent which harness and model the task runs
with, and nothing enforces the line.

## The shape

- The task is started with the project parameters `harness` and `model` (declared in `project.yml`).
- A hook in the task's image writes the trailer from them; the hook for Claude Code exists in `porelo-claude-code`
  ([CC46](https://github.com/porelo-ai/porelo-claude-code/blob/main/issues/README.md#cc46)), the other agent images
  follow.
- `check-commits` in `porelo-buildtools` refuses a commit of a task without the trailer.

Built by `porelo-claude-code`, `porelo-pi`, `porelo-omp` (the hooks) and `porelo-buildtools` (the check). It is split
into their issues once accepted.

## Acceptance

- A commit made in a task started with `harness` and `model` carries exactly that trailer, in each agent image.
- `check-commits` fails on a task's commit without the trailer and names it; it passes the same commit with it.

## To be checked

- How `check-commits` tells a task's commit from one made outside a task, where the operator's own commits carry no
  trailer.
