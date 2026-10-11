# A08 — Agent Copilot CLI

**Status:** Analyzed; a candidate, its brokering answered.
**Size:** L - a new agent repository with its packaging and an acceptance leg; brokering is measured, and the subscription's token exchange at `api.github.com` has to be brokered and documented.

**What must be true.** GitHub Copilot CLI runs in a task as a packaged agent, signed in and brokered
like the supported ones, with its real credential never in the container.

## Why

**Upstream.** https://github.com/github/copilot-cli, npm `@github/copilot`. One subscription, which
itself fronts models from several vendors.

**Measured, from a real sign-in with a personal subscription on a VM:**

- **It can be brokered by environment variable.** `COPILOT_PROVIDER_BASE_URL` (with
  `COPILOT_PROVIDER_TYPE`, `COPILOT_PROVIDER_API_KEY`, `COPILOT_MODEL`) switches it to a custom
  provider (BYOK) and turns GitHub authentication off - the easy shape, like the first agent's. But
  **BYOK is not the Copilot subscription**: building it reaches no new provider and not the Copilot
  subscription Sokar already brokers as a provider.
- **Sign-in has three modes**: a browser loopback redirect with PKCE (default on a desktop), a device
  code (default in SSH, containers and CI, though detection chose the web flow in a container over
  SSH), and a token on standard input (`--with-token`). `COPILOT_GITHUB_TOKEN`, `GH_TOKEN` and
  `GITHUB_TOKEN`, in that order, outrank anything stored. So the sign-in never has to happen in a
  task: a credential is obtained on the host and given to the broker.
- **What it stores**: one file, `~/.copilot/config.json`, mode 0600, holding a `gho_…` token in
  plaintext; no refresh token, no expiry. **A fine-grained PAT with the "Copilot Requests"
  permission is accepted** and is the better credential: the sign-in's token also carries `repo`,
  `gist`, `codespace` and `read:org`.
- **The model API is reached only after an exchange at `api.github.com`**, the same number of calls,
  with nothing new written to disk. So the credential Sokar swaps in is presented at `api.github.com`,
  as the sign-in measured it; on 1.0.95 the CLI makes no exchange (see *Plan*).
- **Hosts contacted:** `api.individual.githubcopilot.com` (the model API), `api.github.com`,
  `telemetry.individual.githubcopilot.com`, `exp.individual.githubcopilot.com`, and `github.com` for
  the sign-in.
- **It updates itself by default** (`COPILOT_AUTO_UPDATE`), so any definition turns it off, or a
  pinned version would silently run another one.

## Plan

- **Measured on Copilot CLI 1.0.95: there is no exchange.** The CLI sends the GitHub token itself as
  `Bearer` to the Copilot API, and `COPILOT_API_URL` points that at any address; the calls are
  `GET /models` and `POST /chat/completions`. So the broker swaps the real token in for
  `api.githubcopilot.com` as for the Pi family, and the task holds only a stand-in - no weaker than
  any other provider. The weekly update watches for `copilot_internal/v2/token` appearing in the code.
- **The stand-in must start with `gho_`, `ghu_` or `github_pat_`;** nothing after the prefix is checked.
  `sokar` gains a provider field `token_prefix` and mints `gho_sokarpt_…` for this agent (S, an Idea of
  Agent Core's once A08 is to be built).
- **The built-in GitHub MCP server is turned off** (`--disable-builtin-mcps` among the sandboxed
  arguments); it would post the token to `<API URL>/mcp/readonly`. Its other calls to `api.github.com`
  (user, managed settings, update check, MCP registry) fail closed in a task and the CLI goes on.
- **The provider exists**: `sokar/providers/github-copilot.yaml`. What is new is that the credential
  Sokar swaps in is presented at `api.github.com`, and the short-lived token that comes back stays in
  the agent.
- **A repository of its own**, shaped like `sokar-omp` (about 35 files): its `AgentMain` against
  `sokar-agent-api` and `sokar-wire`, its definition with `COPILOT_AUTO_UPDATE` off and the npm version
  pinned, the Debian and RPM packaging, unit tests, and an acceptance leg on a machine rented through
  `sokar-machines`.
- **The sign-in happens on the host**: a fine-grained PAT with "Copilot Requests" given to the broker,
  never `--with-token` inside a task.
- **Its documentation says** that a task holds a short-lived Copilot token.
- **Seen to fail first:** the acceptance leg that searches the container for the PAT, and a run with a
  pinned version that would have updated itself.

## Acceptance

- It ships as its own binary and its own package, in a repository of its own, discovered without
  Sokar changing.
- Nothing outside its own directory names it, enforced by the build.
- A task authenticates without anyone signing in inside the container.
- The real credential is never in the container, seen by searching the container for it; where the
  subscription leaves a short-lived token in the agent, that is said in its documentation.
- Auto-update is off in its definition, and the version that runs is the one pinned.

## To be checked

- Which model names the subscription serves, since BYOK requires an explicit model. - Agent Smith's to
  measure.
- Whether `telemetry.individual.githubcopilot.com` can be refused without breaking it. - Agent Smith's
  to measure.
