# PJ64 — A task chooses its agent and effort by its work

**Status:** Idea.

**What must be true.** A task started for an issue gets the agent, provider, model and reasoning effort its work calls
for, chosen by a rule of the project from what the task is for - building, checking, reworking - and how much harm a
fault in the issue could do; the start says what it chose and where the choice came from, and a flag given at the start
still wins. A task that only checks work can read it and report findings, and can neither change nor push it.

## Why

The agents hand work to sub-agents, and which model and effort fits depends on the work: a review of a security change
deserves the deepest reasoning, a typo fix the lightest. Today the agent picks by hand for each run, and a deep review
of a small change took up to 23 minutes. Once the agents work in Porelo tasks ([PJ39](README.md#pj39)), the choice
belongs where the task is started.

"Review" also means three things today: the issue state in which the operator tests, the operator's approval at the
gate, and a sub-agent's reading of a change. Only the operator decides; an agent's reading produces findings, never a
decision.

## The shape proposed

- **A phase for an agent's reading, `check`**, beside `analysis`, `build` and `rework` (the values of porelo
  [B189](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b189) and the phases of
  [PJ38](README.md#pj38)). "Review" stays the operator's word: the issue state and the approval at the gate.
- **An issue says how much harm a fault could do:** a field `**Risk:** harm | ordinary | small` beside `**Size:**`,
  set by the agent at Analyzed and seen by the operator when estimating. A task may raise it for its own work - a change
  that turns out to touch a secret is checked as `harm` - but never lower it (decided); the start names the raise.
  `harm` covers security, secrets, trust, and a contract another repository reads.
- **One effort scale in Porelo:** `low`, `medium`, `high`, `xhigh`, `max`. Each agent's adapter maps it onto its own
  provider - a parameter for Claude and Codex, a model variant for Gemini through agy. Where a model has no such level
  it takes the next lower one, and the start says so; nothing is changed silently.
- **The project's default rule** (decided): the agent is Claude Code, and phase and risk set only its effort.

  | Phase | `small` | `ordinary` (when none is set) | `harm` |
  |---|---|---|---|
  | `analysis` | `low` | `medium` | `high` |
  | `build` | `low` | `medium` | `high` |
  | `check` | `low` | `high` | `xhigh` |
  | `rework` | `low` | `medium` | `high` |

  Building stays light because it is checked; the depth goes into the check. `max` is in no row; a flag gives it.
- **A rule of the operator's for a time** (decided): the operator may set a rule that overrides the project's - for
  example `check` with `harm` to Codex at `xhigh`, or texts to Gemini through agy - kept on the operator's own machine,
  not in the project, and in force until revoked. It is set, listed and revoked by command, and every start it changes
  names it with the date it was set, so a forgotten rule shows.
- **The choice in order of strength:**
  1. a flag given at the start (`--agent`, `--provider`, `--model`, an effort flag);
  2. the operator's rule for a time;
  3. the project's rule, from the task's phase and its issue's risk;
  4. the project's default agent for the repository;
  5. the agent already signed in on the machine
     ([PJ53](README.md#pj53)).

  The start names the step that decided, as it names where an image came from, and hands agent, provider, model and
  effort to the agent's adapter, which applies them its own way. What the agent then hands to sub-agents inside its
  task is the agent's own choice; a sub-agent's work that is to be chosen this way runs as a task of its own.
- **A `check` task reads and reports, nothing more:** its workspace holds the commit it checks and is read-only, its
  gate takes no push, its network is narrower than a build's, it ends within a time limit, and it leaves its findings as
  a file the building task or agent reads. Its tokens count as `check`, apart from build and rework.

## Built in

- **`porelo`:** the phase `check`, the field `risk` and its raise, the project's rule, the operator's rule for a time
  with its commands, the order of choice and the start naming it, and the `check` task that only reads.
- **The agents' adapters** (`porelo-claude-code`, `porelo-codex`, `porelo-agy`): each maps the one effort scale onto its
  provider and says where it takes a lower level.
- **`porelo-frontend`:** the start of a task offers its issue and phase, shows its issue's risk and offers to raise it,
  shows the choice and where it came from before the start, and lets the person override it; a view lists the
  operator's rules for a time, with their dates, and sets and revokes them. Starting an agent for each repository at
  one click (porelo-frontend [F148](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f148))
  makes the same choice for each task.

