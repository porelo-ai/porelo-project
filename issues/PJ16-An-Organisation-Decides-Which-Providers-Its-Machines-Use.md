# PJ16 — An organisation decides which providers its machines use

```json
{
  "$schema": "issue-1.json",
  "id": "PJ16",
  "title": "An organisation decides which providers its machines use",
  "state": "Analyzed",
  "size": "L",
  "priority": "Medium",
  "rank": 5,
  "blockedBy": [],
  "covers": "A root-owned machine policy names the providers tasks may use, and narrows follows, prompts and the `online` class; a developer cannot widen it."
}
```

**Why this size.** several modules of `porelo` (start, clearance, class, doctor) and the interface's side in `porelo-frontend`; nothing of it exists today.

**What must be true.** An organisation can say which model providers the tasks on its machines may
use, and a developer working on such a machine cannot widen that list - not by choosing another
provider at start, not with a provider definition of their own, not from inside a task.

## Why

A security officer allowing coding agents typically has one approved provider and must be able to
show that nothing else is used. Porelo holds the agent to the provider chosen for its task, but the
**choice** belongs to whoever starts it: any provider Porelo knows, or a definition of their own. So
"only the approved provider" is today the organisation's device policy, not Porelo's, and
`doc/corporate-security.md` says so.

## The shape

1. **A machine-wide policy only root can write**, e.g. `/etc/porelo/policy.yml`. Absent, nothing
   changes.
2. **Porelo refuses a start whose provider is not on the list**, before anything is made, naming the
   policy; a provider definition in an account's own directory does not widen it.
3. **It is visible**: `porelo doctor` and the interface show the policy and what it allows.
4. **The first version narrows three things**: the providers; no allow at a clearance prompt; no `online`
   class.
5. **A plain root-owned file first**, rolled out by the organisation's device management; a form
   signed with the organisation's key may follow.

It does not protect against a developer with root on their own machine - that is the device
management's job; Porelo enforces what it puts in place and makes breaking it visible. It does not
choose providers for the organisation; it decides which of Porelo's provider definitions a machine
allows.

## Plan

- **Today**: `porelo` reads no machine policy; `/etc/porelo/` holds only tmux files inside the image.
- **`porelo`**: a reader of `/etc/porelo/policy.yml` that trusts it only when root owns it, applied before
  anything is made in `TaskLaunch` (beside `SelectedProvider`), at the clearance prompt (`clearance`), and on a
  project's class; a definition in the
  account's `providers/` checked against it; `DoctorCommand` names it. `porelo` [B151](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b151) (the providers a
  project allows) is the same check one level down.
- **`porelo-frontend`** [F62](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f62) shows the policy.
- **Seen to fail first:** a test with a policy allowing only `github-copilot` in which a start with
  `openrouter` starts.

## Acceptance

- With a policy allowing only `github-copilot`, a task started with `--provider openrouter` is refused
  before anything is made, naming the policy; with `github-copilot` it starts.
- A provider definition in the account's own `providers/` does not make a disallowed provider usable.
- With the further restrictions set, a clearance prompt offers no allow, and a project of class `online` is refused -
  each naming the policy. A follow without a signature no longer exists: a host follows only what its organization signed.
- `porelo doctor` names the policy and what it allows.
- Without a policy file, every existing behaviour is unchanged.

## To be checked

- Whether this and `porelo` [B151](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b151) are one mechanism at two levels, and which is built first - Agent Core's
  to decide.
- Whether this becomes one case of `porelo` [B198](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b198),
  settings inherited down an organisation's tree: the allowed providers a locked setting of the organisation's
  file, the root-owned policy file its pinned top. To be folded in when that is analysed.
