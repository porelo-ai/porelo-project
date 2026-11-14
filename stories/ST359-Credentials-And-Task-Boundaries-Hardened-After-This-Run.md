# ST359 — Credentials and task boundaries hardened after this run

**Priority:** 🔼 High · **State:** Backlog

**What a user gains.** Credentials stay out of sight and off disk, the hooks start only their fixed programs, and a resumed task follows its project's current MCP methods.

**The test.** Start a task in a workspace holding a known credential form: it is warned or refused. Store a credential with no end: vault list marks it. Sign in through a login container: no plaintext copy lands on a disk. Put a fake dnsmasq first on PATH: the hooks still run the fixed one. Narrow a project's MCP methods and resume its task: the removed method is refused.

**Issues:**

- [porelo#B249](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b249) (Backlog)
- [porelo#B140](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b140) (Backlog)
- [porelo#B178](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b178) (Backlog)
- [porelo#B252](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b252) (Backlog)
- [porelo#B609](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b609) (Backlog)

## Notes

- Comes after the current run, like ST60 and ST210 (operator, 2026-11-13 21:35 Berlin). The five issues were analyzed for it by Core (93e676099).

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST359",
  "title": "Credentials and task boundaries hardened after this run",
  "gain": "Credentials stay out of sight and off disk, the hooks start only their fixed programs, and a resumed task follows its project's current MCP methods.",
  "test": "Start a task in a workspace holding a known credential form: it is warned or refused. Store a credential with no end: vault list marks it. Sign in through a login container: no plaintext copy lands on a disk. Put a fake dnsmasq first on PATH: the hooks still run the fixed one. Narrow a project's MCP methods and resume its task: the removed method is refused.",
  "priority": "High",
  "issues": [
    "porelo#B249",
    "porelo#B140",
    "porelo#B178",
    "porelo#B252",
    "porelo#B609"
  ],
  "tested": null
}
```
