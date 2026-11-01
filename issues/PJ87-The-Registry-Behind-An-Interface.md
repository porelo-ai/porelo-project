# PJ87 — The registry behind an interface

**Status:** Idea.
**Severity:** medium.

**What must be true.** The registry becomes the organization: its owners, its people, its projects with their
members, and its hosts. It is reached through one interface with more than one implementation. Git on the central
forge is the first; others, such as a database, can follow without changing Core's commands or the interface's pages.
The concept is talked through with the operator first; only then does it become issues of Core and Frontend.

## Why

Today the registry is built on Git alone. That was right as a first step, but it may as well be kept elsewhere, such
as in a database, so it belongs behind an interface with more than one implementation.

It touches Core (the registry's reading, filing and trust records) and Frontend (the forge page, the choice of the
registry), so it is settled here before either works on it.

## Found in the same test

- **The name.** "Registry" does not say what it is: who manages an organization, its people, its projects and its
  hosts. A better name is wanted, in the interface, in Core's commands and in the documents.
- **No list of projects.** A project appears in the registry only under a host, so the interface builds its list of
  projects from the machines it knows, and a project on two machines appears twice.
- **Several registries or forges.** Moved to [PJ90](PJ90-Several-Organizations-On-One-Machine.md).
- **Older trust records.** A trust record written by an older porelo, without `<sha>.where.json` beside it, stops
  every identity command of snapshot.368; there is no migration.
- **The forge page.** It does not say what a registry or a registry repository is, and *Choose the registry
  repository…*, the first thing to do, stands below the empty registry list. The page is redesigned
  with Frontend.

## Decided

- **The name is "organization".** It is used in the interface, in Core's and the host's commands (`porelo org …`)
  and in the documents, in place of "registry"; what keeps it is the organization adapter. Two other meanings are
  always spelled out, never called just "organization": the identity source is named by what it is ("vouched for by
  GitHub"), even where it is a GitHub organization, and a project's organization on a host's forge is its "forge
  organization".
- **An organization holds four parts**, each changed only by the one it belongs to (see [Who may do what](#who-may-do-what)):

  | Part | What it holds | Changed by |
  |---|---|---|
  | Organization owners | who manages the organization's structure: its projects, its hosts, its owners | an organization owner |
  | People | one card per person: login, public key, revocation | the person |
  | Projects | one card per project: name, the address of its project repository, its project admin; and its members, each with their role | added and removed, and its admin named, by an organization owner; its address and members by its project admin |
  | Hosts | one card per host: address, host key; its host admins and the projects it carries, by name | added and removed by an organization owner; the rest by its host admins |

  A member's key is the one on their card, nowhere else, so a change of key or a revocation holds in every project
  at once. A project's repositories, agents and signers stay in its `project.yml`
  ([PJ89](PJ89-A-Project-Is-Handled-Apart-From-Its-Machines.md)). In the Git adapter the organization is one
  repository: `owners.yml`, `people/<login>.card`, `projects/<project>/card`, `projects/<project>/members.yml`,
  `hosts/<host>/card` and `hosts/<host>/host.yml`.
- **With GitHub, a Porelo organization is a GitHub organization.** The organization's repository and its projects'
  repositories lie in that GitHub organization, and GitHub vouches for its people's keys and names who may found it,
  so everything meets there, as it does in the work of the people themselves. Another adapter maps the organization
  onto what it has; Porelo knows only the organization.
- **Two interfaces.** One is where the organization is kept (Git first, a database later); the other is the identity
  source, which vouches for a login and its keys (GitHub first, later Forgejo, LDAP or OIDC).
- **Each organization adapter guarantees the security itself.** Porelo uses an API; the adapter behind it is an
  implementation of its own and must meet the organization's security requirements: every change signed by the one
  allowed to make it, a history that cannot be rewritten unnoticed, so no revocation and no older card can be
  played back, and a host's offline check against its pinned key. Today's Git code already meets them and becomes
  the Git adapter; the change separates the API from that implementation. A second adapter must meet the same
  requirements.
- **One organization per machine.** A machine belongs to one organization, set when Porelo is set up there, and has
  one organization adapter installed, which reads and writes it. The organization's address is Porelo's setting,
  handed to the adapter unread. The interface never asks which organization. Several organizations on one machine
  are [PJ90](PJ90-Several-Organizations-On-One-Machine.md), a nice to have.
- **An organization is made outside Porelo.** For Git today by a script or by hand, signed; later perhaps otherwise.
  Porelo is given its address when it is set up.
- **Machines and projects are two separate processes** ([PJ89](PJ89-A-Project-Is-Handled-Apart-From-Its-Machines.md)).
  Machines: a host is set up, a project is put on it with every member it has and later taken off again; that is the
  host admin's. Projects: a project, its repositories and its members are edited; that is the project admin's and
  names no host. A host follows its organization's and its projects' state by itself, fetched through the installed
  adapter, so nothing is brought to it; no step of the project's edits reaches into a host,
  and no host step edits a project.

## The interface

Drawn by the Coordinator as a design canvas and agreed with the operator; it follows the list screens of today.

- **A rail item of its own,** *Organization*, under *Set up* after *Projects*, opening the organization's page at
  once.
- **The organization's page:** the explanation block on top (what the organization is, where it is kept, what can
  be done here), the name, where it is kept and my card's state, then sections *People*, *Projects*, *Hosts* and
  *Organization owners* with filters. Every action stands visibly in its row, and a person sees only the actions of
  their roles:
  - *People*: a person's state (trusted; not yet, the identity source not reached; revoked). In one's own row
    *Change my key* and *Withdraw my card*; in another's row *Revoke the card…* for an organization owner. A person
    with no card yet sees a banner with *Add me* above the sections.
  - *Projects*: every project with its project admin and whether one is its admin, a member or neither; *Open under
    Projects* where one is in it. *Add a project*, *Change the project admin…* and *Remove the project…* for an
    organization owner.
  - *Hosts*: every host with its admins and the projects it carries; *Open the host's page* for its host admins.
    *Add a host* and *Remove the host…* for an organization owner. Everything else about a host is on the host's
    page under *Machines*: *Change address and host key…*, putting projects on it and taking them off, adding and
    removing host admins, and one's own connection.
  - *Organization owners*: *Add an organization owner* and *Remove* for an organization owner.
- **Add a project:** a dialog with the name and the project admin, any person whose card is trusted. The project
  admin makes the project repository when they first open the project.
- **Add a host:** a dialog with the name and the first host admin. The host admin enters the address and host key
  when they set the machine up.
- **A project's page** under *Projects*: the project repository's address with *Change the address…*, the
  repositories and the members with their role; all of it changed by the project admin alone, read-only for a
  member.
- **Forges** keeps only the access to a forge (signed in as, Git over ssh, the check, disconnect, used by). The
  choice of the registry leaves it.

## The order of the work

All in 0.7, none before the test on a rented machine; a second store, such as a database, only when it is needed.

1. The API separated from today's Git code, which becomes the Git adapter, and the security requirements written
   down as the adapter's contract, with checks every adapter must pass (Core). Nothing visible changes.
2. The rename from registry to organization, with the projects and their members moved into it, a hard cut with no
   transition for the old commands and files (Core, Frontend, Machines, documents).
3. A second identity source, such as Forgejo (Core, Frontend).

## Draft API (Coordinator, from today's commands; Core to check against the code)

The identity source:

- `vouches(login, fingerprint)`: whether the key belongs to that person: yes, no, or cannot say. The adapter asks its
  source as it can (GitHub: the login's key lists); a list of all keys is not part of the API.
- `owns(login)`: whether the login may found the organization as its first organization owner: yes, no, or cannot say; needed for the first owners
  file (GitHub: an owner of the GitHub organization).
- Optional, for the interface's *See the keys the forge lists*: the keys of a login, where a source offers them.

The store, `OrganizationStore`, asked by question wherever Porelo decides, read only for display.
Every answer names the revision it rests on, and a revision can be given, so that several questions are
asked against one state. Every write names the acting person, the revision it was made against (`base`, refused when
the store moved on) and an id (asked again, the same answer); the adapter checks the acting person's role and signs.
The names follow one rule: the verb, then whose it is, then what it is (`addProjectMember`, `addHostAdmin`).

| Kind | Function | Input | Answer | The question or purpose |
|---|---|---|---|---|
| Connection | `open` | the organization's address | handle, or a refusal | connect |
| | `close` | – | – | clean up |
| Questions | `trusts` | login, key | yes; no with the reason; cannot say | is it their key, and not revoked? |
| | `keyHolder` | key | login, or nobody | does another person hold this key? |
| | `isOrganizationOwner` | login | yes, no | may they change the organization's structure? |
| | `isHostAdmin` | host, login | yes, no | may they administer this host? |
| | `projectAdmin` | project | login, or no such project | who answers for the project? |
| | `isProjectMember` | project, login | the role, or no | may they work on the project? |
| | `reach` | host | address, port, host key; or unknown | how is the host reached safely? |
| | `hostsFor` | login | hosts carrying a project they are a member of | which hosts does *Machines* offer to connect? |
| Reading, for display | `getPersons` | – | persons with their state | |
| | `getProjects` | – | projects with their project admin | |
| | `getProjectMembers` | project | members with their role | |
| | `getHosts` | – | hosts with their admins and projects | |
| | `getOrganizationOwners` | – | organization owners | |
| | `getCard` | login | the person's card, or unknown | |
| | `getHostCard` | host | the host's card, or unknown | |
| Followed by a host | `fetchFor` | host, pin, last state | the new state with persons and projects; no with the reason | on the host: the adapter fetches the current state and checks it against the host's pin and the last state it took, so nothing older is played back |

## Who may do what

A person may hold several roles; each right belongs to exactly one role, and a role gives no right outside its
scope. A *member* has no right in the organization: being a member only lets them work on the project.

| Role | Who holds it |
|---|---|
| person | anyone whose card the organization holds; filing it needs a login and key the identity source vouches for |
| organization owner | a person named among the organization owners; the first is one the identity source names as its owner (GitHub: an owner of the GitHub organization) |
| project admin | the person a project's card names |
| host admin | a person a host names among its admins |

| Function | Purpose | Role | Scope |
|---|---|---|---|
| `get…` | read everything | person | the whole organization |
| `addCard` | file one's card | person | their own card |
| `changeCard` | change one's key | person | their own card |
| `revokeCard` | revoke a card | person | their own card |
| `revokeCard` | revoke a card | organization owner | any card |
| `addProject` | add a project and name its project admin | organization owner | any project |
| `changeProjectAdmin` | name another project admin | organization owner | any project |
| `removeProject` | remove a project | organization owner | any project |
| `changeProject` | change the address of the project repository | project admin | their project |
| `addProjectMember` | add a member with their role | project admin | their project |
| `changeProjectMemberRole` | change a member's role | project admin | their project |
| `removeProjectMember` | remove a member | project admin | their project |
| `addHost` | add a host and name its first host admin | organization owner | any host |
| `removeHost` | remove a host | organization owner | any host |
| `changeHost` | change a host's address and host key | host admin | their host |
| `addHostAdmin` | name another host admin | host admin | their host |
| `removeHostAdmin` | remove a host admin | host admin | their host |
| `addProjectToHost` | put a project on the host | host admin | their host |
| `removeProjectFromHost` | take a project off the host | host admin | their host |
| `addOrganizationOwner` | name another organization owner | organization owner | the organization |
| `removeOrganizationOwner` | remove an organization owner | organization owner | the organization |

The last organization owner and a host's last host admin cannot be removed; the adapter refuses it. A project's
repositories and agents are in its `project.yml`, changed by the project's signers, not through this API.

The interface shows each person only what their roles allow: everyone reads the organization's page; adding and
removing projects and hosts and changing the organization owners appear for an organization owner alone; a project's
members and repositories can be changed by its project admin alone; a host's management appears for its host admins
alone; a person's own row under *People* holds *Change my key* and *Withdraw my card*, and a person with no card yet
sees *Add me*.

"No" names the reason: revoked, unknown, not proven by the store, or not vouched for by the identity source.

**Signatures are the adapter's alone**. The implementation guarantees itself that the chain
of trust is closed; the Git adapter does it with signatures, as today, and how another adapter does it is no concern
of Porelo's. Porelo uses only the API and relies on a correct implementation; it needs no knowledge of signatures.
So a write hands the adapter the content and the acting person, and the adapter signs it as it must (Git: through
the person's ssh-agent); `fetchFor` on the host is the adapter's code as well.
