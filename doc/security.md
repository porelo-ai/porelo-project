# Reporting a vulnerability

Whoever finds a security problem in Porelo reports it privately, never in a public issue, a pull
request or a discussion.

## How to report

Open the repository the problem is in on GitHub, choose **Security**, then **Report a
vulnerability**. That is GitHub's private vulnerability reporting: the report is seen only by the
repository's maintainers and by you. Say what is affected, how it is reproduced and what it allows.
If you are unsure which repository it belongs to, report it in
[porelo](https://github.com/porelo-ai/porelo).

## What is in scope

Every Porelo repository and the packages built from it: the CLI, the daemon and the gate, the
interface, the message filter and transports, the packaged agents, and the build and test tooling.
A problem in an agent or a provider Porelo packages is reported to its own maintainers; tell us
too if Porelo makes it worse.

## What happens next

- **A first answer comes within 7 days**, saying whether the report is taken up.
- The fix is made privately and released.
- Then a **GitHub security advisory** is published in the affected repository, naming the versions
  affected and the version that fixes it, and the repository's changelog says what was fixed.
- **You are credited in the advisory**, unless you ask not to be.
