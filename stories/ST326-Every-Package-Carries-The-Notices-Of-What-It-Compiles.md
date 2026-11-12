# ST326 — Every package carries the notices of what it compiles in

**Priority:** 🔼 High · **State:** Backlog

**What a user gains.** Every package Porelo ships, the adapters, agents, transports, the window and the plugin, carries one THIRD-PARTY-NOTICES file with the full license and notice texts of every third-party library and runtime compiled into it, made by one shared generator, so a person can see what they install and under which licenses.

**The test.** Install the .deb or .rpm of porelo-agy, porelo-codex, porelo-message-matrix and the window, and the IntelliJ plugin zip: each holds a THIRD-PARTY-NOTICES file naming every compiled-in library with its full license text, LGPL-3.0 and Bouncy Castle included; nothing compiled in is missing from it.

**Issues:**

- [porelo-adapters#GH30](https://github.com/porelo-ai/porelo-adapters/blob/main/issues/README.md#gh30) (Review)
- [porelo-agy#AG16](https://github.com/porelo-ai/porelo-agy/blob/main/issues/README.md#ag16) (Review)
- [porelo-claude-code#CC53](https://github.com/porelo-ai/porelo-claude-code/blob/main/issues/README.md#cc53) (Review)
- [porelo-codex#CX17](https://github.com/porelo-ai/porelo-codex/blob/main/issues/README.md#cx17) (Review)
- [porelo-omp#OM49](https://github.com/porelo-ai/porelo-omp/blob/main/issues/README.md#om49) (Review)
- [porelo-pi#PI54](https://github.com/porelo-ai/porelo-pi/blob/main/issues/README.md#pi54) (Review)
- [porelo-buildtools#BT63](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt63) (Review)
- [porelo-buildtools#BT66](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt66) (Review)
- [porelo-buildtools#BT67](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt67) (Review)
- [porelo-ecosystems#EC21](https://github.com/porelo-ai/porelo-ecosystems/blob/main/issues/README.md#ec21) (Review)
- [porelo-frontend#F472](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f472) (Review)
- [porelo-intellij#IJ24](https://github.com/porelo-ai/porelo-intellij/blob/main/issues/README.md#ij24) (Review)
- [porelo-mcp#MC12](https://github.com/porelo-ai/porelo-mcp/blob/main/issues/README.md#mc12) (Review)
- [porelo-message-matrix#MX101](https://github.com/porelo-ai/porelo-message-matrix/blob/main/issues/README.md#mx101) (Review)
- [porelo-message-sluice#SL51](https://github.com/porelo-ai/porelo-message-sluice/blob/main/issues/README.md#sl51) (Review)
- [porelo#B606](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b606) (Backlog)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST326",
  "title": "Every package carries the notices of what it compiles in",
  "gain": "Every package Porelo ships, the adapters, agents, transports, the window and the plugin, carries one THIRD-PARTY-NOTICES file with the full license and notice texts of every third-party library and runtime compiled into it, made by one shared generator, so a person can see what they install and under which licenses.",
  "test": "Install the .deb or .rpm of porelo-agy, porelo-codex, porelo-message-matrix and the window, and the IntelliJ plugin zip: each holds a THIRD-PARTY-NOTICES file naming every compiled-in library with its full license text, LGPL-3.0 and Bouncy Castle included; nothing compiled in is missing from it.",
  "priority": "High",
  "issues": [
    "porelo-adapters#GH30",
    "porelo-agy#AG16",
    "porelo-claude-code#CC53",
    "porelo-codex#CX17",
    "porelo-omp#OM49",
    "porelo-pi#PI54",
    "porelo-buildtools#BT63",
    "porelo-buildtools#BT66",
    "porelo-buildtools#BT67",
    "porelo-ecosystems#EC21",
    "porelo-frontend#F472",
    "porelo-intellij#IJ24",
    "porelo-mcp#MC12",
    "porelo-message-matrix#MX101",
    "porelo-message-sluice#SL51",
    "porelo#B606"
  ],
  "tested": null
}
```
