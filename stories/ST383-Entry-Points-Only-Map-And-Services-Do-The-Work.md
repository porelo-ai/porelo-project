# ST383 — Entry points only map, and services do the work

**Priority:** 🔼 High · **State:** Accepted

**What a user gains.** Whoever changes Porelo finds each use case in one service: an entry point (a REST controller, an MCP method, a command) only checks its input, maps it to a record, calls the service and maps the answer back; the service holds locks, revisions, rules, storing and events without knowing the transport, and is tested without it.

**The test.** In every repository with such entry points, a review of each finds no use case left in it: each calls one service method, the service's tests run without HTTP, MCP or a command line, and every entry point's own tests still pass unchanged.

**Issues:**

- [porelo#B810](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b810) (Accepted)
- [porelo#B811](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b811) (Accepted)
- [porelo#B812](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b812) (Accepted)
- [porelo#B813](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b813) (Accepted)
- [porelo#B814](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b814) (Accepted)
- [porelo-planner#PL184](https://github.com/porelo-ai/porelo-planner/blob/main/issues/README.md#pl184) (Accepted)
- [porelo-frontend#F625](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f625) (Estimated)
- [porelo-message-matrix#MX116](https://github.com/porelo-ai/porelo-message-matrix/blob/main/issues/README.md#mx116) (Estimated)
- [porelo-message-matrix#MX117](https://github.com/porelo-ai/porelo-message-matrix/blob/main/issues/README.md#mx117) (Estimated)
- [porelo-message-matrix#MX118](https://github.com/porelo-ai/porelo-message-matrix/blob/main/issues/README.md#mx118) (Estimated)
- [porelo-message-matrix#MX119](https://github.com/porelo-ai/porelo-message-matrix/blob/main/issues/README.md#mx119) (Estimated)
- [porelo-intellij#IJ33](https://github.com/porelo-ai/porelo-intellij/blob/main/issues/README.md#ij33) (Estimated)
- [porelo-host#HO198](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho198) (Estimated)
- [porelo-buildtools#BT98](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt98) (Estimated)
- [porelo-message-sluice#SL58](https://github.com/porelo-ai/porelo-message-sluice/blob/main/issues/README.md#sl58) (Estimated)
- [porelo-adapters#GH37](https://github.com/porelo-ai/porelo-adapters/blob/main/issues/README.md#gh37) (Estimated)

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
  "issues": [
    "porelo#B810",
    "porelo#B811",
    "porelo#B812",
    "porelo#B813",
    "porelo#B814",
    "porelo-planner#PL184",
    "porelo-frontend#F625",
    "porelo-message-matrix#MX116",
    "porelo-message-matrix#MX117",
    "porelo-message-matrix#MX118",
    "porelo-message-matrix#MX119",
    "porelo-intellij#IJ33",
    "porelo-host#HO198",
    "porelo-buildtools#BT98",
    "porelo-message-sluice#SL58",
    "porelo-adapters#GH37"
  ],
  "tested": null
}
```
