# PJ08 — An unattended job's refusal reaches a person

**Status:** Estimated. **Size:** L - crosses about six repositories' workflows after a decision on where a refusal lands; each change itself is a few lines.

**What must be true.** Where a job nobody is watching refuses something, the refusal reaches a person.

## Why

The weekly update runs of `porelo-pi` and `porelo-omp` end with GitHub refusing to let Actions create a
pull request. `porelo-pi`'s licence gate answered correctly, and the pull request that would have
carried its verdict to somebody could not be opened, so the finding existed only in a run log nobody
opens. That is worse than a gate that fails, because every place a person looks reports success.

The mechanism is an organisation setting - *Allow GitHub Actions to create and approve pull
requests* - which belongs to no repository. The class is wider: what made it expensive is that the
run was **unattended**. A workflow that runs because somebody pushed or dispatched it has a reader by
construction; a scheduled one needs a place its refusal lands.

## The shape

- **The organisation setting is on**: *Settings → Actions → General → Workflow permissions → Allow
  GitHub Actions to create and approve pull requests* in `porelo-ai`. It covers every workflow that
  opens a pull request, and needs no token of its own; whether the weekly update now opens its pull
  request is measured by running it once by hand. It does not address
  the class on its own: a refusal that is not a pull request still needs a place to land.
- **Every unattended job is listed**, per repository, with where its refusal lands.

## Plan

- **Decided:** the organisation setting *Allow GitHub Actions to create and approve pull requests* is on.
- **Decided:** a refusal lands as a red run whose last step writes an `::error` annotation naming the reason, with a step summary; no issue is opened.
- **Decided first, by the operator**: the organisation setting switched on, and the place a refusal
  lands.
- **Run once by hand**: `update.yml` in `porelo-pi`, `porelo-omp` and `porelo-claude-code`, to see whether
  the pull request now opens.
- **The unattended jobs, read in today's workflows** (scheduled, or started by `workflow_run`):
  `sweep.yml` in `porelo`; `update.yml` in `porelo-pi`, `porelo-omp` and `porelo-claude-code`; `machines.yml`
  in `porelo-buildtools`; `site.yml` in `porelo-ai.github.io`; `delete-runs.yml` in every repository. The
  list, with where each refusal lands, is kept per repository.
- **Each job gets a last step that reaches the chosen place on failure**, built by each repository's
  agent from a handover.
- **Seen to fail first:** each job made to refuse on purpose, by hand, and the refusal not arriving.

## Acceptance

- No scheduled or otherwise unattended job in any repository can refuse something without the refusal
  reaching a person, seen by making one refuse on purpose.
- Every unattended job is listed, per repository, with where its refusal lands; a job whose answer is
  only its run log fails this.

## To be checked

- How many unattended jobs there are: `porelo-message-sluice` has none, `porelo-pi` and `porelo-omp` have
  the weekly update; each other repository reports its own. - the coordinator's to confirm with each
  repository's agent, against the list in *Plan*.
