# PJ88 — A project created from the interface

**Status:** Idea.
**Severity:** medium.

**What must be true.** An organization owner creates a new project from the interface, under *Organization ›
Projects › Add a project*: they name it and name its project admin, who may be themselves. Porelo adds the project's
card to the organization and makes the signed project repository with its `project.yml`, with no hand-written file
and no script. Creating a project picks no host: a host admin puts it on a host afterwards
([PJ89](README.md#pj89)), and its members are added by its project admin. The concept is talked through
with the operator first; only then does it become issues of Core and Frontend.

## Why

In the sprint 6m test (2026-11-01) no project could be started. The interface writes no `project.yml` by design and
can only follow an existing project repository. Core has no command that writes one. `porelo project follow` needed a
first access commit, and `porelo project access init` needed a followed project, so each waited on the other (Core is fixing
this wait). On walk6m the steps Register, Add a developer and Join, and everything after them, could not run
until a project repository was made by hand.

## Known so far

- Frontend: a wizard that hands Core the name, the host, the access address and the signer, and lets Core make and
  sign the repository; size M. It needs Core's creation command as its contract.
- Core: a command that writes `project.yml` (signers, the access repository) and commits it signed through the
  person's agent; Core's fix lets `follow` take an empty access repository so that `access init` writes the first access
  commit.
- Machines: the host registers the project as root today (`porelo-host-project add`); a person registering it is
  [HO88](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho88).

## Decided

- **Only an organization owner adds or removes a project** (`addProject`, `removeProject` in
  [PJ87](README.md#pj87)); a project admin edits the project they are given.
- **No access file.** A project's members are kept in the organization, so there is no access repository and no
  first access commit to make ([PJ89](README.md#pj89)).
- **The project admin signs the first `project.yml`.** The organization owner adds the project's card; the project
  admin it names writes and signs the first commit of `project.yml` when they first open the project, so only a key
  `signers` names ever signs it.

## Open questions

- Where the project repository lives: on the central forge, on the host's forge, or both.
