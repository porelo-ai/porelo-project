# PJ87 — The registry behind an interface

**Status:** Idea.
**Severity:** medium.

**What must be true.** The registry, the directory of every host and person, is reached through one interface with
more than one implementation. Git on the central forge is the first; others, such as a database, can follow without
changing Core's identity commands or the interface's pages. The concept is talked through with the operator first;
only then does it become issues of Core and Frontend.

## Why

The operator in the sprint 6m test (2026-11-01): "Wir sollten generell das Konzept der Registries generalisieren.
Momentan ist alles fix auf Git gebaut (was im ersten Schritt gut ist), aber vermutlich sollte das ganze hinter ein
Interface wandern und verschiedene Implementierungen ermöglichen. Die Identitäten könnten auch woanders lagern
(Datenbank, ...)."

It touches Core (the registry's reading, filing and trust records) and Frontend (the forge page, the choice of the
registry), so it is settled here before either works on it.

## Found in the same test

- **The name.** "Registry" does not say what it is: the directory of all hosts and persons. A better name is wanted,
  in the interface, in Core's commands and in the documents.
- **Several registries or forges.** The interface keeps one chosen registry ("Choose another…" replaces it). Core
  keeps every registry it ever read and applies revocations and "key held by another login" across all of them, but
  asks whether the forge lists a person's key only of the first registry's forge, ordered by a hash of its address
  (`IdentityFacts.forge` in porelo): with two providers it is chance which one is asked.
- **Older trust records.** A trust record written by an older porelo, without `<sha>.where.json` beside it, stops
  every identity command of snapshot.368; there is no migration.
- **The forge page.** It does not say what a registry or a registry repository is, and *Choose the registry
  repository…*, the first thing to do, stands below the empty registry list. The operator wants the page redesigned
  with Frontend.

## Decided (operator, 2026-11-01)

- **Two interfaces.** One is where the directory is kept (Git first, a database later); the other is who vouches
  for a login and its keys and who owns the organisation (GitHub first, later Forgejo, LDAP or OIDC).
- **Each store adapter guarantees the security itself.** Porelo uses an API; the adapter behind it is an
  implementation of its own and must meet the directory's security requirements: every change signed by the one
  allowed to make it, a history that cannot be rewritten unnoticed, so no revocation and no older card can be
  played back, and a host's offline check against its pinned key. Today's Git code already meets them and becomes
  the Git adapter; the change separates the API from that implementation. A second adapter must meet the same
  requirements.
- **Several directories on one machine, kept apart.** Each holds only its own hosts and projects; its revocations
  and its key checks are answered by its own identity source. A person keeps one card, filed in each directory
  they work in. The interface shows all of them side by side.
- **The name is "directory"** (German "Verzeichnis") in the interface, Core's and the host's commands and the
  documents, in place of "registry".

## The order of the work (operator, 2026-11-01)

All in 0.7, none before the test on a rented machine; a second store, such as a database, only when it is needed.

1. The API separated from today's Git code, which becomes the Git adapter, and the security requirements written
   down as the adapter's contract, with checks every adapter must pass (Core). Nothing visible changes.
2. The rename from registry to directory, with a transition for the old commands and files (Core, Frontend,
   Machines, documents).
3. Several directories on one machine, kept apart (Core, Frontend).
4. A second identity source, such as Forgejo (Core, Frontend).

## Draft API (Coordinator, from today's commands; Core to check against the code)

The identity source:

- `vouches(login, fingerprint)`: whether the key belongs to that person: yes, no, or cannot say. The adapter asks its
  source as it can (GitHub: the login's key lists); a list of all keys is not part of the API.
- `owns(organisation, login)`: whether the login owns the organisation: yes, no, or cannot say; needed for the first
  owners file that founds a directory.
- Optional, for the interface's *See the keys the forge lists*: the keys of a login, where a source offers them.

The store, `DirectoryStore`, asked by question wherever Porelo decides, read only for display (operator,
2026-11-01). Every answer names the revision it rests on, and a revision can be given, so that several questions are
asked against one state. Every write names the revision it was made against (`base`, refused when the store moved
on) and an id (asked again, the same answer).

| Kind | Function | Input | Answer | The question or purpose |
|---|---|---|---|---|
| Discovery | `available` | – | the directories this adapter can reach, each with its id, name and a short summary | what the interface offers under *Add a directory*; the interface names no adapter |
| Connection | `open` | id from `available` | handle, or a refusal | connect |
| | `close` | – | – | clean up |
| Questions | `trusts` | login, key | yes; no with the reason; cannot say | is it their key, and not revoked? |
| | `keyHolder` | key | login, or nobody | does another person hold this key? |
| | `isOwner` | login | yes, no | may they change the directory? |
| | `isHostAdmin` | host, login | yes, no | may they administer this host? |
| | `projectAdmin` | host, project | login, or no such project | who answers for the project on the host? |
| | `reach` | host | address, port, host key; or unknown | how is the host reached safely? |
| | `joinable` | login | list of host, project, admin | where may they join? |
| Reading, for display | `getPersons` | – | persons with their state | |
| | `getHosts` | – | hosts with admins and projects | |
| | `getOwners` | – | owners | |
| | `getCard` | login | the person's card, or unknown | |
| | `getHostCard` | host | the host's card, or unknown | |
| Writing | `putCard` | the person's card, the acting person, base, id | new revision; refusal with the reason | file a card or a change of key |
| | `putHostCard` | host, its card, the acting host admin, base, id | same | enter a host |
| | `deleteHostCard` | host, the acting host admin, base, id | same | remove a host |
| | `putHostAccess` | host, its admins and projects, the acting host admin, base, id | same | a host's admins and projects |
| | `putOwners` | the owners, the acting owner, base, id | same | change the owners |
| Delivery to a host | `deliveryFor` | host | a delivery (Git: a bundle) | what the admin brings to the host |
| | `acceptDelivery` | delivery, pin, last state | yes with persons and projects; no with the reason | on the host, offline: may this state be taken? |

"No" names the reason: revoked, unknown, not proven by the store, or not vouched for by the identity source.

**Signatures are the adapter's alone** (operator, 2026-11-01). The implementation guarantees itself that the chain
of trust is closed; the Git adapter does it with signatures, as today, and how another adapter does it is no concern
of Porelo's. Porelo uses only the API and relies on a correct implementation; it needs no knowledge of signatures.
So a write hands the adapter the content and the acting person, and the adapter signs it as it must (Git: through
the person's ssh-agent); `acceptDelivery` on the host is the adapter's code as well.
