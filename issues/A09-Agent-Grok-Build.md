# A09 — Agent Grok Build

**Status:** Analyzed; a candidate.
**Size:** L - a new agent repository with its packaging and an acceptance leg, after a measurement of whether it can be brokered; it needs a provider `sokar` does not have yet, and pins a Rust binary rather than an npm package.

**What must be true.** Grok Build runs in a task as a packaged agent, signed in and brokered like the
supported ones, with its real credential never in the container.

## Why

**Upstream.** https://github.com/xai-org/grok-build - Rust rather than npm, installed from
`x.ai/cli`, so it pins differently from every agent listed here so far.

**Providers.** One vendor, whose model is also on its public API.

**Authentication.** A subscription account.

**Can it be brokered?** Unverified.

## Plan

- **Decided:** looked at again in some months, once usage says something; nothing is spent on it until then.
- **Measured first**, on a VM as [A08](README.md#a08) was: a real sign-in, what it stores, which hosts it contacts, and
  whether its model endpoint can be pointed at the broker. If it cannot be brokered, the answer is
  written here and nothing is built.
- **The provider it talks to** is `sokar` [P07](https://github.com/sokar-ai/sokar/blob/main/issues/providers/README.md#p07) (Provider xAI); `sokar/providers/` has no xAI definition
  today.
- **A repository of its own**, shaped like `sokar-omp` (about 35 files): its `AgentMain` against
  `sokar-agent-api` and `sokar-wire`, its definition, the Debian and RPM packaging, unit tests, and an
  acceptance leg on a machine rented through `sokar-machines`.
  Its definition pins the binary installed from `x.ai/cli` by version and checksum, unlike the npm
  agents.
- **Seen to fail first:** the acceptance leg that searches the container for the real credential, run
  before the broker's swap is wired.

## Acceptance

- It ships as its own binary and its own package, in a repository of its own, discovered without
  Sokar changing.
- Nothing outside its own directory names it, enforced by the build.
- A task authenticates without anyone signing in inside the container.
- The real credential is never in the container, seen by searching the container for it.

## To be checked

- Whether a subscription account yields anything storable, or only a session. - Agent Smith's to measure.
