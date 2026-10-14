# PJ42 — The forge and Artifactory prepared for Porelo

**Status:** Estimated.
**Size:** S - settings at the forge and at Artifactory, done by the operator with the coordinator in one sitting, and
every checkout's remote; no code.

**What must be true.** Before the first renamed commit is pushed, the forge and Artifactory already carry the new
names, so every link, workflow and publish of a renamed repository resolves: the organisation is `porelo-ai`, its
repositories `porelo*`, an empty `sokar-ai` holds the old name, and the package repositories and the signing key pair
exist under `porelo-*`.

Step 1 of [PJ41](README.md#pj41).

## Plan

1. **The organisation renamed** `sokar-ai` to `porelo-ai` at the forge; at once an empty organisation `sokar-ai` made
   by the operator, with a README that says where Porelo is and that nothing of Sokar is carried over.
2. **Each repository renamed** `sokar*` to `porelo*` (`sokar` to `porelo`, `sokar-ai.github.io` to
   `porelo-ai.github.io`); `flutter-guided-walk` is not in the organisation and stays as it is.
3. **The secrets and the variable** made again as `PORELO_UPDATE_TOKEN`, `PORELO_DOCS_READ` and
   `PORELO_UPDATE_AUTO_MERGE`, and the Artifactory access the organisation carries checked after the rename.
4. **At Artifactory:** `porelo-dist-deb` and `porelo-dist-rpm` made like `sokar-dist-*`, and the key pair
   `porelo-packages`.
5. **Every checkout's remote** on this machine moved to the new address (`git remote set-url`), each repository's
   `main` fetched once from it.

**Checked:** each repository's old address answers with a redirect to the new; a fetch from every new remote succeeds;
`sokar-ai` shows only its README.

## To be checked

- Whether the forge carries the organisation's secrets, variables and Pages over the rename, or each is made again.
