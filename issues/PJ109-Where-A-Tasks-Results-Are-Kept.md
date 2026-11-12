# PJ109 — Where A Task's Results Are Kept

```json
{
  "$schema": "issue-1.json",
  "id": "PJ109",
  "title": "Where A Task's Results Are Kept",
  "state": "Analyzed",
  "size": "L",
  "priority": "High",
  "rank": 2,
  "blockedBy": [],
  "covers": "A reading's findings are written as a Markdown file in the repository, where the start instructions of each state tell the agent to put them, and the next task finds them in its source, works them off and deletes the file; the start instructions per state come from the store's adapter through the planner's API."
}
```

**What must be true.** A reading's findings are kept like any other change to the source: as a Markdown file committed
to the repository, so they are in Git's history, readable by everyone with read access, and outlive the computer the
task ran on.
- Where the file goes is a setting of the project, in `project.yml`, which a repository's `porelo.yml` may override.
- The agent learns it from its start instructions: what it is told when its work starts says where to write its
  findings, and, for the task that works them off, to delete the file once they are done.
- The next task, a rework for example, finds the findings in its source like any other file, with no other channel.
- The start instructions are defined per state in the planner (for example, what an agent is told at *Start Review*).
  As they depend on how a store is implemented, the planner asks the store's adapter for them through its API, and the
  window puts them into the message a task is started with.

Files a task makes that do not belong in Git, such as a picture, stay out of this issue: their story exists already
([B15](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b15) in ST160 and
[PJ03](README.md#pj03) in ST163) and comes later. Ideas follow [PJ108](README.md#pj108).

## Why

Found in the operator's planner test on 2026-11-11 and handed over by Agent Planner.

**Findings today.** Read in porelo-planner `main` (core `WorkEnds`, `NextStep`, app `WorkRecord`, store/git
`StoreReader`): a reading's findings come back as a `Findings:` block at the end of the reader's answer. The planner
checks them and keeps them only in its local work record, under the account's state directory on that computer. From
there they feed the next step's rework prompt. Nothing writes them to the store: with the local record they are lost,
and nobody else sees them.

**What porelo carries from a task today**, read in porelo `main` (`doc/commands.md`, `doc/reach.md`,
`apps/app-model/.../AgentEnding.java`):
- **A declared end:** `Done(task, outcome: DONE|BLOCKED, why)` over the task's own MCP endpoint, for itself only and
  only where the project allows `Done` ([B566](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b566)).
  `why` is at most 1024 UTF-8 bytes, one line, no control characters; a longer one is refused, not cut. BLOCKED needs
  a reason. The daemon keeps outcome, reason and time in the host's private task record; a later start clears it.
- **The agent's last answer:** the daemon reads the end of the agent's log (at most 2 MiB, the last 40 lines), the
  agent's adapter names the line that ends the run, and its `answer` keeps at most the last 16 KiB, with `answerCut`
  when it was longer. Beside it: `finished`, `error`, `source`, the provider's status and `unpushed`.
- **Toward the window:** `List` and `Watch` answer `ended` (`outcome`, `why`, `at`) and the run's end with its
  `answer`, only to endpoints allowed Logs or Tail; the reason never reaches another agent's prompt. One varlink message
  is at most 4 MiB.
- **No file:** nothing hands a file from a task to the daemon. Files leave a task only through Git, by the gate or a
  push.

So findings fit today only into the 16 KiB answer, and a reason of 1024 bytes holds a cause, not findings. Writing them
as a file in the repository needs none of these channels to grow.

## Decided by the operator

- **Findings are a Markdown file in Git**, committed like any other change to the source; the task that works them off
  deletes the file, so the history shows both.
- **Where the file goes is a project setting** in `project.yml`, overridable in a repository's `porelo.yml`, and the
  window uses it in the message a task is started with.
- **Start instructions are defined per state in the planner**, and the planner asks the store's adapter for them
  through its API, as they depend on the store's implementation. This is part of the story.
- **Files that do not belong in Git come later**, under their own story.

## Open

- The setting's name and shape in `project.yml` and `porelo.yml`, and its default. `project.yml` is signed, so a
  change to it goes to the operator to sign.
- The adapter's API for the start instructions: the call, what it answers per state, and how a project or repository
  changes the wording.
- The file's name and format: one file per issue and reading, and what it holds (the reading, the findings with their
  places, the verdict).
- What a reading with no findings writes, and how the planner sees from the commit that findings exist.

## Analysis (Agent Planner, 2026-11-12)

**Size:** L - it crosses porelo-planner (start instructions per state from the store's adapter, the findings read from
a file), porelo-frontend (the instructions into a task's start message), porelo (the setting in `project.yml` and
`porelo.yml`), and depends on a reader and a rework reaching another task's branch.

**The planner today.** A reader is told by a fixed text (`NextStep.FINDINGS`) to end its answer with one `Findings:`
block; `WorkEnds.findings` reads it from the answer the window reports with ENDED; the findings live only in the
planner's local work record (`WorkRecord`), from where `NextStep` puts them into the rework's order. The order's text
comes from `stories/work.yml` (`order` with `{story}`, `{issues}`, `{tasks}`). Nothing writes findings to the store.

**Plan, the planner's part.**

1. **Start instructions per state, from the store's adapter.** The store interface (`store/api`) gains the instructions
   for a working state: where findings go, and what the task does with findings it finds. The Git store gives them from
   the project's setting; the planner adds them to every order it builds (`WorkOrder.prompt`, `NextStep.task`), so the
   window puts them into the start message as it does the order today. No new endpoint is needed for the window: the
   order it already receives carries them. The fixed `FINDINGS` text becomes the Git store's instruction.
2. **Findings read from the reader's commit.** The reader commits one Markdown file per issue and reading at the
   configured place; the planner reads it from the reader's branch after its end, checks it (the same rules as the
   `Findings:` block today: numbered rows, blocking or note, file and line), and judges blocking as today. The answer's
   block stays as the fallback until every reader writes the file.
3. **The rework finds the file in its source** and deletes it with its fix; the planner's rework order says so.
4. **A reader and a rework reach the work they read.** Both need the other task's branch: the reader the builder's,
   the rework the reader's file. This is [PL90](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl90)
   with porelo's B646 (a task started naming the tasks whose work it reads, its gate giving those branches read only,
   the branch reported per task). PJ109 waits for it.

**The work it finds:**

| Repository | Work | Size | Waits for |
|---|---|---|---|
| porelo-planner | start instructions per working state from the store's adapter, in every order | M | the setting's name and shape |
| porelo-planner | findings read from the reader's committed file, the answer's block as fallback | M | PL90, porelo B646 |
| porelo | the findings place as a setting in `project.yml`, overridable in `porelo.yml` | S | the operator's word on the name |
| porelo-frontend | none beyond PL90's: the order already carries the instructions | - | - |

**Open questions (the operator's):**

- The setting's name, shape and default, for example `findings: {dir: "readings/"}` in `project.yml` with a
  repository's `porelo.yml` able to override `dir`; `project.yml` is signed, so a change goes to the operator to sign.
- The file: one per issue and reading, named `<dir>/<ISSUE>-reading-<n>.md`, holding the reading's verdict and the
  findings in today's row form (`<n>. <blocking|note> | <file or -> | <line or -> | <text>`).
- A reading without findings writes the file with an empty findings list, so a missing file always means the reader
  did not finish its work, never a clean reading.

**To be checked:** how the planner reads a file on a task's branch that porelo names (B646's reported branch) through
its Git store, and whether the reader's commit reaches the forge before the planner reads it (the gate's `waiting`).
