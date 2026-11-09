# ST290 — Agents on a host work their results off until done

**Priority:** ⏫ Highest · **State:** Implementing

**What a user gains.** A person moves a project of class online to a rented host; its tasks push to the host's own forge and work off every build result, reading and message there until done, and the person then looks at the host's forge and pushes to GitHub.

**The test.** On a rented host with an online project: each agent signs in once by its login task; tasks push to the host's Forgejo, follow every run of a commit to its final verdict, take a person's line by name or to all agents, and rework until done; the person reads rows, machine pages, gate and builds, then pushes to GitHub.

**Issues:**

- [porelo#B519](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b519) (Review)
- [porelo#B520](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b520) (Review)
- [porelo#B521](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b521) (Review)
- [porelo#B522](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b522) (Review)
- [porelo#B523](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b523) (Review)
- [porelo#B524](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b524) (Review)
- [porelo#B525](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b525) (Review)
- [porelo#B526](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b526) (Review)
- [porelo#B527](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b527) (Implementing)
- [porelo#B528](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b528) (Review)
- [porelo#B529](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b529) (Implementing)
- [porelo#B530](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b530) (Review)
- [porelo#B531](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b531) (Review)
- [porelo#B532](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b532) (Review)
- [porelo#B533](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b533) (Review)
- [porelo#B534](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b534) (Implementing)
- [porelo-frontend#F438](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f438) (Review)
- [porelo-frontend#F439](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f439) (Review)
- [porelo-frontend#F440](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f440) (Review)
- [porelo-frontend#F441](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f441) (Review)
- [porelo-frontend#F442](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f442) (Review)
- [porelo-host#HO152](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho152) (Review)
- [porelo-host#HO154](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho154) (Review)
- [porelo-message-matrix#MX85](https://github.com/porelo-ai/porelo-message-matrix/blob/main/issues/README.md#mx85) (Review)
- [porelo-message-matrix#MX86](https://github.com/porelo-ai/porelo-message-matrix/blob/main/issues/README.md#mx86) (Review)
- [porelo-message-matrix#MX87](https://github.com/porelo-ai/porelo-message-matrix/blob/main/issues/README.md#mx87) (Review)
- [porelo-message-matrix#MX88](https://github.com/porelo-ai/porelo-message-matrix/blob/main/issues/README.md#mx88) (Review)
- [porelo-adapters#GH18](https://github.com/porelo-ai/porelo-adapters/blob/main/issues/README.md#gh18) (Review)
- [porelo#B575](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b575) (Backlog)
- [porelo#B576](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b576) (Backlog)
- [porelo#B577](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b577) (Backlog)
- [porelo#B578](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b578) (Backlog)
- [porelo#B579](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b579) (Backlog)
- [porelo#B581](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b581) (Backlog)
- [porelo-message-matrix#MX95](https://github.com/porelo-ai/porelo-message-matrix/blob/main/issues/README.md#mx95) (Backlog)
- [porelo-message-matrix#MX96](https://github.com/porelo-ai/porelo-message-matrix/blob/main/issues/README.md#mx96) (Backlog)
- [porelo#B582](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b582) (Backlog)
- [porelo-claude-code#CC51](https://github.com/porelo-ai/porelo-claude-code/blob/main/issues/README.md#cc51) (Implementing)
- [porelo-claude-code#CC52](https://github.com/porelo-ai/porelo-claude-code/blob/main/issues/README.md#cc52) (Backlog)
- [porelo-pi#PI53](https://github.com/porelo-ai/porelo-pi/blob/main/issues/README.md#pi53) (Backlog)
- [porelo-adapters#GH24](https://github.com/porelo-ai/porelo-adapters/blob/main/issues/README.md#gh24) (Backlog)
- [porelo-adapters#GH25](https://github.com/porelo-ai/porelo-adapters/blob/main/issues/README.md#gh25) (Backlog)
- [porelo-frontend#F452](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f452) (Backlog)
- [porelo-frontend#F453](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f453) (Backlog)
- [porelo-frontend#F454](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f454) (Backlog)
- [porelo-frontend#F455](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f455) (Backlog)
- [porelo-frontend#F456](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f456) (Backlog)
- [porelo-frontend#F457](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f457) (Backlog)
- [porelo-frontend#F458](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f458) (Backlog)
- [porelo-frontend#F459](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f459) (Backlog)
- [porelo-frontend#F460](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f460) (Backlog)
- [porelo-host#HO162](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho162) (Backlog)
- [porelo-host#HO163](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho163) (Backlog)
- [porelo-host#HO164](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho164) (Backlog)
- [porelo-host#HO165](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho165) (Backlog)
- [porelo-buildtools#BT58](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt58) (Backlog)
- [porelo-frontend#F461](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f461) (Backlog)

## Data

```json
{
  "id": "ST290",
  "title": "Agents on a host work their results off until done",
  "state": "Implementing",
  "gain": "A person moves a project of class online to a rented host; its tasks push to the host's own forge and work off every build result, reading and message there until done, and the person then looks at the host's forge and pushes to GitHub.",
  "test": "On a rented host with an online project: each agent signs in once by its login task; tasks push to the host's Forgejo, follow every run of a commit to its final verdict, take a person's line by name or to all agents, and rework until done; the person reads rows, machine pages, gate and builds, then pushes to GitHub.",
  "priority": "Highest",
  "issues": [
    "porelo#B519",
    "porelo#B520",
    "porelo#B521",
    "porelo#B522",
    "porelo#B523",
    "porelo#B524",
    "porelo#B525",
    "porelo#B526",
    "porelo#B527",
    "porelo#B528",
    "porelo#B529",
    "porelo#B530",
    "porelo#B531",
    "porelo#B532",
    "porelo#B533",
    "porelo#B534",
    "porelo-frontend#F438",
    "porelo-frontend#F439",
    "porelo-frontend#F440",
    "porelo-frontend#F441",
    "porelo-frontend#F442",
    "porelo-host#HO152",
    "porelo-host#HO154",
    "porelo-message-matrix#MX85",
    "porelo-message-matrix#MX86",
    "porelo-message-matrix#MX87",
    "porelo-message-matrix#MX88",
    "porelo-adapters#GH18",
    "porelo#B575",
    "porelo#B576",
    "porelo#B577",
    "porelo#B578",
    "porelo#B579",
    "porelo#B581",
    "porelo-message-matrix#MX95",
    "porelo-message-matrix#MX96",
    "porelo#B582",
    "porelo-claude-code#CC51",
    "porelo-claude-code#CC52",
    "porelo-pi#PI53",
    "porelo-adapters#GH24",
    "porelo-adapters#GH25",
    "porelo-frontend#F452",
    "porelo-frontend#F453",
    "porelo-frontend#F454",
    "porelo-frontend#F455",
    "porelo-frontend#F456",
    "porelo-frontend#F457",
    "porelo-frontend#F458",
    "porelo-frontend#F459",
    "porelo-frontend#F460",
    "porelo-host#HO162",
    "porelo-host#HO163",
    "porelo-host#HO164",
    "porelo-host#HO165",
    "porelo-buildtools#BT58",
    "porelo-frontend#F461"
  ],
  "tested": null
}
```
