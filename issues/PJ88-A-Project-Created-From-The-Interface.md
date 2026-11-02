# PJ88 — A project created from the interface

**Status:** Backlog (estimated L).
**Severity:** medium.

**What must be true.** An organization owner creates a new project from the interface, under *Organization ›
Projects › Add a project*: they name it and name its first admin, who may be themselves. Porelo adds the project's
card to the organization, and the first admin's `porelo project open` makes the signed project repository with its
`project.yml`, with no hand-written file and no script. Creating a project picks no host: a host admin puts it on a host afterwards
([PJ89](README.md#pj89)), and its members are added by its admins. The concept is talked through
with the operator first; only then does it become issues of Core and Frontend.

## Why

In the sprint 6m test (2026-11-01) no project could be started. The interface writes no `project.yml` by design and
can only follow an existing project repository. Core has no command that writes one. `porelo project follow` needed a
first access commit, and `porelo project access init` needed a followed project, so each waited on the other (Core is fixing
this wait). On walk6m the steps Register, Add a developer and Join, and everything after them, could not run
until a project repository was made by hand.

## Known so far

- Frontend: the organization's *Add a project* dialog, and on the project's page the first open, which runs Core's
  command. It needs that command as its contract.
- Core: `porelo project open`, which creates the repository through porelo-forge-clients and commits the first
  `project.yml` signed through the first admin's agent.
- Machines: the host registers the project as root today (`porelo-host-project add`); a person registering it is
  [HO88](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho88).

## Decided

- **Only an organization owner adds or removes a project** (`addProject`, `removeProject` in
  [PJ87](README.md#pj87)); a project admin edits the project they are given.
- **No access file.** A project's members are kept in the organization, so there is no access repository and no
  first access commit to make ([PJ89](README.md#pj89)).
- **The project admin signs the first `project.yml`.** The organization owner adds the project's card; the project
  admin it names writes and signs the first commit of `project.yml` when they first open the project, so only an
  admin's key ever signs it.
- **Where the project repository lives.** Wherever the first admin's `porelo project open` creates it, through
  porelo-forge-clients with their token; its address is in the organization as a pointer, which the organization
  adapter never opens. porelo depends on porelo-forge-clients for it.
