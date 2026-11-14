# ST127 — Keep container limits on large hosts

**Priority:** 🔽 Low · **State:** Finished (2026-11-14)

**What a user gains.** Container limits still apply on large hosts, so the same configuration behaves the same on small and large machines.

**The test.** Start the same configuration on a small and a large host. Read task CPU visibility and process limits. Run the homeserver and backup with a deliberately low process limit. Request an oversized VM pool; it is refused before creation.

**Issues:**

- [porelo-message-matrix#MX94](https://github.com/porelo-ai/porelo-message-matrix/blob/main/issues/README.md#mx94) (Finished)

## Notes

- Limit Tasks And Image Builds; Limit Homeserver And Backup Runs; Limit Forge And Runner Jobs; Check VM Pool Capacity.

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST127",
  "title": "Keep container limits on large hosts",
  "gain": "Container limits still apply on large hosts, so the same configuration behaves the same on small and large machines.",
  "test": "Start the same configuration on a small and a large host. Read task CPU visibility and process limits. Run the homeserver and backup with a deliberately low process limit. Request an oversized VM pool; it is refused before creation.",
  "priority": "Low",
  "issues": [
    "porelo-message-matrix#MX94"
  ],
  "tested": "2026-11-14"
}
```
