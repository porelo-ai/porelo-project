# PJ67 — A change is checked before it leaves the machine

**Status:** Idea.

**What must be true.** A task's work that waits at its gate is checked by another agent in a task of its own before
the person sees it: the check reads exactly the commit that waits, leaves its findings beside it, and the building task,
or another one, fixes what it found and pushes again, until a check is clean or a set number of rounds is reached. Only
then does the person approve at the gate, with the findings and every round in front of them, and only after that does
the work leave the machine.

## Why

The agents now have each change read by a sub-agent before they hand it over, by hand and outside Porelo: a Codex or
Gemini run on a worktree, its findings read and fixed by the agent itself, the rounds told in the channel. Once the
agents work in Porelo tasks ([PJ39](README.md#pj39)), that loop belongs where the work waits, at the gate, so the
person sees what was checked and what was fixed before approving it, and nothing unchecked reaches the forge.

## The shape proposed

```
build task --push--> gate (waits, local) --> check task reads that commit
     ^                                              | findings
     +---- rework (the same task or another) <------+
                     ... until a check is clean or the rounds run out ...
gate: the person approves --> the forge
```

- **A check runs on the waiting commit:** a task of phase `check` ([PJ64](README.md#pj64)) starts on the commit that
  waits at another task's gate, not on its upstream's head, with the agent and effort the rule names for `check` and
  the issue's risk; it reads and reports, and can neither change nor push.
- **Its findings stay with the commit:** a file kept at the gate beside the commit, and a message to the building task's
  mailbox, which wakes it as any message does.
- **The fix:** the building task reads the findings, fixes and pushes again; or a task of phase `rework`, with another
  agent, does it on the same commit.
- **Every new push to the gate starts a new check**, by the project's rule (after `build`, `check`) or at the building
  agent's request.
- **The loop is bounded:** after a set number of rounds (three, say) without a clean check, it stops, and the person
  decides with what is there.
- **At the gate,** `porelo gate review` and the interface show the diff with the last findings and the rounds before
  it; the person's approval stays the only decision.

## What Porelo has and lacks today

- **Has:** a gate per task with the person's approval, the values `issue` and `phase`, a mailbox per task and waking an
  agent at rest.
- **Lacks:** starting a task on a commit that waits at another task's gate; findings kept at the gate and shown in its
  review; the rule that starts a check after a push; the bound on rounds.
