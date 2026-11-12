# ST297 — A short download outage does not turn a build red

**Priority:** 🟰 Medium · **State:** Accepted

**What a user gains.** A build that fetches a pinned JDK or tool tries again by one shared rule with a deadline, so a short outage of a download site does not turn a build red.

**The test.** Make a pinned download fail twice and then succeed: the build stays green and says it tried again. Make it fail past the deadline: the build fails and names the download.

**Issues:**

- [porelo-buildtools#BT43](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt43) (Review)
- [porelo-buildtools#BT49](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt49) (Review)
- [porelo-buildtools#BT51](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt51) (Review)
- [porelo-buildtools#BT52](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt52) (Review)
- [porelo-buildtools#BT53](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt53) (Review)
- [porelo-host#HO150](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho150) (Review)
- [porelo-host#HO151](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho151) (Review)
- [porelo-pi#PI49](https://github.com/porelo-ai/porelo-pi/blob/main/issues/README.md#pi49) (Review)
- [porelo-host#HO171](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho171) (Accepted)
- [porelo#B641](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b641) (Review)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST297",
  "title": "A short download outage does not turn a build red",
  "gain": "A build that fetches a pinned JDK or tool tries again by one shared rule with a deadline, so a short outage of a download site does not turn a build red.",
  "test": "Make a pinned download fail twice and then succeed: the build stays green and says it tried again. Make it fail past the deadline: the build fails and names the download.",
  "priority": "Medium",
  "issues": [
    "porelo-buildtools#BT43",
    "porelo-buildtools#BT49",
    "porelo-buildtools#BT51",
    "porelo-buildtools#BT52",
    "porelo-buildtools#BT53",
    "porelo-host#HO150",
    "porelo-host#HO151",
    "porelo-pi#PI49",
    "porelo-host#HO171",
    "porelo#B641"
  ],
  "tested": null
}
```
