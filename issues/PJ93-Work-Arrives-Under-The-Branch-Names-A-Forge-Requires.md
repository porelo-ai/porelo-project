# PJ93 — Work Arrives Under The Branch Names A Forge Requires

```json
{
  "$schema": "issue-1.json",
  "id": "PJ93",
  "title": "Work Arrives Under The Branch Names A Forge Requires",
  "state": "Idea",
  "size": "-",
  "priority": "Medium",
  "rank": 7,
  "blockedBy": [],
  "covers": "Wherever Porelo pushes work, online or after a gate, the branch name follows what that repository's forge accepts, and a person can set it."
}
```

**What must be true.** Wherever Porelo pushes work, online or after a gate, the branch name follows what that repository's forge accepts,
such as `feature/<agent>/<task>` and `bugfix/<agent>/<task>`, a person can set it without knowing the code, and a name the forge would
refuse is seen before work is done.

## What holds today

Read from `porelo` at `7d8ed2ea`, `porelo-frontend` at `0a6becda` and `porelo-host` at `ba89456`. Nothing here was run for this issue.

- The `branch` block in `project.yml` names a template and a required pattern, for the project and per repository under
  `repositories.<name>.branch`. Its placeholders are `{task}`, `{project}`, `{repository}` and the project's `parameters`, the values
  a start hands in with `--set`, which a task also holds in its environment, record and guide.
- A repository's `nickname` names its agent: "Agent Payments", in a conversation and as the author of its task's commits. It has no short
  form and is no placeholder.
- An `online` task's push arrives under it, and an acceptance scenario shows that.
- A `guarded` approval goes to the task's own branch under it, by the documentation and the code. No acceptance scenario shows it, and it
  has never run on a host.
- The host's push judge names no branch.

## The gaps

1. **Without the block the names are fixed:** `porelo/<task>` for `online`, and `main` for a `guarded` approval, which is not even the
   repository's default branch. Either is refused by a forge with stricter rules, and that shows only at the push.
2. **The agent's short name does not exist.** The one who pushes is the agent, so a forge's `<user>` part names it. Wanted: a short name
   that can be set, `porelo` by default, usable as a placeholder, for example `POR`. Today it could only be a parameter handed in at
   each start.
3. **The window:** a search found no `--set` or `--branch` in what it starts, so parameters and a required one may not be possible from
   there. To be read properly.
4. **`project init` writes no block,** and no ecosystem adapter or forge says what the rule is, so the first task finds out.
5. **The host's gathered push goes to central `main`** and the local forge's text says `porelo/<task>`. A central forge that takes changes
   only by a pull request refuses that push, and the block does not reach it.

## To be decided

- Whether the default stays `main` and `porelo/<task>`, or a project must name its scheme when it is made.
- Where the agent's short name stands, its form, and its placeholder's name: for the project with a repository's own beside `nickname`.
- What a host hands to a central forge that requires a pull request.
- Whether `project init` for a host's forge can then write `guarded` with a block, rather than choosing `online`.
