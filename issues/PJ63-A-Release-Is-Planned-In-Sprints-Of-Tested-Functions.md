# PJ63 — A release is planned in sprints of tested functions

**Status:** Analyzed; accepted by the operator 2026-10-23, planned right after sprint 2 of [PJ39](README.md#pj39).
**Size:** M - one new command with two verbs in the release tools, a file format another repository (porelo-frontend)
will read, its documentation, and this project's plan moved into it.

**What must be true.** What goes into a release is written down once, in a file checked into `porelo-project`: the
release's goal, its sprints, each sprint's two or three functions the operator tests by hand, how each is tested and
when it was, and the issues of every repository that serve it. A page made from that file shows the plan and where
every issue stands, readable on the central forge, and is kept current by the coordinator at every change of state.

## Why

The plan of [PJ39](README.md#pj39) was rebuilt into sprints that each end in functions the operator can try, and a
page showing them per sprint, with each issue's state and each function tested or not, turned out to be what the
operator reads to know where the work stands. Today that page lives only on the operator's machine and is edited by
hand, and the sprint section of this index repeats part of it.

## The shape proposed

- **One source, the plan file**, for example `plan/<release>.yml`: the release and its goal, the sprints in order,
  each function with its title, how it is tested and the date it was, and the issues as `<repository>#<number>`. **It
  holds no issue's state**: that stays in each repository's index, where its agent keeps it, and is read from there.
- **The page is made, never edited**: a command of the project's release tools (`plan render`, beside
  `check-citations`) writes `plan/<release>.md` from the plan file and every repository's index - a bar per sprint by
  its issues' states, a mark per function tested or not, each issue linked to its index row - and, on request, the
  same as a local HTML page.
- **A check keeps it true** (`plan check`): an issue named that does not exist, an issue in two sprints, a page that
  does not match its file, and a Finished issue serving a function not yet tested are each refused.
- **The coordinator changes only the plan file** and renders the page, in a `[skip ci]` commit gathered with the
  others. The sprint section of this index points to the page instead of repeating it.
- **Later:** the estimate and the measured time per sprint beside each other, once [PJ38](README.md#pj38) counts them;
  and a panel in porelo-frontend that shows the same and lets the operator search issues and place them in sprints
  and functions, writing only the plan file (an Idea filed there).

## Plan

Read in `porelo-buildtools` `release` at `c296fdd`, and in this repository.

- **Where:** `porelo-buildtools`' `release` module, beside `check-citations`, owned by Agent Machines. It already
  reads every repository's index, from the tree, from a checkout beside it, or from `main` on the central forge
  (`IssueLinks`), and it has Jackson's YAML reader (`jackson-dataformat-yaml`). No new tool and no new dependency.
- **New:**
  - `Plan` reads `plan/<release>.yml` into records (release, goal, sprints, functions, issue references).
  - `IssueIndex` gives each index row's state, from the `## <State>` heading it stands under. That is an extension of
    what `IssueLinks` parses, not a second parser.
  - `PlanRender` writes the Markdown page: a text bar per sprint by state, a mark per function, and each issue linked
    to its index row. It also writes the HTML page on `--html <file>`, with the layout of today's local page.
  - `PlanCheck`.
  - `Main` gains `plan render <file>` and `plan check <file>`.
- **The checks of `plan check`**, each a test seen red first:
  - an issue named that has no row in its index;
  - an issue in two functions;
  - a page that differs from what `render` writes now;
  - a Finished issue in a function not yet tested;
  - a function with no issue and no `tested` date.
- **In this repository**, by the coordinator, once the command is published:
  - `plan/0.6.yml` with [PJ39](README.md#pj39)'s nine sprints and the usability sprints as they stand;
  - the page `plan/0.6.md` rendered from it;
  - the index's sprint section shortened to a pointer to the page;
  - `plan check` run by hand before each push, as the project's other checks are. This project has no workflow of
    its own.
- **Estimate:** wall time about 180 minutes for the command, with Codex building and reviewing, and about 45 minutes
  for this repository's part. Measured neighbour: porelo-host
  [HO18](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho18), size S, 51 minutes - one plugin, its
  tests seen red first, docs. This is about three times that: two verbs, a renderer, a file format.

## Acceptance

- `plan render plan/0.6.yml` writes the page from the file and the indexes, and a second run changes nothing.
- `plan check` passes on this repository's plan, and fails for each of the five faults above, naming the issue or
  function.
- The page on the central forge shows the same sprints, functions, states and marks as today's local page.

