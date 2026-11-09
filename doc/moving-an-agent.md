# Moving an agent

How each agent of the project moves into a Porelo task of the project `porelo`, one agent at a time, in a fixed
order, each move checked before the next begins. Each agent's move is a story of its own.

## The procedure

The move happens twice. **A trial move per repository**, in the sprint that prepares it: the repository runs in a task
on the host rented for that sprint until its check is green, then goes the way back and is worked on the development
machine again. **The real move of all of them at once**, once every repository has passed its trial: the host carries
the whole project, then each repository's check on the host.

Every repository's move follows these steps; a repository's own move issue states only what is particular to it, and
the coordinator gives its agent this procedure when its move is due.

### Who moves, and in which order

A task holds one repository, so each repository moves with an agent of its own, named after the repository or the
nickname its entry in `project.yml` gives it. The trial moves go one at a time, also within one stage, in this order:
the next may start on the same rented host while the last one still runs there, and is checked only after the last one's
check is green and the operator has accepted it. Trial moves run on rented hosts only, never on a local VM; between
rentals come pauses without a machine, in which the gathered findings are fixed.

1. `porelo-message-sluice`.
2. `porelo-pi`, `porelo-omp` and `porelo-claude-code`.
3. `porelo-agy` and `porelo-codex`.
4. `porelo-buildtools`.
5. `porelo-message-matrix`.
6. `porelo-intellij` and `porelo-frontend`.
7. `porelo-adapters` and `porelo-ai.github.io`.
8. `porelo` and `porelo-host`, last of the builders.
9. The coordinator, once tasks that review work exist; until then it reads the moved agents' work from outside, and
   stays on the development machine after the real move.

`porelo-parent` has no agent and does not move: a change to it is a task on that repository, started when one is
needed. After the real move, an agent's session on the development machine and its VM accounts stop.

### Before the first trial

- **The room is reachable from the host**: the development machine opens `ssh -R` to the host, to one socket only, the
  card's return path, and the host's tasks reach the room through it. The homeserver stays on the
  development machine, since the host is rented for a few hours at a time and work here goes on without it. This path
  is not built yet.
- **Snapshots come from the central source; the host's registry holds only what was built there and has not yet gone
  through the central forge**. So
  a freshly rented host builds at once, and `porelo-parent` and `porelo-buildtools` build on its forge only when changed
  there.
- **`project.yml` names no host** (operator, 2026-11-06). It holds the project's rules and each repository's central
  forge as `central:`, nothing that changes with the host the project is put on. Which host carries which repository
  is the organization's: the host's `host.yml` names the project, whole or by some of its repositories. A host derives its own forge's
  address for what it carries; a task pushes there, and the gathered push takes the work on to the central forge.
  A build reader follows that derived address; no `builds:` block names a host's forge. How a project the host does
  not carry, such as the default project, works on a host is still open.
- **The project `porelo` is `online`**, decided 2026-11-04: a task's push goes to its own branch on the forge without
  approval at the gate, and `porelo build status` reads its Build; `guarded` allows neither. `project.yml` changes for
  that class once, signed by the operator. No task of the project runs across a carry, and `gate review` is empty
  first; a second trial under one task name needs `porelo/<task>` deleted. Open: whether `access`, with
  `mail.transports` moved to `access.yml`, belongs to the first trial.

### Before each trial

- **The dry run passed on the development machine**: a task for the repository, online with the central forge as its
  upstream and the room on the machine's own homeserver, takes a change through the gate to a `porelo/…` branch, is
  woken by a message in the room, and reads its build. A person opens the pull request there.
- **The repository builds on the host's forge as on the central one**: its workflows run unchanged on both, with the
  values of [the local registry and publication settings](https://github.com/porelo-ai/porelo-host/blob/main/doc/local-forge.md#the-local-registry-and-publication-settings).
- **The host's inventory names the repository in `forge_repositories`**: the forge migrates a repository, protects
  its `main` and makes the gate's identity only for those named.
- **The repository has a `porelo.yml`** whose image holds the agent's tools; the agent's sign-ins are in the host's
  vault. A task has no sub-agent of its own.
- **The task's egress reaches what the build and the agent fetch**: Maven Central, Sonatype's snapshots, GitHub's
  release downloads and API, and the skills' store. A snapshot built on the host and not yet central is read by the
  task only once a task can fetch a snapshot from its host's forge, which a trial does not need unless it changes one.
- **The skills the repository names are in the task** where its harness reads them, checked against their digests.

### The steps

The same for a trial and for the real move, which carries the whole project in step 1.

1. **The carry:** the host carries the repository, `porelo org host carry <host> porelo --repository <name>` or, in
   the window, *Put it on a machine…* with that repository chosen. `project.yml` does not change.
2. **The start:** `porelo task start --repository <name> --agent <agent>` on the host, attended, its terminal opened
   by the operator.
3. **The work:** the agent takes its move's own small change from start to review inside the task, through the gate,
   with the forge's build green.
4. **The check** (below).
5. **After a trial, the way back** (below): the repository is worked on the development machine again until the real
   move.

### The check

Read-only, on the host. Each line says what it found, and each fails by name before the trial:

- the task runs;
- its last push reached the forge as `porelo/<task>`;
- a Build of that push was read by the forge's build reader;
- the pull request was opened by the gate;
- the task is listed in the room's `agent-card.json`;
- a message naming the agent in the room wakes it, and its answer appears there.

### Working in a task

- **A moved agent runs attended**: Porelo wakes an agent resting at its prompt when a message names it. Only an agent
  whose definition declares both its resting and its waiting screen is woken; a Pi in a task is woken only once porelo-pi
  declares both screens.
- **What a task cannot test runs in the forge's Build**: an acceptance leg on a machine from the host's pool. A
  hand-over names those legs in place of a VM run on the development machine.
- **An adapter moves before the pool is there**: during its move the adapter's checks that rent a
  machine from the host's pool are switched off. porelo's Build moves to the forge before the adapters, so they build
  against its snapshots there, and its acceptance job is off on the forge the same way. Each adapter switches them on again in its own issue of release 0.7,
  planned once the pool and machines asked for by kind are done.
- **The reading before a hand-over is done from outside**: the coordinator has the pull request's diff read against
  the repository's skills by a sub-agent on the development machine and posts the findings in the room.
- **A fix after a reading amends the task's commit** and is pushed with `--force` to the task's own unmerged branch,
  which the gate lets through; the work stays one commit. `main` is never pushed with force.
- **A revoked sign-in** is renewed with `porelo vault login <agent> --force` and a restart of the task, which keeps
  the token it read at its start.
- **The task changes nothing on the host.** Only the host admin installs a new Porelo there, deliberately; if the
  installed Porelo is broken, the way back is the remedy.

### What the agent is given in place of `.AGENTS.md`

`.AGENTS.md` is not committed, so it is not in the task. At the start, the task's context gives the agent:

- **its name**, the one it signs with;
- **its commit attribution**, `Assisted-by: <tool>, <model>` (the harness, such as `Claude Code`, never the agent's
  name), and no other trailer of its own;
- **which forge its upstream is**: the host's forge, and the central forge only through the gathered push;
- **the room in place of the channel**: it reads and writes the project's room, not the channel file;
- **the operator's language and time zone**, as the development machine's local rules state them;
- **every local rule Porelo does not yet replace in the task**, until its replacement is shown in that agent's own
  task.

What the coordinator finds missing in a task's context is said before the start.

### The room

Every agent, in a task or not, talks in the project's one room. Its homeserver runs on the development machine,
reached by the host's tasks over `ssh -R`; the agents on the development machine use a room client in place of the
channel's commands, and the channel file is read-only from the first trial on. After the real move the project's room
is made anew on the host's homeserver and `project.yml` names it; the old room is cleared, and its history is not
carried over.

### The way back

Every trial ends with it, and a moved agent can take it at any time - for a failed move, a host given back or lost,
or any other reason:

1. What the host's forge holds of the task's work is fetched into the agent's local checkout.
2. The host stops carrying the repository, `porelo org host uncarry <host> porelo --repository <name>`; it holds the
   repository while work on it has not reached the central forge. `project.yml` does not change.
3. The local session resumes, with its watcher.

Work that only the host held is lost with the host, as for any work on it; the host's backup is what protects it.
Moving in again is a new start, from *The steps*.

### Open

- **The guided walks of the interface** - the walk's folder on the operator's laptop and the walk first done on a
  test machine - are settled with `porelo-frontend`'s move.
- **Testing against another repository's work before it is published**: whether a moved agent tests only against
  snapshots another repository's Build published, or where such a hand-over lies for a task.

## When a move counts as done

- Sluice's move: `build/move-check.sh` of porelo-host, copied to the host, red before, green after, with its move issue in Review from inside the task.
- Every later move the same; the coordinator's own move last, in the project `porelo-all`.
- Seen to fail first: the check against an agent that has not moved.
