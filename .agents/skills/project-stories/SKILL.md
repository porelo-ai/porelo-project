---
name: project-stories
description: porelo-project rules for stories: one file a story, states, the issues a story needs, release cuts, the stories index. Use when changing a story or placing an issue in one.
---

# project-stories

## Work in this repository

- **Work is planned in `stories/`, one file a story**: a function of value to a user, the test the person runs at its
  end, its priority and state, and every issue it needs. Work follows the stories' priority. `porelo-release stories
  index stories` writes each story's readable part and `stories/README.md` from the stories' heads; never edit those
  by hand. The workflow `stories-check.yml` checks them against every repository's index, at a push and hourly.
- **A story's states and their changes are an issue's.** The coordinator sets Analyzed, Implementing and Review; the
  person sets the rest. A story with no issue is an Idea. A story waits in Review only with every issue it needs in
  Review, Finished or Rejected; its Finished, with the day its test passed, sets those still in Review to Finished.
- **A release is a cut the person calls** (`porelo-release stories cut <version> stories --after <day>`): every story
  Finished since the last one. No release is planned ahead.
- **A requirement here is planned as an issue only while it is not split.** Once its parts are filed in the
  repositories that build them, the story names those parts; one built by a single repository is handed over and
  leaves.
- **Every issue not in Idea appears in the story it serves.** Add a new or split issue to it when it leaves Idea, is
  filed in a later state or is started; an issue no story fits gets a new story.

- **A story's priority is the highest priority of its issues before Review**, changed in the same commit as theirs.
  A story whose only open work is the operator's live test keeps the test's priority; one with nothing open before
  Review keeps its own; a story the operator set to Low stays Low and its open issues go down to Low.
