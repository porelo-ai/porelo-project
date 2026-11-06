# PJ38 — An estimate learns from the tokens spent

**Status:** Analyzed.
**Size:** M + S - the gatherer, the record, the statistic and its page (M, porelo-project); the task's start values
kept in its usage record after removal (S, porelo).

**What must be true.** Before an issue is set Finished, the tokens actually spent on it are written beside the
size it was estimated at. Every finished issue adds to a statistic - a velocity: what a size has cost in tokens so
far - and a new estimate is compared against finished issues of similar size, so a size says something measured
rather than felt.

## Why

The sizes (XS to XL) are estimated from reading the code and never checked afterwards. Whether an M costs twice an S
or ten times, and whether one agent's M is another's, is not known. Once the tokens of the work are counted, each
finished issue can correct the next estimate.

## The shape proposed

- **The count comes from Porelo only:** porelo
  [B148](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b148)'s usage record, which sees what the
  agents spend once they work in Porelo tasks ([PJ39](README.md#pj39)); an agent's own session
  record is not a source.
- **One issue per task**, handed in at the task's start as a value of porelo
  [B189](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b189) (`issue: porelo#B148`), fixed for the
  task's life. An issue's tokens are the sum over every task carrying it, in every repository. Work for no issue -
  coordination, index upkeep, the channel - runs as `issue: none` and is not in the statistic.
- **One phase per task**, a second value: `phase: analysis | build | rework`. The size is estimated at the end of the
  analysis and foretells what comes after it, so the velocity compares the size with build and rework; the analysis
  is shown apart.
- **What is counted: the new tokens** - input without the cache, cache write and output, the reasoning within it.
  Cache reads are left out: every answer reads the whole context again, so they grow with a session's length, not
  with the work. Beside them, for information only, the cost at list price from porelo
  [B191](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b191), with its price date; it depends
  on the model and on prices that change, so it is not what an estimate is compared with.
- **At Finished, a record for machines and a row for people:** the issue's figures go into a structured record in its
  repository, one JSON object per finished issue, since the file itself is deleted then. The record holds the issue,
  the estimated size, the new tokens per phase, the cost with its price date, the tasks counted, and the one-line kind
  of work. The row under *Finished* in the index shows the same figures for a reader. It is rendered from the record
  and never written by hand, so the statistic is computed from the records and not parsed out of a Markdown table.
- **The statistic:** per size and per repository, what build and rework of the finished issues cost - the middle and
  the spread - and how often a size was exceeded; updated with every issue set Finished.
- **At estimating, by likeness:** an issue's size is given with the finished issue most like it in kind of work -
  the same sort of change, in the same part, with the same kind of test - and what that one cost in time and tokens;
  the size follows from that measured neighbour, not from the size alone. The finished issues of the size it lands on
  stand beside it, so a size that does not fit stands out before the operator sets Estimated. Each finished issue
  therefore keeps a one-line description of its kind of work.

## Analysis

Read in porelo-project, porelo and the coordinator's local files; nothing run. `estimate=100 velocity median=62`
(M) plus 38 (S): the two parts are built by two agents and summed.

**What exists today.**

- **The coordinator's velocity file**, a local file outside the repositories, kept by hand from each agent's hand-over line: 455
  rows of `repo, issue, size, start, ready, est_min, wall_min, vm_min, subagents, rework`, then per tool the tokens
  read from the agent's own session records (`claude_input`, `claude_cache_write`, `claude_cache_read`,
  `claude_output`, the same for Codex and agy), a note and a one-line `work`. 308 rows carry tokens, 424 an estimate.
  An analysis is a row whose issue names `analysis`.
- **The coordinator's state script** computes the velocity used for every estimate today: per size, over the last
  150 rows, the median and the 80th percentile of `wall_min` (index `int(n * 0.8)` of the sorted list). It reads XS
  8/23, S 38/122, M 62/173, L 148/457 minutes now. Wall time, not tokens.
- **The coordinator's render script** renders a local page: per size and per repository the median
  estimate, the median wall time, the median ratio of the two, the count with rework, and the new tokens as this issue
  defines them (input, cache write and output; for Codex input less its cached part), with list prices read
  2026-10-25. It keeps analyses and bundled sizes (`M+S`) apart. So the arithmetic exists; its source is what this
  issue replaces.
- **porelo's [B148](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b148)** (in Review) writes a per-task `usage/<task>.jsonl` that outlives the task's removal
  (`TaskUsage`, `UsageObservation` in porelo): each line has agent, provider, credential, the models, the five counts
  and how the answer ended, and `task status --json` and the daemon's `Usage(task)` sum them. **porelo's [B189](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b189)**
  (finished) gives a project `parameters:` that a task is started with, fixed for its life. **porelo's [B231](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b231)** (in
  Review) copies the usage records off a machine with `porelo keep`. **porelo's [B191](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b191)** (prices) is analyzed and
  blocked on [B148](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b148).
- **The gap:** a task's start values live in its task record, which `TaskPaths.taskRecord` says is deleted at
  removal, and the usage lines do not carry them. So once a task is removed, nothing ties its tokens to an issue or a
  phase. And `project.yml` declares no `parameters:` yet.

**Steps, each safe on its own.**

1. **porelo (S), asked of its agent in the room:** the usage record keeps the task's start values beside its counts
   (a first line naming the task, its project, repository and values, kept with the record at removal and by
   `porelo keep`). Red first: a removed task's retained record still names its `issue` and `phase`.
2. **Red tests in porelo-project**, on fixture records: an issue's new tokens are the sum over every task carrying it,
   per phase, cache reads left out; `issue: none` is left out; a machine whose records cannot be read is named and the
   sum refused, never computed without it; the medians per size computed from fixture records equal those
   the state script's method gives for the same numbers, so the change of source does not change the arithmetic.
3. **The gatherer**, `tools/velocity/gather.py`: reads the kept usage records of every machine given, groups them by
   issue and phase, and prints the record for one issue, or refuses naming what it could not read.
4. **The record**, one JSON line per finished issue with `"schema": 1`: issue, repository, estimated size, new tokens
   per phase, the tasks and machines counted, the one-line kind of work, and the cost with its price date once [B191](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b191) is
   there (absent until then, never zero). Written in the commit that sets Finished, beside the index row.
5. **The statistic and the Finished row rendered**: per size and per repository the median, the 80th percentile and
   how often the size was exceeded, for build and rework, the analysis apart; the Finished row's figures written from
   the record by a script and checked against it, never by hand.
6. **At estimating:** `tools/velocity/neighbours.py` lists the finished issues of a size and the nearest by kind of
   work, which an analysis cites beside its size.
7. **`project.yml` declares `issue` (a pattern for `<repository>#<number>` or `none`) and `phase` (`analysis`,
   `build`, `rework`)**: prepared by the coordinator, signed by the operator. Until it is, tasks carry neither and the
   gatherer finds nothing, which is safe.

**Waits, apart from the estimate:** [B148](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b148) and [B231](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b231) reaching Finished; the operator's signature of `project.yml`; and
the first issue built from start to Finished in tasks, which sprint 10's real move gives. Until then the acceptance
runs on fixtures only.

## Open questions

- **Where the records and the statistic live.** Recommended: one file per repository, `issues/finished.jsonl`, a
  line per finished issue, written by the agent owning the repository in the commit that sets Finished, since only it
  writes there; the statistic a page rendered from every repository's file, as the plan pages are, never committed.
  This adds a shared rule for every repository. The other way, one file in porelo-project for all, would have the
  coordinator record what other repositories finish.
- **What becomes of the velocity file.** Its tokens come from the agents' session records, which this issue excludes
  as a source, and Porelo counts no time yet. Recommended: keep it for minutes (the estimates and the state script) until an
  issue gives Porelo's task times, import none of its tokens, and start the token statistic empty with the first
  issue finished in tasks.

## To be checked

- Who runs the gatherer before Finished: the coordinator, reading the copies `porelo keep` makes of each machine's
  records ([PJ45](README.md#pj45) keeps them in the project's store); to be confirmed with porelo's agent that those
  copies keep the start values of step 1.
- Whether a reasoning count the provider reports apart from output is already inside output, so it is not counted
  twice.
