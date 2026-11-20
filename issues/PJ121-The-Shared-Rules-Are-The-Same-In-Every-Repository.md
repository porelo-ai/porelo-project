# PJ121 — The Shared Rules Are The Same In Every Repository

```json
{
  "$schema": "issue-1.json",
  "id": "PJ121",
  "title": "The Shared Rules Are The Same In Every Repository",
  "state": "Idea",
  "size": "-",
  "priority": "Medium",
  "rank": 1,
  "blockedBy": [],
  "covers": "A scheduled workflow here reads `AGENTS.md` and `.agents/skills` on every repository's `main` and fails, naming repository and block, when a shared block's or shared skill's hash differs from this repository's copy."
}
```

**What must be true.** A shared block of `AGENTS.md` or a shared skill that differs between two repositories is
found within an hour, whoever changed it and wherever the agents run, without a checkout of every repository on one
machine.

## Why

Each repository's own `check-shared` holds its copy to the hash its markers carry, so an edit of the text alone is
refused there. A copy edited and given a new hash in one repository passes its own check and still differs from the
others; only a comparison across the repositories shows it. Today that comparison is done by hand on one machine,
which ends once the agents and the coordinator run in tasks, each on one repository.

## Acceptance

- The workflow runs on a schedule, on a push of `AGENTS.md` or `.agents/` here, and by hand, with read access only.
- For every repository `project.yml` names but `porelo-parent`, it compares each `Shared Area` block's and each
  `Shared Skill` block's name and hash with this repository's, reports a missing or extra shared skill, and fails
  naming each repository, block and the two hashes.
- Seen to fail: a test run against a repository whose copy of one shared skill carries another hash fails and names
  it; with every copy equal it passes.
