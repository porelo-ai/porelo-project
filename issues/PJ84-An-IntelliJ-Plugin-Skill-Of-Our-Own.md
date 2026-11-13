# PJ84 — An IntelliJ plugin skill of our own

```json
{
  "$schema": "issue-1.json",
  "id": "PJ84",
  "title": "An IntelliJ plugin skill of our own",
  "state": "Idea",
  "size": "-",
  "priority": "Low",
  "rank": 18,
  "blockedBy": [],
  "covers": "A reviewed skill in the shared skills store for building the IntelliJ plugin, stating what holds for today's IntelliJ Platform - Gradle plugin and SDK versions, descriptor, threading, services, tool windows, a headless test run - built from what the plugin's spike measured, since the skills on offer are outdated or tied to a third party."
}
```

**What must be true.** An agent building the IntelliJ plugin loads a reviewed skill from the shared skills store that
states what holds for today's IntelliJ Platform: the Gradle plugin and SDK versions, the plugin descriptor, threading
and read/write actions, services, tool windows, and running the plugin headless for a test. The skill is built from
what the plugin's own spike measured, not from a template.

## Why

The two IntelliJ plugin skills on offer are not worth adopting: one is outdated, its template does not build and it
lacks the SDK's documentation; the other is tied to a third party's templates and engine. The plugin's spike found
the facts an agent needs, and a skill holds them where the next agent reads them first.
