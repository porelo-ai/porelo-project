# ST301 — A host is given back only once its work has reached central

**Priority:** 🟰 Medium · **State:** Accepted

**What a user gains.** A host is given back only when everything its tasks did has reached central; work still ahead of central is said, with the reason in words, and holds the give-back.

**The test.** Leave a commit on a host that central does not have and try to give the host back: it is refused and the window names the work and why. Push it to central: the give-back goes through.

**Issues:**

- [porelo-frontend#F428](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f428) (Review)
- [porelo-frontend#F462](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f462) (Review)
- [porelo-host#HO143](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho143) (Review)
- [porelo-host#HO167](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho167) (Accepted)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST301",
  "title": "A host is given back only once its work has reached central",
  "gain": "A host is given back only when everything its tasks did has reached central; work still ahead of central is said, with the reason in words, and holds the give-back.",
  "test": "Leave a commit on a host that central does not have and try to give the host back: it is refused and the window names the work and why. Push it to central: the give-back goes through.",
  "priority": "Medium",
  "issues": [
    "porelo-frontend#F428",
    "porelo-frontend#F462",
    "porelo-host#HO143",
    "porelo-host#HO167"
  ],
  "tested": null
}
```
