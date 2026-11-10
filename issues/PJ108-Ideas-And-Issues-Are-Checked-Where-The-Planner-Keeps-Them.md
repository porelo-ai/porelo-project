# PJ108 — Ideas And Issues Are Checked Where The Planner Keeps Them

```json
{
  "$schema": "issue-1.json",
  "id": "PJ108",
  "title": "Ideas And Issues Are Checked Where The Planner Keeps Them",
  "state": "Analyzed",
  "size": "L",
  "priority": "High",
  "rank": 1,
  "blockedBy": [],
  "covers": "A task knows nothing of stories or issues: it gets its work as text and hands back its result, its work through Git and its ideas through the planner; whether an idea or an issue holds every field it must is checked by the planner's backend, and before it by the window, not by tools in the repository."
}
```

**Why this size.** the work it finds crosses four repositories, each piece S or M; it is filed as issues in the
repositories it names, and their sizes follow.

Filed 2026-11-10 by the operator's request; accepted by the operator.

**What must be true.** A task knows nothing of stories or issues. It is started with its work as text: typed or pasted
by a person at the task's console, or handed in by the window as an issue's text for an unattended run. It ends by
answering its result as its status, and its work goes out through Git, to the gate or by a direct push. The ideas a
task has while it works are handed back as well, to the planner, not written as files into the repository: issues may
be kept anywhere the planner reaches, and only this project keeps them, for now, as files in Git. So no check of an
idea's or an issue's fields can run in the repository. Whether an idea or a new issue holds every field it must is
checked by the planner's backend, and before that, for a person, by the window.

## Why

The planner (porelo-planner, ST311) now keeps the board of stories and issues outside the repositories. The tools that
read and check stories and issues still sit in the repositories' build: porelo-buildtools' `porelo-stories` and the
`porelo-release` commands built on it (`issues check`, `issues index`, `stories index`, `check-citations`, the plan
pages), run by each repository's checks and by the coordinator's pre-push. A task that adds an idea today writes an
issue file and is held to those checks. With issues kept by the planner, wherever they live, that check belongs where
they are kept.

## Plan

The questions the analysis answers: what a task needs to know of stories and issues today; what is missing (an idea
handed back to the planner, the planner's check of an idea and an issue, the window's check before it, an issue's text
handed into an unattended task and what the task answers); what moves out of `porelo-stories`, `porelo-release`, the
repositories' checks and `AGENTS.md`; and what it means for the work in flight. The answers, read on each repository's
`main`:

### 1. What a task needs to know today

- **Product code: almost nothing.** `porelo` reads no issue or story file and parses no issue id; the one trace is
  `PORELO_ISSUE_PREFIXES`, the repository's prefixes from the project file's `repositories[].issues`, handed to every
  task so its agent cites issues as the repository does (`porelo` `apps/app-task/.../TaskLaunch.java:38`).
  `porelo-mcp`, `porelo-host` and the adapters touch none; the window reads no issue file and only embeds the planning
  screen.
- **Rules: a great deal.** The Shared Area's *Issues* section (every open task an issue file, the skeleton, the states
  an agent sets in `issues-only [skip ci]` commits, the index changed in the same commit, rejected and finished files
  deleted, links to index rows), and its rules on documents checks, flaky tests, findings and readings that end in an
  issue, all tell an agent to write issue files and check them. `porelo-project`'s own part does the same for stories
  (`stories index`, the coordinator setting story states, every issue not in Idea in a story).
- **Checks: only citations and workflows in the builds.** No build runs `issues check`, `issues index` or
  `stories index`; agents run them locally before a hand-over. Every repository's build or *Shared rules check* runs
  `check-shared` and `check-citations` (the latter reads the own issue heads and indexes to resolve a cited id);
  `check-commits` reads `issues/workflow.yml` and `stats/`. `porelo-project`'s `stories-check.yml` clones every
  repository hourly and runs `stories check`. The coordinator's local pre-push runs the same citation, commit and shared
  checks, and its plan and story tables read issue heads from every `main`.
- **So a task needs none of it to do its work.** It needs its work as text, which `Start(... prompt ...)` already
  carries, and a way to say how it ended and what it found. Everything else serves the planning.

### 2. What is missing

- **An idea handed back.** A new daemon method in `porelo`, `Tasks1.ProposeIdea(title, whatMustBeTrue)`, called by
  the task's agent over its own task socket; the daemon takes the task from the socket, keeps the idea on the task's
  row and offers it through `List`/`Watch`. `porelo-mcp` needs no change: each `Tasks1` method the daemon describes
  becomes a tool, offered in a task only when the signed project file allows it. The window, which already watches
  Porelo's tasks, hands each idea to the planner's API, since the planner talks to no Porelo; the planner saves it at
  once as an issue in state *Idea* in the task's repository, naming the task it came from, and the person sees it on
  the board under *Idea*. An idea holds a title (one line) and
  *What must be true* (one or two sentences); its repository is the task's.
- **The planner's check.** The planner's API takes an idea and a new issue (`POST .../ideas`, `POST .../issues`) and
  checks every field the issue schema asks for its state, answering a refusal per field as `application/problem+json`
  (`/title: missing`, `/size: XL is no size`). The check is `porelo-stories`', made public, so the planner, the
  `issues check` command and a reading of the store share one rule. Reading the store is the check of what stands in
  Git: a file whose head breaks the schema is shown on the board as a fault of that file, not hidden, and not allowed to
  blind the rest of its repository.
- **The window's check.** No new code in the window: it validates no form against a schema today, and should not hold
  a second copy of the rule. The planning screen (this project's `porelo-planner/screen`) sends the form and shows the
  planner's refusals beside the fields, as the window shows Porelo's.
- **An issue's text into an unattended task, and the answer.** Already there: the planning screen's *Start work* goes
  through the window's `startTask` hook to Porelo's `Start`, which takes the text as `prompt` and runs unattended.
  What it answers when it ends comes with [B566](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b566): `Done(outcome DONE|BLOCKED, why)`, `Task.ended` and the answer on the
  task's row. The screen's own
  `StartStoryWork`/`GetStoryWork` calls exist only in its fake and give way to `Start` with the issue's text.

- **An issue's state from the task's outcome.** The planner sets the state itself; nobody moves an issue by hand
  out of or into a working state. The window reports each task's end to the planner as it watches it ([PL09](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl09): the
  task's `ended` record), and the planner maps it by the work rule of the state the work runs in, kept in
  `stories/work.yml` of the project's own repository ([PL07](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl07)) and applied in the planner's `core`:
  - `DONE`: to the rule's `then`, the next working state (Implementing leads to Reading), when it names one; else to
    its `done` state (Review).
  - `DONE` from a reading with blocking findings: to the rule's `blocked` state (Reworking) while the issue has
    readings left; on the last allowed reading the issue stays, under *Needs you* with its findings.
  - `BLOCKED` or `FAILED`: the issue stays where it is, under *Needs you* with the task's `why`; it never counts as a
    finding.

  The planner saves the new state as any save ([PL05](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl05)): committed and pushed under the project's lock. The states
  only the operator sets (Accepted, Estimated, Backlog, Rework, Finished, Rejected) stay the operator's choice, made in
  the window.

### 3. What moves

- **`porelo-stories` stays a library** of `porelo-buildtools`, read by the planner and by `porelo-release`: `Project`,
  `Story`, `Workflow` with `storyState`, `IssueHead`, `IssueIndexes`, `IssueSource`. New in it: the issue and idea
  field check, public, answering per-field faults.
- **`porelo-release`'s commands stay** while this project keeps its issues as files: `issues index|check`,
  `stories index|check|cut`, `plan`, `stage`, `check-commits`, `check-citations`. None of them is a task's; they are
  the planner's way of keeping the files right, run by the planner through the library on every save, and by the
  coordinator meanwhile. Nothing goes away now.
- **The checks in the repositories' builds:** `check-citations` stays as long as prose links to index rows in Git;
  `stories-check.yml` in `porelo-project` gives way to the planner's reading once the planner keeps the board.
- **The rules in `AGENTS.md`:** the Shared Area says that an agent in a task writes no issue or story file and sets no
  state; it ends with its outcome and hands its ideas back through `ProposeIdea`; the planner sets an issue's state
  from that outcome. The issue skeleton, the states and the index stay as the description of the store's format, read by the
  planner. `PORELO_ISSUE_PREFIXES` goes, since a task cites no issue.
- **What stays for this project while its issues are files:** the files, their heads and generated indexes, and the
  checks above; the planner checks them on every read and every save.

### 4. What it means for work in flight

- [BT64](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt64) and [BT65](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt65) (the public readers): **kept**; the planner reads with them.
- [PL03](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl03) (the store read from Git): **kept**, with one change: a file that breaks its schema is listed as a fault on
  the board instead of refusing its whole repository.
- [PJ105](README.md#pj105) (an issue's JSON head): **kept**; the head is what the planner checks. Its acceptance
  "the document checks refuse a hand-edited index" becomes the planner's and `issues check`'s.
- [PJ103](README.md#pj103) and [B507](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b507): **changed in words only**: a task is started with its work as text, not with an
  issue and a phase; [B507](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b507) itself names no issue.
- [PL05](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl05) (moves saved): **kept**, and it takes the new issues and ideas through the same save.
- [PL09](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl09) (the run from building to review): **changed**: it starts a task with the issue's text and sets the issue's state
  from the task's outcome as above.

### The work it finds

| Repository | Work | Size | Waits for |
|---|---|---|---|
| porelo | `Tasks1.ProposeIdea`, kept on the task's row and offered by `List`/`Watch` | M | [B566](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b566) |
| porelo | `PORELO_ISSUE_PREFIXES` no longer handed to a task | XS | the Shared Area's rule |
| porelo-buildtools | the issue and idea field check in `porelo-stories`, public, per-field faults | S | - |
| porelo-planner | ideas and new issues taken over the API, checked, saved as *Idea* | M | the field check, [PL05](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl05) |
| porelo-planner | a broken file shown as a fault, not a refused repository | S | - |
| porelo-planner | the screen's idea and issue form showing the planner's refusals | S | the API above |
| porelo-project | the Shared Area: a task writes no issue file, sets no state, hands ideas back | S | agreement in the room |
| porelo-project | `stories-check.yml` retired | XS | the planner keeping the board |
| porelo-frontend | each idea of a task the window watches handed to the planner's API | S | `ProposeIdea`, the planner's API |
| porelo-mcp | none | - | - |

**Size of the whole: L** - it crosses four repositories, and each piece is S or M.

## Acceptance

- The analysis answers the four questions above, each answer resting on the code and rules read, with the files named.
- Each piece of work it finds is named with its repository, its size, and what it waits for.
- The operator has decided on the plan.

## Decided by the operator

- **An issue's state is set by the planner from the task's outcome**, not by a person by hand; the mapping is the one
  under *What is missing*.
- **An idea a task hands back is saved at once as an issue in state *Idea*.**
- **`stories-check.yml` stays until the planner keeps the board.**
