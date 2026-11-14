# PJ104 — A Story Groups The Issues Of One Function The Person Tests

```json
{
  "$schema": "issue-1.json",
  "id": "PJ104",
  "title": "A Story Groups The Issues Of One Function The Person Tests",
  "state": "Rejected",
  "size": "-",
  "priority": "Medium",
  "rank": 1,
  "blockedBy": [],
  "covers": "A story groups every issue of one function a user values, with the person's test; work follows each story's priority, a release is a cut of the stories tested since the last, a story moves through an issue's states, and the coordinator is started with stories."
}
```

**What must be true.** The person says what is to be finished by naming stories, not issues: a story is one function
of value to a user, with a name a user understands, what a user gains, a priority, a test the person runs at its
end, and every issue across the repositories it needs. Work follows the stories' priority; a release is a cut the
person calls when they choose, holding every story tested since the last one. The coordinator is started with one or
more stories and coordinates their finishing in the person's name.

## Why

Today the person orders work by sprints in `plan/<release>/plan.yml`. A sprint's *functions* already are what a story
is meant to be: a title a user understands, a test the person runs, and the issues it needs. But they live inside
sprints, which are periods, and have no state or name of their own to be started by. With the coordinator working in a
task ([PJ103](README.md#pj103)), it needs a unit it can be started with, that it can split into tasks and report back
on, and that the person can test on its own.

## Decided by the operator (2026-11-08)

- **Stories replace sprints, and releases are no longer planned.** The order of work follows each story's priority
  and what it waits on. A release is a cut the person calls at some point; it holds every story tested since the
  last release, listed when it is cut, never kept beforehand.
- **A story has a priority, as Jira's:** `Highest`, `High`, `Medium`, `Low` or `Lowest`. In the conversion, the open
  functions of plan 0.6 became `Highest`, of 0.7 `High`, of 0.8 to 0.12 `Medium`, the rest `Low`.
- **A story may name no issue yet**: it then stands as Idea, a place for work a later story needs.
- **Agents still file new issues as Ideas, and the coordinator files new stories as Ideas.** The person accepts a
  story as an issue is accepted.
- **A story has the states of an issue, set by the same hands** (AGENTS.md, the issue's states): Idea (anyone),
  Accepted or Rejected (the person), Analyzed (the coordinator: the issues it needs named), Estimated and Backlog (the
  person), Implementing (the coordinator, when its first issue is started), Review (the coordinator, when every issue
  it needs is in Review, Finished or Rejected), Rework or Finished (the person, after the story's test; Finished
  sets its issues still in Review to Finished with it). The state is written in
  the story's head; the index groups by it in the issues' order. In the conversion each story took the state of its
  least advanced issue, Review where all were finished, Finished where the person's test had passed.
- **Every function of the existing plans becomes a story**, by the coordinator, tested ones too with their tested
  date; no plan keeps its sprints.
- **A story's number names no release** (`ST1`, `ST2`, …).
- **A story's data is a JSON head in its own file**, checked by a JSON schema, and `stories/README.md` is generated
  from the heads; the prose below the head stays Markdown. Issues follow the same form afterwards.

## The shape proposed

- **One file per story** in `stories/`, its JSON head holding the number (`ST1`, `ST2`, …), a name a user
  understands, its state, what a user gains, the person's test, its priority, the issues it needs
  (`repository#ID`), and the date the person's test passed. The index `stories/README.md`, grouped by state and within
  a state by priority, is generated from the heads, and a check refuses an index that differs from the generation. It
  is the plan.
- **`plan/` goes** once the stories are read in its place: each of its functions is a story, a tested one with its
  tested date.
- **The rendering in porelo-buildtools** reads stories, and lists at a release's cut the stories tested since the
  last one, as an issue of its own there.
- **The coordinator's start** takes the stories as a parameter, beside `issue` and `phase` of [PJ99](README.md#pj99).

## Acceptance

- The check refuses a story in Review while an issue it needs is in a state before Review, and a story Finished
  without the date its test passed.
- The check refuses a story naming an issue that does not exist, and a priority outside the five.
- A release's cut lists exactly the stories tested since the last release.
- No function of a plan is lost in the conversion: each is a story, with its test, its issues and, where tested, its
  date.

## To be checked

- The rendering's change in porelo-buildtools and its size.

## Decided by the operator (2026-11-12)

- Rejected: what [PJ104](README.md#pj104) asks of the planner is held by PL59 and PL84 (Agent Planner's reading, 2026-11-12); nothing new is built for it.
