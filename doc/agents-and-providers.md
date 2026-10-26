# Agents and providers compared

Every agent and provider set beside each other: which of them can be brokered at all, what that
costs, and which to build next. Each claim says whether it was measured; a candidate found
unsupportable stays here, so the question is not asked twice.

Two axes that are easy to conflate. The **agent** is the harness that runs in the
box and is what Porelo packages. The **model provider** serves the model and is something
an agent talks to. Some agents are tied to one provider, some deliberately are not,
and a provider with no agent of its own is reached through somebody else's.

The column that decides everything is the last one. Brokering only works if the
agent can be pointed at a different endpoint - that is what lets a task hold a
task-scoped token while the real credential stays on the host. An agent that can
only reach its vendor's endpoint cannot be brokered, and would have to be given the
real credential or go unsupported.

## Agents

| Agent | Provider(s) | Tied to one? | Authentication | Redirectable endpoint? |
|---|---|---|---|---|
| Claude Code | Anthropic; also three cloud vendors | model yes, endpoint no | subscription token or API key | **yes**, verified |
| Codex CLI | OpenAI | yes | ChatGPT sign-in or API key | **yes**, verified - a custom provider's base URL, for both |
| Antigravity CLI (`agy`) | Google; Gemini, Claude and gpt-oss models | yes | Google sign-in tied to an AI plan, or a Gemini API key | **yes** for the API key, measured - `GOOGLE_GEMINI_BASE_URL` with `modelProvider: gemini`; the sign-in unverified |
| GitHub Copilot CLI | GitHub Copilot | yes | forge account, device flow, or a token on standard input | **yes**, by environment variable (BYOK), which is not the subscription |
| Grok Build | xAI | yes | subscription account | unverified |
| OpenCode | many, per session | **no** | key, sign-in, or variable | **documented** |
| Pi | several; Anthropic, OpenRouter and GitHub Copilot measured | **no** | key, variable, or sign-in with refresh | **yes**, verified - by an extension, not a variable |
| Oh My Pi | many, per provider, ranked | **no** | key, variable, or a host-side grant (GitHub Copilot) | **yes**, verified - a base URL in its `models.yml` |

Ordered by reported usage among professional developers, except the last three: Grok
Build is too recent for usage to mean anything, Pi is here because it is
provider-agnostic and small enough to be a fair test of the onboarding path, and Oh My Pi
is a fork of a different project of the same shape, listed so the two are not confused
again.

## Providers

| Provider | Reached how | Credential | Consequence |
|---|---|---|---|
| [Anthropic](https://github.com/porelo-ai/porelo/blob/main/doc/credentials.md#the-providers-porelo-ships) | its own agent, natively | subscription token or API key | the case already built |
| [OpenRouter](https://github.com/porelo-ai/porelo/blob/main/doc/credentials.md#the-providers-porelo-ships) | any agent speaking the OpenAI dialect | API key, as a bearer token | the second case built, and the first with an agent not its own |
| [OpenAI](https://github.com/porelo-ai/porelo/blob/main/issues/providers/README.md) | its own agent, or any speaking its dialect | account or API key | the most imitated dialect |
| [Google](https://github.com/porelo-ai/porelo/blob/main/issues/providers/README.md) | its own agent, or a provider-agnostic one | account or API key | one agent each |
| [GitHub Copilot](https://github.com/porelo-ai/porelo/blob/main/doc/credentials.md#the-providers-porelo-ships) | its own agent, or as a provider inside others | forge account, granted once by device flow; the token never expires | shipped, measured with two agents |
| [xAI](https://github.com/porelo-ai/porelo/blob/main/issues/providers/README.md) | its own agent, or its public API | subscription or API key | one agent each |
| [Zhipu](https://github.com/porelo-ai/porelo/blob/main/issues/providers/README.md) | an endpoint compatible with another vendor's dialect | API key, in a variable of its own | **the broker's destination endpoint cannot be a constant** |

Pi reaches GitHub Copilot through the broker, with the sign-in on the host
([a subscription granted once](https://github.com/porelo-ai/porelo/blob/main/doc/credentials.md#a-subscription-granted-once-github-copilot)).

## What a provider-agnostic agent already models

The agents in the lower half of the table treat the provider as a first-class thing
of its own, separate from the agent, and that shape is worth adopting rather than
rediscovering:

- **A provider carries its own identity, default model, and credential lookup** -
  typically an ordered list of environment variables to fall back through.
- **Authentication is per provider and comes in three shapes**: an environment
  variable, a stored static key, and an interactive sign-in that yields a token
  **plus a refresh flow**.
- **The endpoint is overridable per provider**, at least for the ones speaking a
  common API dialect. That is the property brokering depends on, and it exists by
  design there rather than by accident.
- **Adding one is a declaration plus a registry entry**, not a change to the agent.
- **Credentials land in one store** rather than one file per provider, and at least
  one agent lets a stored value be written as a reference to an environment variable
  instead of a literal. That indirection is the cleanest thing Porelo could ask for:
  no file to seed, no format to imitate, just a variable already being injected.

Two of those land directly on Porelo's own design:

- The vault entry is keyed by **model provider** name. An agent that talks to several
  model providers uses each provider's credential; agents using the same provider share
  that entry.
- A **refresh flow is a problem for a task-scoped token**. An agent holding what it
  believes is an expiring credential will try to renew it, and a phantom token
  cannot be renewed by anyone but the broker that minted it. Either the proxy
  answers refresh as well as use, or the token must be presented in a form the agent
  will not try to refresh.

## Not yet known

- **Which of these can actually be redirected**, and how. It is the single fact that
  decides whether an agent can be brokered, and it is not reliably documented -
  establishing it for an agent can take a local listener and a raw socket.
- **Subscription-gated agents are the risky shape.** Two rows require a paid account
  rather than a key, and that is the shape that already cost the most: a session
  verified with the vendor before anything runs, over a path that ignores whatever
  endpoint the agent was given.
- An agent that authenticates by account sign-in rather than by a key may verify the
  session with its vendor before use. That check does not go through a redirected
  endpoint, so it has to be reachable, which widens what the box may contact.
- Token refresh: unanswered, it limits the candidates to those authenticating with a static key.
