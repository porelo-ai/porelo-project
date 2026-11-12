# ST344 — Lightweight Alternative to Porelo on Mac/Windows Desktops

**Priority:** 🔽 Low · **State:** Idea

**What a user gains.** A person on a Mac or Windows desktop runs agent tasks without a VM: the window and the planner manage tasks through a runtime-neutral interface, with a native sandbox such as sandbox-runtime behind it, and are told plainly which of Porelo's protections that runtime does not give.

**The test.** On a Mac without a VM, start a task in the window with sandbox-runtime as the runtime: it runs, its file and network rules hold, and the window names the capabilities that runtime lacks (gate, clearance, broker, resource limits).

**Issues:** none yet

## Notes

- **The idea.** On macOS and Windows, Porelo needs a VM. Anthropic's sandbox-runtime (srt) sandboxes a process natively: Seatbelt on macOS; on Windows a sandbox account plus a WFP filter (alpha). The window and the planner manage tasks through a runtime-neutral interface: a core every runtime offers (start, list and watch, output and screen, talk, stop, remove) and capabilities a runtime reports or not (gate, clearance, broker, resource limits). Behind it stands Porelo, srt or another runtime. A weaker runtime must never look like Porelo.
- **Measured 2026-11-12.** srt 0.0.82 builds unchanged with `bun build --compile` into one binary per platform: Linux 110 MB, macOS arm64 90 MB, macOS x64 99 MB, Windows x64 117 MB. On Linux it runs without Node; its file and network rules held, and its gaps fail closed. The macOS and Windows builds were cross-compiled and not yet run there. A package ships srt's helpers itself and sets their paths (`apply-seccomp` on Linux, `srt-win.exe` on Windows, the Java agent jar). Windows needs one elevated install per machine, and again whenever srt raises its setup version.
- **Issues expected later, not now:** sandbox-runtime packaged for macOS and Windows without Node; the window and the planner on a neutral task API, with Porelo, srt or another runtime behind it.
- The comparison of srt with Porelo Core is the operator's document of 2026-11-12 (German).

## Data

```json
{
  "$schema": "story-2.json",
  "id": "ST344",
  "title": "Lightweight Alternative to Porelo on Mac/Windows Desktops",
  "gain": "A person on a Mac or Windows desktop runs agent tasks without a VM: the window and the planner manage tasks through a runtime-neutral interface, with a native sandbox such as sandbox-runtime behind it, and are told plainly which of Porelo's protections that runtime does not give.",
  "test": "On a Mac without a VM, start a task in the window with sandbox-runtime as the runtime: it runs, its file and network rules hold, and the window names the capabilities that runtime lacks (gate, clearance, broker, resource limits).",
  "priority": "Low",
  "state": "Idea",
  "issues": [],
  "tested": null
}
```
