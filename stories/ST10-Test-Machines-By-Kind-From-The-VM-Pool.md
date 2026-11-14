# ST10 — Test machines by kind from the VM pool

**Priority:** ⏫ Highest · **State:** Finished (2026-11-14)

**What a user gains.** A build leg that needs a test machine can ask for one by kind from the VM pool on the host's forge and gets an account that is reset afterward.

**The test.** porelo-frontend's leased leg asks for the kind `amd64` on Forgejo and gets an account of the pool, reset afterwards, and a rented machine on the central forge; no workflow names a provider.

**Issues:**

- [porelo-host#HO12](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho12) (Finished)
- [porelo-buildtools#BT24](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt24) (Finished)
- [porelo-buildtools#BT25](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt25) (Finished)
- [porelo-host#HO126](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho126) (Finished)

## Notes

- The pool taken by the same call on Forgejo

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST10",
  "title": "Test machines by kind from the VM pool",
  "gain": "A build leg that needs a test machine can ask for one by kind from the VM pool on the host's forge and gets an account that is reset afterward.",
  "test": "porelo-frontend's leased leg asks for the kind `amd64` on Forgejo and gets an account of the pool, reset afterwards, and a rented machine on the central forge; no workflow names a provider.",
  "priority": "Highest",
  "state": "Finished",
  "issues": [
    "porelo-host#HO12",
    "porelo-buildtools#BT24",
    "porelo-buildtools#BT25",
    "porelo-host#HO126"
  ],
  "tested": "2026-11-14"
}
```
