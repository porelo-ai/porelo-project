# PJ43 — `sokar-project` renamed `porelo-project`

**Status:** Estimated.
**Size:** S - 626 occurrences in 35 of 40 files and 4 paths, words and addresses only; checked by hand, since this
repository has no build.

**What must be true.** Nothing in this repository says Sokar any more, except what records the old name: the planning,
the documents, `project.yml` with every repository's new address, and the Shared Area's text, whose new hash every
repository then takes.

Step 5 of [PJ41](README.md#pj41).

## Plan

1. **The script** as [PJ41](README.md#pj41) says: `git mv` for the four paths naming `sokar`, then `sokar`/`Sokar`/`SOKAR` replaced by
   `porelo`/`Porelo`/`PORELO`; the issue numbers of the other repositories stay (B, F, CC, ...), only their addresses
   change.
2. **The exceptions put back:** [PJ41](README.md#pj41) itself and this issue, which record the rename; the
   operator's decisions quoted with their old wording; dates and hashes of past work.
3. **`project.yml`:** the project's name, every `upstream`, and its description.
4. **The Shared Area:** its text renamed, the hash rewritten, before any other repository takes it in the window.

**Checked by hand:** a search of every tracked file for `sokar` in any case finds only the exceptions; the shared
checks, read with the release tools from their new coordinates, are green.
