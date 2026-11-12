# ST32 — Load, time out and forget one connection

**Priority:** 🔼 High · **State:** Backlog

**What a user gains.** A person sees pages load, connection actions time out and a connection be forgotten in one consistent way in the interface.

**The test.** Load a page for the first time and open a rarely used connection action; both show the same loading state. Connect a server that accepts but never answers; the call ends with a named timeout. Forget one connection; the others remain.

**Issues:**

- [porelo#B200](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b200) (Backlog)
- [porelo-frontend#F91](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f91) (Backlog)
- [porelo-frontend#F93](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f93) (Review)
- [porelo#B321](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b321) (Review)
- [porelo-frontend#F219](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f219) (Backlog)
- [porelo-frontend#F367](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f367) (Review)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST32",
  "title": "Load, time out and forget one connection",
  "gain": "A person sees pages load, connection actions time out and a connection be forgotten in one consistent way in the interface.",
  "test": "Load a page for the first time and open a rarely used connection action; both show the same loading state. Connect a server that accepts but never answers; the call ends with a named timeout. Forget one connection; the others remain.",
  "priority": "High",
  "issues": [
    "porelo#B200",
    "porelo-frontend#F91",
    "porelo-frontend#F93",
    "porelo#B321",
    "porelo-frontend#F219",
    "porelo-frontend#F367"
  ],
  "tested": null
}
```
