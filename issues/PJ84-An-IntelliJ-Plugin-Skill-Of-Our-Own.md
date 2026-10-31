# PJ84 — An IntelliJ plugin skill of our own

**Status:** Idea.

**What must be true.** An agent building the IntelliJ plugin loads a reviewed skill from the shared skills store that
states what holds for today's IntelliJ Platform: the Gradle plugin and SDK versions, the plugin descriptor, threading
and read/write actions, services, tool windows, and running the plugin headless for a test. The skill is built from
what the plugin's own spike measured, not from a template.

## Why

The two IntelliJ plugin skills on offer are not worth adopting: one is outdated, its template does not build and it
lacks the SDK's documentation; the other is tied to a third party's templates and engine. The plugin's spike found
the facts an agent needs, and a skill holds them where the next agent reads them first.
