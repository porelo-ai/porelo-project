# ST311 — A planner app serves the board to the window

**Priority:** 🔼 High · **State:** Idea

**What a user gains.** The window reads and changes stories and issues through porelo-planner, a Spring Boot GraalVM native app running beside it, over a REST API described in OpenAPI; the app reads and writes the stories and issues in Git, and porelo keeps only its task functions.

**The test.** Start porelo-planner on the computer the window runs on and open Planning: every story shows in its state's column by priority, a story and one of its issues open, a story moved and saved is in porelo-project's Git, and the OpenAPI description names every call the window makes.

**Issues:** none yet

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST311",
  "title": "A planner app serves the board to the window",
  "gain": "The window reads and changes stories and issues through porelo-planner, a Spring Boot GraalVM native app running beside it, over a REST API described in OpenAPI; the app reads and writes the stories and issues in Git, and porelo keeps only its task functions.",
  "test": "Start porelo-planner on the computer the window runs on and open Planning: every story shows in its state's column by priority, a story and one of its issues open, a story moved and saved is in porelo-project's Git, and the OpenAPI description names every call the window makes.",
  "priority": "High",
  "state": "Idea",
  "issues": [],
  "tested": null
}
```
