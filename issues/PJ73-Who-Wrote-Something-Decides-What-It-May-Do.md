# PJ73 — Who wrote something decides what it may do

**Status:** Idea.

**What must be true.** Every pull request, commit and review comment that reaches Porelo carries a source level the
daemon derives from authenticated data, never from the content itself, and the code it changes carries a risk class
derived from what it touches. The weaker of the two is its profile, and the profile alone decides which operations
Porelo performs on it: delivering it to an agent, applying a suggestion, starting a reviewer, building it, giving it
secrets, writing back to the forge, and how many people approve it.

## Why

Review data reaches Porelo from people outside the project, from known contributors, from the project's own people and
from agents ([PJ72](README.md#pj72)). Today each issue of the review area decides on its own whom to trust:
[B171](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b171) holds comments of accounts not on the
project's list, [B288](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b288) starts a reviewer on
any green build, [B145](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b145) asks for a second
person. One model makes these decisions the same everywhere, and a project or a machine's policy can tighten it.

Most code in Porelo is written by agents, and always autonomously, not as a person's assistant. Code an agent generated
is not trusted as a person of the project would be, even when the agent runs inside the project: an agent can be
steered by what it reads.

The model follows NIST's Secure Software Development Framework (SP 800-218): PW.4.4 asks that third-party components be
verified before they are used, PW.7.1 and PW.7.2 that an organisation decide when code needs review by a person or
analysis, and perform it. A person in the loop is required; whether one person or two approve is the project's choice,
not a requirement of the framework.

## The shape proposed

### Source levels

| Level | Who | Derived from |
|---|---|---|
| **E0 External, unknown** | any account, a first contribution, a fork | not on the project's list; the forge's association with the repository (on GitHub `author_association` `NONE` or `FIRST_TIME_CONTRIBUTOR`) |
| **E1 External, known** | returning contributors, partners | named in the project file, or merged contributions before |
| **I1 Internal** | people of the organisation | membership of the forge's organisation or team, or accounts of the organisation's own forge; signed commits where the project asks for them |
| **A Agent** | a Porelo task, internal or not | started by the daemon, with its role (builder, reviewer); never higher than the level of what it read |

- The level is set **per item**: the pull request's author, each commenter, each commit. A pull request of I1 with a
  commit of E0 pushed into it is E0.
- Nothing inside SARIF or a message sets a level: `tool.driver`, property bags and text claim nothing.

### Code risk classes

| Class | What the change touches |
|---|---|
| **C0** | documentation, texts, tests that add no dependency |
| **C1** | application code |
| **C2** | build scripts, added or changed dependencies ([B141](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b141)), container and package definitions |
| **C3** | workflows and CI, the gate, the sluice and other security code, keys and trust anchors, symbolic links ([B283](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b283)), binaries, tests deleted or weakened, database schemas and migrations |

- The class comes **only from rules** - paths, file modes, dependencies, deleted tests - on top of the review's
  existing ranking of changed files; the project file can name further C3 paths.
- A model may raise a change's class, never lower it, and never compute it as a score: a score a model reads from the
  diff can be steered by what the diff contains.
- No class leads to a merge without a person: C0 may get a lighter review, never an automatic approval.

### Operations by profile (the default; open cells are the operator's decision)

| Operation | E0 | E1 | I1 | A |
|---|---|---|---|---|
| A comment delivered to the building agent | only after a person releases it | open | yes | yes, marked untrusted |
| A suggestion (`fixes`) applied by the agent | no | after release | yes | after release |
| A reviewer task started by itself | no | yes | yes | - |
| The code built or tested | only in a throw-away container without secrets or egress ([B95](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b95)) | throw-away container | as usual | - |
| Secrets or tokens in that run | never | never | by the project's rule | never |
| A reply written back to the forge | after release | after release | by the project's rule | always after release |
| Approval at the gate | two people ([B145](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b145)) | one person | one person | never |

- A class C3 change is treated at least as E0 for building, secrets and approval, whoever wrote it.
- **Contained, not filtered:** what a source wrote reaches an agent as untrusted data, kept apart from its
  instructions; the agent holds the least rights its role needs and never approves or merges; the person at the gate
  is the last check. No filter of words or forms is taken as protection against prompt injection.
- **A check by an agent never stands in for a person on E0 or C3:** the agent reviewing such a change reads its code,
  comments and test data, all written by the source, and can be steered by them. Its result is shown, but the
  person's review is still required.
- The project file can tighten the default; a machine's policy
  ([PJ16](README.md#pj16)) can tighten it further, never loosen it.

### Provenance that can be checked

- The forge's own data: organisation and team membership, the association with the repository, whether the pull
  request comes from a fork, the account.
- Signed commits (SSH or Sigstore `gitsign`) where a project requires them for I1.
- SLSA and in-toto attestations for what a build produced; OpenSSF Scorecard for a third-party repository or
  dependency.
- Porelo's own: the `Assisted-by` trailer and the models recorded at approval
  ([B144](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b144)), taken from the broker, not from
  what the agent claims.

## Acceptance

- For each forge Porelo supports, a test account of each level is classified correctly from the forge's data alone,
  and a SARIF document that claims another identity does not change it.
- A comment of E0 does not reach the building agent until a person releases it; a pull request of E0 is not built
  with secrets; a C3 change by an I1 author needs the approvals of E0.
- A project file that loosens a default, or a machine policy that is looser than the project, is refused by name.

## Open questions

- Which cells marked "open" or "by the project's rule" hold by default.
- Whether E1 is a list kept by hand in the project file, or follows from merged contributions.
- Whether I1 requires signed commits by default.

## To be checked

- Per forge (GitHub, GitLab, Bitbucket, Azure DevOps, Forgejo): which authenticated fields tell E0, E1 and I1 apart,
  and how reliable each is (a renamed account, a fork, a bot).
- How SLSA, in-toto, gitsign and Scorecard can be read by the daemon without network access the task does not have.
