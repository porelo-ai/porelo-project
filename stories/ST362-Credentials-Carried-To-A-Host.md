# ST362 — Credentials carried to a host

**Priority:** 🔼 High · **State:** Review

**What a user gains.** A person who has already signed in to a provider on this computer need not sign in again on each host: a small dialog on a host's provider row offers this computer's vault entries and the local agents' own sign-in files for that provider, for every provider available here, and the chosen one goes into the host's vault, never shown, logged or put in a command line.

**The test.** On a rented host whose provider rows say not authenticated, open each import dialog: it lists this computer's vault entry and each local agent's sign-in file for that provider, without values, a source that cannot be carried greyed with its reason. Pick one: the row says authenticated and a task there uses it. No value appears in the window, a log or a process list.

**Issues:**

- [porelo#B774](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b774) (Review)
- [porelo#B775](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b775) (Review)
- [porelo-claude-code#CC73](https://github.com/porelo-ai/porelo-claude-code/blob/main/issues/README.md#cc73) (Review)
- [porelo-codex#CX26](https://github.com/porelo-ai/porelo-codex/blob/main/issues/README.md#cx26) (Review)
- [porelo-agy#AG29](https://github.com/porelo-ai/porelo-agy/blob/main/issues/README.md#ag29) (Review)
- [porelo-pi#PI65](https://github.com/porelo-ai/porelo-pi/blob/main/issues/README.md#pi65) (Review)
- [porelo-omp#OM63](https://github.com/porelo-ai/porelo-omp/blob/main/issues/README.md#om63) (Review)
- [porelo-frontend#F572](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f572) (Review)
- [porelo-frontend#F575](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f575) (Review)
- [porelo-frontend#F566](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f566) (Review)
- [porelo#B781](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b781) (Review)
- [porelo#B782](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b782) (Review)
- [porelo#B783](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b783) (Review)
- [porelo-frontend#F577](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f577) (Review)
- [porelo-frontend#F578](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f578) (Review)
- [porelo-frontend#F579](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f579) (Review)
- [porelo-frontend#F580](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f580) (Review)
- [porelo-frontend#F581](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f581) (Review)
- [porelo-frontend#F582](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f582) (Review)
- [porelo-frontend#F583](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f583) (Review)
- [porelo-planner#PL137](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl137) (Review)

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
  "state": "Review",
  "issues": [
    "porelo#B774",
    "porelo#B775",
    "porelo-claude-code#CC73",
    "porelo-codex#CX26",
    "porelo-agy#AG29",
    "porelo-pi#PI65",
    "porelo-omp#OM63",
    "porelo-frontend#F572",
    "porelo-frontend#F575",
    "porelo-frontend#F566",
    "porelo#B781",
    "porelo#B782",
    "porelo#B783",
    "porelo-frontend#F577",
    "porelo-frontend#F578",
    "porelo-frontend#F579",
    "porelo-frontend#F580",
    "porelo-frontend#F581",
    "porelo-frontend#F582",
    "porelo-frontend#F583",
    "porelo-planner#PL137"
  ]
}
```
