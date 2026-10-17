# PJ42 — The forge and Artifactory prepared for Porelo

**Status:** Review.
**Size:** S - settings at the forge and at Artifactory, done by the operator with the coordinator, and every
checkout's remote; no code.

**What must be true.** Before the first renamed commit is pushed, the forge and Artifactory already carry the new
names, so every link, workflow and publish of a renamed repository resolves: every repository lives in the
organisation `porelo-ai` as `porelo*`, `sokar-ai` holds only its profile and the old name, and the package
repositories and the signing key pair exist under `porelo-*`.

Step 1 of [PJ41](README.md#pj41).

## How it was done

`porelo-ai` existed already and was empty, so `sokar-ai` was not renamed: its repositories were transferred, in this
order.

1. **The organisation's settings made again in `porelo-ai`**, which a transfer does not carry: the Actions settings
   (with *Allow GitHub Actions to create and approve pull requests*), the organisation's secrets and the variable
   `JF_URL` under their old names, each restricted to the repositories that read it, and the ruleset on `main`
   (deletion, non-fast-forward, pull request, linear history, the coordinator in its bypass list).
2. **Each repository transferred** from `sokar-ai` to `porelo-ai` and renamed `sokar*` to `porelo*` in a second step
   (`sokar-ai.github.io` to `porelo-ai.github.io`): first the twelve the window renames, `sokar-intellij` and the test
   repositories `sokar-test-project`, `sokar-test-1` and `sokar-test-2` later in the window. After each, its old
   address was checked to redirect, by the web and by `git ls-remote`, and its `main` to be unchanged.
3. **What a transfer leaves behind**, found and put right:
   - the scheduled workflows stop and are started once by hand in the new organisation;
   - a fine-grained token scoped to `sokar-ai` cannot read a transferred repository, not even through its old
     address: the coordinator's read of the builds and the site's token for the private `porelo-intellij` were made
     again for `porelo-ai`, the site's secret under the new name `PORELO_DOCS_READ`, and `project.yml`'s
     `upstream:` addresses moved to `porelo-ai` before the site could read them;
   - the repository's own secrets, variables, Pages and Actions caches travel with it.
4. **`sokar-ai` keeps only `.github`**, whose profile says where Porelo is; `porelo-ai` has a `.github` of its own
   with the profile under the new name. No repository of an old name is made in `sokar-ai` again, since it would end
   that name's redirect. The organisation's secrets in `sokar-ai` were deleted once nothing read them.
5. **At Artifactory:** `porelo-dist-deb`, `porelo-dist-rpm`, `porelo-dist-intellij` and `porelo-dist-windows`
   made like `sokar-dist-*`, and a new key pair `porelo-packages` (RSA 4096, five years) bound to the Debian and
   RPM repositories. `porelo-dist-rpm` needs the *YUM Metadata Folder Depth* of 1, as `sokar-dist-rpm` has; a YUM
   repository made by hand starts at 0 and indexes beside the channel instead of in it.
6. **Every checkout's remote** on this machine moved to the new address and fetched once from it.

**Checked:** each old address redirects to the new; a fetch from every new remote succeeds; a workflow run by hand
in `porelo-ai` reads its secrets; `sokar-ai` shows only its profile; the published indexes of `porelo-dist-deb` and
`porelo-dist-rpm` are signed by `porelo-packages`.

## Learned

- No update token and no auto-merge variable are needed: neither existed in `sokar-ai`, and the update jobs run on
  their fallback.
- A key pair's fingerprint is not a name: the rename script cannot change one, so every place that pins the package
  key was corrected by hand and is now held to the served key by a test.
