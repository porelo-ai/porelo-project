# PJ57 — A person is led from nothing to work

```json
{
  "$schema": "issue-1.json",
  "id": "PJ57",
  "title": "A person is led from nothing to work",
  "state": "Analyzed",
  "size": "XL",
  "priority": "Medium",
  "rank": 7,
  "blockedBy": [],
  "covers": "The Porelo Wizard, in a repository of its own with an agent of its own: questions first, a plan of every step, progress kept and taken up again, hand-overs with instructions to an administrator or a forge's, and a chat beside it in the interface; the core of the usability sprint."
}
```

**How it stands.** Built in sprints 11 and 13 of release 0.7, the usability release, after porelo-project [PJ39](README.md#pj39).

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
  `project.yml`, the hosting provider's key and console, the machine file, a Matrix client, `gpgcheck=0` on Fedora, the remedies `porelo doctor` names.
- **Steps that need someone else:** packages, the task account and SELinux (root); deploy keys, the
  approval of a fine-grained token and the forge's administration right (the forge's administrator);
  the project's members, its repositories and the signature on its file (the project's admin); a
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
  (`porelo doctor --json`, `vault status`, `agents --json`, `project list --json`, and new
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

**Why this size.** XL: it crosses four repositories (porelo, porelo-frontend, a new porelo-wizard with an agent of its
own, porelo-project) and makes a new repository. It is built as the six issues of L or smaller that *Plan* names.

## Plan

Read in today's code: porelo main (Agent Core) and porelo-frontend `st314-flow-walk`. The window already has a wizard
that keeps its progress and takes it up again: `lib/src/app/setup_run.dart`, with the steps key, where, prepare, reach,
vault, drive and harden, kept in the settings after every step. Its other wizards are separate pieces:
`lib/src/ui/new_machine.dart`, `lib/src/ui/host_dialog.dart` and `lib/src/app/server_setup.dart`, about 2.4 k lines.
The window reads porelo over varlink, not the CLI. It already has `Doctor`, `FirstStart`, `Credentials`,
`AgentSignIns`, `Projects`, `CheckProjectFile`, `Keyslots`, `MessageMembers` and `DeployKey`.

1. **porelo: one readiness check per step** (M, Agent Core). A daemon method `Readiness(step)` answers
   `{state, detail, remedy}`, the shape `Doctor`'s findings already have. It is built from doctor's probes and three
   new ones: an agent can start (today only a provider grant in `Credentials` says so), a repository's deploy key and
   forge token are present (by where each is kept, never its value), and the task account is in place.
   `porelo doctor --json --step <name>` gives the same answer on the CLI. The wizard reads one shape, not a dozen.
   A project's signed file (`project verify --json`) and messaging (doctor's messages and transports) are already
   covered.
2. **porelo-wizard: the catalogue** (L, new repository and agent). The step catalogue as data with a JSON schema. Each
   step names who does it, how often, what comes before it, its `Readiness` step, what it runs, what it asks for
   (a secret only by where it is kept) and its instructions per role. The repository's CI checks every step against the
   schema, and checks that each `Readiness` name is one porelo answers. The first steps are the window's seven
   `SetupStep`s, `porelo setup`, the vault, an agent's sign-in, and work in `default`.
3. **porelo-frontend: the plan and its progress** (L). The questions first, then the plan of only the steps the
   answers need, shown before anything runs. Progress is kept the way `SetupRun` keeps it today. A step is done when
   its `Readiness` says so, also when someone else did it by hand. `SetupRun`'s steps become catalogue steps, and the
   machine wizard becomes the plan's first part. The red test comes first: a plan made from a fake catalogue and fake
   answers, taken up again after a restart, with a step done elsewhere seen as done.
4. **Hand-overs** (M, porelo-wizard and porelo-frontend). A step for someone else is given to them as instructions,
   plus a file they can run where the step can run without a person. The wizard waits on the step's `Readiness`.
5. **The chat beside the wizard** (L, porelo-frontend). It uses `flutter_ai_toolkit`, with Porelo's own
   `LlmProvider`: Claude Code run with no person (`claude -p --output-format stream-json`, reading only, in the
   documentation's directory). It sees the plan, the current step and the checks' output, never a secret, and it runs
   nothing. The first test is a fake provider that streams an answer about the current step.
6. **Running without a person** (M). The same plan runs from a file of answers. A step that must stay attended stops
   it and says so. Agent Core lists those steps: the passphrase, a browser or device sign-in, a signature with a key in
   a locked store, and `ConfirmFirstStart`. The vault is unattended once its passphrase comes from a file the person
   made (`vault init --passphrase-stdin` or `--passphrase-command`). `porelo setup` and `TakeProject` run without a
   terminal.

Order: 1 and 2 first, side by side. Then 3. Then 4 and 6. 5 can start after 3.

## Acceptance

- A person on an empty machine answers the questions, sees the whole plan before anything runs, and reaches their
  first reviewed work in `default`. The wizard is stopped and taken up again on the way.
- A step done by an administrator elsewhere is seen as done when the wizard is taken up again. Its hand-over showed
  them the instructions and a file they could run.
- A plan runs from a file of answers on a fresh machine, and stops at the first attended step, naming it.
- The chat answers a question about the current step and never receives a secret. A test shows this: the provider is
  given a step whose vault passphrase was typed, and gets no secret.

## Open questions

- **A new repository and agent, `porelo-wizard`**: is it made, under which organization, and whose agent owns it?
  Or does the catalogue live in porelo-frontend until it is needed elsewhere?
- **What the person is told** about what the chat sends to the agent's provider, and how they choose another
  (kept from before).
- **Who runs the unattended plan**: a CLI of porelo-wizard's own, or the window run headless? The CLI serves a
  company's rollout without a desktop; the window keeps one implementation.

## To be checked

- Which of `host_dialog.dart`'s fifteen states are steps of the catalogue, and which are the dialog's own (F450's
  slice 5 makes it a model either way).
- Whether `flutter_ai_toolkit`'s current release builds with the window's Flutter 3.47 and its licence check.
- How the catalogue's instructions stay true when the repository that does a step changes: the step's `Readiness`
  run in porelo-wizard's acceptance leg against the released porelo is the proposal (this replaces the earlier open
  question on where the format is checked, which the plan's step 2 answers).
