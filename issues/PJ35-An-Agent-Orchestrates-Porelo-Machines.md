# PJ35 — An agent orchestrates Porelo machines

```json
{
  "$schema": "issue-1.json",
  "id": "PJ35",
  "title": "An agent orchestrates Porelo machines",
  "state": "Accepted",
  "size": "-",
  "priority": "Low",
  "rank": 12,
  "blockedBy": [],
  "covers": "An MCP server outside Porelo lets an agent steer tasks and machines of one or many Porelo instances, without approving work or opening a vault."
}
```

**What must be true.** An agent outside Porelo can do through MCP much of what a person does in the
interface - start, watch and message tasks, and set up and choose machines - across several Porelo
machines or on a single one; it steers Porelo instances from outside, is not part of Porelo itself, and
never approves work or opens a vault, which stay with a person.
