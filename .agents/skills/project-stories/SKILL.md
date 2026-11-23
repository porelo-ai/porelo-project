---
name: project-stories
description: porelo-project rules for stories: a story as an issue of this repository, states, the issues a story needs, its priority. Use when changing a story or placing an issue in one.
---

# project-stories

## Work in this repository

- **Work is planned in stories, each an issue of this repository with the label `story`** on the project board
  `porelo-ai/1`: a function of value to a user, the test the person runs at its end, its priority and state, and
  every issue it needs as its sub-issues. Work follows the stories' priority. Stories and issues are read and written
  through the planner, never by hand on GitHub's fields.
- **A story's states and their changes are an issue's.** The coordinator sets Analyzed, Implementing and Review; the
  person sets the rest. A story with no issue is an Idea. A story waits in Review only with every issue it needs in
  Review, Finished or Rejected; its Finished, with the day its test passed, sets those still in Review to Finished.
- **Before Review, a story stands where its furthest issue stands**, counting only issues not rejected: a story is
  in a state of active building (Implementing, Reading, Reworking) only while one of its issues is, and then in the
  furthest of them, however many still wait in Idea; without one, an issue in Review or
  later counts as Backlog, so the story stands at most in Backlog. A blocked issue shows as blocked and moves no story
  back. Each issue that stands before its story's state is shown as a warning on the story.
- **A requirement here is planned as an issue only while it is not split.** Once its parts are filed in the
  repositories that build them, the story names those parts; one built by a single repository is handed over and
  leaves.
- **Every issue not in Idea appears in the story it serves.** Add a new or split issue to it when it leaves Idea, is
  filed in a later state or is started; an issue no story fits gets a new story.
- **A story in work is not widened**: a new issue joins it only when it is a bug or the story cannot be finished
  without it. Any other finding made during a work package goes into that package's follow-up story, which the person
  reviews as a whole.
- **A story's priority is the highest priority of its issues before Review**, changed with theirs. A story whose only
  open work is the operator's live test keeps the test's priority; one with nothing open before Review keeps its own;
  a story the operator set to Low stays Low and its open issues go down to Low.
