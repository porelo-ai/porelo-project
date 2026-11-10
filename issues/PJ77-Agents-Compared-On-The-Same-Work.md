# PJ77 — Agents compared on the same work

```json
{
  "$schema": "issue-1.json",
  "id": "PJ77",
  "title": "Agents compared on the same work",
  "state": "Idea",
  "size": "-",
  "priority": "Medium",
  "rank": 10,
  "blockedBy": [],
  "covers": "Several agents with their own models build the same issue side by side, one more compares the results, and time, tokens and cost are measured; finished issues with their commit serve as references; the overview feeds which agent and model suits which work."
}
```

**What must be true.** Several agents, each with its own model, build the same issue side by side in tasks of their own,
and one more agent compares their results. Each run's wall time, tokens and cost are measured. From many such runs,
an overview shows which agent with which model suits which kind of work. A finished issue whose result is a commit in
git can be built again for comparison, with that commit as the reference.

## Why

Today the agent and model for a piece of work are chosen by habit. [PJ64](README.md#pj64) wants a task to get the agent
and model its work calls for, and [PJ38](README.md#pj38) wants estimates to learn from the tokens spent; both need
measured comparisons of the same work, which nothing produces yet.

## To be checked

- What a comparing agent judges, and against what: the issue's acceptance, the reference commit, the checks.
- Where the time, tokens and cost of a task are measured today (porelo
  [B148](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b148)) and what is missing for cost.
- How a finished issue is set up again at the commit before its result, so its reference stays unseen by the agents.
