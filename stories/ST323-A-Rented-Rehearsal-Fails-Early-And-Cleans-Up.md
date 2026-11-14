# ST323 — A rented rehearsal fails early and cleans up after itself

**Priority:** 🔼 High · **State:** Finished (2026-11-12)

**What a user gains.** A rehearsal on a rented server stops before it touches the server when a program it needs cannot run, can be run again on the same server after a clean down, and takes the read keys it left at central off by itself, so the person only rents and deletes the server.

**The test.** The fixes stand on main; the story is closed once they are built, without a run of its own.

**Issues:**

- [porelo-host#HO174](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho174) (Finished)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST323",
  "title": "A rented rehearsal fails early and cleans up after itself",
  "gain": "A rehearsal on a rented server stops before it touches the server when a program it needs cannot run, can be run again on the same server after a clean down, and takes the read keys it left at central off by itself, so the person only rents and deletes the server.",
  "test": "The fixes stand on main; the story is closed once they are built, without a run of its own.",
  "priority": "High",
  "issues": [
    "porelo-host#HO174"
  ],
  "tested": "2026-11-12"
}
```
