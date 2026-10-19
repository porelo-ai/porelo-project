# PJ48 — GitHub does not run scheduled workflows reliably

**Status:** Idea. A collection of ways to solve it; nothing is decided.

**The problem.** GitHub is the primary system: the updates of the packaged agents, the sweep of abandoned test
machines and the daily *Shared rules check* run there on a `schedule`, and they must run when nobody develops too.
GitHub starts a scheduled workflow late or not at all when Actions is busy. A dropped run leaves no failed run and
no notification, so it shows only when someone looks for what it should have made.

## What was seen

- porelo-claude-code's weekly "Update" (Mondays, `17 5 * * 1`) did not start, and in all of that repository's history
  only one scheduled run of any of its workflows started.
- porelo's hourly sweep (`17 * * * *`) ran with gaps of several hours.
- Every schedule already avoids the full and the half hour, and every workflow is on the default branch, as GitHub
  advises; it did not help.

## Ideas

- **Start it from outside by the API.** A timer outside GitHub starts the workflow with `workflow_dispatch`, which
  GitHub's scheduler does not delay. It needs a fine-grained token that may only write Actions in the repositories
  concerned.
- **Catch up rather than double.** The timer looks when each scheduled workflow last ran and starts only one that is
  overdue for its window, so a schedule that does run is not run twice.
- **Notice a missing run.** Something that knows each workflow's window says so in the channel, or to the operator,
  when a run has not happened; a dropped schedule otherwise stays silent.
- **Where the timer runs.** The operator's machine (a systemd timer that catches up on missed runs when the machine
  is on again), the rented host while it is up, a small machine that is always on, or the local Forgejo once it
  exists. Only an always-on place covers the times nobody works.
- **Fewer schedules that matter.** What can run on a push or at a release instead of on a clock needs no schedule;
  what must run on a clock is listed with its window and why.
- **An external monitoring service** that alerts on a missing ping is possible too, but it is one more party that
  learns about Porelo's runs.

## Until it is solved

The coordinator checks every morning that each scheduled workflow ran in its window, and asks the operator to
start a missing one by hand.
