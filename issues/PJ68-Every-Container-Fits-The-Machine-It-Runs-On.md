# PJ68 — Every container fits the machine it runs on

**Status:** Accepted.

**What must be true.** Every container a Porelo part starts - a task, an image build, the room's homeserver, the
host's forge and its runner's jobs - runs with limits set for it (processes, memory, CPU, open files), and whatever
inside it sizes a pool from the machine sees those limits rather than the whole host. So a part that works on a small
machine also works on a large rented host, and one container cannot take the host's memory or processor from the
others.

## Why

The room's homeserver failed at its first start on a 32-core rented host: tuwunel sizes its database pool from the
cores, reached 2048 threads, and podman's default limit of 2048 processes refused it. The test machines have 4 to 16
cores, so it was never seen before. A read of every part's containers finds the same pattern elsewhere:

| Container | Part | Limits today | What grows with the machine |
|---|---|---|---|
| a task | `porelo` | pids 2048 and memory 8g by default; no CPU limit; podman's open files | whatever the agent and the work start: `nproc`, a JVM's processors, `make -j`, Maven `-T 1C`, Gradle workers see every core |
| the image build | `porelo` | none; 10 minutes in time | the project's `RUN` steps |
| the room's homeserver, and its run for `backup` and `restore` | `porelo-message-matrix` | none | database pool, RocksDB threads and read cache scale with the cores |
| the forge and its runner | `porelo-host` | none | Go's threads; the runner's jobs run builds that size themselves from the cores |
| the VM pool's VMs | `porelo-host` | 1 vCPU and 1536 MiB each | nothing checks that the host's memory holds the pool |

The agent adapters start no container on a machine; the agent runs inside the task's.

## The shape proposed

- **Each part sets the limits of the containers it starts:** processes, memory, CPU and open files, as values of its
  own with a reason, never podman's defaults by omission.
- **A pool sized from the machine is capped** where the program allows it, as for tuwunel's database pool, or the
  container's CPU limit makes the program see fewer cores.
- **A task's CPU limit makes `nproc` inside read the limit**, so builds in a task size themselves to it; the project's
  `limits` still raise or lower it.
- **A host whose memory cannot hold what is asked of it is refused** before anything is made, such as the VM pool.
- **A part's tests hold its limits on a large machine and a small one:** at least one run with a forced small process
  limit, which today's homeserver fails and which a capped pool passes.

## Fixes in the parts

- `porelo-message-matrix`: the homeserver's pool capped in the unit and in its `backup`/`restore` run; its memory and
  container limits.
- `porelo`: a task's default CPU limit; limits for the image build; open files.
- `porelo-host`: limits on the forge's and the runner's containers and on the runner's jobs; the VM pool refused when
  the host's memory cannot hold it.
