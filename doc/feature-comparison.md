# Porelo compared: features

What Porelo has, what is planned for it and what is missing, beside twelve tools that isolate or run coding agents.

## How to read it

- **Porelo** is read from its documentation and the issue indexes of every Porelo repository. A planned feature names
  its issue; the index row says how far it is.
- **The other tools** are read from their published documentation. Nothing of it is tested: ❌ means the pages read
  do not name the feature and it does not fit how the tool is built, not that it is proven missing.
- **Two tools are changing:** the public Daytona repository is archived while its cloud service runs on, and Vibe
  Kanban has announced its end.
- **Two columns are runtimes, not tools:** gVisor and Kata Containers are OCI runtimes beneath an engine such as
  Docker or containerd. Everything above the container (broker, gate, review, interface) lies outside them, so most
  rows are ❌ by scope; a 🟡 for attaching or a port forward means the engine gives it, not the runtime. Kata does not
  support Podman.
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
| **gVisor** | gVisor (`runsc`) |
| **Kata** | Kata Containers |

**Legend:** ✅ yes · 🟡 partly (in the Porelo column: planned) · ❌ no · ❔ could not be found out

## Overview

87 features over the three tables below, counted per tool. The features are picked from Porelo's point of view, so
the counts show how close a tool comes to Porelo's aims, not which tool is better.

| Tool | ✅ yes | 🟡 partly | ❌ no | ❔ unknown |
|---|---|---|---|---|
| ▶ **Porelo** | **40** | **39 planned** | **8** | **0** |
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
| **gVisor** | 8 | 8 | 69 | 2 |
| **Kata** | 7 | 9 | 70 | 1 |

## What Porelo has

Each feature links to the page that describes it.

| Feature | Porelo | Docker SB | OpenShell | srt/CC | Codex | cu | Squad | Cond. | VK | E2B | Daytona | gVisor | Kata |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| [Agent isolated (a container or stronger)](https://github.com/porelo-ai/porelo/blob/main/doc/how-it-works.md)¹ · [2](https://github.com/porelo-ai/porelo/blob/main/doc/security.md) | ✅ | ✅ | ✅ | 🟡 | 🟡 | ✅ | ❌ | ❌ | ❌ | ✅ | ✅ | ✅ | ✅ |
| [Outbound network closed, failing closed](https://github.com/porelo-ai/porelo/blob/main/doc/security.md)² | ✅ | ✅ | ✅ | 🟡 | 🟡 | ❔ | ❌ | ❌ | ❌ | ❔ | ❔ | 🟡 | 🟡 |
| [Blocked already when the name is resolved (its own resolver)](https://github.com/porelo-ai/porelo/blob/main/doc/security.md) | ✅ | ❌ | ❌ | 🟡 | ❌ | ❔ | ❌ | ❌ | ❌ | ❔ | ❔ | ❌ | ❌ |
| [Only ports 80 and 443 to declared hosts](https://github.com/porelo-ai/porelo/blob/main/doc/reach.md) | ✅ | 🟡 | ❔ | 🟡 | ❔ | ❔ | ❌ | ❌ | ❌ | ❔ | ❔ | ❌ | ❌ |
| [Named allow sets and a refuse list](https://github.com/porelo-ai/porelo/blob/main/doc/project-file.md)³ | ✅ | 🟡 | 🟡 | 🟡 | 🟡 | ❔ | ❌ | ❌ | ❌ | ❔ | ❔ | ❌ | ❌ |
| [The person is asked when a connection is blocked](https://github.com/porelo-ai/porelo/blob/main/doc/how-it-works.md)⁴ | ✅ | ❔ | 🟡 | ✅ | 🟡 | ❔ | ❌ | ❌ | ❌ | ❔ | ❔ | ❌ | ❌ |
| [A running task widened without a restart](https://github.com/porelo-ai/porelo/blob/main/doc/security.md) | ✅ | ❔ | ✅ | ✅ | ❔ | ❔ | ❌ | ❌ | ❌ | ❔ | ❔ | ❌ | ❌ |
| [Credentials stay on the host (broker)](https://github.com/porelo-ai/porelo/blob/main/doc/credentials.md)⁵ | ✅ | ✅ | ✅ | ❌ | 🟡 | ❔ | ❌ | ❌ | ❌ | ❔ | ❔ | ❌ | ❌ |
| [The broker prevents token theft](https://github.com/porelo-ai/porelo/blob/main/doc/reach.md)⁶ | ✅ | ❔ | ❔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❔ | ❔ | ❌ | ❌ |
| [Further services with their own key through the broker](https://github.com/porelo-ai/porelo/blob/main/doc/credentials.md) | ✅ | 🟡 | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❔ | ❔ | ❌ | ❌ |
| [A subscription sign-in is renewed on the host](https://github.com/porelo-ai/porelo/blob/main/doc/credentials.md) | ✅ | ❔ | ❔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| [An encrypted vault with a key slot per device](https://github.com/porelo-ai/porelo/blob/main/doc/credentials.md) | ✅ | ❔ | ❔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❔ | ❔ | ❌ | ❌ |
| [Git gate: review before the upstream, enforced](https://github.com/porelo-ai/porelo/blob/main/doc/security.md)⁷ · [2](https://github.com/porelo-ai/porelo/blob/main/doc/reach.md) | ✅ | ❔ | ❌ | ❌ | 🟡 | 🟡 | 🟡 | 🟡 | 🟡 | ❌ | ❌ | ❌ | ❌ |
| [Three security classes (offline, guarded, online)](https://github.com/porelo-ai/porelo/blob/main/doc/security.md)⁸ | ✅ | ❌ | ❌ | ❌ | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| [No git key in the container](https://github.com/porelo-ai/porelo/blob/main/doc/how-it-works.md) | ✅ | ❔ | ❔ | ❌ | ❔ | ❔ | ❌ | ❌ | ❌ | ❔ | ❔ | ❌ | ❌ |
| [The working copy is a clone, not a mount](https://github.com/porelo-ai/porelo/blob/main/doc/how-it-works.md)⁹ | ✅ | ✅ | ❔ | ❌ | 🟡 | ✅ | 🟡 | 🟡 | 🟡 | 🟡 | 🟡 | ❌ | ❌ |
| [A task is kept, its session continues](https://github.com/porelo-ai/porelo/blob/main/doc/commands.md)¹⁰ | ✅ | ✅ | ❔ | 🟡 | 🟡 | ❔ | ✅ | ✅ | ✅ | ✅ | ✅ | 🟡 | ❌ |
| [Several tasks in parallel](https://github.com/porelo-ai/porelo/blob/main/doc/how-it-works.md) | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| [Limits for CPU, memory and processes](https://github.com/porelo-ai/porelo/blob/main/doc/project-file.md) · [2](https://github.com/porelo-ai/porelo/blob/main/doc/security.md) | ✅ | ✅ | ❔ | ❌ | ❌ | ❔ | ❌ | ❌ | ❌ | ✅ | ✅ | ✅ | ✅ |
| [A signed or centrally set project configuration](https://github.com/porelo-ai/porelo/blob/main/doc/project-file.md)¹¹ | ✅ | 🟡 | ❔ | 🟡 | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | 🟡 |
| [Messages between tasks, signed and filtered](https://github.com/porelo-ai/porelo/blob/main/doc/messages.md) | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| [Any agent, as a package with a pinned checksum](https://github.com/porelo-ai/porelo/blob/main/README.md)¹² | ✅ | 🟡 | 🟡 | 🟡 | ❌ | 🟡 | 🟡 | 🟡 | 🟡 | 🟡 | 🟡 | ❌ | ❌ |
| [A log of blocked connections and DNS queries](https://github.com/porelo-ai/porelo/blob/main/doc/security.md)¹³ · [2](https://github.com/porelo-ai/porelo/blob/main/doc/commands.md) | ✅ | 🟡 | ❔ | 🟡 | 🟡 | 🟡 | ❌ | ❌ | ❌ | ❔ | 🟡 | 🟡 | ❌ |
| [A file handed to a running task, and recorded](https://github.com/porelo-ai/porelo/blob/main/doc/commands.md) | ✅ | 🟡 | ❔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | 🟡 | 🟡 | ❌ | ❌ |
| [The forge's build result back in the task](https://github.com/porelo-ai/porelo/blob/main/doc/running.md) | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ |
| [Shows whether a task works or waits on somebody](https://github.com/porelo-ai/porelo/blob/main/doc/commands.md) | ✅ | ❔ | ❌ | ❌ | ❌ | ❌ | 🟡 | 🟡 | 🟡 | ❌ | ❌ | ❌ | ❌ |
| [Leave the terminal and attach again](https://github.com/porelo-ai/porelo/blob/main/doc/running.md) | ✅ | 🟡 | ❔ | ❌ | ❌ | ✅ | ✅ | ❔ | 🟡 | 🟡 | 🟡 | 🟡 | 🟡 |
| [A desktop interface, also for remote machines](https://github.com/porelo-ai/porelo-frontend)¹⁴ | ✅ | ❔ | ❌ | ❌ | ❌ | ❌ | 🟡 | 🟡 | ✅ | 🟡 | 🟡 | ❌ | ❌ |
| [A programming interface for clients](https://github.com/porelo-ai/porelo/tree/main/wire/src/main/resources/varlink) | ✅ | ❔ | ✅ | 🟡 | ❔ | 🟡 | ❌ | 🟡 | ❌ | ✅ | ✅ | 🟡 | 🟡 |
| [Installed as a Linux package (apt/dnf)](https://github.com/porelo-ai/porelo/blob/main/README.md)¹⁵ | ✅ | ❔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ | 🟡 |
| [Windows, with Porelo in WSL](https://github.com/porelo-ai/porelo-frontend)¹⁶ | ✅ | ✅ | 🟡 | 🟡 | ✅ | ❔ | ❔ | ❌ | ✅ | ✅ | ✅ | ❔ | ❔ |
| [Its own certificate authority for outbound TLS](https://github.com/porelo-ai/porelo/blob/main/doc/credentials.md) | ✅ | ❔ | ❔ | ❔ | ❔ | ❌ | ❌ | ❌ | ❌ | ❔ | ❔ | ❌ | ❌ |
| [Everything stopped with one command](https://github.com/porelo-ai/porelo/blob/main/doc/commands.md#panic) | ✅ | ❔ | ❔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❔ | ❔ | ❌ | ❌ |
| [Doctor's findings as data](https://github.com/porelo-ai/porelo/blob/main/doc/commands.md#doctor) | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | 🟡 |
| [Review a diff in the IDE](https://github.com/porelo-ai/porelo-intellij/blob/main/doc/index.md) | ✅ | ❌ | ❌ | ✅ | ❔ | ❌ | ❌ | ❌ | 🟡 | ❌ | ❌ | ❌ | ❌ |
| [Tokens counted per task](https://github.com/porelo-ai/porelo/blob/main/doc/credentials.md) | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| [The workspace scanned for secrets at start](https://github.com/porelo-ai/porelo/blob/main/doc/how-it-works.md) | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| [The conversation survives a real restart](https://github.com/porelo-ai/porelo/blob/main/doc/running.md) | ✅ | ❔ | ❔ | 🟡 | 🟡 | ❔ | ❔ | ✅ | ❔ | ✅ | 🟡 | 🟡 | ❌ |
| [Personal data caught by the message filter](https://github.com/porelo-ai/porelo-message-sluice/blob/main/doc/detectors.md) | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| [Remote machines reached through a tunnel](https://github.com/porelo-ai/porelo/blob/main/doc/credentials.md) | ✅ | 🟡 | 🟡 | ❌ | 🟡 | ❌ | ❌ | ❌ | ✅ | ✅ | ✅ | ❌ | ❌ |

1. **Isolation:**
   - Docker SB and E2B: a microVM with its own kernel, so stronger than Porelo.
   - Daytona: a container or a VM, by choice.
   - OpenShell: Landlock and seccomp.
   - srt/CC and Codex: only a sandbox at the operating-system level.
   - gVisor: a kernel of its own in user space per sandbox. Kata: a lightweight VM with a guest kernel per pod.
   - Porelo: rootless Podman, every capability dropped, `no-new-privileges`.
2. **Network block:** in Porelo, OCI hooks load the nftables rules into the task's network namespace, and no
   container starts without them. CC runs on without a sandbox when `failIfUnavailable` is not set. The Codex proxy
   covers neither MCP nor the model traffic. gVisor closes everything with `--network=none` but has no allow list;
   Kata takes its network from the engine's CNI.
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
    conversation, not the environment. gVisor checkpoints a running sandbox with its memory and restores it into a
    new container; Kata provides no checkpoint or restore.
11. **Project configuration:** Porelo signs it per project, and every machine checks it. Docker SB (governance), CC
    and Codex (managed settings) set it centrally, but sign nothing.
12. **Agents:** the others run several agents or any process, but with no pinned checksum.
13. **Log:**
    - Docker SB: a policy log and audit entries.
    - srt: monitoring of violations.
    - Codex and Daytona: OpenTelemetry.
    - cu: a command history.
    - gVisor: system-call trace points streamed to an external monitor, such as Falco.
14. **Interface:** Porelo has a Flutter app that reaches remote machines over ssh. Cond. exists only for macOS and
    only locally, Squad only as a TUI. VK has a web interface with a relay. E2B and Daytona have a web dashboard.
15. **Installation:** the others install through npm, Homebrew, install scripts or Helm; the cloud services need no
    installation. gVisor has an apt repository of its own; Kata ships tarballs and a Helm chart.
16. **Windows:** the interface reaches a Porelo in a WSL distribution through `wsl.exe`. The IntelliJ plugin reaches
    a Porelo in WSL through `wsl.exe` and a machine over ssh; trying both on a Windows machine is open:
    porelo-intellij [porelo-intellij#7](https://github.com/porelo-ai/porelo-intellij/issues/7).

## What is planned

Each feature names its issue; the index row says how far it is.

| Feature | Porelo | Docker SB | OpenShell | srt/CC | Codex | cu | Squad | Cond. | VK | E2B | Daytona | gVisor | Kata | Issue |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| A token ceiling per task | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | porelo [porelo#20](https://github.com/porelo-ai/porelo/issues/20) |
| An alert on what looks wrong, the task frozen¹ | 🟡 | ❌ | ❌ | ❌ | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | 🟡 | ❌ | porelo [porelo#21](https://github.com/porelo-ai/porelo/issues/21) |
| New dependencies checked (slopsquatting) | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | porelo [porelo#23](https://github.com/porelo-ai/porelo/issues/23) |
| A template for a local provider | 🟡 | ❌ | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | porelo [porelo#29](https://github.com/porelo-ai/porelo/issues/29) |
| The whole diff in review | 🟡 | ❌ | ❌ | ❌ | ❔ | 🟡 | ✅ | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ | porelo [porelo#31](https://github.com/porelo-ai/porelo/issues/31) |
| A tamper-evident event log² | 🟡 | 🟡 | ❌ | ❌ | 🟡 | ❌ | ❌ | ❌ | ❌ | ❔ | 🟡 | ❌ | ❌ | porelo [porelo#35](https://github.com/porelo-ai/porelo/issues/35), then [porelo#15](https://github.com/porelo-ai/porelo/issues/15) |
| An approve bound to the reviewed version | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | porelo [porelo#19](https://github.com/porelo-ai/porelo/issues/19) (`--commit` exists) |
| A task's virtual screen seen and controlled | 🟡 | ❔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ | ✅ | ❌ | ❌ | porelo [porelo#7](https://github.com/porelo-ai/porelo/issues/7) |
| Waiting work tried in a fresh container | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❔ | 🟡 | ❌ | ❌ | ❌ | ❌ | porelo [porelo#392](https://github.com/porelo-ai/porelo/issues/392), porelo-frontend [porelo-frontend#193](https://github.com/porelo-ai/porelo-frontend/issues/193) |
| An overview in the terminal that updates itself | 🟡 | ❔ | ❌ | ❌ | ❌ | ❌ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | porelo [porelo#166](https://github.com/porelo-ai/porelo/issues/166) |
| An attached agent shown at rest or working | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | 🟡 | 🟡 | 🟡 | ❌ | ❌ | ❌ | ❌ | porelo [porelo#13](https://github.com/porelo-ai/porelo/issues/13), porelo-frontend [porelo-frontend#200](https://github.com/porelo-ai/porelo-frontend/issues/200) |
| What the machine did, past the end of a task | 🟡 | 🟡 | ❌ | ❌ | 🟡 | ❌ | ❌ | ❌ | ❌ | ❔ | 🟡 | ❌ | ❌ | porelo [porelo#69](https://github.com/porelo-ai/porelo/issues/69) |
| A waiting push read as a pull request | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ | porelo-frontend [porelo-frontend#194](https://github.com/porelo-ai/porelo-frontend/issues/194) |
| A timeline of everything a piece of work did | 🟡 | ❌ | ❌ | ❌ | ❌ | 🟡 | ❌ | 🟡 | 🟡 | ❌ | ❌ | ❌ | ❌ | porelo-frontend [porelo-frontend#10](https://github.com/porelo-ai/porelo-frontend/issues/10), [porelo-frontend#11](https://github.com/porelo-ai/porelo-frontend/issues/11) |
| An unattended job's refusal reaches a person | 🟡 | ❔ | ❔ | ❌ | ❔ | ❌ | ❌ | ❔ | ❔ | ❌ | ❌ | ❌ | ❌ | [porelo-project#233](https://github.com/porelo-ai/porelo-project/issues/233) |
| MCP tools pinned, changes held back³ | 🟡 | 🟡 | ❌ | ❌ | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | [porelo-project#257](https://github.com/porelo-ai/porelo-project/issues/257) |
| A kernel of its own per task (experiment) | 🟡 | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ | ✅ | ✅ | ✅ | porelo [porelo#254](https://github.com/porelo-ai/porelo/issues/254) |
| A misuse test suite as a release condition⁴ | 🟡 | ❌ | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | porelo [porelo#24](https://github.com/porelo-ai/porelo/issues/24) |
| AI provenance in the commit, set on the host⁵ | 🟡 | ❌ | ❌ | 🟡 | ❔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | porelo [porelo#26](https://github.com/porelo-ai/porelo/issues/26) |
| Four eyes at the gate | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | porelo [porelo#27](https://github.com/porelo-ai/porelo/issues/27) |
| A wall-clock limit for unattended runs | 🟡 | ❔ | ❔ | ❌ | ❔ | ❌ | ❌ | ❌ | ❌ | ✅ | ✅ | ❌ | ❌ | porelo [porelo#28](https://github.com/porelo-ai/porelo/issues/28) |
| The providers a project or machine allows | 🟡 | ✅ | 🟡 | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | porelo [porelo#32](https://github.com/porelo-ai/porelo/issues/32), [porelo-project#258](https://github.com/porelo-ai/porelo-project/issues/258) |
| An organization's policy developers cannot override⁶ | 🟡 | ✅ | ❔ | ✅ | ✅ | ❌ | ❌ | ❔ | ❌ | ❔ | 🟡 | ❔ | 🟡 | [porelo-project#258](https://github.com/porelo-ai/porelo-project/issues/258), porelo-frontend [porelo-frontend#179](https://github.com/porelo-ai/porelo-frontend/issues/179) |
| Logs documented field by field, a data-protection page, an inventory | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | porelo [porelo#36](https://github.com/porelo-ai/porelo/issues/36), [porelo#25](https://github.com/porelo-ai/porelo/issues/25), [porelo#37](https://github.com/porelo-ai/porelo/issues/37) |
| Unused key slots and deploy keys reported | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | porelo [porelo#34](https://github.com/porelo-ai/porelo/issues/34) |
| Intermediate results handed between tasks | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❔ | 🟡 | ❌ | ❌ | porelo [porelo#30](https://github.com/porelo-ai/porelo/issues/30) |
| Several machines on one homeserver, groups | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | porelo [porelo#391](https://github.com/porelo-ai/porelo/issues/391), [porelo#22](https://github.com/porelo-ai/porelo/issues/22) |
| A stance on A2A, MCP, ACP and AG-UI | 🟡 | ❔ | ❔ | ❔ | ❔ | 🟡 | ❔ | ❔ | ❔ | ❔ | ❔ | ❌ | ❌ | [porelo-project#259](https://github.com/porelo-ai/porelo-project/issues/259) |
| macOS, with Apple Containers | 🟡 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ | [porelo-project#260](https://github.com/porelo-ai/porelo-project/issues/260) |
| More agents: Copilot CLI, Grok Build, OpenCode | 🟡 | ✅ | 🟡 | ❌ | ❌ | 🟡 | 🟡 | 🟡 | ✅ | 🟡 | 🟡 | ❌ | ❌ | [porelo-project#229](https://github.com/porelo-ai/porelo-project/issues/229), [porelo-project#230](https://github.com/porelo-ai/porelo-project/issues/230), [porelo-project#231](https://github.com/porelo-ai/porelo-project/issues/231) |
| More providers through the broker: xAI, Zhipu | 🟡 | 🟡 | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | porelo [porelo#395](https://github.com/porelo-ai/porelo/issues/395), [porelo#396](https://github.com/porelo-ai/porelo/issues/396) |
| A device's key released only with a touch or a PIN | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | porelo-frontend [porelo-frontend#127](https://github.com/porelo-ai/porelo-frontend/issues/127) |
| Several attempts at one assignment, compared ("best of N")⁷ | 🟡 | ❌ | ❌ | ❌ | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | porelo [porelo#38](https://github.com/porelo-ai/porelo/issues/38) |
| Rollback points per agent turn (files and chat)⁸ | 🟡 | ❌ | ❌ | 🟡 | ❔ | ❌ | ❌ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ | porelo [porelo#39](https://github.com/porelo-ai/porelo/issues/39) |
| A port forward or preview URL to the dev server | 🟡 | ✅ | ❔ | ❌ | ❌ | 🟡 | ❌ | ❔ | ✅ | ❔ | ✅ | 🟡 | 🟡 | porelo [porelo#40](https://github.com/porelo-ai/porelo/issues/40) |
| Line comments in review sent back to the agent | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❔ | ✅ | ❌ | ❌ | ❌ | ❌ | porelo [porelo#41](https://github.com/porelo-ai/porelo/issues/41) |
| An MCP gateway on the host that sees tool calls | 🟡 | ✅ | ❔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❔ | ❌ | ❌ | porelo [porelo#42](https://github.com/porelo-ai/porelo/issues/42) |
| A recording of the session, played back | 🟡 | ❌ | ❌ | ❌ | ❌ | 🟡 | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | porelo [porelo#43](https://github.com/porelo-ai/porelo/issues/43) |
| Containers inside a task (Docker or Podman for Testcontainers) | 🟡 | ✅ | ❔ | ❌ | ❌ | ❔ | ❌ | ❌ | ❌ | ❔ | ❔ | ✅ | ✅ | porelo [porelo#44](https://github.com/porelo-ai/porelo/issues/44) |

1. **Alert:** Codex lets a reviewing agent refuse risky actions. That comes closest, but it is no alert on what
   looks wrong. gVisor's runtime monitoring can feed an alerting tool, but freezes nothing.
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

| Feature | Porelo | Docker SB | OpenShell | srt/CC | Codex | cu | Squad | Cond. | VK | E2B | Daytona | gVisor | Kata | Judged for Porelo |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Snapshot, fork, pause and resume with memory | ❌ | 🟡 | ❔ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ | ✅ | ✅ | 🟡 | **partly:** forking a task fits; CRIU with rootless Podman is limited |
| A pull request on the forge from the approve, with a description | ❌ | ❌ | ❌ | ❌ | ❔ | ❌ | ❌ | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ | **partly:** work on the host with the host's key; the description must not come from the agent unreviewed |
| Network rules per program | ❌ | ❔ | ✅ | ❌ | ❌ | ❔ | ❌ | ❌ | ❌ | ❔ | ❔ | ❌ | ❌ | **partly:** of little use while everything in a task belongs to one agent; hard with nftables |
| Rules per HTTP method or path¹ | ❌ | ❔ | 🟡 | 🟡 | ❌ | ❔ | ❌ | ❌ | ❌ | ❔ | ❔ | ❌ | ❌ | **partly:** needs TLS interception beyond the broker, more attack surface on the host |
| GPU passthrough into the task | ❌ | 🟡 | ✅ | ❌ | ❌ | ❔ | ❌ | ❌ | ❌ | ❔ | ✅ | ✅ | ✅ | **partly:** possible with Podman and CDI; local models belong on the host, as porelo [porelo#29](https://github.com/porelo-ai/porelo/issues/29) has it |
| Export over OpenTelemetry | ❌ | ❔ | ❌ | ❔ | ✅ | ❌ | ❌ | ❌ | ❌ | ❔ | ✅ | ❌ | ✅ | **partly:** needless for one person, useful for companies; small as an output of porelo [porelo#35](https://github.com/porelo-ai/porelo/issues/35) |
| A kanban or task board | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ | ❌ | ❌ | ❌ | ❌ | **partly:** overlaps with the interface; the forge manages tasks better |
| A devcontainer file as the image source | ❌ | ❔ | ❔ | ❌ | 🟡 | ❔ | ❌ | ❔ | ❔ | ❔ | ❔ | ❌ | ❌ | **no:** it gives only `image` or `build`, with the tools behind `features` that Porelo does not fetch; an image per repository comes from `porelo.yml` instead |

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
