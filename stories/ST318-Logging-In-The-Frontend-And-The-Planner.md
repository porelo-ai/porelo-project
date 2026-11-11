# ST318 — Logging in the frontend and the planner

**Priority:** 🔼 High · **State:** Accepted

**What a user gains.** The window and the planner each keep a log with levels; a person sets the level in the window, INFO by default, raises or lowers it there, and opens either log file on the local machine from a link in the window. The planner's backend log, written through its Java logging, lies beside the window's log, so a fault is read in one place and Needs you keeps only what asks for an action.

**The test.** Start the window and the planner: both log files lie side by side, at INFO. Set DEBUG in the window: both logs gain debug lines without a restart; set WARN: info lines stop. Click the log link: the file opens in the local viewer. A planner message that only informs shows in the log, not in Needs you.

**Issues:** none yet

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST318",
  "title": "Logging in the frontend and the planner",
  "gain": "The window and the planner each keep a log with levels; a person sets the level in the window, INFO by default, raises or lowers it there, and opens either log file on the local machine from a link in the window. The planner's backend log, written through its Java logging, lies beside the window's log, so a fault is read in one place and Needs you keeps only what asks for an action.",
  "test": "Start the window and the planner: both log files lie side by side, at INFO. Set DEBUG in the window: both logs gain debug lines without a restart; set WARN: info lines stop. Click the log link: the file opens in the local viewer. A planner message that only informs shows in the log, not in Needs you.",
  "priority": "High",
  "state": "Accepted",
  "issues": [],
  "tested": null
}
```
