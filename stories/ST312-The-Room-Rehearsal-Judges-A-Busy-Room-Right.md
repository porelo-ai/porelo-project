# ST312 — The room rehearsal judges a busy room right

**Priority:** 🟰 Medium · **State:** Backlog

**What a user gains.** The room rehearsal of a move says OK only where the room behaved and FAIL only where it did not, also in a room with history, other persons, retired tasks and other logins on the same host, and leaves no session or chat open behind it.

**The test.** Run the room rehearsal against a room with earlier messages, a second person, a retired task and another login on the host: every step's OK or FAIL matches what the room did, and afterwards the test person has no open session or chat left.

**Issues:**

- [porelo-message-matrix#MX99](https://github.com/porelo-ai/porelo-message-matrix/blob/main/issues/README.md#mx99) (Backlog)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST312",
  "title": "The room rehearsal judges a busy room right",
  "gain": "The room rehearsal of a move says OK only where the room behaved and FAIL only where it did not, also in a room with history, other persons, retired tasks and other logins on the same host, and leaves no session or chat open behind it.",
  "test": "Run the room rehearsal against a room with earlier messages, a second person, a retired task and another login on the host: every step's OK or FAIL matches what the room did, and afterwards the test person has no open session or chat left.",
  "priority": "Medium",
  "issues": [
    "porelo-message-matrix#MX99"
  ],
  "tested": null
}
```
