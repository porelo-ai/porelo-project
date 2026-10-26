# [PJ72](README.md#pj72) — Every review seen as one area

**Status:** Idea.

**What must be true.** Every issue about reviewing work - by a person at the gate, by an agent in a task of its own,
or by comments on a forge's pull request - is listed here, grouped by theme, so that the order in which they are
built, and the gaps between them, can be decided for the area as a whole rather than one issue at a time.

## Why

Reviewing is spread over many repositories: the daemon's gate and comment model, the interface, the IntelliJ plugin,
the forge adapters, the sluice, the host. A review can come from three places - the person at the gate, a checking
agent, a forge - and the issues for each were written apart. Release 0.8 is the release of this area, planned in
[plan/0.8.yml](../plan/0.8.yml): first the profile and the review at the gate, then the agent that reviews and the rounds
of check and fix, the risk classes, and last the reviews on GitHub, on the host's Forgejo and in IntelliJ.

## The technical base: SARIF

**Porelo reads and writes review data only as SARIF 2.1.0** (Static Analysis Results Interchange Format, OASIS):
a person's comment at the gate, a checking agent's finding, a forge's review comment and a linter's report are all
SARIF results. Nothing in Porelo knows a forge's own format.

- **One profile of SARIF for a review,** written down once and read by every part:
  - a comment or finding is a `result`; its anchor is the `physicalLocation` (file, `region` of lines on the new side,
    the commit in `versionControlProvenance`);
  - a suggestion is the result's `fixes` (replacement lines for exactly that region);
  - who wrote it - the person, a task in its role, a forge account, a linter - is the `run`'s `tool` and the result's
    property bag;
  - a thread, a reply and the resolved state live in the result's property bag (SARIF has no threads of its own), the
    resolved state as a `suppression`;
  - which round of a check ([PJ67](README.md#pj67)) a result belongs to is its `run`, compared across rounds by `baselineState`.
- **The adapters convert, nothing else does:** each forge adapter (GitHub, Forgejo, Bitbucket Data Center, ...)
  translates between its forge's pull request review API and the profile, in both directions, and says so in the
  run's `conversion`. `Review1` ([B171](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b171), [GH02](https://github.com/porelo-ai/porelo-adapters/blob/main/issues/README.md#gh02)) takes and gives SARIF.
- **The sluice checks the profile:** a result passes only in the profile's exact shape ([SL24](https://github.com/porelo-ai/porelo-message-sluice/blob/main/issues/README.md#sl24)), in both directions.
- **More than reviews for free:** a linter or scanner that already writes SARIF (CodeQL, Semgrep, SpotBugs, detekt,
  Qodana) can put its results beside the review without a converter.
- **A checking agent is a reviewer:** [PJ67](README.md#pj67)'s check task is a task in
  [B172](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b172)'s role reviewer, and its findings
  are SARIF results like every other comment; one design serves the gate and the pull request.
- **The forges of 0.8 are GitHub and Forgejo;** GitLab, Bitbucket and Azure DevOps follow later, each with an adapter
  of its own.
- **IntelliJ reuses what it ships rather than building a review of its own:** the plugin keeps its own review of a
  waiting push in the platform's diff ([IJ01](https://github.com/porelo-ai/porelo-intellij/blob/main/issues/README.md#ij01)). For comment threads in the diff's gutter ([IJ04](https://github.com/porelo-ai/porelo-intellij/blob/main/issues/README.md#ij04)) it uses the
  platform's `collaborationTools` code review module, on which the bundled GitHub and GitLab integrations draw, behind
  a narrow adapter of its own, written in Java like the rest of the plugin, that can be replaced: JetBrains promises no stability for that module, parts of it are
  experimental or internal. The bundled Qodana plugin is a model to learn from and at most an optional report viewer,
  never a dependency.
- **The Java library is `com.contrastsecurity:java-sarif`** (MIT, on Maven Central, classes generated from the SARIF
  2.1.0 schema): every Java part of Porelo reads and writes SARIF through it, the IntelliJ plugin included, which bundles it isolated
  from the IDE's own libraries and checks the same profile. The `qodana-sarif` model inside IntelliJ is not used, so
  that one model and one check hold everywhere.

## The issues, by theme

### 1. The person reviews waiting work at the gate

| # | Status | What it covers |
|---|---|---|
| porelo-frontend [F78](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f78) | Estimated | A waiting push read as a pull request at a forge, not as git's diff. |
| porelo [B150](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b150) | Analyzed | The whole diff in review, or said plainly where it was cut. |
| porelo [B136](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b136) | Estimated | An approve forwards exactly the commit the person read. |
| porelo [B283](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b283) | Idea | A retargeted symbolic link ranked dangerous in the review. |
| porelo [B141](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b141) | Estimated | A new dependency marked and checked in the review; a finding holds the approve back. |
| porelo [B145](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b145) | Estimated | Four eyes: a second person approves. |
| porelo [B163](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b163) | Estimated | Several attempts at one assignment, their results side by side at the gate. |
| porelo [B174](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b174), porelo-frontend [F112](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f112) | Estimated | What a piece of work did, in words, before it reaches the gate. |
| porelo-intellij [IJ01](https://github.com/porelo-ai/porelo-intellij/blob/main/issues/README.md#ij01), [IJ02](https://github.com/porelo-ai/porelo-intellij/blob/main/issues/README.md#ij02) | Implementing | Waiting work reviewed, approved and rejected in IntelliJ; a new waiting push announced within seconds. |

### 2. Trying waiting work out

| # | Status | What it covers |
|---|---|---|
| porelo [B95](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b95) | Idea | A fresh container to build and test waiting work in, never on the host or in the agent's container. |
| porelo-frontend [F74](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f74) | Estimated | That container's run started from the interface, its result beside the review. |
| porelo-frontend [F95](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f95) | Estimated | A waiting push fetched into a clone the person chooses. |

### 3. Comments on lines

| # | Status | What it covers |
|---|---|---|
| porelo [B166](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b166) | Estimated | The comment model: line comments sent back to the agent as messages. The others build on it. |
| porelo [B176](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b176) | Analyzed | A comment thread follows a new push to unchanged lines. |
| porelo-message-sluice [SL24](https://github.com/porelo-ai/porelo-message-sluice/blob/main/issues/README.md#sl24) | Estimated | A comment passes the filter only in its exact shape, in both directions. |
| porelo-frontend [F107](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f107) | Estimated | Comments written and read in the interface's review, each with its origin. |
| porelo-intellij [IJ04](https://github.com/porelo-ai/porelo-intellij/blob/main/issues/README.md#ij04) | Estimated | The same in IntelliJ's diff. |

### 4. An agent checks the work before the person

| # | Status | What it covers |
|---|---|---|
| [PJ67](README.md#pj67) | Idea | Rounds of check and fix at the gate until a check is clean or the rounds run out; the person approves with every round in view. |
| [PJ64](README.md#pj64) | Idea | The agent and effort of a `check` task chosen by phase and risk. |
| porelo [B172](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b172) | Estimated | A task in the role reviewer: reads waiting work, a branch or a pull request read-only, writes only comments. |
| porelo-omp [OM19](https://github.com/porelo-ai/porelo-omp/blob/main/issues/README.md#om19) | Estimated | A read-only mode asked for by name at a task's start. |

### 5. Reviews on a forge's pull request

| # | Status | What it covers |
|---|---|---|
| porelo [B171](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b171) | Estimated | A pull request's review comments reach the task that made it, its replies go back; only listed accounts are delivered, outgoing ones released by the person. |
| porelo-adapters [GH02](https://github.com/porelo-ai/porelo-adapters/blob/main/issues/README.md#gh02) | Analyzed | GitHub's side of it: review comments, threads and suggestions read and written (`Review1`). |
| [PJ66](README.md#pj66) | Idea | An adapter lists the services it offers, a forge's reviews among them. |
| porelo [B288](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b288) | Idea | A reviewer task started by itself when the forge's build is green. |
| porelo [B289](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b289) | Idea | A task removed once its pull request is merged. |
| porelo-host [HO28](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho28) | Idea | The forge's events, a comment among them, routed to the right account's daemon; a speed-up only. |
| porelo-frontend [F190](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f190) | Idea | The pull request on the host's forge approved from the interface and brought on to the central forge. |
| [PJ34](README.md#pj34) | Accepted | Every change reaches `main` through a pull request with green checks. |

## Gaps seen across the themes

- [PJ67](README.md#pj67) does not yet say that its check task is
  [B172](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b172)'s reviewer, nor that its findings
  are [B166](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b166)'s comments.
- The forge's way (theme 5) and the comment model it needs (theme 3) are in no release plan.
- [B166](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b166)'s comment model, [B171](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b171)'s and [GH02](https://github.com/porelo-ai/porelo-adapters/blob/main/issues/README.md#gh02)'s `Review1`, [SL24](https://github.com/porelo-ai/porelo-message-sluice/blob/main/issues/README.md#sl24)'s filter, [F107](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f107) and [IJ04](https://github.com/porelo-ai/porelo-intellij/blob/main/issues/README.md#ij04) are written against a model of
  Porelo's own; each is to be rewritten against the SARIF profile, handed over to its repository with this issue's
  text.
- No issue writes the SARIF profile itself down; it belongs to `porelo`, beside [B166](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b166).

## Acceptance

- Every open issue about reviewing, in any repository, is listed in one theme here, with its current status.
- Each gap above is either closed in its issue or filed.

## To be checked

- Which `collaborationTools` classes the adapter uses, and whether the Plugin Verifier passes on each IntelliJ release
  the plugin supports.
- Whether `java-sarif` reads and writes all the profile needs (`fixes`, `suppressions`, `baselineState`, property
  bags) and what it pulls in (its JSON binding).
