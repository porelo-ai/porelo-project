---
name: project-coordinating
description: porelo-project rules for coordinating the other repositories' agents: defects found by reading, shared-block checks, proposals, pushes of stories, forecasts and reports. Use for any coordination work.
---

# project-coordinating

The agent working here coordinates the agents of the other repositories.
## Coordinating

- **A defect found by reading another repository goes to its responsible agent**, with the text and
  the position. Reading does not replace asking: only that agent knows why something is so, or whether
  a requirement went away finished or abandoned.
- **When a shared block or a shared skill changes, compare every copy's hash and text with this one**, at the commits
  the agents name, and once more at their tips before calling it done.
- **A requirement here that waits on another repository's issue is checked against that repository**,
  which does not know it is cited. Report every hit, never a truncated search.
- **A check keyed on file names cannot verify a rename**; ask the history (`git log --diff-filter=D`)
  or the agent. A check over an empty set proves nothing, so assert it is not empty.
- **Work is proposed because it serves the story of the highest priority or unblocks another task.** Never propose
  low-priority work merely to keep an idle role busy.
- **`flutter-guided-walk` is developed independently and is excluded from coordinated Porelo
  changes, shared-rule rollouts, and release plans.**
- **A planning round’s issue maintenance is one planning task per repository, collected in one
  commit.** Implementation tasks keep their own commits.
- **Coordination follows the plan's open issues, not the posts**: nobody waits on Review or a push,
  dependents build on what stands, and a new architecture decision first lists the issues it makes
  needless and stops them at once.
- **A story's issues are pushed in the same round as the story, porelo-project last**, so its stories
  check finds each one on `main`; they never wait for a code commit.
- **Before asking the operator, or passing on an agent's claim ("never ran", a sum of sizes), look
  it up**: the operator's earlier answers, the handovers of earlier sprints, the measured times, and
  what is already set up on GitHub or a provider.
- **An agent counts as working only once it has said it started**; an order sent is no work begun. An
  agent with open work that is idle and silent for 15 minutes, or past the p80 of its size, is asked
  at once.

## Estimates and reporting

- **A forecast uses measured median times for comparable issue sizes rather than a sum of
  uncorrected estimates.** Name the measured basis and explain departures.
- **A report of changed coordinated work shows the current overall status, including builds, ready
  pushes, and participating repositories.** Put what needs the operator’s action first.
- **Every report of the agents' work shows their table with each one's expected finish**, by the
  measured medians, and the expected acceptance of the next story whenever it moves, with its cause.

## Steering

- **A broken agreed rule is corrected by the coordinator's order at once**, and reported - a wait on a push instead of
  a local hand-over, a whole rerun instead of a targeted one, a red build left standing. It is never put to the
  operator as if it were new, and every Push ready is checked against the rules before it is acted on.
- **The coordinator owns the order of the lanes**: at every change it checks each wait between lanes (`blockedBy`, a
  wait named in an issue, a push waiting on another's publish, an operator action such as a permission or a secret)
  and reorders before a lane stands idle; a provider issue is pulled forward into a lane with slack, the agents are
  told the new order in the room, and a wait on the operator is raised at once.
- **A change to `project.yml` is never committed unannounced**: changes are collected and handed to the operator, who
  signs the file anew (`porelo project sign porelo`), since a machine reads it only when its newest change is
  signed by a project admin. Other files of this repository need no signature.
