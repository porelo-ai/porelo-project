# PJ100 — A Push Is Checked For A Person's Own Terms

**Status:** Idea.

**What must be true.** Work an agent made in a task never leaves the gate carrying a word that names the person's own
machine, accounts or paths, unless the person forwards it knowingly; and the list of those words is never public and
never at rest on a host.

## Why

A task holds only its repository. The check of tracked text against a person's own list of words that name their
machine runs today on one machine, outside any task, and the list must not be handed to the agent. Inside a task,
nothing checks it.

## The shape

- **In the sluice:** a detector for a person's own terms, one regular expression each, and a mode that checks a push's
  commit messages and added lines with that detector and the credential and personal-data detectors only. The
  statistical detectors stay out of this mode: they are tuned to English prose and misfire on code.
- **At the gate:** `gate review` shows the findings, and `gate approve` refuses on one unless the person forwards it
  explicitly anyway. The list lives in the person's local Porelo settings and reaches a host only on standard input
  while the person forwards, never at rest there.
- **In the task:** a generic check in the shared tooling for home-directory dot paths and token shapes, naming no
  machine, warns before the push.
- The person moves their list into the local Porelo settings once.

Built by `porelo-message-sluice` (the detector and the mode), `porelo` (the gate), `porelo-frontend` (review and
forward in the window) and `porelo-buildtools` (the generic check). It is split into their issues once accepted.

## Acceptance

- A push whose added line holds a listed term is refused at `gate approve`, the finding names the commit and the line,
  and an explicit forward-anyway passes it.
- The list is found in no file on the host and in nothing the task can read, before, during and after a forward.
- A push with no listed term, but code the statistical detectors would flag, is not refused.

## To be checked

- How the sluice is reached at the gate on a host, and whether its mode runs where the list is.
