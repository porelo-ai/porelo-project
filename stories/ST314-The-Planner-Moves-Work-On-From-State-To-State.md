# ST314 — The planner moves work on from state to state by itself

**Priority:** 🔼 High · **State:** Accepted

**What a user gains.** The planner moves an issue on by itself when its task ends, as the project's configuration says from which state to which and how often: work that ends DONE in Implementing goes to Reading and a reader starts with that state's instructions, a reading that asks for rework goes to Reworking and the builder starts with the findings, and a reading that is OK goes to Review for the person.

**The test.** With a configuration of Implementing to Reading, Reading to Reworking or Review, and at most two readings: start an issue's work and let it end DONE; the planner sets Reading and starts the reader with its instructions; a reading with findings sets Reworking and starts the builder with them; the next reading OK sets Review, and the person is asked only there; a third reading is never started.

**Issues:** none yet

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST314",
  "title": "The planner moves work on from state to state by itself",
  "gain": "The planner moves an issue on by itself when its task ends, as the project's configuration says from which state to which and how often: work that ends DONE in Implementing goes to Reading and a reader starts with that state's instructions, a reading that asks for rework goes to Reworking and the builder starts with the findings, and a reading that is OK goes to Review for the person.",
  "test": "With a configuration of Implementing to Reading, Reading to Reworking or Review, and at most two readings: start an issue's work and let it end DONE; the planner sets Reading and starts the reader with its instructions; a reading with findings sets Reworking and starts the builder with them; the next reading OK sets Review, and the person is asked only there; a third reading is never started.",
  "priority": "High",
  "state": "Accepted",
  "issues": [],
  "tested": null
}
```
