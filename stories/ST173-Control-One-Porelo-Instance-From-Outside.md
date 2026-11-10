# ST173 — Control one Porelo instance from outside

**Priority:** 🔽 Low · **State:** Accepted

**What a user gains.** A person can control one Porelo instance from outside over MCP to start tasks, read status and send messages, while approving, rejecting and vault access stay refused.

**The test.** Start a task, read status and send a message over MCP. Then try approve, reject and vault unlock; those operations are unavailable or explicitly refused.

**Issues:**

- [porelo-project#PJ35](https://github.com/porelo-ai/porelo-project/blob/main/issues/README.md#pj35) (Accepted)
- [porelo-mcp#MC06](https://github.com/porelo-ai/porelo-mcp/blob/main/issues/README.md#mc06) (Finished)
- [porelo-mcp#MC07](https://github.com/porelo-ai/porelo-mcp/blob/main/issues/README.md#mc07) (Finished)
- [porelo-mcp#MC08](https://github.com/porelo-ai/porelo-mcp/blob/main/issues/README.md#mc08) (Finished)
- [porelo#B515](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b515) (Review)
- [porelo-mcp#MC01](https://github.com/porelo-ai/porelo-mcp/blob/main/issues/README.md#mc01) (Review)
- [porelo-mcp#MC02](https://github.com/porelo-ai/porelo-mcp/blob/main/issues/README.md#mc02) (Review)
- [porelo-mcp#MC04](https://github.com/porelo-ai/porelo-mcp/blob/main/issues/README.md#mc04) (Review)
- [porelo-mcp#MC05](https://github.com/porelo-ai/porelo-mcp/blob/main/issues/README.md#mc05) (Review)
- [porelo-mcp#MC09](https://github.com/porelo-ai/porelo-mcp/blob/main/issues/README.md#mc09) (Review)

## Notes

- Control One Porelo Instance Over MCP; Refuse Approval And Vault Operations. This parent also covers sprint 6.

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST173",
  "title": "Control one Porelo instance from outside",
  "gain": "A person can control one Porelo instance from outside over MCP to start tasks, read status and send messages, while approving, rejecting and vault access stay refused.",
  "test": "Start a task, read status and send a message over MCP. Then try approve, reject and vault unlock; those operations are unavailable or explicitly refused.",
  "priority": "Low",
  "issues": [
    "porelo-project#PJ35",
    "porelo-mcp#MC06",
    "porelo-mcp#MC07",
    "porelo-mcp#MC08",
    "porelo#B515",
    "porelo-mcp#MC01",
    "porelo-mcp#MC02",
    "porelo-mcp#MC04",
    "porelo-mcp#MC05",
    "porelo-mcp#MC09"
  ],
  "tested": null
}
```
