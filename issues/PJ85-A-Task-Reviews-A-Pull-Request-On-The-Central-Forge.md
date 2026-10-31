# PJ85 — A task reviews a pull request on the central forge

**Status:** Idea.

**What must be true.** A person starts a task, in a project or without one, with an existing pull request on the
central forge as its target. The task's agent reads that pull request's change read-only and answers only with SARIF
comments and findings; the person reads and answers them in IntelliJ's review, and each one reaches the pull request
only after the person releases it. The task can push nothing, approve nothing and resolve nothing on the forge.

## Why

A task that reviews today receives another task's work, not a pull request that already lies on a forge, and a task
without a project reaches no forge and is mapped to no pull request, so its comments to a forge are refused. Most of
what this needs is being built for the review area of release 0.8: the reviewer role, the daemon's comment calls with
held and outgoing forge comments, IntelliJ's review threads, and the adapters' conversion between a forge's review
comments and SARIF. What is missing is starting a task with a pull request as its target, and mapping a task to a pull
request without a project, including which forge account reads the pull request and which one writes the released
comments.
