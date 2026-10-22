# Porelo compared: features

What Porelo has, what is planned for it and what is missing, beside ten tools that isolate or run coding agents.

## How to read it

- **Porelo** is read from its documentation and the issue indexes of every Porelo repository. A planned feature names
  its issue; the index row says how far it is.
- **The other tools** are read from their published documentation. Nothing of it is tested: ❌ means the pages read
  do not name the feature and it does not fit how the tool is built, not that it is proven missing.
- **Two tools are changing:** the public Daytona repository is archived while its cloud service runs on, and Vibe
  Kanban has announced its end.
- **Columns:**

| Column | Tool |
|---|---|
| **Docker SB** | Docker Sandboxes (`sbx`) |
| **OpenShell** | NVIDIA OpenShell |
| **srt/CC** | Anthropic sandbox-runtime, or the sandbox in Claude Code |
| **Codex** | OpenAI Codex CLI, and Codex Cloud where needed |
| **cu** | Dagger container-use |
| **Squad** | Claude Squad |
| **Cond.** | Conductor |
| **VK** | Vibe Kanban |
| **E2B** | E2B |
| **Daytona** | Daytona |

**Legend:** ✅ yes · 🟡 partly (in the Porelo column: planned) · ❌ no · ❔ could not be found out

## Overview

87 features over the three tables below, counted per tool. The features are picked from Porelo's point of view, so
the counts show how close a tool comes to Porelo's aims, not which tool is better.

| Tool | ✅ yes | 🟡 partly | ❌ no | ❔ unknown |
|---|---|---|---|---|
| ▶ **Porelo** | **34** | **46 planned** | **7** | **0** |
| **Docker SB** | 16 | 15 | 33 | 23 |
| **OpenShell** | 9 | 12 | 42 | 24 |
| **srt/CC** | 7 | 15 | 62 | 3 |
| **Codex** | 6 | 19 | 49 | 13 |
| **cu** | 5 | 10 | 55 | 17 |
| **Squad** | 6 | 7 | 71 | 3 |
| **Cond.** | 8 | 10 | 61 | 8 |
| **VK** | 13 | 9 | 61 | 4 |
| **E2B** | 13 | 6 | 42 | 26 |
| **Daytona** | 15 | 12 | 41 | 19 |

## What Porelo has

Each feature links to the page that describes it.

| Feature | Porelo | Docker SB | OpenShell | srt/CC | Codex | cu | Squad | Cond. | VK | E2B | Daytona |
|---|---|---|---|---|---|---|---|---|---|---|---|
| [Agent isolated (a container or stronger)](https://github.com/porelo-ai/porelo/blob/main/doc/how-it-works.md)¹ · [2](https://github.com/porelo-ai/porelo/blob/main/doc/security.md) | ✅ | ✅ | ✅ | 🟡 | 🟡 | ✅ | ❌ | ❌ | ❌ | ✅ | ✅ |
| [Outbound network closed, failing closed](https://github.com/porelo-ai/porelo/blob/main/doc/security.md)² | ✅ | ✅ | ✅ | 🟡 | 🟡 | ❔ | ❌ | ❌ | ❌ | ❔ | ❔ |
| [Blocked already when the name is resolved (its own resolver)](https://github.com/porelo-ai/porelo/blob/main/doc/security.md) | ✅ | ❌ | ❌ | 🟡 | ❌ | ❔ | ❌ | ❌ | ❌ | ❔ | ❔ |
| [Only ports 80 and 443 to declared hosts](https://github.com/porelo-ai/porelo/blob/main/doc/reach.md) | ✅ | 🟡 | ❔ | 🟡 | ❔ | ❔ | ❌ | ❌ | ❌ | ❔ | ❔ |
| [Named allow sets and a refuse list](https://github.com/porelo-ai/porelo/blob/main/doc/project-file.md)³ | ✅ | 🟡 | 🟡 | 🟡 | 🟡 | ❔ | ❌ | ❌ | ❌ | ❔ | ❔ |
| [The person is asked when a connection is blocked](https://github.com/porelo-ai/porelo/blob/main/doc/how-it-works.md)⁴ | ✅ | ❔ | 🟡 | ✅ | 🟡 | ❔ | ❌ | ❌ | ❌ | ❔ | ❔ |
| [A running task widened without a restart](https://github.com/porelo-ai/porelo/blob/main/doc/security.md) | ✅ | ❔ | ✅ | ✅ | ❔ | ❔ | ❌ | ❌ | ❌ | ❔ | ❔ |
| [Credentials stay on the host (broker)](https://github.com/porelo-ai/porelo/blob/main/doc/credentials.md)⁵ | ✅ | ✅ | ✅ | ❌ | 🟡 | ❔ | ❌ | ❌ | ❌ | ❔ | ❔ |
| [The broker prevents token theft](https://github.com/porelo-ai/porelo/blob/main/doc/reach.md)⁶ | ✅ | ❔ | ❔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❔ | ❔ |
| [Further services with their own key through the broker](https://github.com/porelo-ai/porelo/blob/main/doc/credentials.md) | ✅ | 🟡 | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❔ | ❔ |
| [A subscription sign-in is renewed on the host](https://github.com/porelo-ai/porelo/blob/main/doc/credentials.md) | ✅ | ❔ | ❔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| [An encrypted vault with a key slot per device](https://github.com/porelo-ai/porelo/blob/main/doc/credentials.md) | ✅ | ❔ | ❔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❔ | ❔ |
| [Git gate: review before the upstream, enforced](https://github.com/porelo-ai/porelo/blob/main/doc/security.md)⁷ · [2](https://github.com/porelo-ai/porelo/blob/main/doc/reach.md) | ✅ | ❔ | ❌ | ❌ | 🟡 | 🟡 | 🟡 | 🟡 | 🟡 | ❌ | ❌ |
| [Three security classes (offline, guarded, online)](https://github.com/porelo-ai/porelo/blob/main/doc/security.md)⁸ | ✅ | ❌ | ❌ | ❌ | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| [No git key in the container](https://github.com/porelo-ai/porelo/blob/main/doc/how-it-works.md) | ✅ | ❔ | ❔ | ❌ | ❔ | ❔ | ❌ | ❌ | ❌ | ❔ | ❔ |
| [The working copy is a clone, not a mount](https://github.com/porelo-ai/porelo/blob/main/doc/how-it-works.md)⁹ | ✅ | ✅ | ❔ | ❌ | 🟡 | ✅ | 🟡 | 🟡 | 🟡 | 🟡 | 🟡 |
| [A task is kept, its session continues](https://github.com/porelo-ai/porelo/blob/main/doc/commands.md)¹⁰ | ✅ | ✅ | ❔ | 🟡 | 🟡 | ❔ | ✅ | ✅ | ✅ | ✅ | ✅ |
| [Several tasks in parallel](https://github.com/porelo-ai/porelo/blob/main/doc/how-it-works.md) | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| [Limits for CPU, memory and processes](https://github.com/porelo-ai/porelo/blob/main/doc/project-file.md) · [2](https://github.com/porelo-ai/porelo/blob/main/doc/security.md) | ✅ | ✅ | ❔ | ❌ | ❌ | ❔ | ❌ | ❌ | ❌ | ✅ | ✅ |
| [A signed or centrally set project configuration](https://github.com/porelo-ai/porelo/blob/main/doc/project-file.md)¹¹ | ✅ | 🟡 | ❔ | 🟡 | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| [Messages between tasks, signed and filtered](https://github.com/porelo-ai/porelo/blob/main/doc/messages.md) | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| [Any agent, as a package with a pinned checksum](https://github.com/porelo-ai/porelo/blob/main/README.md)¹² | ✅ | 🟡 | 🟡 | 🟡 | ❌ | 🟡 | 🟡 | 🟡 | 🟡 | 🟡 | 🟡 |
| [A log of blocked connections and DNS queries](https://github.com/porelo-ai/porelo/blob/main/doc/security.md)¹³ · [2](https://github.com/porelo-ai/porelo/blob/main/doc/commands.md) | ✅ | 🟡 | ❔ | 🟡 | 🟡 | 🟡 | ❌ | ❌ | ❌ | ❔ | 🟡 |
| [A file handed to a running task, and recorded](https://github.com/porelo-ai/porelo/blob/main/doc/commands.md) | ✅ | 🟡 | ❔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | 🟡 | 🟡 |
| [The forge's build result back in the task](https://github.com/porelo-ai/porelo/blob/main/doc/running.md) | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | 🟡 | ❌ | ❌ | ❌ |
| [Shows whether a task works or waits on somebody](https://github.com/porelo-ai/porelo/blob/main/doc/commands.md) | ✅ | ❔ | ❌ | ❌ | ❌ | ❌ | 🟡 | 🟡 | 🟡 | ❌ | ❌ |
| [Leave the terminal and attach again](https://github.com/porelo-ai/porelo/blob/main/doc/running.md) | ✅ | 🟡 | ❔ | ❌ | ❌ | ✅ | ✅ | ❔ | 🟡 | 🟡 | 🟡 |
| [A desktop interface, also for remote machines](https://github.com/porelo-ai/porelo-frontend)¹⁴ | ✅ | ❔ | ❌ | ❌ | ❌ | ❌ | 🟡 | 🟡 | ✅ | 🟡 | 🟡 |
| [A programming interface for clients](https://github.com/porelo-ai/porelo/tree/main/daemon/src/main/resources/varlink) | ✅ | ❔ | ✅ | 🟡 | ❔ | 🟡 | ❌ | 🟡 | ❌ | ✅ | ✅ |
| [Installed as a Linux package (apt/dnf)](https://github.com/porelo-ai/porelo/blob/main/README.md)¹⁵ | ✅ | ❔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| [Windows, with Porelo in WSL](https://github.com/porelo-ai/porelo-frontend)¹⁶ | ✅ | ✅ | 🟡 | 🟡 | ✅ | ❔ | ❔ | ❌ | ✅ | ✅ | ✅ |
| [Its own certificate authority for outbound TLS](https://github.com/porelo-ai/porelo/blob/main/doc/credentials.md) | ✅ | ❔ | ❔ | ❔ | ❔ | ❌ | ❌ | ❌ | ❌ | ❔ | ❔ |
| [Everything stopped with one command](https://github.com/porelo-ai/porelo/blob/main/doc/commands.md#panic) | ✅ | ❔ | ❔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❔ | ❔ |
| [Doctor's findings as data](https://github.com/porelo-ai/porelo/blob/main/doc/commands.md#doctor) | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |

1. **Isolation:**
   - Docker SB and E2B: a microVM with its own kernel, so stronger than Porelo.
   - Daytona: a container or a VM, by choice.
   - OpenShell: Landlock and seccomp.
   - srt/CC and Codex: only a sandbox at the operating-system level.
   - Porelo: rootless Podman, every capability dropped, `no-new-privileges`.
2. **Network block:** in Porelo, OCI hooks load the nftables rules into the task's network namespace, and no
   container starts without them. CC runs on without a sandbox when `failIfUnavailable` is not set. The Codex proxy
   covers neither MCP nor the model traffic.
3. **Allow sets:** Porelo has `egress.sets`, `domains` and `refused`. Docker SB has the presets Open, Balanced and
   Locked Down; OpenShell a YAML policy; srt/CC and Codex allow and deny lists.
4. **Asking:** Porelo asks Allow or Deny by desktop notification, once per target, and silence for 60 s counts as
   Deny. CC asks for a new domain. OpenShell holds risky policy changes back for review. Codex asks by its approval
   rule, per action.
5. **Broker:** Porelo trades a task-bound phantom token for the real key. Codex Cloud hands secrets out only in its
   setup phase.
6. **Token theft:** Porelo blocks `refresh_token` and `client_credentials` grants from the task, holds tokens back in
   responses and drops the task's own auth headers.
7. **Git gate:** 🟡 means a diff can be reviewed, but nothing enforces it: the agent holds git rights itself (Squad,
   Cond., VK, cu). Codex asks per action, not per push.
8. **Security classes:** the Codex modes (read-only, workspace-write, full access) measure something else.
9. **Working copy:** Docker SB has a clone mode for it, cu a branch of its own. Squad, Cond. and VK use worktrees on
   the host. E2B and Daytona bring files or the repository into the sandbox.
10. **Continuing:** E2B pauses with its memory, Daytona has snapshots. srt/CC and Codex continue only the
    conversation, not the environment.
11. **Project configuration:** Porelo signs it per project, and every machine checks it. Docker SB (governance), CC
    and Codex (managed settings) set it centrally, but sign nothing.
12. **Agents:** the others run several agents or any process, but with no pinned checksum.
13. **Log:**
    - Docker SB: a policy log and audit entries.
    - srt: monitoring of violations.
    - Codex and Daytona: OpenTelemetry.
    - cu: a command history.
14. **Interface:** Porelo has a Flutter app that reaches remote machines over ssh. Cond. exists only for macOS and
    only locally, Squad only as a TUI. VK has a web interface with a relay. E2B and Daytona have a web dashboard.
15. **Installation:** the others install through npm, Homebrew, install scripts or Helm; the cloud services need no
    installation.
16. **Windows:** the interface reaches a Porelo in a WSL distribution through `wsl.exe`. The IntelliJ plugin on
    Windows is planned:
    [IJ03](https://github.com/porelo-ai/porelo-intellij/blob/main/issues/README.md#ij03).

## What is planned

Each feature names its issue; the index row says how far it is.

| Feature | Porelo | Docker SB | OpenShell | srt/CC | Codex | cu | Squad | Cond. | VK | E2B | Daytona | Issue |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Review a diff in the IDE | 🟡 | ❌ | ❌ | ✅ | ❔ | ❌ | ❌ | ❌ | 🟡 | ❌ | ❌ | porelo-intellij [IJ01](https://github.com/porelo-ai/porelo-intellij/blob/main/issues/README.md#ij01) |
| A token ceiling per task | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | porelo [B138](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b138) |
| Tokens counted per task | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | porelo [B148](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b148) |
| An alert on what looks wrong, the task frozen¹ | 🟡 | ❌ | ❌ | ❌ | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | porelo [B139](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b139) |
| The workspace scanned for secrets at start | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | porelo [B140](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b140) |
| New dependencies checked (slopsquatting) | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | porelo [B141](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b141) |
| A template for a local provider | 🟡 | ❌ | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | porelo [B149](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b149) |
| The whole diff in review | 🟡 | ❌ | ❌ | ❌ | ❔ | 🟡 | ✅ | ✅ | ✅ | ❌ | ❌ | porelo [B150](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b150) |
| A tamper-evident event log² | 🟡 | 🟡 | ❌ | ❌ | 🟡 | ❌ | ❌ | ❌ | ❌ | ❔ | 🟡 | porelo [B154](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b154), then [B121](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b121) |
| An approve bound to the reviewed version | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | porelo [B136](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b136) (`--commit` exists) |
| A task's virtual screen seen and controlled | 🟡 | ❔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ | ✅ | porelo [B100](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b100) |
| Waiting work tried in a fresh container | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❔ | 🟡 | ❌ | ❌ | porelo [B95](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b95), porelo-frontend [F74](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f74) |
| An overview in the terminal that updates itself | 🟡 | ❔ | ❌ | ❌ | ❌ | ❌ | ✅ | ❌ | ❌ | ❌ | ❌ | porelo [B48](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b48) |
| An attached agent shown at rest or working | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | 🟡 | 🟡 | 🟡 | ❌ | ❌ | porelo [B118](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b118), porelo-frontend [F99](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f99) |
| What the machine did, past the end of a task | 🟡 | 🟡 | ❌ | ❌ | 🟡 | ❌ | ❌ | ❌ | ❌ | ❔ | 🟡 | porelo [B26](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b26) |
| The conversation survives a real restart | 🟡 | ❔ | ❔ | 🟡 | 🟡 | ❔ | ❔ | ✅ | ❔ | ✅ | 🟡 | porelo [B46](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b46) |
| A waiting push read as a pull request | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ | ✅ | ❌ | ❌ | porelo-frontend [F78](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f78) |
| A timeline of everything a piece of work did | 🟡 | ❌ | ❌ | ❌ | ❌ | 🟡 | ❌ | 🟡 | 🟡 | ❌ | ❌ | porelo-frontend [F111](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f111), [F112](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f112) |
| An unattended job's refusal reaches a person | 🟡 | ❔ | ❔ | ❌ | ❔ | ❌ | ❌ | ❔ | ❔ | ❌ | ❌ | [PJ08](README.md#pj08) |
| MCP tools pinned, changes held back³ | 🟡 | 🟡 | ❌ | ❌ | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | [PJ15](README.md#pj15) |
| Personal data caught by the message filter | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | porelo-message-sluice [SL07](https://github.com/porelo-ai/porelo-message-sluice/blob/main/issues/README.md#sl07) |
| A kernel of its own per task (experiment) | 🟡 | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ | ✅ | porelo [B59](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b59) |
| Remote machines reached through a tunnel | 🟡 | 🟡 | 🟡 | ❌ | 🟡 | ❌ | ❌ | ❌ | ✅ | ✅ | ✅ | porelo [B06](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b06) |
| A misuse test suite as a release condition⁴ | 🟡 | ❌ | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | porelo [B142](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b142) |
| AI provenance in the commit, set on the host⁵ | 🟡 | ❌ | ❌ | 🟡 | ❔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | porelo [B144](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b144) |
| Four eyes at the gate | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | porelo [B145](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b145) |
| A wall-clock limit for unattended runs | 🟡 | ❔ | ❔ | ❌ | ❔ | ❌ | ❌ | ❌ | ❌ | ✅ | ✅ | porelo [B147](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b147) |
| The providers a project or machine allows | 🟡 | ✅ | 🟡 | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | porelo [B151](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b151), [PJ16](README.md#pj16) |
| An organization's policy developers cannot override⁶ | 🟡 | ✅ | ❔ | ✅ | ✅ | ❌ | ❌ | ❔ | ❌ | ❔ | 🟡 | [PJ16](README.md#pj16), porelo-frontend [F62](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f62) |
| Logs documented field by field, a data-protection page, an inventory | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | porelo [B155](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b155), [B143](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b143), [B156](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b156) |
| Unused key slots and deploy keys reported | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | porelo [B153](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b153) |
| Intermediate results handed between tasks | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❔ | 🟡 | porelo [B15](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b15) |
| Several machines on one homeserver, groups | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | porelo [B86](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b86), [B14](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b14), porelo-message-matrix [MX12](https://github.com/porelo-ai/porelo-message-matrix/blob/main/issues/README.md#mx12) |
| A stance on A2A, MCP, ACP and AG-UI | 🟡 | ❔ | ❔ | ❔ | ❔ | 🟡 | ❔ | ❔ | ❔ | ❔ | ❔ | [PJ24](README.md#pj24) |
| macOS, with Apple Containers | 🟡 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | [PJ25](README.md#pj25) |
| More agents: Codex CLI, Antigravity CLI, Copilot CLI, Grok Build, OpenCode | 🟡 | ✅ | 🟡 | ❌ | ❌ | 🟡 | 🟡 | 🟡 | ✅ | 🟡 | 🟡 | porelo-codex [CX01](https://github.com/porelo-ai/porelo-codex/blob/main/issues/README.md#cx01), porelo-agy [AG01](https://github.com/porelo-ai/porelo-agy/blob/main/issues/README.md#ag01), [A08](README.md#a08), [A09](README.md#a09), [A10](README.md#a10) |
| More providers through the broker: OpenAI, Google, xAI, Zhipu | 🟡 | 🟡 | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | porelo [P05](https://github.com/porelo-ai/porelo/blob/main/issues/providers/README.md#p05), [P06](https://github.com/porelo-ai/porelo/blob/main/issues/providers/README.md#p06), [P07](https://github.com/porelo-ai/porelo/blob/main/issues/providers/README.md#p07), [P08](https://github.com/porelo-ai/porelo/blob/main/issues/providers/README.md#p08) |
| A device's key released only with a touch or a PIN | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | porelo-frontend [F52](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f52) |
| Several attempts at one assignment, compared ("best of N")⁷ | 🟡 | ❌ | ❌ | ❌ | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | porelo [B163](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b163) |
| Rollback points per agent turn (files and chat)⁸ | 🟡 | ❌ | ❌ | 🟡 | ❔ | ❌ | ❌ | ✅ | ❌ | ❌ | ❌ | porelo [B164](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b164) |
| A port forward or preview URL to the dev server | 🟡 | ✅ | ❔ | ❌ | ❌ | 🟡 | ❌ | ❔ | ✅ | ❔ | ✅ | porelo [B165](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b165) |
| Line comments in review sent back to the agent | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❔ | ✅ | ❌ | ❌ | porelo [B166](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b166) |
| An MCP gateway on the host that sees tool calls | 🟡 | ✅ | ❔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❔ | porelo [B167](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b167) |
| A recording of the session, played back | 🟡 | ❌ | ❌ | ❌ | ❌ | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | porelo [B168](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b168) |
| Containers inside a task (Docker or Podman for Testcontainers) | 🟡 | ✅ | ❔ | ❌ | ❌ | ❔ | ❌ | ❌ | ❌ | ❔ | ❔ | porelo [B169](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b169) |
| A devcontainer file as the image source | 🟡 | ❔ | ❔ | ❌ | 🟡 | ❔ | ❌ | ❔ | ❔ | ❔ | ❔ | porelo [B170](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b170) |

1. **Alert:** Codex lets a reviewing agent refuse risky actions. That comes closest, but it is no alert on what
   looks wrong.
2. **Event log:**
   - Docker SB: audit entries.
   - Codex: OpenTelemetry.
   - Daytona: audit logs in its enterprise offer.
   - None of them describes its log as tamper-evident.
3. **MCP:** Docker SB routes MCP through a gateway with organization policies. In Codex, admins restrict the MCP
   servers. None describes pinning the tools.
4. **Test suite:** OpenShell checks policies with a formal prover, not with misuse scenarios.
5. **AI provenance:** CC adds a co-author trailer, but the agent writes it, not the host.
6. **Organization policy:** Docker SB needs a paid governance subscription of its own for it; Codex uses MDM, CC
   managed settings.
7. **Best of N:** Codex Cloud runs several attempts at one task. Not found in the others.
8. **Rollback points:** CC can rewind to a checkpoint. Conductor resets files, git and chat with one click, for
   Claude Code and Codex.

## What is missing and not planned

Judged against Porelo's aims: one person, one machine, review before the upstream, nothing leaves the machine
unseen.

| Feature | Porelo | Docker SB | OpenShell | srt/CC | Codex | cu | Squad | Cond. | VK | E2B | Daytona | Judged for Porelo |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Snapshot, fork, pause and resume with memory | ❌ | 🟡 | ❔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ | ✅ | **partly:** forking a task fits; CRIU with rootless Podman is limited |
| A pull request on the forge from the approve, with a description | ❌ | ❌ | ❌ | ❌ | ❔ | ❌ | ❌ | ✅ | ✅ | ❌ | ❌ | **partly:** work on the host with the host's key; the description must not come from the agent unreviewed |
| Network rules per program | ❌ | ❔ | ✅ | ❌ | ❌ | ❔ | ❌ | ❌ | ❌ | ❔ | ❔ | **partly:** of little use while everything in a task belongs to one agent; hard with nftables |
| Rules per HTTP method or path¹ | ❌ | ❔ | 🟡 | 🟡 | ❌ | ❔ | ❌ | ❌ | ❌ | ❔ | ❔ | **partly:** needs TLS interception beyond the broker, more attack surface on the host |
| GPU passthrough into the task | ❌ | 🟡 | ✅ | ❌ | ❌ | ❔ | ❌ | ❌ | ❌ | ❔ | ✅ | **partly:** possible with Podman and CDI; local models belong on the host, as porelo [B149](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b149) has it |
| Export over OpenTelemetry | ❌ | ❔ | ❌ | ❔ | ✅ | ❌ | ❌ | ❌ | ❌ | ❔ | ✅ | **partly:** needless for one person, useful for companies; small as an output of porelo [B154](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b154) |
| A kanban or task board | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ | ❌ | ❌ | **partly:** overlaps with the interface; the forge manages tasks better |

1. **HTTP rules:** OpenShell names approving a new API method. srt intercepts TLS experimentally.

### What does not fit Porelo

Other tools have these, but they do not fit Porelo's aims and are left out of the tables:

- **Policy as code with formal proof** (OpenShell): `project.yml` stays small and readable; `--dry-run` shows the
  rules beforehand.
- **An AI reviewer that approves actions** (srt/CC, Codex): fixed rules on purpose, rather than one more model.
- **A session moved to the cloud, cloud sandboxes** (Docker SB, srt/CC, Codex, Cond., VK, E2B, Daytona): one
  machine, and nothing leaves it unseen. Docker SB has `--cloud` (experimental, paid), Conductor has announced a
  cloud, VK has a self-hosted cloud, CC has separate cloud sessions.
- **SDKs that create sandboxes from a program** (OpenShell, srt/CC, E2B, Daytona): Porelo is no sandbox service for
  other applications; varlink serves its own clients.
- **Running on Kubernetes or as a team server** (OpenShell, VK, E2B, Daytona): one node per user account, no
  control center.
- **SSO and RBAC** (Docker SB, Codex, Daytona): a matter of the operating system and the organization; four eyes at
  the gate is planned.
- **Billing per second, hosted compute** (Docker SB, E2B, Daytona): it runs on your own machines.
