# PJ36 — Builds read from Bitbucket Data Center and Jenkins

**Status:** Idea.

**What must be true.** A task in an `online` project whose repository is on Bitbucket Data Center and whose
builds run on Jenkins is told what the build of its push did, as a task on GitHub is today: the commit it
pushed found among Jenkins' builds, the verdict, the stages and the failed stages' logs - read on the host,
with no credential in the task. A build server is not bound to one forge: Jenkins read for a repository on
Bitbucket is the same reader as for one on GitHub or GitLab.

## The shape proposed

- **Two roles, two readers.** `builds.forge` answers `head` (where a branch points: the repository's host);
  a new `builds.server` answers `look` (what the build of a commit did: the build server). Unset, the forge's
  reader answers both, as today.
- **`sokar-build-bitbucket`** answers `head`, and `look` where Bitbucket itself builds or holds the build status.
  **`sokar-build-jenkins`** answers `look`, finding a commit's build among Jenkins' jobs; it serves any forge.
- **Bitbucket comes in two variants with different APIs:** Cloud (`api.bitbucket.org`, REST 2.0, workspaces,
  its own Pipelines) and Data Center (on the organisation's host, REST 1.0, projects, the build-status API that
  Jenkins or Bamboo report to). They are two forge names, `bitbucket-cloud` and `bitbucket-datacenter`, two
  executables from one repository, sharing what they can. **Data Center first**, with Jenkins; a test
  installation runs as a container on a VM under an evaluation licence.
- **Each reader has its own credential**, so the contract keeps one address and one token a call.
