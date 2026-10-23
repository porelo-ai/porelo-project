# PJ63 — A release is planned in sprints of tested functions

**Status:** Idea.

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

## Open questions

- Whether the release tools' command belongs in `porelo-buildtools` with the other checks, or in a tool of its own.
