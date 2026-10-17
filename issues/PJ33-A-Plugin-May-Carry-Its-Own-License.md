# PJ33 — A plugin may carry its own license

**Status:** Analyzed; the license is decided: Apache-2.0 for the parts others link.
**Size:** L - crosses `porelo` (three modules, the varlink definitions, the documentation) and the shared tooling's license check, after legal advice.

**What must be true.** Whoever writes an agent, a build reader, a messaging transport or a client for
Porelo may license it as they choose, proprietary included, while Porelo itself stays under the GPL
v3 or later. The documentation says where that boundary is.

## Why

Porelo promises that adding an agent - "including a proprietary agent that will never be upstreamed" -
means adding a directory, not patching Porelo (`porelo` `doc/why.md`). Today that holds only for some
kinds of plugin:

| Plugin | What it takes from Porelo | Porelo code in the plugin |
|---|---|---|
| Messaging transport | the protocol in `porelo` `doc/transports.md` (`describe`, JSON on standard input and output, exit codes, secrets as environment variables) | none |
| Client (an interface, an IDE plugin) | the varlink interface definitions and the socket | none, unless it uses `porelo-wire` |
| Agent | `porelo-agent-api` and `porelo-wire`, started through `AgentMain` (`porelo` `agents/README.md`) | compiled in, also into the native image |
| Build reader | `porelo-build-api` (`BuildMain`) and `porelo-wire` | compiled in |
| Build tooling (`porelo-parent`, `porelo-release`, `porelo-machines`) | used while building and checking | none in what ships |

Programs that talk only through pipes, sockets, files or command lines are, as the FSF reads the
GPL, separate works. A program that links a GPL library and is distributed is a combined work and
must be offered under a GPL-compatible license. So an agent or a build reader built the documented
way is bound to the GPL today, and a transport or a client is not.

All of Porelo is GPL-3.0-or-later today, with no exception and no differently licensed module.

## The shape

1. **The parts others link under Apache-2.0:** `porelo-agent-api`, `porelo-build-api`, `porelo-wire` and
   the `.varlink` interface definitions. Everything else in Porelo stays GPL-3.0-or-later. A plugin may
   then carry any license, and a plugin built as one native image needs nothing further: Apache-2.0
   asks for the license and notices to be kept, not for the library to be replaceable, which the LGPL
   would ask of a statically linked native image. Apache-2.0 code may be combined into GPL-3.0 work,
   so Porelo itself keeps using these libraries unchanged.
2. **The boundary written down**, in `porelo`'s documentation and its agent and transport guides: the
   protocols - the transport JSON, the varlink interfaces, the agent and reader descriptions - may be
   implemented by anyone; a plugin that only talks through them is a work of its own.
3. **Each artifact names its license** in its POM, its packages and its source headers, and the
   build checks that a module of the interface libraries depends on nothing GPL- or LGPL-only.

Changing the license of existing code needs every contributor's consent; today that is one person,
and every outside contribution makes it harder, so this comes before contributions are invited
(`porelo-project` [PJ27](README.md#pj27)).

## Plan

- **Today**: every module is GPL-3.0-or-later through `porelo-parent`'s `<licenses>`; no source carries
  a header; the interface libraries are `porelo/wire`, `porelo/agents/api` (which links `snakeyaml`,
  Apache-2.0) and `porelo/builds/api` (with `org.fuin.porelo.Build1.varlink`); the daemon's definitions
  are in `porelo/daemon/src/main/resources/varlink/`.
- **1. Legal advice**, by the operator.
- **2. `porelo`**: `LICENSE` and `NOTICE` in each interface module, its POM's
  `<licenses>`, source headers, and the varlink definitions marked or moved so they carry Apache-2.0.
- **3. The check**: a build of an interface module fails on a dependency that is GPL- or LGPL-only. Seen
  to fail first: a GPL-only test dependency added to `porelo-wire`, accepted.
- **4. The documentation** in `porelo`: the boundary in one place, linked from `agents/README.md`, the
  build reader guide and `doc/transports.md`.

## Acceptance

- Apache-2.0 is applied to each interface library, checked with legal advice: `LICENSE` and `NOTICE`
  in the module, the POM's `<licenses>`, the packages, the source headers.
- `porelo`'s documentation states the boundary in one place, linked from the agent, reader and
  transport guides.
- A build check fails when an interface library gains a dependency that is GPL- or LGPL-only.

## To be checked

- Whether the daemon's varlink definitions move out of `daemon` into a module of their own, so that they
  can carry Apache-2.0 - Agent Core's to decide.
