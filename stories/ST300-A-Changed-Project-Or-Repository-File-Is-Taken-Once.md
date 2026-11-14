# ST300 — A changed project or repository file is taken once an admin signs it anew

**Priority:** 🟰 Medium · **State:** Finished (2026-11-14)

**What a user gains.** When a project's or a repository's porelo.yml changes, an admin signs it anew from the checkouts they keep, and hosts follow the newly signed file; an unsigned change is never taken.

**The test.** Change a repository's porelo.yml and push it unsigned: hosts keep the old one. Sign it anew as admin: the host's copy follows, and check-commits accepts Porelo's own trailers.

**Issues:**

- [porelo#B477](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b477) (Finished)
- [porelo#B488](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b488) (Finished)
- [porelo-buildtools#BT47](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt47) (Finished)
- [porelo-host#HO135](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho135) (Finished)
- [porelo#B723](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b723) (Finished)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST300",
  "title": "A changed project or repository file is taken once an admin signs it anew",
  "gain": "When a project's or a repository's porelo.yml changes, an admin signs it anew from the checkouts they keep, and hosts follow the newly signed file; an unsigned change is never taken.",
  "test": "Change a repository's porelo.yml and push it unsigned: hosts keep the old one. Sign it anew as admin: the host's copy follows, and check-commits accepts Porelo's own trailers.",
  "priority": "Medium",
  "issues": [
    "porelo#B477",
    "porelo#B488",
    "porelo-buildtools#BT47",
    "porelo-host#HO135",
    "porelo#B723"
  ],
  "tested": "2026-11-14"
}
```
