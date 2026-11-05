# PJ94 — The Plan Pages Are Built Outside Main

**Status:** Implementing.

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

## What was settled in building it

- `porelo-release` comes from the snapshot repository, at the version the workflow names; a checkout of `porelo-buildtools` at that tag gives its dependencies.
- A plan that does not render turns the run red, and the published pages stay. What `plan check` finds is a warning with the findings in the job summary, not red: on 2026-11-05 all 16 plans had findings, such as 45 lines in 0.6, so red would have hidden every page.
- The table of issues by status is rendered there too, so it needs no one to remember it.
- This repository's own commits with `[skip ci]` start no run at a push; the hourly run takes them.
