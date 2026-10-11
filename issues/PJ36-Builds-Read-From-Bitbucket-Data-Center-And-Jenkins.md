# PJ36 — Builds read from Bitbucket Data Center and Jenkins

**Status:** Idea.

**What must be true.** A task in an `online` project whose repository is on Bitbucket Data Center and whose
builds run on Jenkins is told what the build of its push did, as a task on GitHub is today: the commit it
pushed found among Jenkins' builds, the verdict, the stages and the failed stages' logs - read on the host,
with no credential in the task. A build server is not bound to one forge: Jenkins read for a repository on
Bitbucket is the same reader as for one on GitHub or GitLab.
