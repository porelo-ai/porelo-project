# PJ61 — The project porelo is online with the local forge upstream

**Status:** Accepted.

**What must be true.** The project `porelo`'s file names the local Forgejo as its upstream: a task's push passes through
its gate to the branch `porelo/<task>` on Forgejo at once, Forgejo builds it, the task reads the verdict through the
`forgejo` reader, and the work reaches the central forge only through the push mirrors after the operator approved it.

From [PJ39](README.md#pj39): "The project `porelo` becomes `online`, its upstream the local Forgejo of
[PJ22](README.md#pj22). A task's push goes to its gate, which passes the branch `porelo/<task>` on to Forgejo at once;
nothing of it is public."

## Why

This is the switch that makes the local forge the agents' forge. Everything it needs is built elsewhere; what is left
is this project's `project.yml` and the proof that the whole way works for one repository before the first agent
moves ([PJ59](README.md#pj59)).

## The shape proposed

- **`project.yml`:** `online`, each repository's upstream on the local Forgejo, `builds:` read by the `forgejo` reader
  (porelo [B253](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b253)), the reader's token a
  destination through the broker, which trusts the host's authority (porelo-host
  [HO17](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho17)).
- **To the central forge only after approval:** the push mirrors (porelo-buildtools
  [BT06](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt06)) start once the operator
  approved a task's work.
- **Proved on porelo-message-sluice first:** a task pushes, Forgejo builds on the pool, the task reads the verdict, the
  operator approves, the mirror reaches the central forge.

## Acceptance

- A task's push of porelo-message-sluice reaches Forgejo as `porelo/<task>`, is built there, and its verdict and the
  log of a failed job are in the task's `/porelo/files`.
- Nothing of it reaches the central forge before the operator's approval; after it, the mirror does.
- Seen to fail first: the same push with the project `offline` reaches no forge.

## To be checked

- Whether the project file's signature and `follow --signed-by` need anything new for an upstream on the host.
