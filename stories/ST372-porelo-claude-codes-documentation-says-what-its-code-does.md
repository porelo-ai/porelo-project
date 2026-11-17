# ST372 — porelo-claude-code's documentation says what its code does

**Priority:** 🟰 Medium · **State:** Idea

**What a user gains.** Whoever installs, signs in, starts a task or builds the adapter can trust its README, user guide, decisions, build.md and AGENTS.md: every claim in them matches what the code and the agent definition actually do.

**The test.** A person picks claims from each document (reachable and refused hosts, sign-in commands, vault.log messages, build steps), checks them against claude.yaml and the Java code or tries them on a task, and finds no mismatch; the audit lists every claim checked.

**Issues:**

- [porelo-claude-code#CC81](https://github.com/porelo-ai/porelo-claude-code/blob/main/issues/README.md#cc81) (Idea)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST372",
  "title": "porelo-claude-code's documentation says what its code does",
  "gain": "Whoever installs, signs in, starts a task or builds the adapter can trust its README, user guide, decisions, build.md and AGENTS.md: every claim in them matches what the code and the agent definition actually do.",
  "test": "A person picks claims from each document (reachable and refused hosts, sign-in commands, vault.log messages, build steps), checks them against claude.yaml and the Java code or tries them on a task, and finds no mismatch; the audit lists every claim checked.",
  "priority": "Medium",
  "issues": ["porelo-claude-code#CC81"],
  "tested": null
}
```
