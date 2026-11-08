# PJ105 — An Issue Carries Its Data In A JSON Head

**Status:** Accepted.

**What must be true.** Every issue in every repository of the project carries its data - number, title, state, size,
what it is blocked by, the one line its index shows - in a JSON head at the top of its own file, checked by one JSON
schema shared by all repositories. Each repository's `issues/README.md` is generated from those heads. Tools across
repositories read the heads, never a Markdown table. The prose below the head stays Markdown, written by hand.

## Why

Today an issue's data stands twice: in its file's first lines and in a row of its repository's index, kept in step by
hand. Tools that need it - the plan pages and `plan check` in porelo-buildtools, the coordinator's state table, a
story's derived state ([PJ104](README.md#pj104)), and later the coordinator through Porelo's MCP server
([PJ103](README.md#pj103)) - parse Markdown tables. One machine-readable place per issue, checked by a schema, serves
every tool alike and leaves nothing to drift.

## Decided by the operator (2026-11-08)

- **Mixed form:** data in a head, prose in Markdown, one file per issue; the index is generated, not the issue's prose.
- **The head is JSON**, checked by a JSON schema.
- **Stories come first** in this form ([PJ104](README.md#pj104), porelo-buildtools BT46); the issues of all repositories
  follow as this issue.

## The shape proposed

- A JSON object at the top of each issue file, set apart from the prose; the exact fencing is decided with
  porelo-buildtools.
- The schema, the generator of the index and the check that the index equals the generation live in
  porelo-buildtools and run in every repository's document checks.
- The shared block of `AGENTS.md` says how an issue's head is written, who sets which field, and that the index is
  never edited by hand.
- The existing issues are converted by a script from their first lines and their index rows; a difference between the
  two is listed for the repository's agent, not guessed.

## Acceptance

- In every repository, `issues/README.md` equals what the generator makes from the heads, and the document checks
  refuse a hand-edited index.
- An issue whose head fails the schema is refused by the document checks, naming the field.
- The plan pages and the coordinator's state table read issues from the heads alone.

## To be checked

- The fencing of the head, so Markdown viewers on the forges still show the prose well.
- The order of the conversion across the repositories, and the size.
