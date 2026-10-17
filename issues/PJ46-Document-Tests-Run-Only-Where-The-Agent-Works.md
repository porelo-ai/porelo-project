# PJ46 — Document tests run only where the agent works

**Status:** Estimated.
**Size:** M - one or two lines of build configuration in each of twelve repositories, no contract and no code; it
crosses repositories, but every part is XS and none waits on another.

**What must be true.** The tests that read only issues and documents - the old name refused, citations, the index,
the Shared Area's hash, a site's documents - are run by the agent on its own machine before every hand-over, and
never in a Build. No repository's Build runs them, and a commit that changes only issues or documents starts no
Build. The *Shared rules check*, which runs once a day and on a pull request and leases no machine, keeps
running them.

## Why

A commit that set an issue Finished also took the issue out of a test's list of exceptions. That test is code, and
code is not in a Build's `paths-ignore`, so the push of an issue change started a whole Build with its rented
acceptance machines, in several repositories at once. It takes time and money for checks that say nothing about
whether the product works, and that the agent has already run before handing the commit over.

## Decided

- **The Build leaves them out by its build tool's own switch, not by its paths.** In Maven they are the tests of
  the `documents` group, which a plain build leaves out and the profile `-Pdocuments` runs alone. Dart, Gradle
  and the site's Python have the equivalent: a tag or task left out by default and asked for by name. The agent and
  the daily *Shared rules check* ask for it, and the Build does not.
- **A document test names no single issue.** An exception it needs - the issues that record a rename, say - is
  found by what the issue says, such as a title pattern, never by its number, path or anchor. Setting an issue
  Finished then never touches a test, so the push stays one of `issues/` alone, which `paths-ignore` already skips.
  It keeps the rule that code cites no issue number.
- **No `paths-ignore` for the tests themselves.** A change to a document test is a change to code and may start a
  Build; it is rare once no test names an issue.

## What is there today

- **No build tool leaves them out.** The Maven repositories tag them `documents` and declare a profile `documents`
  that sets `groups` to run them alone, but no pom sets `excludedGroups`, so a plain `verify` runs them with the
  rest. IntelliJ's `test` excludes only `live`. The interface's `flutter test` in its Maven build has no tag filter;
  its Windows job already passes `--exclude-tags "linux || documents"`. The site's `site.yml` runs
  `unittest discover -s tests`, which takes `test_documents_*.py` too.
- **The parent** runs `test/no-old-name.sh` in its Build, which has no path filter, and has no *Shared rules check*.
- **No document test names an issue** once this round's commits are pushed: the exceptions are released changelog
  entries, prose sentences and, in two repositories, the rename issue matched by its title.
- **Every repository except the parent and the site** has a `paths-ignore` for `**/*.md`, `doc/**`, `issues/**` and
  `mkdocs.yml` on push; `porelo-build-github` and `porelo-intellij` have none on `pull_request`.

## Plan

One commit per repository, by its agent:

1. **Maven** (`porelo`, `porelo-buildtools`, `porelo-build-github`, `porelo-claude-code`, `porelo-pi`, `porelo-omp`,
   `porelo-message-sluice`, `porelo-message-matrix`): the property `excludedGroups` set to `documents` by default,
   and the profile `documents` setting it empty beside `groups`. In each child, not in `porelo-parent`, so no
   parent release is needed.
2. **`porelo-intellij`:** `tasks.test` excludes the tags `live` and `documents`; `documentsTest` stays as it is.
3. **`porelo-frontend`:** the Maven `flutter-test` execution passes `--exclude-tags documents`.
4. **`porelo-ai.github.io`:** `site.yml`'s test step takes `test_assemble*.py` only (or every `test_*.py` but
   `test_documents_*`); the *Shared rules check* keeps `test_documents_*.py`.
5. **`porelo-parent`:** `test/no-old-name.sh` moves from the Build to a new *Shared rules check*, and the Build gets
   the same `paths-ignore` as the others.
6. **`porelo-build-github`, `porelo-intellij`:** the same `paths-ignore` on `pull_request` as on push.

**Proof, not a test of the workflow:** in each repository a plain build run once and its report shows no test tagged
`documents` ran; the documents profile, tag or task run once and shows they all ran; the *Shared rules check* run by
hand once after the push. The tag's guard (`DocumentTestsTaggedTest` and its counterparts) already fails a test that
reads documents without the tag, so nothing slips into the Build untagged.
