# PJ41 — Sokar is renamed Porelo

**Status:** Accepted.

**What must be true.** The product, its repositories, its organisation at the forge, its packages and artifacts, its
commands, its paths and its documentation are named Porelo; nothing a user installs, types or reads still says
Sokar, except where it says what the old name was. Porelo is installed afresh: nothing of a machine that ran Sokar is
carried over.

## Why

The name is to change before the repositories are opened to others and before the work moves to a server
([PJ39](README.md#pj39), [PJ40](README.md#pj40)): every later step - the contributor guide, the deploy collection,
the published artifacts - would otherwise carry the old name, and renaming grows with every repository and every
user.

## The shape proposed

What carries the name today, counted across the checkouts:

- **The organisation and the repositories:** `sokar-ai` and its 18 repositories named `sokar*`, the site
  `sokar-ai.github.io`.
- **The code:** 1,206 Java files in packages under `org.fuin.sokar`; 320 poms with the group `org.fuin.sokar`; the
  artifacts on Maven Central under it.
- **The commands and the services:** `sokar`, `sokard`, `sokar-machines`, `sokar-release`, their systemd units, the
  Debian and RPM packages.
- **The paths:** `~/.sokar`, `$XDG_CONFIG_HOME/sokar`, `$XDG_DATA_HOME/sokar`, `$XDG_RUNTIME_DIR/sokar`, and
  `/sokar/files` inside a task.
- **The contracts:** the varlink interfaces' names, environment variables, file names such as `project.yml`'s keys
  where they say `sokar`, branch names such as `sokar/<task>`.
- **The words:** documentation, issues, the agents' names and rules.

Done in one go per repository, in the order its dependants need, with a release under the new coordinates and the old
ones marked as moved.

## Decided

- **Group and packages: `org.fuin.porelo`**, in the namespace already verified at Maven Central.
- **The organisation at the forge is renamed** (`sokar-ai` to `porelo-ai`), and an empty organisation `sokar-ai` is
  made at once to hold the old name, so the forge's redirects are not taken over by somebody else.
- **No migration:** Porelo is installed afresh and its projects set up again; no state, command or path of Sokar is
  read or kept, and no `sokar` command remains.
- **First in Phase 0 of [PJ39](README.md#pj39)**, before the reformatting of [PJ29](README.md#pj29), in a window with
  no other work open: what is running is finished and pushed first.
