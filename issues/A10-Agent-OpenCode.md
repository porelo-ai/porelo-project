# A10 — Agent OpenCode

```json
{
  "$schema": "issue-1.json",
  "id": "A10",
  "title": "Agent OpenCode",
  "state": "Analyzed",
  "size": "L",
  "priority": "Low",
  "rank": 8,
  "blockedBy": [],
  "covers": "OpenCode as a packaged agent: a base URL configurable per provider."
}
```

**Why this size.** a new agent repository with its packaging and an acceptance leg; brokering is documented, so the measurement is short, and the per-provider credential may need a vault change in `porelo`.

**How it stands.** A candidate.

**What must be true.** OpenCode runs in a task as a packaged agent, signed in and brokered like the
supported ones, with its real credential never in the container.

## Why

**Upstream.** https://github.com/sst/opencode.

**Providers.** Many, chosen per session.

**Authentication.** Per provider: a pasted key in one store, a browser sign-in, or an environment
variable. A stored value may be a reference to a variable rather than a literal.

**Can it be brokered?** **Documented.** A base URL is configurable per provider.

## Plan

- **Measured first**, on a VM as [A08](README.md#a08) was: a real sign-in, what it stores, which hosts it contacts, and
  whether the reference-to-a-variable form and a base URL per provider point it at the broker. If it
  cannot be brokered, the answer is written here and nothing is built.
- **The provider it talks to** is one of the definitions `porelo/providers/` has (`anthropic`,
  `chatgpt`, `github-copilot`, `google`, `google-sign-in`, `openai`, `openrouter`). A task's agent has one
  provider; a second one reaches the task as a further credential (`credentials:` in `project.yml`, or
  `--credential`), seen there as `PORELO_TOKEN_<NAME>` and `PORELO_URL_<NAME>` (`porelo`, `doc/credentials.md`).
- **A repository of its own**, shaped like `porelo-omp` (about 35 files): its `AgentMain` against
  `porelo-agent-api` and `porelo-wire`, its definition, the Debian and RPM packaging, unit tests, and an
  acceptance leg on a machine rented through `porelo-machines`.
- **Seen to fail first:** the acceptance leg that searches the container for the real credential, run
  before the broker's swap is wired.

## Acceptance

- It ships as its own binary and its own package, in a repository of its own, discovered without
  Porelo changing.
- Nothing outside its own directory names it, enforced by the build.
- A task authenticates without anyone signing in inside the container.
- The real credential is never in the container, seen by searching the container for it.

## To be checked

- The reference-to-a-variable form would need no file placed in the container at
  all, which would be simpler than what the supported agent needs. Worth confirming
  before building anything. - Agent Smith's to measure.
- Whether a further credential serves OpenCode's second provider: the vault holds one entry per provider and
  a task may hold several, but OpenCode must then read each provider's base URL and token from those
  variables. - Agent Core's to decide, in `porelo`.
