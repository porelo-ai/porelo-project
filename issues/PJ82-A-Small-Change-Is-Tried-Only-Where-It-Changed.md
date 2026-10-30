# PJ82 — A small change is tried only where it changed

**Status:** Idea.

**What must be true.** On a host with a local forge, a bugfix or other small change made in a task is tried on the
host's VM only in the area it changed, so that runs on the local VM get shorter, and the second agent's review of it
is limited to that same area. Both only show that nothing there is broken; the full test runs afterwards on the
central forge. A project with only the central forge and no local one on its host is not affected.

## Why

The operator asked on 2026-10-30 to shorten the run times on the local VM: a bugfix or small change is tried there
only in the area where it changed, and the second agent's review is limited to the same area. It is only meant to show
that nothing is broken; the full test runs afterwards on the central forge.

## To be checked

- Whether a task can choose a part of an acceptance run on the host's VM today.
- How the area is marked: area tags on tests (such as JUnit 5 tags), the Java packages a change touches, or another
  way per kind of repository; every agent is asked for ideas for its own repositories.
- How the area of a change is found (changed files, modules, roles) and passed on, both to the try on the VM and to the
  second agent's review ([PJ67](PJ67-A-Change-Is-Checked-Before-It-Leaves-The-Machine.md)).
- What makes a change small enough for this, and who says so: the task, the issue's size or the person.
- What the local forge's runner runs on a push from a task, and whether that run stays complete or follows the same
  limit, given that the central forge runs the full test afterwards.
