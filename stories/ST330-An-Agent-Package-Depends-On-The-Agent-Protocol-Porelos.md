# ST330 — An agent package depends on the agent protocol Porelo's package provides

**Priority:** 🟰 Medium · **State:** Estimated

**What a user gains.** Each agent package names at install time the agent contract that Porelo's package provides, so a person cannot install an agent that does not fit the installed Porelo.

**The test.** Install porelo-agy, porelo-codex, porelo-omp and porelo-pi beside a porelo that provides the agent protocol: they install; against one that does not, the package manager refuses them by name.

**Issues:**

- [porelo-agy#AG10](https://github.com/porelo-ai/porelo-agy/blob/main/issues/README.md#ag10) (Estimated)
- [porelo-codex#CX13](https://github.com/porelo-ai/porelo-codex/blob/main/issues/README.md#cx13) (Estimated)
- [porelo-omp#OM43](https://github.com/porelo-ai/porelo-omp/blob/main/issues/README.md#om43) (Estimated)
- [porelo-pi#PI45](https://github.com/porelo-ai/porelo-pi/blob/main/issues/README.md#pi45) (Estimated)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST330",
  "title": "An agent package depends on the agent protocol Porelo's package provides",
  "gain": "Each agent package names at install time the agent contract that Porelo's package provides, so a person cannot install an agent that does not fit the installed Porelo.",
  "test": "Install porelo-agy, porelo-codex, porelo-omp and porelo-pi beside a porelo that provides the agent protocol: they install; against one that does not, the package manager refuses them by name.",
  "priority": "Medium",
  "issues": [
    "porelo-agy#AG10",
    "porelo-codex#CX13",
    "porelo-omp#OM43",
    "porelo-pi#PI45"
  ],
  "tested": null
}
```
