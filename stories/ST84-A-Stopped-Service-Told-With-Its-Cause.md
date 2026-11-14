# ST84 — A stopped service told with its cause

**Priority:** 🟰 Medium · **State:** Finished (2026-11-14)

**What a user gains.** A person gets one message naming the machine, the service and the cause when a service such as the room's homeserver stops on a host.

**The test.** The room's homeserver stopped on a host makes one message naming the machine, the service, since when and its last error line; when it runs again, the person is told it is resolved.

**Issues:**

- [porelo#B501](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b501) (Finished)

## Notes

- the watcher in porelo, the person's ways of being told (from PJ70)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST84",
  "title": "A stopped service told with its cause",
  "gain": "A person gets one message naming the machine, the service and the cause when a service such as the room's homeserver stops on a host.",
  "test": "The room's homeserver stopped on a host makes one message naming the machine, the service, since when and its last error line; when it runs again, the person is told it is resolved.",
  "priority": "Medium",
  "issues": [
    "porelo#B501"
  ],
  "tested": "2026-11-14"
}
```
