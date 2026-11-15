# ST366 — The documentation of porelo-pi says what the implementation does

**Priority:** 🔼 High · **State:** Analyzed

**What a user gains.** Whoever reads porelo-pi's README, doc/index.md, doc/decisions.md, build.md or CONTRIBUTING.md can rely on it: every statement there holds for the code, scripts and configuration on main.

**The test.** A person reads the review report: each deviation names the document passage and the code it contradicts; the accompanying commit corrects the documentation, and spot checks of corrected passages match the code.

**Issues:**

- [porelo-pi#PI68](https://github.com/porelo-ai/porelo-pi/blob/main/issues/README.md#pi68) (Analyzed)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST366",
  "title": "The documentation of porelo-pi says what the implementation does",
  "gain": "Whoever reads porelo-pi's README, doc/index.md, doc/decisions.md, build.md or CONTRIBUTING.md can rely on it: every statement there holds for the code, scripts and configuration on main.",
  "test": "A person reads the review report: each deviation names the document passage and the code it contradicts; the accompanying commit corrects the documentation, and spot checks of corrected passages match the code.",
  "priority": "High",
  "issues": ["porelo-pi#PI68"],
  "tested": null
}
```
