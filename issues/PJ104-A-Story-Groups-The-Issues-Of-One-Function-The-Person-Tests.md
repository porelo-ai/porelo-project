# PJ104 — A Story Groups The Issues Of One Function The Person Tests

**Status:** Accepted.

**What must be true.** The person says what is to be finished by naming stories, not issues: a story is one function
of value to a user, with a name a user understands, a test the person runs at its end, and every issue across the
repositories it needs. A release is a set of stories. The coordinator is started with one or more stories and
coordinates their finishing in the person's name.

## Why

Today the person orders work by sprints in `plan/<release>/plan.yml`. A sprint's *functions* already are what a story
is meant to be: a title a user understands, a test the person runs, and the issues it needs. But they live inside
sprints, which are periods, and have no state or name of their own to be started by. With the coordinator working in a
task ([PJ103](README.md#pj103)), it needs a unit it can be started with, that it can split into tasks and report back
on, and that the person can test on its own.

## Decided by the operator (2026-11-08)

- **Stories replace sprints.** A release names its stories; the order follows from what each waits on.
- **Agents still file new issues as Ideas, and the coordinator files new stories as Ideas.** The person accepts a
  story as an issue is accepted.
- **A story's state is derived from its issues**: it stands at the state of its least advanced issue. One issue in
  Review and another still Implementing leave the story Implementing. Only the person's test moves a story past that,
  to tested.
- **The open functions of the existing plans become stories**, by the coordinator.
- **A story's number names no release** (`ST1`, `ST2`, …), so a story can move between releases.

## The shape proposed

- **One file per story** in `stories/`, with an index `stories/README.md` grouped by state as the issue index is:
  number (`ST1`, `ST2`, …), a name a user understands, what a user gains, the person's test, the issues it needs
  (`repository#ID`), and the date the person tested it. The state is not written; it is derived from the issues'
  indexes, as `plan.yml` does today.
- **`plan/<release>/plan.yml` lists stories instead of sprints.** Plans whose functions are all tested stay as they
  are, as their record; in the others, every function not yet tested becomes a story and the plan names it.
- **`plan check` and the plan pages** read stories: the rendering in porelo-buildtools changes with this, as an issue
  of its own there.
- **The coordinator's start** takes the stories as a parameter, beside `issue` and `phase` of [PJ99](README.md#pj99).

## Acceptance

- A story with one issue in Review and one Implementing shows Implementing in the index and on the plan page.
- `plan check` refuses a story naming an issue that does not exist, and a release naming a story that does not exist.
- No function left untested in a plan is lost in the conversion: each is a story, with its test and its issues.

## To be checked

- The rendering's change in porelo-buildtools and its size.
