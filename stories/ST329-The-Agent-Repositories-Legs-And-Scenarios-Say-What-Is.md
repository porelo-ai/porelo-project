# ST329 — The agent repositories' legs and scenarios say what is true

**Priority:** 🟰 Medium · **State:** Idea

**What a user gains.** The agent repositories' acceptance legs and scenarios fail only for a real fault: a clean-up says when nothing was rented, a scenario decides by what the task ran rather than by the model's words, a busy loop is held in the foreground, the pinned CLI shows no false installation warning, and the bill generator is locked past its advisories.

**The test.** Let a leg fail before it rents: its clean-up says nothing was rented and passes; run the subagent and busy scenarios several times: they pass for the right reason and fail only when the denial or the loop is wrong.

**Issues:**

- [porelo-agy#AG12](https://github.com/porelo-ai/porelo-agy/blob/main/issues/README.md#ag12) (Estimated)
- [porelo-claude-code#CC49](https://github.com/porelo-ai/porelo-claude-code/blob/main/issues/README.md#cc49) (Review)
- [porelo-omp#OM47](https://github.com/porelo-ai/porelo-omp/blob/main/issues/README.md#om47) (Estimated)
- [porelo-pi#PI50](https://github.com/porelo-ai/porelo-pi/blob/main/issues/README.md#pi50) (Estimated)
- [porelo-agy#AG14](https://github.com/porelo-ai/porelo-agy/blob/main/issues/README.md#ag14) (Estimated)
- [porelo-claude-code#CC54](https://github.com/porelo-ai/porelo-claude-code/blob/main/issues/README.md#cc54) (Review)
- [porelo-claude-code#CC58](https://github.com/porelo-ai/porelo-claude-code/blob/main/issues/README.md#cc58) (Review)
- [porelo-pi#PI51](https://github.com/porelo-ai/porelo-pi/blob/main/issues/README.md#pi51) (Estimated)
- [porelo-claude-code#CC67](https://github.com/porelo-ai/porelo-claude-code/blob/main/issues/README.md#cc67) (Review)
- [porelo-pi#PI62](https://github.com/porelo-ai/porelo-pi/blob/main/issues/README.md#pi62) (Backlog)
- [porelo-claude-code#CC68](https://github.com/porelo-ai/porelo-claude-code/blob/main/issues/README.md#cc68) (Backlog)
- [porelo-omp#OM56](https://github.com/porelo-ai/porelo-omp/blob/main/issues/README.md#om56) (Idea)

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST329",
  "title": "The agent repositories' legs and scenarios say what is true",
  "gain": "The agent repositories' acceptance legs and scenarios fail only for a real fault: a clean-up says when nothing was rented, a scenario decides by what the task ran rather than by the model's words, a busy loop is held in the foreground, the pinned CLI shows no false installation warning, and the bill generator is locked past its advisories.",
  "test": "Let a leg fail before it rents: its clean-up says nothing was rented and passes; run the subagent and busy scenarios several times: they pass for the right reason and fail only when the denial or the loop is wrong.",
  "priority": "Medium",
  "issues": [
    "porelo-agy#AG12",
    "porelo-claude-code#CC49",
    "porelo-omp#OM47",
    "porelo-pi#PI50",
    "porelo-agy#AG14",
    "porelo-claude-code#CC54",
    "porelo-claude-code#CC58",
    "porelo-pi#PI51",
    "porelo-claude-code#CC67",
    "porelo-pi#PI62",
    "porelo-claude-code#CC68",
    "porelo-omp#OM56"
  ],
  "tested": null
}
```
