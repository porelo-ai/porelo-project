# ST333 — The commit check trusts no commit's own word

**Priority:** 🔼 High · **State:** Review

**What a user gains.** The commit check gives no exemption, trailer or switch-off of the stage rule to whoever writes a commit, in the planner and in the build tools alike, so a commit cannot excuse itself from the rules.

**The test.** Push a commit that names itself a bot, carries an exempting trailer or deletes a stage file: check-commits refuses it in both the planner's and the build tools' check.

**Issues:**

- [porelo-buildtools#BT79](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt79) (Review)
- [porelo-planner#PL82](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl82) (Review)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST333",
  "title": "The commit check trusts no commit's own word",
  "gain": "The commit check gives no exemption, trailer or switch-off of the stage rule to whoever writes a commit, in the planner and in the build tools alike, so a commit cannot excuse itself from the rules.",
  "test": "Push a commit that names itself a bot, carries an exempting trailer or deletes a stage file: check-commits refuses it in both the planner's and the build tools' check.",
  "priority": "High",
  "issues": [
    "porelo-buildtools#BT79",
    "porelo-planner#PL82"
  ],
  "tested": null
}
```
