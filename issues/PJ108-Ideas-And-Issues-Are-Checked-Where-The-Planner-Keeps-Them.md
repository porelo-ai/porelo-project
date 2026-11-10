# PJ108 — Ideas And Issues Are Checked Where The Planner Keeps Them

```json
{
  "$schema": "issue-1.json",
  "id": "PJ108",
  "title": "Ideas And Issues Are Checked Where The Planner Keeps Them",
  "state": "Accepted",
  "size": "-",
  "priority": "High",
  "rank": 1,
  "blockedBy": [],
  "covers": "A task knows nothing of stories or issues: it gets its work as text and hands back its result, its work through Git and its ideas through the planner; whether an idea or an issue holds every field it must is checked by the planner's backend, and before it by the window, not by tools in the repository."
}
```

**Why this size.** not sized yet: this issue is analyzed first. The analysis names what is missing, where, and which
existing functions move; the work it finds is filed as issues in the repositories it names, and their sizes follow.

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

The analysis, by Agent Planner with Agent Machines (porelo-buildtools) and Agent Frontend (the window), answers:

1. **What a task needs to know today.** Every place where a task, an agent's rules (AGENTS.md, the Shared Area), a
   repository's checks or the coordinator's pre-push reads or writes stories or issues; which of them a task needs to
   do its work, and which only serve the planning.
2. **What is missing.**
   - Handing an idea back from a task to the planner: through which interface (the task's status, Porelo's MCP server,
     the planner's API), what an idea holds, and how a person sees it.
   - The planner backend's check of an idea and of an issue: which fields, which refusals, in which words.
   - The window's check before a person sends an idea or an issue to the planner.
   - Handing an issue's text into an unattended task from the window, and what the task answers when it ends.
3. **What moves.**
   - `porelo-stories` and the `porelo-release` commands built on it: which go to the planner (porelo-planner), which
     stay as a library both use, and which go away.
   - The issue and story checks in each repository's build and in the coordinator's pre-push, and the rules in AGENTS.md
     that tell a task to write or check issue files.
   - What stays for this project while its issues are still files in Git, and how it is checked then: by the planner
     reading the repository, not by the repository's own build.
4. **What it means for work in flight.** BT64 and BT65 (public readers of porelo-stories for PL03), PL03 (the store read
   from Git), and [PJ105](README.md#pj105) (an issue's JSON head), stated as kept, changed or dropped.

The analysis is written into this issue as a plan, each piece of work named with its repository; the operator decides
on it before any of it is filed.

## Acceptance

- The analysis answers the four questions above, each answer resting on the code and rules read, with the files named.
- Each piece of work it finds is named with its repository, its size, and what it waits for.
- The operator has decided on the plan.
