# A06 — Agent Codex CLI

**Status:** Analyzed; a candidate.
**Size:** L - a new agent repository with its packaging and an acceptance leg, after a measurement of whether it can be brokered; it needs a provider `porelo` does not have yet.

**What must be true.** Codex CLI runs in a task as a packaged agent, signed in and brokered like the
supported ones, with its real credential never in the container.

## Why

**Upstream.** https://github.com/openai/codex, npm `@openai/codex`.

**Providers.** One vendor.

**Authentication.** An account sign-in or an API key.

**Can it be brokered?** Unverified.

## Plan

- **Measured first**, on a VM as [A08](README.md#a08) was: a real sign-in, what it stores, which hosts it contacts, and
  whether its model endpoint can be pointed at the broker. If it cannot be brokered, the answer is
  written here and nothing is built.
- **The provider it talks to** is `porelo` [P05](https://github.com/porelo-ai/porelo/blob/main/issues/providers/README.md#p05) (Provider OpenAI); `porelo/providers/` has no OpenAI
  definition today.
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

- Whether the endpoint can be redirected at all. - Agent Smith's to measure.
- Whether the account sign-in verifies a session before use, as the supported agent
  does. - Agent Smith's to measure.
