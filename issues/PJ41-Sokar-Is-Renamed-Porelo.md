# PJ41 — Sokar is renamed Porelo

**Status:** Analyzed.
**Size:** XL - every repository, every contract and the organisation at the forge; it splits into a preparation (S),
one rename per repository (XS to L, below) and the local machine (S), each an issue of its own in its repository.

**What must be true.** The product, its repositories, its organisation at the forge, its packages and artifacts, its
commands, its paths and its documentation are named Porelo; nothing a user installs, types or reads still says
Sokar, except where it says what the old name was. Porelo is installed afresh: nothing of a machine that ran Sokar is
carried over.

## Why

The name is to change before the repositories are opened to others and before the work moves to a server
([PJ39](README.md#pj39), [PJ40](README.md#pj40)): every later step - the contributor guide, the deploy collection,
the published artifacts - would otherwise carry the old name, and renaming grows with every repository and every
user.

## Decided

- **Group and packages: `org.fuin.porelo`**, in the namespace already verified at Maven Central.
- **The organisation at the forge is renamed** (`sokar-ai` to `porelo-ai`), and an empty organisation `sokar-ai` is
  made at once to hold the old name, so the forge's redirects are not taken over by somebody else.
- **No migration:** Porelo is installed afresh and its projects set up again; no state, command or path of Sokar is
  read or kept, and no `sokar` command remains.
- **First in Phase 0 of [PJ39](README.md#pj39)**, before the reformatting of [PJ29](README.md#pj29), in a window with
  no other work open: what is running is finished and pushed first.
- **What stays at the old addresses:** the artifacts at Maven Central under `org.fuin.sokar` stay as they are,
  without a relocation; the Artifactory repositories `sokar-dist-deb` and `sokar-dist-rpm` are deleted once Porelo's
  packages are published; the placeholder organisation's README says where Porelo is.
- **The version reads on:** Porelo and the tools at `0.5.0`, the parent at `0.2.0`.
- **The daemon is `porelod`** (`porelod.service`), as the script makes it from `sokard`.
- **The logo stays:** its design and colours are kept, the word in it changes.
- **The changelog's released entries stay as they were released**, saying Sokar; `0.5.0` is the first entry under
  the new name and says the product was renamed. The test that refuses the old name excepts those entries.

## What carries the name

Counted on each repository's `main` (occurrences of `sokar` in any case, files holding one, paths naming it):

| Repository | Occurrences | Files | Paths |
|---|---|---|---|
| `sokar` | 12,026 | 1,190 of 1,296 | 919 |
| `sokar-frontend` | 3,833 | 708 of 1,675 | 28 |
| `sokar-buildtools` | 716 | 162 of 194 | 114 |
| `sokar-project` | 626 | 35 of 40 | 4 |
| `sokar-pi`, `sokar-claude-code`, `sokar-omp` | about 580 each | about 55 each | about 33 each |
| `sokar-message-sluice` | 561 | 105 of 144 | 73 |
| `sokar-message-matrix` | 474 | 75 of 87 | 59 |
| `sokar-intellij` | 384 | 64 of 80 | 44 |
| `sokar-build-github` | 228 | 27 of 45 | 5 |
| `sokar-ai.github.io` | 110 | 9 of 20 | 0 |
| `sokar-parent` | 35 | 4 of 12 | 0 |

Beyond the words, these are contracts that something outside the repository reads, each renamed on purpose:

- **Maven:** the group `org.fuin.sokar` and 45 artifacts named `sokar-*`, the parent `sokar-parent`, the tools
  `sokar-release` and `sokar-machines`; Java packages `org.fuin.sokar.*`.
- **The daemon's contract:** the varlink interfaces `org.fuin.sokar.Tasks1`, `org.fuin.sokar.Build1` and the others,
  which every client (the interface, the IntelliJ plugin, the build readers) speaks.
- **On a machine:** the commands `sokar` and `sokard`, `sokard.service`, the nftables table `inet sokar`, the
  container label `sokar`, 47 environment variables `SOKAR_*`, the paths `~/.sokar`, `$XDG_*_HOME/sokar`,
  `$XDG_RUNTIME_DIR/sokar` and `/sokar/files` in a task, the gate's branches `refs/heads/sokar/<task>`.
- **Packages:** `sokar`, `sokar-agent`, `sokar-transport`, `sokar-homeserver` and the agents', in the Artifactory
  repositories `sokar-dist-deb` and `sokar-dist-rpm`, signed with the key pair `sokar-packages`.
- **Other ecosystems:** the Dart package `sokar_frontend`, the IntelliJ plugin id `org.fuin.sokar`.
- **The forge:** the organisation `sokar-ai`, its repositories, the site `sokar-ai.github.io`, the secret
  `SOKAR_UPDATE_TOKEN` and the variable `SOKAR_UPDATE_AUTO_MERGE`.

## Plan

**How each repository is renamed.** One commit per repository, made by a script its agent runs and reviews, never by
hand: `git mv` for every path naming `sokar`, then the three spellings `sokar`, `Sokar` and `SOKAR` replaced by
`porelo`, `Porelo` and `PORELO`, then a list of exceptions put back - what says what the old name was (the
changelog's released entries, the decision that records the rename), and what names something outside that is not
renamed. The commit is checked as any other: the whole build, the documents, and the acceptance on the VM where it
ships something. A repository's agent writes its issue from this plan before the window, with its own exceptions and
the size measured on its code.

**What the script does not do by replacement**, measured in `sokar`, and what follows from it:

- **The images that draw the name** (`sokar.xcf`, `sokar-pitch.svg`, and any icon another repository finds) keep their
  design and colours; only the word Sokar in them becomes Porelo, edited in the image rather than by the script.
- **History stays:** the released changelog entries (66 files under `changelog/v*` in `sokar`), past dates and hashes
  quoted in issues; `git log` is not rewritten.
- **The Shared Area's text names Sokar**, so its hash changes: `sokar-project` takes the new area first, and every
  repository takes it within the window.
- **Links resolve on the forge**, and the forge redirects an old name to a new one, not the other way: the
  organisation and the repositories are renamed there before the first renamed commit is pushed.
- **The SELinux types and the firewall's table** are renamed and need the native build and the acceptance on both
  legs, an enforcing Fedora for the policy, before `sokar`'s commit is named.
- **`porelo` is one character longer** than `sokar`: socket paths stay within their limit, and the tests that assert a
  cut or padded line are read, not regenerated.

**In this order**, each step waiting for the one before, since each resolves what the one before publishes:

1. **Preparation (S, the operator with the coordinator):** the organisation renamed `porelo-ai` and an empty
   `sokar-ai` made; the repositories renamed `porelo*`, the site `porelo-ai.github.io`; the secret and the variable
   made again under `PORELO_*`; the Artifactory repositories `porelo-dist-deb` and `porelo-dist-rpm` and the key pair
   `porelo-packages` made; every checkout's remote moved. Nothing of the code changes in this step.
2. **`sokar-parent` (XS)** to `porelo-parent`, then **`sokar-buildtools` (M**, 850 occurrences, 114 paths, four values
   in its Java that name the organisation or the product) - `porelo-release`, `porelo-machines`, its five modules - each
   published before `sokar` builds against it.
3. **`sokar` (L**, at its top: 13,482 occurrences, 919 paths, 7 varlink interfaces, 7 native-image directories): the
   packages, the 45 artifacts, the varlink interfaces, the commands, the unit, the firewall's
   table, the label, the variables, the paths, the branches, the packages and the documentation; published as a
   snapshot, since every other repository builds on its artifacts or speaks its contract.
4. **The repositories built on it, side by side:** `sokar-build-github` (S), `sokar-message-sluice` (S),
   `sokar-message-matrix` (S), `sokar-claude-code`, `sokar-pi` and `sokar-omp` (S each), `sokar-intellij` (S, its
   plugin id `org.fuin.porelo`), `sokar-frontend` (M, the Dart package `porelo_frontend` and its 708 files' imports).
5. **The words:** `sokar-ai.github.io` (S) and `sokar-project` (S), whose `project.yml` names every repository's new
   address.
6. **The local machine (S, the coordinator):** the checkouts' directories, `.AGENTS.md`, the channel's scripts and
   files, the VM accounts' installs - none of which is committed.

Then a release of each under the new coordinates, released by hand at Maven Central as every release is. The window
ends when every repository's `main` builds green under the new name and the operator has installed Porelo afresh on a
machine and found nothing that still says Sokar.

**Red first:** in each repository, a test of the documents that fails while any tracked file outside the exceptions
still says `sokar` - seen to fail before the script runs, green after, and kept, so the old name does not come back.

## To be checked

- What other ecosystems require of a new name: a new IntelliJ plugin id is a new plugin, not yet published, so
  nothing is lost; the Dart package is not published.
- Whether the forge carries an organisation's secrets, variables and Pages over a rename, or each is made again.
