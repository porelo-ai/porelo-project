# PJ109 — Where A Task's Results Are Kept

```json
{
  "$schema": "issue-1.json",
  "id": "PJ109",
  "title": "Where A Task's Results Are Kept",
  "state": "Idea",
  "size": "-",
  "priority": "High",
  "rank": 1,
  "blockedBy": [],
  "covers": "Everything a task hands back besides its commits lands in a known place: a reading's findings kept as input for the next step and readable by others, an idea filed as an issue, and a file it made that does not belong in Git, such as a picture, kept and reachable."
}
```

**What must be true.** Everything a task hands back besides its commits lands in a known place that outlives the
computer it ran on:
- A reading's findings are kept as input for the next step, and others can read them.
- An idea is filed as an issue the normal way.
- A file the task made that does not belong in Git, such as a picture or a report, is kept and reachable.

Git's commits remain the history; a story's run itself (order, containers, machines, reading count) is not kept.

## Why

Found in the operator's planner test on 2026-11-11 and handed over by Agent Planner. Read in porelo-planner `main`
(core `WorkEnds`, `NextStep`, app `WorkRecord`, store/git `StoreReader`):

- **Findings.** A reading's findings come back as a `Findings:` block at the end of the reader's answer. The planner
  checks them and keeps them only in its local work record, under the account's state directory on that computer.
  From there they feed the next step's rework prompt. Nothing writes them to the store: with the local record they are
  lost, and nobody else sees them.
- **Ideas.** An idea an agent brings back has no path. It lands only if the agent writes and commits the issue file
  itself, and the planner never learns of it. [PJ108](README.md#pj108) plans that path (`ProposeIdea`, saved by the
  planner as an issue in *Idea*).
- **Files.** A file a task makes that does not belong in Git, such as a generated picture, has no place to go.
  [B15](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b15) hands intermediate artifacts between
  working tasks over the message transport, and says outright that it is not for the work's result.
  [PJ03](README.md#pj03) decides whether a message may carry more than text at all.

## Open

- Who writes the results: the planner through the store's adapter (one way for every store, checked), or the agent
  by its own commit (Git only, past the planner)?
- Do the findings go into the issue's own file, visible to everyone with read access, or somewhere beside it?
- Where does a file a task made land, and who may read it: the host's forge, a store beside the issues, or the
  person's own computer? How long is it kept?
- Does [B15](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b15) carry it after all, or is a
  task's result a path of its own?
