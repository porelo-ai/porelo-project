# PJ88 — A project created from the interface

**Status:** Idea.
**Severity:** medium.

**What must be true.** A project admin creates a new project from the interface: they name it, pick the host it
runs on and confirm. Porelo makes the signed project repository and its first access commit, follows it on the
admin's machine and registers it on the host, with no hand-written file and no script. The concept is talked through
with the operator first; only then does it become issues of Core and Frontend.

## Why

In the sprint 6m test (2026-11-01) no project could be started. The interface writes no `project.yml` by design and
can only follow an existing project repository. Core has no command that writes one. `porelo project follow` needed a
first access commit, and `porelo project access init` needed a followed project, so each waited on the other (B387
fixes this wait). On walk6m the steps Register, Add a developer and Join, and everything after them, could not run
until a project repository was made by hand.

## Known so far

- Frontend: a wizard that hands Core the name, the host, the access address and the signer, and lets Core make and
  sign the repository; size M. It needs Core's creation command as its contract.
- Core: a command that writes `project.yml` (signers, the access repository) and commits it signed through the
  person's agent; B387 lets `follow` take an empty access repository so that `access init` writes the first access
  commit.
- Machines: the host registers the project as root today (`porelo-host-project add`); a person registering it is
  HO88.

## Open questions

- Where the project repository lives: on the central forge, on the host's forge, or both.
- Who signs the first commit, and which keys `signers` names at the start.
- Whether creating, following and registering are one action in the interface or three.
