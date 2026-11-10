# PJ97 — A Repository Can Be Renamed Without Losing Work

```json
{
  "$schema": "issue-1.json",
  "id": "PJ97",
  "title": "A Repository Can Be Renamed Without Losing Work",
  "state": "Accepted",
  "size": "-",
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

## Open questions

## To be checked

- Analysis: which repositories build which part (`porelo` for the follow, the mirror and the gate; `porelo-host` for
  the host's follow), and whether the key should stay the identity at all or the central address take its place.
