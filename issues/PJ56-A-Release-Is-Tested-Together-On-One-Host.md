# PJ56 — A release is tested together on one host

**Status:** Idea.

**What must be true.** Before a release, every part's release candidate - `porelo`, the agent
adapters, the message sluice and transport, the build reader and the interface - is installed and
tested together, the way a person's machine has them, so that a fault between two parts is found
before it ships rather than after.

## Why

Each repository's acceptance legs test its own package against what the others have published.
Whether the release candidates work together is tested nowhere. A host rented for the release's test
window can run every part's suite at once, each under an account of its own, as the local VM does
today. Accounts side by side on one host also test that Porelo keeps one account's tasks and vault
apart from another's.

## The shape proposed

- **A bare-metal host with virtualization, rented by the hour for the release's test window**, brought
  up and taken down by the same tooling as porelo-project's [PJ39](README.md#pj39) host
  ([PJ40](README.md#pj40)) rather than a tool of its own, its window and cost posted before the rental
  and given the operator's word.
- **A VM per operating system the packages ship for** (Ubuntu, Fedora), and in each VM one account per
  part, running that part's acceptance suite against the release candidates of all the others.
- **For arm64, the Mac rented for the same window** ([PJ55](README.md#pj55)), in its ARM Lima VM, with
  the interface built for macOS.
- **The per-push acceptance legs stay as they are**: they find a part's fault early; this test finds
  the faults between parts.

## To be checked

- Which suites cannot run side by side - a restart, a machine-wide install, timings that depend on
  an idle machine - and run them one after the other.
- That a clean install on a fresh machine is still tested once per release, since only the first run
  on the host finds a clean one.
- Who starts the release test across the repositories, hands out the accounts and gives the host back,
  when today each repository's workflow rents its own machines.
- The host's size for every suite at once, and the cost of the window against today's legs.
