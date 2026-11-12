# ST328 — An attended session opens on the person's text, and its last answer is read

**Priority:** 🔼 High · **State:** Backlog

**What a user gains.** A person who starts an attended session with an opening text, as a discussion in the planner does, sees Claude Code, Antigravity CLI, Codex CLI or Oh My Pi answer that text as its first turn and then wait for them; each agent declares where its last message stands, so a reader's answer is never empty.

**The test.** Start an attended task with an opening text for each of Claude Code, agy, codex and omp: each answers the text first and then waits at its prompt; run a reader with each, and the answer the task records is the agent's own last reply.

**Issues:**

- [porelo-claude-code#CC61](https://github.com/porelo-ai/porelo-claude-code/blob/main/issues/README.md#cc61) (Backlog)
- [porelo-agy#AG21](https://github.com/porelo-ai/porelo-agy/blob/main/issues/README.md#ag21) (Backlog)
- [porelo-codex#CX21](https://github.com/porelo-ai/porelo-codex/blob/main/issues/README.md#cx21) (Backlog)
- [porelo-omp#OM53](https://github.com/porelo-ai/porelo-omp/blob/main/issues/README.md#om53) (Backlog)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST328",
  "title": "An attended session opens on the person's text, and its last answer is read",
  "gain": "A person who starts an attended session with an opening text, as a discussion in the planner does, sees Claude Code, Antigravity CLI, Codex CLI or Oh My Pi answer that text as its first turn and then wait for them; each agent declares where its last message stands, so a reader's answer is never empty.",
  "test": "Start an attended task with an opening text for each of Claude Code, agy, codex and omp: each answers the text first and then waits at its prompt; run a reader with each, and the answer the task records is the agent's own last reply.",
  "priority": "High",
  "issues": [
    "porelo-claude-code#CC61",
    "porelo-agy#AG21",
    "porelo-codex#CX21",
    "porelo-omp#OM53"
  ],
  "tested": null
}
```
