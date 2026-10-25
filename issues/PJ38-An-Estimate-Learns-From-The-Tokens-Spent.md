# PJ38 — An estimate learns from the tokens spent

**Status:** Accepted; analysed after the groundwork of [PJ39](README.md#pj39).

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

## Open questions

- **Where the statistic lives:** a file next to the records in each repository, one in porelo-project for all
  repositories, or a page rendered from the records, as the plan is rendered from `plan/*.yml`.
- **Who adds up an issue's tasks** when they ran on several machines: each machine's usage records are its own
  ([PJ45](README.md#pj45) keeps them beyond the machine). Something must gather every record that carries the issue
  before the issue is set Finished, and it must name a machine whose records it could not read rather than count
  without them.
- **The record's form:** one file per repository with one line per finished issue, or one file per issue, and its
  schema version.
