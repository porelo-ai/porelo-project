# PJ42 — The forge and Artifactory prepared for Porelo

**Status:** Estimated.
**Size:** S - settings at the forge and at Artifactory, done by the operator with the coordinator in one sitting, and
every checkout's remote; no code.

**What must be true.** Before the first renamed commit is pushed, the forge and Artifactory already carry the new
names, so every link, workflow and publish of a renamed repository resolves: every repository lives in the
organisation `porelo-ai` as `porelo*`, `sokar-ai` holds only its README and the old name, and the package
repositories and the signing key pair exist under `porelo-*`.

Step 1 of [PJ41](README.md#pj41).

## Plan

`porelo-ai` exists already and is empty, so `sokar-ai` is not renamed: its repositories are transferred.

1. **What the organisation carries made again in `porelo-ai`**, before the first transfer: the secrets and the
   variable as `PORELO_UPDATE_TOKEN`, `PORELO_DOCS_READ` and `PORELO_UPDATE_AUTO_MERGE`, the Actions settings, the
   rulesets, the members' rights, and the access of every token that reads or writes the repositories (the
   coordinator's read of the builds, the update token); a transfer carries none of the organisation's own settings.
2. **Each repository transferred** from `sokar-ai` to `porelo-ai` and renamed `sokar*` to `porelo*` (`sokar` to
   `porelo`, `sokar-ai.github.io` to `porelo-ai.github.io`): `sokar-parent`, `sokar-buildtools`, `sokar`,
   `sokar-build-github`, `sokar-message-sluice`, `sokar-message-matrix`, `sokar-claude-code`, `sokar-pi`,
   `sokar-omp`, `sokar-intellij`, `sokar-frontend`, `sokar-ai.github.io` and `sokar-project`; after each, its old
   address checked for a redirect to the new, by the web and by `git fetch`. `flutter-guided-walk` is not in the
   organisation and stays as it is.
3. **`sokar-ai` keeps only `.github`**, whose profile README is rewritten to say where Porelo is and that nothing of
   Sokar is carried over; `porelo-ai` gets a `.github` of its own with the profile under the new name. No repository
   of an old name is made in `sokar-ai` again, since it would end that name's redirect.
4. **At Artifactory:** `porelo-dist-deb` and `porelo-dist-rpm` made like `sokar-dist-*`, and the key pair
   `porelo-packages`; the access the build uses checked from `porelo-ai`.
5. **Every checkout's remote** on this machine moved to the new address (`git remote set-url`), each repository's
   `main` fetched once from it.

**Checked:** each repository's old address answers with a redirect to the new; a fetch from every new remote succeeds;
a workflow run by hand in `porelo-ai` reads its secrets; `sokar-ai` shows only its profile.

## To be checked

- What a transfer carries - repository secrets and variables, rulesets, Pages, the Actions history - and what is
  made again in `porelo-ai`.
- Whether the transfer takes the new name in the same step, or the repository is renamed after it.
- Whether the site's old address `sokar-ai.github.io` redirects after the transfer; if not, `sokar-ai`'s profile is
  the only pointer.
