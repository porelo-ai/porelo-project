# ST1 — Builds on the host's forge resolve snapshots with a read-only token

**Priority:** ⏫ Highest · **State:** Finished (2026-11-14)

**What a user gains.** Builds on the host's own forge can fetch Porelo snapshots with a read-only token, so they get what they need without being able to change anything.

**The test.** Every project's organization on the host holds `PORELO_PACKAGES_READ_TOKEN` (scope `read:package`) and its own `MAVEN_SNAPSHOTS_URL`; a build on an unreviewed branch resolves snapshots with it and holds no publisher's token, only the deploying step on `main` does; a missing `MAVEN_SNAPSHOTS_URL` fails the Build on any forge but github.com.

**Issues:**

- [porelo-buildtools#BT42](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt42) (Finished)
- [porelo-host#HO52](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho52) (Finished)
- [porelo-buildtools#BT39](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt39) (Finished)
- [porelo-message-sluice#SL36](https://github.com/porelo-ai/porelo-message-sluice/blob/main/issues/README.md#sl36) (Finished)
- [porelo-claude-code#CC41](https://github.com/porelo-ai/porelo-claude-code/blob/main/issues/README.md#cc41) (Finished)
- [porelo-pi#PI41](https://github.com/porelo-ai/porelo-pi/blob/main/issues/README.md#pi41) (Finished)
- [porelo-omp#OM38](https://github.com/porelo-ai/porelo-omp/blob/main/issues/README.md#om38) (Finished)
- [porelo-agy#AG13](https://github.com/porelo-ai/porelo-agy/blob/main/issues/README.md#ag13) (Finished)
- [porelo-claude-code#CC47](https://github.com/porelo-ai/porelo-claude-code/blob/main/issues/README.md#cc47) (Finished)
- [porelo-codex#CX15](https://github.com/porelo-ai/porelo-codex/blob/main/issues/README.md#cx15) (Finished)
- [porelo-host#HO147](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho147) (Finished)
- [porelo-omp#OM45](https://github.com/porelo-ai/porelo-omp/blob/main/issues/README.md#om45) (Finished)
- [porelo-pi#PI47](https://github.com/porelo-ai/porelo-pi/blob/main/issues/README.md#pi47) (Finished)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST1",
  "title": "Builds on the host's forge resolve snapshots with a read-only token",
  "gain": "Builds on the host's own forge can fetch Porelo snapshots with a read-only token, so they get what they need without being able to change anything.",
  "test": "Every project's organization on the host holds `PORELO_PACKAGES_READ_TOKEN` (scope `read:package`) and its own `MAVEN_SNAPSHOTS_URL`; a build on an unreviewed branch resolves snapshots with it and holds no publisher's token, only the deploying step on `main` does; a missing `MAVEN_SNAPSHOTS_URL` fails the Build on any forge but github.com.",
  "priority": "Highest",
  "state": "Finished",
  "issues": [
    "porelo-buildtools#BT42",
    "porelo-host#HO52",
    "porelo-buildtools#BT39",
    "porelo-message-sluice#SL36",
    "porelo-claude-code#CC41",
    "porelo-pi#PI41",
    "porelo-omp#OM38",
    "porelo-agy#AG13",
    "porelo-claude-code#CC47",
    "porelo-codex#CX15",
    "porelo-host#HO147",
    "porelo-omp#OM45",
    "porelo-pi#PI47"
  ],
  "tested": "2026-11-14"
}
```
