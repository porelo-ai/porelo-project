# PJ54 — The ChatGPT sign-in is a provider

**Status:** Accepted; waits here until `porelo` takes it up.

**What must be true.** A task's Codex CLI is served models through the person's ChatGPT sign-in, brokered
on the host like the supported sign-ins, with the real tokens never in the container. It is a provider
of its own beside the API key of `porelo` [P05](https://github.com/porelo-ai/porelo/blob/main/issues/providers/README.md#p05).

## Why

Measured in porelo-codex [CX01](https://github.com/porelo-ai/porelo-codex/blob/main/issues/README.md#cx01),
with Codex CLI in a rootless container and a relay on the host:

- **The credential** is an OAuth sign-in with `access_token`, `account_id`, `id_token` and
  `refresh_token`, made through a device-code flow.
- **The model route** is `chatgpt.com`, `POST /backend-api/codex/responses`. The broker replaces the
  client's dummy bearer with the access token and adds the account id as `ChatGPT-Account-Id`.
- **The refresh** is `POST auth.openai.com/oauth/token` with `grant_type=refresh_token`; it rotates the
  refresh token, so the broker stores the new one before it uses it.
- **The CLI also contacts `ab.chatgpt.com`** at start-up.

**The accepted risk.** The route is the ChatGPT subscription's own backend, not a documented API: it
can change without notice, and whether the provider's terms allow it was not checked. It stays
because Codex CLI is mostly used with that subscription; a change of the route or a refusal by the
provider would change the answer.

## Acceptance

- A task's Codex CLI answers through the person's ChatGPT sign-in, and the container holds none of its
  tokens, seen by searching the container for them.
- A rotated refresh token is kept when the broker is interrupted after the refresh.
- Whether `ab.chatgpt.com` is allowed or refused is decided and enforced.

## To be checked

- Which provider identity and contract version porelo-codex builds against.
