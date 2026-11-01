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

- **Two interfaces, the check stays in Core.** One is where the signed entries are kept (Git first, a database
  later); the other is who vouches for a login and its keys and who owns the organisation (GitHub first, later
  Forgejo, LDAP or OIDC). Core checks every signature the same way whatever the store.
- **The store guarantees its history.** Each implementation keeps a history that cannot be rewritten unnoticed
  (Git's descent from the pinned state; an append-only table in a database), so no revocation and no older card
  can be played back silently. Core relies on the store for it.
- **Several directories on one machine, kept apart.** Each holds only its own hosts and projects; its revocations
  and its key checks are answered by its own identity source. A person keeps one card, filed in each directory
  they work in. The interface shows all of them side by side.
- **The name is "directory"** (German "Verzeichnis") in the interface, Core's and the host's commands and the
  documents, in place of "registry".

## Still open

- How the store states its guarantee, and how a host checks a directory brought from a store that is not Git.
- The order of the work: the rename, several directories, then a second store and a second identity source.
