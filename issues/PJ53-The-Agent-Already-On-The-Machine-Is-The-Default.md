# PJ53 — The agent already on the machine is the default

**Status:** Analyzed.
**Size:** XL - four repositories and a contract change every agent repository reads; splits into the issues under
*Plan*.

**What must be true.** A developer who already uses a coding agent on their machine, signed in to its provider,
starts a Porelo task without `--agent` and `--provider`, and gets that agent with that provider. Porelo says which it
found and where; a flag given still wins.

## Why

The person this is for used an agent on their laptop before Porelo, and the laptop already says which: the agent's
command, its configuration and its sign-in. Today a start with several of Porelo's agents installed and none named
asks by number, and without a terminal asks for `--agent`; the provider is chosen by hand as well. Porelo already
reads part of this: `vault import` copies the credential an agent installed on this machine holds, and `vault login`
refuses when the agent is already signed in here.

## The shape proposed

- **Each packaged agent says what it finds of itself on the host**: its command, its configuration, whether it is
  signed in and to which provider (a subscription or an API key, by kind), every finding with the path it came from.
  The agent's own package knows where its tool keeps these, as it does for `vault import`; `porelo` names no agent.
  Only presence is reported, never a credential's value.
- **The findings are a call of their own, not `describe`**: `Agent1.Describe` is every spawn's handshake and returns
  the agent's static definition, so host state there would read the person's home at every spawn, inside a task's
  start too. A method beside `ExtractCredential`, taking the same `configDirectory`, answers a list of kind, path and,
  where known, provider and credential kind. A new method is a protocol change: `handshake` refuses any other
  `protocolVersion`, so either `porelo`'s API and every adapter move to a new version together, or the check learns
  optional methods.
- **The handshake accepts an agent at or above the lowest protocol version `porelo` needs**
  (`porelo` [B224](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b224)), instead of only its
  own, so `porelo` and the adapters are no longer released together for a new method. It holds only because `Agent1`
  strictly grows: a changed parameter, field or meaning of an existing method raises the lowest version instead. A
  method an agent lacks answers `MethodNotFound`, shown as "this agent cannot say"; an agent that has the method but
  cannot read its tool's state answers "cannot say" itself. Neither is ever shown as "nothing found".
- **What the person has installed is looked up on `PATH` by `porelo` itself**, once for every agent: an adapter runs
  its own pinned CLI inside the task, never the host's, so a command found says only that the person uses that agent.
- **What each agent finds today**: Claude Code reads `~/.claude/.credentials.json`, `claudeAiOauth` for a
  subscription, `apiKey` for an API key, as its `vault import` does, and reports a file holding neither instead of
  failing as the import does. pi and oh-my-pi have no configuration directory and no `vault import` yet, which they need
  first: pi keeps `~/.pi/agent/auth.json`, oh-my-pi `~/.omp/agent/`.
- **`porelo` chooses from the findings**, in this order: a flag given; what the project names; one agent found
  signed in; several found, asked at a terminal with the signed-in ones first, refused without one, naming them; none
  found, as today.
- **What was found but is not yet in the vault is offered**: the start runs `vault import` for the chosen agent at
  the terminal, as it already offers `vault login` and `vault put`, so the first task needs no command beforehand.
- **The findings decide at every start**; no choice is kept for the machine, so an agent installed, removed or
  signed out since the last start is seen at the next.
- **The start names the choice and its source**, for example "agent claude, provider anthropic (subscription),
  found in ~/.claude", so a default never acts unseen.

## Plan

The split, each part sized by its repository's agent, read in the code.

- **`porelo`**:
  - [B224](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b224), M: the agent protocol only grows; an agent at or above the lowest version is accepted, and a missing
    method is "cannot say".
  - [B225](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b225), L: `Find` in the agent contract, the `PATH` lookup, the order in `AgentChoice` (which the start, its dry
    run and the shield all call), the choice and its source named, `vault import` offered, the daemon's start the
    same; `project.yml` names no agent today, so "what the project names" is a new key.
  - [B226](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b226), M: an optional provider for `ExtractCredential` and `vault import --provider`, since one store can hold
    several providers.
- **The agents**, each blocked by [B224](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b224) and [B225](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b225):
  - `porelo-claude-code` [CC36](https://github.com/porelo-ai/porelo-claude-code/blob/main/issues/README.md#cc36), S: the sign-in from `~/.claude/.credentials.json`; another
    base URL, Bedrock or Vertex in `settings.json` reported as not Anthropic.
  - `porelo-pi` [PI36](https://github.com/porelo-ai/porelo-pi/blob/main/issues/README.md#pi36), M: a configuration directory and `vault import` first, then the findings
    from `~/.pi/agent/auth.json`; a key given as a command is reported, never run.
  - `porelo-omp` [OM32](https://github.com/porelo-ai/porelo-omp/blob/main/issues/README.md#om32), S: oh-my-pi found by
    `~/.omp/agent/agent.db` existing, never opened, and "cannot say" for its sign-in, which stays with `vault login`.
    Reading the sign-ins from that SQLite database is
    [OM33](https://github.com/porelo-ai/porelo-omp/blob/main/issues/README.md#om33), an Idea and a nice to have.
- **The interface**, `porelo-frontend` [F143](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f143),
  S to M until analyzed: it stops sending `claude` when nobody picked an agent, shows the machine's choice and its
  source, marks who is signed in in its picker, and offers the import the daemon composes.

## To be checked

- What else says Claude Code is signed in, or to which provider, measured before its finding is built: the login in
  macOS's Keychain rather than the file; `ANTHROPIC_API_KEY` or `CLAUDE_CODE_OAUTH_TOKEN` in the person's shell, which an
  agent the daemon spawns does not see; `CLAUDE_CONFIG_DIR` moving `~/.claude`; `~/.claude.json`; an `env` block or
  `apiKeyHelper` in `~/.claude/settings.json` naming another provider (`ANTHROPIC_BASE_URL`, Bedrock, Vertex). "Provider
  anthropic" is a finding only when none of these says otherwise.
- Whether and where oh-my-pi keeps a sign-in among `config.yml` and its SQLite databases.
