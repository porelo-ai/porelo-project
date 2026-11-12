# PJ97 — A Repository Can Be Renamed Without Losing Work

```json
{
  "$schema": "issue-1.json",
  "id": "PJ97",
  "title": "A Repository Can Be Renamed Without Losing Work",
  "state": "Estimated",
  "size": "L",
  "priority": "Medium",
  "rank": 3,
  "blockedBy": [],
  "covers": "A repository's key renamed in the project file, by hand or signed, in one step or two, loses nothing on a following machine or a carrying host: waiting work, tasks, mirror, gate, the judged `porelo.yml` and the host's forge; measured today as a silent removal plus addition."
}
```

**What must be true.** A person renames a repository's key under `repositories:` in a project file - by a signed
change or by hand, in one step or in two - and nothing is lost, orphaned or made unreachable on any machine that
follows the project or any host that carries it: waiting work, running and kept tasks, the mirror and the gate, the
judged `porelo.yml`, and what the host's forge holds. Where a rename cannot be told apart from a removal and an
addition, Porelo says so before anything is changed, and names what would be affected.

## Why

The key is what a person types and the default name of the repository's agent, so people will rename it, and some
will do it by hand. Measured today, a rename is taken as a removal plus an addition everywhere, without a warning.

## What was measured

**On a machine that follows the project** (a local guarded project, real tasks of the stub agent, `github` renamed to
`adapters` with the same address):

- The mirror is named by the key (`mirrors/<project>/github.git`). After the rename the next start seeds a new, empty
  `adapters.git` from the same address; the old mirror stays on disk with its waiting work, and no command reaches
  it.
- Work a running task pushed before the rename becomes unreachable: `gate pending -r adapters` says nothing is
  pending, `gate review` and `gate approve` find no such push, and `-r github` is refused because the project no
  longer has that repository. Nothing arrived at the address.
- The running task goes on under the old name; `task status` reports work waiting at the gate that no gate command can
  find. Which mirror a kept task's gate serves after it starts again was not shown.
- A new start on the new key works; a start on the old key is refused.

**On a host** (the follow's unit stand-in, a card that carries the project whole or names some repositories):

- A host knows a copy by its central address; the key appears only in the card's `repositories` list and in status.
- A card that carries the project whole, or a card and file renamed in the same follow: nothing happens but the name
  in status.
- A card naming the old key while the file has the new one, or the other way round: the follow takes the repository
  off the host, and the next follow with both renamed migrates it anew from the central forge. Unpushed work on the
  host refuses the take-off and stays.

**Read, not measured:**

- Credentials and vault entries are matched by address, so a rename leaves them alone.
- The judged `porelo.yml` is recorded under the key, so the new key judges its newest change again from scratch and the
  old record is orphaned.
- After a take-off and a fresh migrate, what lived only on the host's forge - its pull requests, reviews and issues -
  is gone, and the central deploy key is deleted and made again; pushed work is safe at the central forge.
- Neither the file nor any command can say "this is a rename" today.

## Proposals so far

- Warn, in `project verify` and when a project is followed, when a key disappears while its mirror holds waiting work,
  and name that work.
- A command that renames a repository of a followed project: it moves the mirror and the records, and says what the
  person must change in the file.
- On a host: while a card names a repository the file does not list, take nothing off; report the mismatch until both
  agree.

## Acceptance

- A key renamed by hand, with work waiting at its gate and a task running on it, keeps that work reachable and
  approvable under the new key, or is refused before anything changes with words naming the waiting work.
- A rename done in two steps on a host - card first or file first - takes nothing off and loses nothing on the host's
  forge.
- Seen to fail first: each of the measured losses above, reproduced by a test before its fix.

**Why this size.** L: it crosses porelo (follow, mirror, gate, judged record) and porelo-host (the host's follow). Porelo's part is M.

## Plan

Read in porelo's code on 2026-11-12 (Agent Core). The key names three things on a machine:
- the mirror, `mirrors/<project>/<key>.git` (`GateSupport.mirror`);
- the judged `porelo.yml` record, `organization/settings-taken/<project>/<key>` (`RepositorySettingsSignature`);
- a task's repository label.
Credentials and vault entries are keyed by address and need nothing.

1. **Red first.** In a `GitGate` and `ProjectInventory` test, a key renamed with the same address, with work waiting and a task labelled with the old key: `gate pending -r <new>` lists the work, and `gate approve` reaches the address. Today it says nothing is pending.
2. **Detection, in porelo.** When a followed project's file changes, its `repositories:` before and after are compared. A key gone plus a key added with the same address is a rename. A key gone whose mirror holds waiting work, or that a running or kept task carries, is named in `project verify` and in the follow's answer before anything changes. A start under the old key keeps being refused.
3. **The move, in porelo.** A detected rename moves the mirror and the judged record to the new key under the gate's lock, and records the old key as an alias. Gate commands and a running task's gate resolve the alias until the last task carrying the old label is removed.
4. **By hand, in two steps (remove, then add).** This cannot be told apart from a removal plus an addition, so it is not guessed. The warning of step 2 fires, and `porelo project rename-repository PROJECT OLD NEW` does the move of step 3 and prints the line the person must change in the file.
5. **On a host, in porelo-host.** While a card names a key the file does not list, or the other way round, nothing is taken off. The mismatch is reported until both agree, and a rename the follow detects as in step 2 is carried by the address the host already keys its copy by.
6. **Docs.** `doc/running.md` gets a section on renaming a repository.


## Decided by the operator (2026-11-12)

- **The identity:** the key stays the name a person types; porelo detects a rename by the unchanged address.
- **A detected rename moves by itself:** porelo moves the mirror and the judged record to the new key under the gate's lock, with no command needed.
- **A rename that also changes the address** stays a removal plus an addition, with the warning only.

## Open questions

1. **The identity.** The key stays the name a person types, and porelo detects a rename by the unchanged address (recommended). Or should the central address become the identity of the local state outright? That moves every mirror and record once and makes a key change free.
2. **A detected rename: automatic, or asked?** Should porelo move the mirror and records on its own when the address is the same, or only say so and wait for `project rename-repository`?
3. **A rename that also changes the address.** Should it stay a removal plus an addition, with the warning only?

## To be checked

- Which mirror a kept task's gate serves after it starts again under a renamed key (not shown in the measurement).
