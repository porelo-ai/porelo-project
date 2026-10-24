# PJ69 — A machine reaches the forge with the person's token

**Status:** Implementing; built in its two parts, `porelo` [B269](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b269) and `porelo-frontend` [F153](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f153), held for porelo-frontend's push.

**What must be true.** A machine reaches a project's repositories and the forge's API with the person's own
credentials, kept in the machine's vault: for git, the person's ssh key or their token, for the forge's API, their
token. Porelo no longer makes a deploy key per machine and repository at the forge, and no longer removes them. A
person in a company, who may not create access keys on the company's repositories, can use Porelo with the key or
token they already have.

## Why

Today the interface makes one deploy key per machine and repository at the forge, titled after the machine,
read-only for the project's own repository and with write access for a work repository. It removes them when a
machine or project is cleared, which is why it needs the person's token with the forge's right to manage deploy
keys (*Administration* at GitHub).

- **A company seldom lets a person create deploy keys** on its repositories. The right to administer a repository is
  usually the company's, not the developer's. So the default way blocks the people Porelo is meant for.
- **The token is needed anyway:** the interface holds it to make the keys. With a token on the machine, the keys add
  a second set of credentials, a step at the forge and a cleanup, but no access the token does not already give.
- **A machine can already reach its upstream with a token:** porelo's `doc/credentials.md` names the upstream as
  "reached with an ssh key or a token", and the key or token is lent to the gate from the vault and never enters a
  task.

## The shape proposed

- **What a machine needs depends on the forge's function** (decided):

  | Function of the forge | Examples | Credential |
  |---|---|---|
  | Git | clone, fetch, push to a project's repositories | the person's ssh key (`ssh` address) or their token (`https` address); both stay |
  | The forge's API | build status, runs and logs, reviews, releases | the person's token only; an ssh key cannot reach an API |

  Each is stored in the machine's vault through a terminal or the forge's own login, never through a form of the
  interface (the operator's rule), and lent to the gate as the ssh key is today. Which credential a service of an
  adapter needs, it says itself ([PJ66](README.md#pj66)).
- **Deploy keys per repository go entirely** (decided): no machine gets one, and Porelo neither makes nor removes them
  at any forge.
- **One token per person, the person's own PAT, at every forge** (decided): where a function takes a token, the
  person's machines and this computer use it; no computer or machine keeps a token of a kind of its own.
- **Only the person's own token for now** (decided): this is about the kind of token, not about ssh. A token of a
  machine's own, such as a machine user's or a GitHub App's, can be added later as another credential of the same
  kind. The person's own ssh key stays a way for git.
- **The token needs only the rights the work needs** (read the project's repository, write the work repositories), no
  longer *Administration*.
- **What goes with them:** the deploy-key steps of following, clearing and unfollowing; `doctor`'s report of unused
  deploy keys; the interface's making and removing of keys and its decision "A forge's token stays on this computer;
  a machine gets deploy keys of its own".

## Parts touched

- `porelo`: the machine's way to the upstream, `doc/project-file.md` *Deploy keys*, `doc/credentials.md`, clearing,
  `doctor`.
- `porelo-frontend`: its forge page, the deploy keys it makes and removes, and the decision in its `doc/decisions.md`;
  together with its issue for the forge's token typed only in a terminal.
- `porelo-host`: whatever a rented host's set-up does for the forge's access.

## Open

- `porelo credentials deploy-key` goes with the keys. A repository's `ssh` address keeps working with the person's
  key (`git.ssh.<host>`); its `https` address takes the token (`git.token.<host>`), as porelo serves both today.
- The forge's own expiry of a token; a machine telling its person that it needs a new one is [PJ70](README.md#pj70).
