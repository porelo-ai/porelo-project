# PJ76 — A pull request's commits checked alike on both forges

**Status:** Idea.

**What must be true.** The *Shared rules check* of a pull request passes or refuses on the host's private forge as it
does on GitHub: it reads the pull request's commits without a credential in the job, and it tells a member's pull
request from an outsider's by one rule that holds on both forges, so an agent's commit needs no `Signed-off-by:` and
an outsider's still does.

## Why

On the host's forge the step that checks a pull request's commit messages fails twice. Its second `git fetch` after a
checkout without credentials cannot read a private repository, which GitHub's public one never needed. And Forgejo
sends no `author_association`, so every pull request there counts as from outside. The same step is in the
`shared-rules.yml` of porelo, porelo-adapters, porelo-ai.github.io, porelo-host, porelo-buildtools,
porelo-message-matrix, porelo-frontend and porelo-message-sluice. A checkout of the whole history, and a repository
variable listing the members' logins, are the ways proposed so far; who counts as a member is a trust decision.
