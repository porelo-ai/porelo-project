# PJ94 — The Plan Pages Are Built Outside Main

**Status:** Backlog.

**What must be true.** The release plans always show the issues' real states without anyone remembering to render them, and no build
writes to `main`.

## What holds today

The pages under `plan/` are rendered by a local script of the Coordinator, by hand and per release, and committed to `main`. Nothing runs it
at a push. On 2026-11-04 two releases stood a day behind and others up to six days. A render from the local checkouts also read old states, as
those stood up to 140 commits behind `origin/main`.

## What is wanted

- `main` holds only the sources, `plan/<release>/plan.yml` and `plan/after.yml`. The rendered `README.md` and `.svg` files leave it.
- A workflow in this repository runs at a push and on a schedule, about hourly, since states change in other repositories and often with
  `[skip ci]`. It reads each repository's `main` and publishes the pages to a branch of their own, `plan-pages`, so they stay Markdown with
  their graphic. It may write only that branch.
- `plan check` runs in that workflow and turns a broken plan red. An open issue in no plan is a warning.
- `plan/README.md` and other links point at the new place.

## To be checked

- How the workflow gets `porelo-release`, from the snapshot repository or by building it.
- What reads the rendered pages today, such as the Coordinator's local progress page.
