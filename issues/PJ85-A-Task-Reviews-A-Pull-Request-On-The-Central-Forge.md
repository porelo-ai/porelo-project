# PJ85 — A task reviews a pull request on the central forge

**Status:** Idea.

**What must be true.** A reviewer task, as [B172](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b172)
builds it, also takes as its target any existing pull request on the central forge, named by its URL, that no task
made and no project maps, and it does so in a project or without one. Everything else is the reviewer's as [B172](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b172) has it:
read-only, pinned to the pull request's head, no push, SARIF comments and findings only, read and answered in
IntelliJ, and each one reaching the pull request only after the person releases it.

## Why

[B172](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b172) reviews another task's work, and a pull request only where
[B171](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b171)'s authenticated mapping ties it to a
task of the same project. A pull request somebody else opened, or one in a repository no project names, cannot be
reviewed that way, and a task without a project reaches no forge at all. What this adds to [B172](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b172): the pull request's URL
as a target, fetching its base and head into the task's gate read-only, and, without a project, which forge account
reads the pull request and which one writes the released comments.
