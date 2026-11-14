# ST362 — Credentials carried to a host

**Priority:** 🔼 High · **State:** Backlog

**What a user gains.** A person who has already signed in to a provider on this computer need not sign in again on each host: a small dialog on a host's provider row offers this computer's vault entries and the local agents' own sign-in files for that provider, for every provider available here, and the chosen one goes into the host's vault, never shown, logged or put in a command line.

**The test.** On a rented host whose provider rows say not authenticated, open each import dialog: it lists this computer's vault entry and each local agent's sign-in file for that provider, without values, a source that cannot be carried greyed with its reason. Pick one: the row says authenticated and a task there uses it. No value appears in the window, a log or a process list.

**Issues:** none yet

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST362",
  "title": "Credentials carried to a host",
  "gain": "A person who has already signed in to a provider on this computer need not sign in again on each host: a small dialog on a host's provider row offers this computer's vault entries and the local agents' own sign-in files for that provider, for every provider available here, and the chosen one goes into the host's vault, never shown, logged or put in a command line.",
  "test": "On a rented host whose provider rows say not authenticated, open each import dialog: it lists this computer's vault entry and each local agent's sign-in file for that provider, without values, a source that cannot be carried greyed with its reason. Pick one: the row says authenticated and a task there uses it. No value appears in the window, a log or a process list.",
  "tested": null,
  "priority": "High",
  "state": "Backlog",
  "issues": []
}
```
