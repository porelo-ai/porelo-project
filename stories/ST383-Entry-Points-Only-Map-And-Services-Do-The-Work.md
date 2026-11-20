# ST383 — Entry points only map, and services do the work

**Priority:** 🔼 High · **State:** Accepted

**What a user gains.** Whoever changes Porelo finds each use case in one service: an entry point (a REST controller, an MCP method, a command) only checks its input, maps it to a record, calls the service and maps the answer back; the service holds locks, revisions, rules, storing and events without knowing the transport, and is tested without it.

**The test.** In every repository with such entry points, a review of each finds no use case left in it: each calls one service method, the service's tests run without HTTP, MCP or a command line, and every entry point's own tests still pass unchanged.

**Issues:** none yet

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST383",
  "title": "Entry points only map, and services do the work",
  "gain": "Whoever changes Porelo finds each use case in one service: an entry point (a REST controller, an MCP method, a command) only checks its input, maps it to a record, calls the service and maps the answer back; the service holds locks, revisions, rules, storing and events without knowing the transport, and is tested without it.",
  "test": "In every repository with such entry points, a review of each finds no use case left in it: each calls one service method, the service's tests run without HTTP, MCP or a command line, and every entry point's own tests still pass unchanged.",
  "priority": "High",
  "state": "Accepted",
  "issues": [],
  "tested": null
}
```
