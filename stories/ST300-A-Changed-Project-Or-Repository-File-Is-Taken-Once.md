# ST300 — A changed project or repository file is taken once an admin signs it anew

**Priority:** 🟰 Medium · **State:** Backlog

**What a user gains.** When a project's or a repository's porelo.yml changes, an admin signs it anew from the checkouts they keep, and hosts follow the newly signed file; an unsigned change is never taken.

**The test.** Change a repository's porelo.yml and push it unsigned: hosts keep the old one. Sign it anew as admin: the host's copy follows, and check-commits accepts Porelo's own trailers.

**Issues:**

- [porelo#B477](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b477) (Review)
- [porelo#B488](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b488) (Review)
- [porelo-buildtools#BT47](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt47) (Review)
- [porelo-host#HO135](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho135) (Review)
- [porelo#B723](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b723) (Backlog)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST300",
  "title": "A changed project or repository file is taken once an admin signs it anew",
  "gain": "When a project's or a repository's porelo.yml changes, an admin signs it anew from the checkouts they keep, and hosts follow the newly signed file; an unsigned change is never taken.",
  "test": "Change a repository's porelo.yml and push it unsigned: hosts keep the old one. Sign it anew as admin: the host's copy follows, and check-commits accepts Porelo's own trailers.",
  "priority": "Medium",
  "state": "Backlog",
  "issues": [
    "porelo#B477",
    "porelo#B488",
    "porelo-buildtools#BT47",
    "porelo-host#HO135",
    "porelo#B723"
  ],
  "tested": null
}
```
