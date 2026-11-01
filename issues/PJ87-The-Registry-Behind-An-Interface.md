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

## Open questions

- What the interface holds: persons and their cards, hosts and their cards, owners, admissions, revocations.
- How trust is kept when the store is not a signed Git history.
- Whether a machine may read several registries at once, and which one a person's card is filed in.
