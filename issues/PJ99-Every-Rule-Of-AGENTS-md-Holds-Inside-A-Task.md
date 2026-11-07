# PJ99 — Every Rule Of AGENTS.md Holds Inside A Task

**Status:** Idea. Its groups are open for the operator's decisions; nothing is built from it before.

**What must be true.** An agent working in a Porelo task, whose workspace holds its one repository and nothing else,
can follow every rule of the shared block of `AGENTS.md`. What a rule needs from outside that repository is handed
in by Porelo at the task's start, checked by Porelo outside the task, or the rule is reworded for a task. No rule
makes a task read another repository, and the local rules of one machine's `.AGENTS.md` play no part in a task.

## Why

The first trial move of an agent into a task on a rented host (2026-11-07) showed rules that could not be met inside
the task: the local-trace check and `.AGENTS.md` were absent, nothing set the commit trailer, the task did not know
its builds, and the citations check read other repositories. Every rule of the shared block was then read against
what a task holds. About two thirds hold inside a task as they stand: every rule on tests, claims, security and code,
and the checks `check-shared`, `check-readmes`, `check-doc-site`, `check-actions` and `check-commits`, which read
only their own repository. The rest falls into the groups below.

## What a task holds

Its repository's checkout, the agent's harness, the build's toolchain, egress limited to the project's allowed
hosts, a gate that the person approves, its mailbox in the task's directory, and the values the task was started
with. It does not hold other repositories, a person's local files, a machine's VMs, the person's keys or vault, or
other agents' sessions.

## The groups

| Group | What a task lacks | Proposed solution | Who | When |
|---|---|---|---|---|
| **G1 Messages and the task's own context** | How the agent writes and reads messages; its name, the person's language and time zone | Messages go through the task's **mailbox**: the sluice filters what leaves, the Matrix transport carries it, answers arrive in the same mailbox. **Waking is built**: an agent resting at its prompt is woken when a message names it, is said to it, or is a person's word to the room naming nobody ([B118](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b118), [B120](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b120), [B264](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b264), [B274](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b274)). Rules naming the room's command-line client are reworded for a task. Name, language and time zone come as **project parameters** ([B189](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b189)): `agent`, `language`, `timezone`. Who owns which repository is in this file already. Long content goes into the repository's work tree. | Coordinator (wording, a draft of the parameters for the operator to sign) | before the second move |
| **G2 Local traces** | The check of tracked text against a person's own list of words that name their machine; the list itself must never be public | **In the sluice (proposed):** a new detector for a person's own terms, and a mode that checks a push's commit messages and added lines with that detector and the credential and personal-data detectors only (the statistical ones are tuned to English prose and would misfire on code). **At the gate:** `gate review` shows the findings and `gate approve` refuses on one, with an explicit "forward anyway"; the list lives in the person's local Porelo settings and reaches a host only on standard input while the person forwards, never at rest there. **In the task:** a generic check in the shared tooling for home dot paths and token shapes, naming no machine, warns before the push. | Sluice, Core, Frontend, Machines; the person moves their list once | before the second move |
| **G3 The commit trailer** | Which harness and model drive the task; nothing enforces `Assisted-by:` | Parameters `harness` and `model`; a hook in the task's image writes the trailer (porelo-claude-code [CC46](https://github.com/porelo-ai/porelo-claude-code/blob/main/issues/README.md#cc46), in work); `check-commits` refuses a commit without it (new) | Smith, Machines | before the second move |
| **G4 Builds, tests, VMs** | The central build, local VMs, rented machines | Builds through the host's own forge, named per project in the host's file ([PJ39](README.md#pj39), in work); VM legs through the host's VM pool ([PJ22](README.md#pj22), [PJ60](README.md#pj60)); a task never rents a machine | Core, Machines | [PJ39](README.md#pj39) before the second move, the VM pool after |
| **G5 Other repositories' state** | Dependencies, contracts, snapshots, the copies of the shared blocks | [PJ98](README.md#pj98), extended to compare the shared blocks' copies; facts about other repositories come from the coordinator through the mailbox; the repository's sprint issues come in the task's first words | Coordinator; [PJ98](README.md#pj98) | after |
| **G6 Skills and a second model** | The skills' registry may be out of the task's egress; a second model to read the work | Checked skills mounted read-only or baked into the image by slug; the reading by a second harness through the broker, or by a read-only review task of its own ([PJ64](README.md#pj64)) | Smith, Core | after |
| **G7 Timing and estimates** | The stages of an issue and the medians | The shared tooling's stage record (in porelo-buildtools, in work); parameters `issue` and `phase`; seed medians per repository; later replaced by [PJ38](README.md#pj38) | Machines | the tool now, in a task after |
| **G8 Watching after the gate** | Following a build, reading job logs, what was published, the hosts the bill of materials and pin moves need | The coordinator watches after the gathered push; the task reads its host forge's runs and the logs of failed jobs with [PJ39](README.md#pj39); the hosts for the bill of materials and pin moves are measured first | Coordinator, Core, Machines | partly with [PJ39](README.md#pj39), the rest after |
| **The local rules** | — | `.AGENTS.md` is local to one machine and plays no part in a task; a rule a task needs moves, stated generally, into the shared block | Coordinator | ongoing |
| **Rules to reword** | Commands marked for the operator's console, the push hand-over as a command, "`.AGENTS.md` names you", "rules go into `.AGENTS.md`", "Implementing is set on `main`" | Reworded for a task: a request to the gate, parameters instead of `.AGENTS.md` | Coordinator | before the second move |

## Open questions

- G2: whether the person's own terms are checked by the sluice, as proposed, or by the gate alone.
- Which of G2, G3 and the rewording become issues of their own now.
- The parameter declarations for the project file, which the operator signs.
