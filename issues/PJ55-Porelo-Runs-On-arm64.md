# PJ55 — Porelo runs on arm64

**Status:** Accepted.

**What must be true.** Porelo and every native package it installs are built, tested and published for
arm64 (aarch64 Linux), so a Linux VM on Apple silicon installs them like an x86-64 machine does.

## Why

porelo-frontend [F109](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f109)
runs the interface on macOS with Porelo in a local Lima VM whose architecture follows the Mac's. The
deb repository `porelo-dist-deb` publishes only `amd64`, `i386` and `all` for `releases` and
`snapshots`, and its `InRelease` names `Architectures: amd64 i386`, so an ARM VM finds nothing to
install.

**What decides it** is a probe inside an ARM Lima VM (Ubuntu 26.04, VZ with Rosetta) on a real Mac:
rootless Podman 5; containers of its own architecture, and amd64 ones through Rosetta; nftables adding
a table and a drop chain inside `unshare --user --map-root-user --net`; the cgroup controllers
delegated to the user; a lingering user service's socket in `/run/user/<uid>/porelo/` forwarded to
the Mac; and, as a stop-gap, the published amd64 `porelo` and `porelod` started through Rosetta.

## The shape

Read in what is published and in the shared rules, not measured:

- **`porelo` and `porelod`** as aarch64 native images, their `.deb` as `arm64` and `.rpm` as `aarch64`,
  published into the same repositories, with `Architectures` in the index growing.
- **The shared rule that every native executable is built with `-march=x86-64`** gets an arm64
  counterpart, a fixed ARMv8 baseline checked the same way, agreed in the channel.
- **Every other native package Porelo installs** is built the same way, each in its own repository:
  the agent adapters (`porelo-claude-code`, `porelo-pi`, `porelo-omp`, `porelo-codex`),
  `porelo-build-github`, `porelo-message-sluice` and `porelo-message-matrix`.
- The interface's Linux build stays `amd64`; its macOS build is porelo-frontend [F109](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f109)'s.

## How it is tested

- **Built and checked on GitHub's arm64 Linux runners**, since `native-image` does not cross-compile:
  the unit tests, the packages built and installed, `--version`, and the executable checked for its
  ARMv8 baseline. This runs on every Build, like the x86-64 build.
- **For a release, a Mac with Apple silicon is rented for the release's whole test window**, rented
  through `porelo-machines` like every other machine, never on a push. On it, every part is tested
  as a person on a Mac meets it: Porelo and the native packages in an ARM Lima VM, through their
  acceptance legs, and the interface built natively for macOS, as porelo-frontend
  [F109](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f109) plans, against
  that VM. No separate rented ARM server and no test by hand on another Mac are needed.
- **The window is said before the rental**: its length and cost are posted and the operator gives the
  word, as for every rented machine. A macOS rental runs at least a day, by the licence, so the
  machine stays up through the window and is given back at its end, its `porelo-expires` time set to
  that end so the sweep catches it if the run does not.
- **No local VM for arm64**: the development machines are x86-64 and an emulated ARM VM is too slow to test on.
  An arm64 change is handed over green on GitHub's arm64 runner instead of a local VM; the local rule
  for a push gets that exception when the arm64 build exists.

## To be checked

- The probe's results on the Mac; a gap they show is closed before anything is built.
- Whether GitHub's arm64 Linux runners are free for these public repositories.
- Whether an ARM Lima VM with rootless Podman runs on the rented Mac, the type the window needs (16 GiB
  RAM looks like the least for a VM, its containers and the interface), and its cost with VAT.
- The rental in `porelo-machines`: a provider with macOS hosts, a machine kept up for a window rather
  than one run, and given back at the window's end.
- `porelo`'s share, sized by its repository's agent, and each other repository's.
