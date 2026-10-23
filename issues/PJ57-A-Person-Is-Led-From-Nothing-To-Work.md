# PJ57 — A person is led from nothing to work

**Status:** Accepted; built in sprints 3 and 4 of release 0.7, the usability release, after porelo-project [PJ39](README.md#pj39).

**What must be true.** A person who wants to work with Porelo is led from an empty machine to their
first reviewed work by one guide, the Porelo Wizard. It asks first what the person has and wants, plans
every step that follows from the answers before the first one runs, keeps the progress so it can be
stopped and taken up again, and hands a step that someone else must do - an administrator with root, a
forge's administrator, a provider - to that person with instructions of its own. Beside it, a chat
answers the person's questions about the step they are on.

## Why

Setting Porelo up touches many parts, each documented in its own repository: the machine and its
packages, `porelo setup`, the vault, an agent's sign-in, the forge's keys and tokens, a project and its
file, messaging, a rented host. The interface guides some of them already - a new machine
(`SetupRun`, saved and resumable), reaching a machine, the vault in a terminal it opens, signing in,
starting work in `default` (porelo-frontend `integration_test/a_new_person.feature`) - but each as a
wizard of its own, with no plan across them.

What a person meets today without a guide:

- **Steps that need a terminal or Porelo's own words:** the SELinux policy, writing and signing
  `project.yml`, the hosting provider's key and console, the drive's layout and the machine file, the
  VPN client, a Matrix client, `gpgcheck=0` on Fedora, the remedies `porelo doctor` names.
- **Steps that need someone else:** packages, the task account and SELinux (root); deploy keys, the
  approval of a fine-grained token and the forge's administration right (the forge's administrator);
  the project's signing key's fingerprint and enrolment approvals (the project's maintainer); a
  central homeserver's registration token and invitations (its administrator); a provider's key or
  subscription and a hosting provider's quota (the account's owner); a company's CA and policy
  (security).
- **Gaps no document closes:** an outbound HTTP proxy, branch protection at the forge, a forge
  organisation's approval of a token.

## The shape proposed

- **A repository of its own, `porelo-wizard`, with an agent of its own.** It holds the Porelo Wizard:
  what can be set up, how a plan is made from a person's answers, how progress is kept, and the
  instructions for each role. The interface (porelo-frontend) shows it, and Porelo and porelo-host
  carry out its steps; neither holds the catalogue.
- **A catalogue of steps, kept centrally in `porelo-wizard` first**, as data, versioned. Each step
  says who does it (the person, an administrator, a forge's administrator, a provider), how often (per
  machine, account, project or repository), what must be done before it, how to check it is done
  (`porelo doctor --json`, `vault status`, `agents --json`, `project following --json`, and new
  checks where none exist), what it runs, what it asks for (names, choices; a secret only by where it
  will be kept, never its value), and the instructions for whoever does it. Splitting the catalogue
  so that each repository ships its own steps, as an agent ships its definition, comes later if the
  central one grows too large.
- **A plan before the first step:** the questions first (where Porelo runs - this computer, a machine
  over ssh, a machine rented for it, Windows with WSL; which agent and how it signs in; a project of
  one's own or `default`; messaging; a company's CA or proxy; which forge), then only the steps those
  answers need, in their order, shown before anything runs.
- **Progress kept and taken up again:** the plan and each step's state are kept on the person's
  computer. A step's check decides whether it is done, so a step done elsewhere - by an administrator,
  or by hand - is seen as done when the wizard is taken up again.
- **Hand-overs:** a step for someone else is given to them as instructions they can read and as a file
  they can run, for a step that can run without a person; the wizard waits for its check.
- **A chat beside the wizard, in the interface, from the first step:** it answers questions about the
  current step from the documentation of every repository, the plan and the output of the checks. It
  never sees a secret: a passphrase, a token or a key is typed in a terminal and kept in the vault, as
  today. It proposes and explains; it runs nothing the person has not confirmed. It runs in the
  interface with an access of its own, since Porelo and its agents are not set up yet when it is first
  needed.
- **The chat's access is an agent already on the computer**, one Porelo may use without breaking its
  terms: the wizard finds what is installed and signed in there and proposes it, and the person may
  sign in to another provider instead. Claude Code first, since Porelo supports it already; Codex CLI
  and others later. An agent whose terms forbid such use, as Antigravity's sign-in may, is not
  proposed.
- **The chat is built on `flutter_ai_toolkit`** (the Flutter team's chat widget, BSD-3) with providers of
  Porelo's own behind its `LlmProvider` interface: first one that runs Claude Code without a person
  (`claude -p --output-format stream-json`, no tools beyond reading, in the documentation's directory)
  and streams its answer; Codex CLI (`codex exec --json`) and a provider over an API key later. The
  widget is the toolkit's; only the providers are Porelo's.
- **Running without a person, from the first version:** the same plan runs from a file of answers,
  for many machines or a company's rollout; a step that must stay attended (a passphrase, a sign-in in
  a browser) stops it and says so.
- **The core of the usability sprint**: the steps of "Next: Usability" in the index - work in
  `default` without a project, the agent signed in on the machine as the default, the drafts of a
  project from a checkout - become steps in its catalogue.

## Open questions

- **What the person is told** about what the chat sends to the agent's provider, and how they choose
  another.
- **Where the catalogue's format is checked**, and how a step's instructions stay true when the
  repository that does the step changes.

## To be checked

- What of porelo-frontend's `SetupRun`, its new-machine wizard and its host dialog carries over, and
  what moves into the catalogue.
- Which checks Porelo lacks today to say whether a step is done, beyond `doctor`, `vault status`,
  `agents` and `project following`.
- Which steps can run without a person at all, and which must stay attended (a passphrase, a sign-in in
  a browser).
