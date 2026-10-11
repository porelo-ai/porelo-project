# PJ16 — An organisation decides which providers its machines use

**Status:** Analyzed. **Size:** L - several modules of `sokar` (start, follow, clearance, class, doctor) and the interface's side in `sokar-frontend`; nothing of it exists today.

**What must be true.** An organisation can say which model providers the tasks on its machines may
use, and a developer working on such a machine cannot widen that list - not by choosing another
provider at start, not with a provider definition of their own, not from inside a task.

## Why

A security officer allowing coding agents typically has one approved provider and must be able to
show that nothing else is used. Sokar holds the agent to the provider chosen for its task, but the
**choice** belongs to whoever starts it: any provider Sokar knows, or a definition of their own. So
"only the approved provider" is today the organisation's device policy, not Sokar's, and
`doc/corporate-security.md` says so.

## The shape

1. **A machine-wide policy only root can write**, e.g. `/etc/sokar/policy.yml`. Absent, nothing
   changes.
2. **Sokar refuses a start whose provider is not on the list**, before anything is made, naming the
   policy; a provider definition in an account's own directory does not widen it.
3. **It is visible**: `sokar doctor` and the interface show the policy and what it allows.
4. **The first version narrows four things**: the providers; no `--unverified` follow; no allow at a
   clearance prompt; no `online` class.
5. **A plain root-owned file first**, rolled out by the organisation's device management; a form
   signed with the organisation's key may follow.

It does not protect against a developer with root on their own machine - that is the device
management's job; Sokar enforces what it puts in place and makes breaking it visible. It does not
choose providers for the organisation; it decides which of Sokar's provider definitions a machine
allows.

## Plan

- **Today**: `sokar` reads no machine policy; `/etc/sokar/` holds only tmux files inside the image.
- **`sokar`**: a reader of `/etc/sokar/policy.yml` that trusts it only when root owns it, applied before
  anything is made in `TaskLaunch` (beside `SelectedProvider`), in the follow (`FollowSignedBy`,
  `--unverified`), at the clearance prompt (`clearance`), and on a project's class; a definition in the
  account's `providers/` checked against it; `DoctorCommand` names it. `sokar` [B151](https://github.com/sokar-ai/sokar/blob/main/issues/base/README.md#b151) (the providers a
  project allows) is the same check one level down.
- **`sokar-frontend`** [F62](https://github.com/sokar-ai/sokar-frontend/blob/main/issues/README.md#f62) shows the policy.
- **Seen to fail first:** a test with a policy allowing only `github-copilot` in which a start with
  `openrouter` starts.

## Acceptance

- With a policy allowing only `github-copilot`, a task started with `--provider openrouter` is refused
  before anything is made, naming the policy; with `github-copilot` it starts.
- A provider definition in the account's own `providers/` does not make a disallowed provider usable.
- With the further restrictions set, a follow `--unverified` is refused, a clearance prompt offers no
  allow, and a project of class `online` is refused - each naming the policy.
- `sokar doctor` names the policy and what it allows.
- Without a policy file, every existing behaviour is unchanged.

## To be checked

- Whether this and `sokar` [B151](https://github.com/sokar-ai/sokar/blob/main/issues/base/README.md#b151) are one mechanism at two levels, and which is built first - Agent Core's
  to decide.
