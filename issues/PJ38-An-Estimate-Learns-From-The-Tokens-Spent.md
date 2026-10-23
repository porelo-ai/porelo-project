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
- **At Finished:** the issue's row under *Finished* in the index keeps its estimated size and gains the new tokens per
  phase and the cost beside them, since the file itself is deleted then.
- **The statistic:** per size and per repository, what build and rework of the finished issues cost - the middle and
  the spread - and how often a size was exceeded; updated with every issue set Finished.
- **At estimating:** an issue's size is given with the finished issues of the same size beside it and what they cost,
  so a size that does not fit stands out before the operator sets Estimated.
