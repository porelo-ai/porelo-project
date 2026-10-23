# PJ65 — What is left of each provider's limits is shown

**Status:** Idea.

**What must be true.** A person sees, for every account their agents spend on, what is left of its limits and when it
comes back - a subscription's share of its window, an API key's tokens or money, a forge's AI credits, a company's
budget for each developer - in one view, read from the provider where it can be read and marked as estimated where it
cannot. Several accounts of the same kind are told apart, such as two Claude Code subscriptions.

## Why

The agents now run on several accounts at once, and each runs out differently. On one working day the operator's
Claude and GPT pool through Antigravity fell from 100 % to 18 % of its five-hour window, and the coordinator could see
it only by asking the CLI by hand. Codex's weekly share was known only from the operator's screen. Work was then moved
between models by hand.

The billing models differ widely:

- **A subscription** shows a share of a time window - five hours, a week - with the time it resets, and sometimes
  several windows at once.
- **An API key** has tokens or money per period, and short rate limits per minute.
- **A forge** such as GitHub counts AI credits of its own.
- **A company** often gives each developer a budget of tokens or credits.

A person may hold several at once: two Claude Code subscriptions, one ChatGPT, one Google, and a key for OpenRouter.

## The shape proposed

- **Where the accounts come from, per person** (to start with): what Porelo already keeps for each person's own account
  on a machine. `porelo providers` lists the providers declared there (data files under
  `~/.local/share/porelo/providers` and `/usr/share/porelo/providers`), which agents use each, and what the person's
  vault holds for each: an API key, or a subscription's sign-in. Each such vault entry is an account; nothing is
  configured twice.
- **An account** is one thing that is billed: a provider, the identity it bills (a subscription, a key, a seat in an
  organisation), and a name the person gives it. **Today a vault entry is named by its provider**, so one person holds
  one account per provider; two Claude Code subscriptions need entries named apart (for example `anthropic` and
  `anthropic.work`), each naming its provider, and the start of a task names the account it spends on.
- **An account has meters, each of one kind:**
  - a share of a window, in %, with the window's length and its reset time;
  - a quota of tokens, used and allowed, per period;
  - credits, such as a forge's AI credits, used and allowed, per period;
  - money, spent and capped, per period;
  - a rate, per minute, which is short-lived and shown only while it limits.

  Each meter says when it was read and where from: read from the provider, or counted by Porelo and therefore
  estimated.
- **Each provider's adapter reads its meters** where the provider tells them: a CLI's usage command, an API's usage or
  key endpoint, response headers, a forge's billing API. Where nothing can be read, Porelo's own count of what its tasks
  spent (porelo [B148](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b148)) stands in, marked as
  estimated. The adapter keeps no credential of its own: it takes the vault's per call, as build readers do.
- **One view, on the command line and in the interface,** drawn from the daemon's answer as `porelo providers` is
  today, so the interface reads what the command line reads: every account, its meters, what is left and when it comes
  back, and which running tasks spend on it. A meter below a threshold the person sets is shown as warned.
- **Later, tied to [PJ64](README.md#pj64):** a rule that moves work to another account when a meter runs low, set by
  the operator as a rule for a time, named at every start it changes.

## Built in

- **`porelo`:** the account as a vault entry naming its provider, several per provider; the meters' model; the
  daemon's answer and `porelo limits` on the command line; the estimate from its own count.
- **The providers' and agents' adapters:** each reads the meters its provider tells.
- **`porelo-frontend`:** one view of every configured account, each with its provider's own kind of meters drawn as
  that kind reads best - a window's share as a bar with its reset time, a quota or credits as used of allowed, money
  as spent of its cap - estimated ones marked as such, and the warned ones first.

## Open questions

- Which accounts to read first. Proposed: Claude Code, Codex and Antigravity, as used daily; then OpenRouter and an
  API key; then GitHub's AI credits and a company's budget.
- Whether a forge's AI credits belong here, or with the forge's own adapter.
