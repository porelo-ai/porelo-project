# PJ89 — A project is handled apart from its machines

**Status:** Accepted.
**Severity:** high.

**What must be true.** Handling a project and putting it on a machine are two processes of their own, in Porelo and in
the interface. A project, its repositories and who belongs to it are made and changed on the project, which names no
host. A host admin puts a project on a host, with every person it names, and takes it off again. A host follows its
projects' state by itself, and a person who belongs to a project finds it ready on their own machine without asking to
join. The concept is talked through with the operator first; only then does it become issues of Core, Frontend and
Machines.

## Why

There are two separate processes. One sets up machines, puts projects on them with all their developers and later
takes them off again. The other edits projects and who belongs to them, and has nothing to do with a host. Today
Porelo and the interface mix the two, so the steps of either cannot be followed, and a person is asked to join a
project they were already added to.

[PJ87](PJ87-The-Organization-Behind-An-Interface.md) records the separation as decided for the organization's host menu; this
issue carries it through the whole handling of a project.

## Found in the same test

- **Projects are listed per machine.** sprint6m-demo and "Without a project" appear once per machine, with no sign
  that they are one project (porelo-frontend F300).
- **Who belongs to a project sits on a machine's page.** *Add a developer* is hidden in the page menu of the project
  "on this machine", in a dialog that does not say what its parts are for; the page's own *Persons* section is a host's registry
  admission, not the project's members (porelo-frontend F301, F303).
- **Adding a developer reaches into the host.** After signing the project's access file, the dialog uploads the
  project to the host and runs its sync. And the host admitted the developer only once the host admin had pinned
  them under the host's `admins` in the registry, a second signature on the host's side (Core fixed the reading in
  95101a54; whether the pin goes is Machines' and Frontend's).
- **Register does both at once.** It files the project and puts it on the host in one dialog, and the host keeps
  the project from bundles uploaded once, which no later project change renews.
- **Joining asks for what is already granted.** The developer presses *Join* for a project the admin added them to,
  and must first choose the registry in their own interface. Joining only sets up their own machine; it grants
  nothing.
- **No guidance through the steps.** The interface shows lists and menus, but not where a project stands
  (host ready, project on the host, persons, persons' machines) nor what comes next.

## Decided

- **A project is its `project.yml` and its part of the organization.** `project.yml`, in the project's repository,
  holds its repositories, its agents and its signers. The organization
  ([PJ87](PJ87-The-Organization-Behind-An-Interface.md)) holds the project's card (its name, the address of its project
  repository, its project admin) and its members with their role, changed by the project admin. A member's key is the
  one on their card. The access file leaves with no transition: no `access.repository`, no access repository, no host
  block, no person's `hosts:` list; which projects a host carries is the host's, kept in the organization.
- **Every member of a project is on every host the project is on.** When a host admin puts a project on a host,
  every member of the project is admitted there; a member removed from it is locked on every host at once.
  There is no choice of members per host.
- ***Projects* holds the person's own projects; *Organization* shows them all.** *Projects* lists the projects the
  person is the project admin or a member of, with their role, and is the only place a project is edited: its
  project admin adds and removes repositories and members and changes a member's role; a member sees the same page
  and changes nothing. A project is added and removed by an organization owner, on the organization's page
  ([PJ88](PJ88-A-Project-Created-From-The-Interface.md)). The organization's page lists every project with its project
  admin and changes none; a project the person is in links to its page under *Projects*. Nobody joins a project on
  their own: the project admin adds them.
- ***Projects* deals with projects alone.** It lists the person's projects, one entry each, and a project's page holds its
  repositories and its members with their role, with *Add* and *Remove* beside them. Nothing there refers to a
  machine: not the hosts a project is on, of which there may be several, nor whether it is ready on this machine.
  Which projects a host carries, and putting a project on a host or taking it off, is on the host's page alone.
- **A connection belongs to a host, not to a project.** A person has one account, one daemon and one vault on a host,
  and one connection to it from their machine (ssh configuration, the host key from the organization, the tunnels to the
  forge, the homeserver and their daemon), whatever number of the host's projects they are a member of. *Machines*
  lists the hosts carrying a project the person is a member of, and *Connect* sets up that connection once per host. Every
  project the person is a member of on a connected host is ready to work on at once and followed with no step of its
  own; a project put on that host later appears the same way. There is no *Join*.
- **A host fetches its organization's and its projects' state itself.** No interface uploads or brings anything to
  a host. The host asks the
  installed adapter for the current, signed state of its organization and of each project it carries, and applies it; where and how the project is kept (today
  Git on the central forge) is known only to the adapter, never to Porelo. As with the organization
  ([PJ87](PJ87-The-Organization-Behind-An-Interface.md)), the adapter guarantees that a state it hands over is signed by
  the project's signers and cannot be played back.
- **The host admin's token brings a project onto the host.** Putting a project on a host sends the host admin's
  central token through the tunnel once, as the gathered push does today, so the project's repositories are on the
  host's forge at once; nothing waits for another person's first connection.
- **A host takes a change within five minutes, or at once on asking.** The host fetches its organization's and its
  projects' state every five minutes; *Refresh* on the host's page fetches it at once.
- **A member's card is enough for a host.** A host admits a person when the organization names them as a member of the
  project and trusts their card. The host admin pins no developer: the host's `admins` name only its host
  admins, and the host admin decides which projects the host carries, never which persons.
- **No person follows a project by hand.** `porelo project follow` and `unfollow` go with the cut, for every
  project: a host follows the projects it carries through the adapter, and nothing else is followed.
- **A project is created from the interface in the same change.** [PJ88](PJ88-A-Project-Created-From-The-Interface.md)
  is built in 6q beside this issue.
- **What a finished issue's Done section says stays as it is.** It records what was built; an issue in Review is
  changed by the cut only where its open text depends on what goes.
- **The project admin signs the members.** The project's members are changed and signed by the project admin named
  on the project's card; the signers of `project.yml` sign that file alone.

## The order of the work

The change is a hard cut, so the old and the new structure are never kept side by side; the cut itself lands in one
sprint, and until then the old structure keeps working. Together with
[PJ87](PJ87-The-Organization-Behind-An-Interface.md) and [PJ88](PJ88-A-Project-Created-From-The-Interface.md):

| Sprint | Step | Who | What works at its end |
|---|---|---|---|
| 6m | The running test finished, its reviews made, everything pushed | all | today's structure, as the base |
| 6p | The organization's API and the Git adapter taken out of today's registry code, with the security requirements as contract tests every adapter passes; nothing visible changes | Core | everything as in 6m, and the contract tests |
| 6q | 1. The contract first: `porelo org …` and `porelo project …` with their `--json` output, the organization's files, `fetchFor` on the host; Core writes it, Frontend and Machines check it | Core, Frontend, Machines | one document all three build against |
| 6q | 2. The three parts built side by side on branches: Core the data model and the commands; Machines the host fetching its organization and projects itself, with no bundle upload and no pin; Frontend the new pages and dialogs, with no *Register*, *Join* or developers' dialog | Core, Machines, Frontend | each part with its unit tests against the contract |
| 6q | 3. The test organization made anew by a script, not converted | Core writes it, the operator runs it | an organization with an owner, people, a project and a host |
| 6q | 4. The three branches merged together and tested on a fresh machine in one walk | all | the new structure throughout |

Before 6q starts, every open issue of Core, Frontend, Machines and this repository is sorted against PJ87, PJ89 and
[PJ90](PJ90-Several-Organizations-On-One-Machine.md): obsolete, taken into a part of 6q, changed, or untouched. What
6o holds is cut again afterwards.
