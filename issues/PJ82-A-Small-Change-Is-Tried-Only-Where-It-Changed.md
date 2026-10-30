# PJ82 — A small change is tried only where it changed

**Status:** Idea.

**What must be true.** On a host with a local forge, a bugfix or other small change made in a task is tried on the
host's VM only in the area it changed, and the second agent's review of it is limited to that same area. Both only show
that nothing there is broken; the full test runs afterwards on the central forge. A project with only the central forge
and no local one on its host is not affected.

## Why

The operator decided on 2026-10-30 that a small change is tried on a local VM only as far as the change needs, never
by a full run of the whole flow, because the complete run follows on GitHub anyway. A task on a host should keep to the
same rule, so a small fix does not wait for a full acceptance run on the host's VM pool before it can leave.

## To be checked

- Whether a task can choose a part of an acceptance run today: `porelo-machines acceptance --pool` showed no option
  for it.
- How the area of a change is found (changed files, modules, roles) and passed on, both to the try on the VM and to the
  second agent's review ([PJ67](PJ67-A-Change-Is-Checked-Before-It-Leaves-The-Machine.md)).
- What makes a change small enough for this, and who says so: the task, the issue's size or the person.
- What the local forge's runner runs on a push from a task, and whether that run stays complete or follows the same
  limit, given that the central forge runs the full test afterwards.
