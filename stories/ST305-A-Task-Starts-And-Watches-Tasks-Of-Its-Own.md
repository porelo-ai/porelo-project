# ST305 — A task starts and watches tasks of its own through MCP

**Priority:** 🔼 High · **State:** Finished (2026-11-14)

**What a user gains.** A task the signed project file allows starts, lists, reads and stops tasks of its own through an MCP endpoint, within the file's limits and held to its own project.

**The test.** From a task, start a second task over MCP, read its state and stop it; a start beyond the file's limits and a read of another project's task are refused.

**Issues:**

- [porelo#B507](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b507) (Finished)
- [porelo#B573](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b573) (Finished)
- [porelo-mcp#MC03](https://github.com/porelo-ai/porelo-mcp/blob/main/issues/README.md#mc03) (Finished)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST305",
  "title": "A task starts and watches tasks of its own through MCP",
  "gain": "A task the signed project file allows starts, lists, reads and stops tasks of its own through an MCP endpoint, within the file's limits and held to its own project.",
  "test": "From a task, start a second task over MCP, read its state and stop it; a start beyond the file's limits and a read of another project's task are refused.",
  "priority": "High",
  "issues": [
    "porelo#B507",
    "porelo#B573",
    "porelo-mcp#MC03"
  ],
  "tested": "2026-11-14"
}
```
