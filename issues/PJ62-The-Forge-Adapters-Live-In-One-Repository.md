# PJ62 — The forge adapters live in one repository

**Status:** Accepted.

**What must be true.** Every adapter Porelo uses to read a build server's builds or a forge's reviews, and later to
act on them, is built in one repository, `porelo-adapters` (named after [PJ66](README.md#pj66)), beside one contract
suite that each of them passes; `porelo-build-github` is renamed `porelo-adapters`, a `forgejo` adapter joins its
`github` one, and a person asks any of them through one command of Porelo's.

From [PJ39](README.md#pj39), sprint 3, and [PJ22](README.md#pj22) part 4: "The `forgejo` reader and one contract suite
in the API's kit, run against both readers."

## Why

The local forge's builds must be read as the central forge's are before a task can hear its verdict from Forgejo
([PJ61](README.md#pj61)). One repository for all adapters keeps one suite, one release and one way of packaging for
them, and its name leaves room for actions beyond reading - a failed job started again, a review's comments (porelo-build-github
[GH02](https://github.com/porelo-ai/porelo-build-github/blob/main/issues/README.md#gh02)) - which "reader" would
not.

## The shape proposed

- **New coordinates:** the parent `org.fuin.porelo:porelo-adapters`; the modules `porelo-build-contract` (the suite,
  published so an adapter outside the project can run it), `porelo-adapter-github` and `porelo-adapter-forgejo`. Each
  adapter is packaged as `.deb` and `.rpm` of the module's name and installed where Porelo looks today,
  `/usr/libexec/porelo/builds/<forge>`, so no project changes its file; `porelo-adapter-github` replaces the package
  `porelo-build-github` (Debian `Replaces`/`Conflicts`, RPM `Obsoletes`).
- **A rename, not a move:** the operator renames the repository `porelo-build-github` to `porelo-adapters` on the central
  forge when sprint 3 begins, so its history, issues, settings, secrets and variables and the organisation's grants
  stay as they are, and the central forge sends the old address on to the new one. Every place in the project that
  names the old repository - the project file's upstream, the documentation, the site, the local clones' remotes - is
  changed in the same round.
- **The contract stays Porelo's:** `porelo-build-api` and `org.fuin.porelo.Build1` stay in `porelo`. Its method
  `look` is renamed `build` under a new protocol version, so an adapter of the old one is refused by name, as an
  unknown version is today; every adapter is released anew with it.
- **The suite** (porelo [B253](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b253), its home
  moved here): a branch's head and an absent branch; a commit with no build, queued, running, passed, failed and
  cancelled; the logs of `failure` and of `all`, with the bounds of 64 KiB a log, 50 jobs and 2 MiB; each refusal
  (`RateLimited`, `CredentialRefused`, `NoSuchRepository`, `Unreachable`); all from recorded answers, so CI calls no
  forge. Forgejo's answers are recorded once from a Forgejo run in podman.
- **The command, in `porelo`** (*new, `porelo`*): `porelo build status --project=<project>
  --repository=<repository> --branch=<branch>`, or `--commit=<sha>`, with `--logs=none|failure|all` (default
  `failure`) and `--json`; `-p` and `-r` as in `porelo task start`. The project and the repository are named by their
  keys, never a URL: the adapter, its address and its credential come from the project file's `builds:`, the token
  from the vault, and it appears nowhere. A project without `builds:`, `default` among them, is refused naming why.
- **Nothing new to grant:** the rename keeps the repository's grants; Maven Central takes the new artifacts under the
  namespace `org.fuin.porelo` it already publishes to.

## Acceptance

- `porelo build status` against GitHub names the commit, the verdict, the jobs and a failed job's log, for one red
  and one green Build; against a Forgejo in podman it answers in the same shape.
- Both adapters pass the same suite; an adapter changed to answer one case wrongly fails it.
- After installing `porelo-adapter-github` in place of `porelo-build-github`, an `online` task's verdicts arrive as
  before.

## To be checked

- Whether the `forgejo` adapter is the `github` one with another address, as Forgejo's Actions API is GitHub's in
  shape; if the suite proves it, the module stays thin.
