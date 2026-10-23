# PJ70 — A machine nobody sits at tells its person what needs them

**Status:** Accepted.

**What must be true.** A machine that works while nobody sits at it - a rented host, or this computer while the
person is away - watches what it needs to go on working, and tells its person when something needs them, wherever
they are: a credential that is about to expire or has expired, a locked vault, a service that has stopped, a machine
running short of memory or disk, a host that costs longer than planned. Each message says what, where, since when and
what to do.

## Why

Agents are to work on a rented host for hours with nobody at it ([PJ39](README.md#pj39)). Several things can stop
them there, and today nobody is told until they look:

- **A credential runs out:** the person's forge token ([PJ69](README.md#pj69)), an agent's sign-in, a provider's key.
  The work then stops at the next fetch, push or call.
- **The vault is locked**, so Porelo cannot say who is signed in or lend a credential.
- **A service stops:** the daemon, the room's homeserver, the forge on the host, a container that restarts again and
  again. In the sprint 2 test the homeserver failed five times in a row, and the only sign was a start that waited.
- **The machine runs short:** memory, disk, processes ([PJ68](README.md#pj68)).
- **A rented host keeps costing:** it is still up after its work, or no longer reachable while still rented.

What exists covers parts of it, each in its own place:

- porelo [B139](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b139): alerts on what looks
  wrong inside a task, to the desktop and `Watch`;
- porelo [B147](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b147): a time limit for an
  unattended run;
- porelo-frontend [F110](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f110): an
  unattended run ends with a line;
- [PJ08](README.md#pj08): an unattended CI job's refusal reaches a person.

None watches the machine and its account as a whole.

## The shape proposed

- **One watcher per machine account** checks, at intervals and at each event it can see, what the account needs:
  credentials and their expiry, the vault, its services and containers, memory, disk and processes, and for a rented
  host its reachability and running time.
- **A finding is a message to the person**, by the way the person chose: their own channel in the project's room, a
  push to their phone, mail, and *Needs you* in the interface when it is open. Each says what, where, since when and
  the step that resolves it.
- **A finding is said once and again only when it changes**, not every interval, and says when it is resolved.
- **Expiry is told ahead**, so a token is renewed before the work stops.
- **The watcher needs no secret of its own to report**, and its message carries no secret value.

## A company's central monitoring

A company usually runs a central monitoring system. Its machines send their state (memory, CPU, disk), the programs
running there with their performance and the user they run as, and their error and status messages; alerts are made
and routed there. Porelo fits into that, rather than standing beside it:

- **Porelo's findings and its machines' state are exported in an open format** that such systems take, OpenTelemetry
  (OTLP) for metrics, logs and events first, so no vendor is chosen by Porelo. Which formats beyond it, such as a
  Prometheus endpoint, is decided in the analysis.
- **The collecting agent on a host is set up by porelo-host's Ansible roles**, pointed at the company's endpoint from
  the machine file. Open-source agents to be compared in the analysis, for example the OpenTelemetry Collector,
  Prometheus' `node_exporter` and `process-exporter`, Grafana Alloy, Zabbix agent, Netdata, Checkmk's agent.
- **Each process is named with the account it runs as**, so a task, the daemon, the gate and the homeserver can be
  told apart per project and person.
- **A person without such a system** still gets the findings their own way, as above.
- **Nothing exported carries a secret value or the work's content:** names, states, numbers and Porelo's own message
  texts only.

## Open

- Which ways of telling a person come first, and how the person sets them.
- Which export format and which collecting agent porelo-host sets up first, and how a company names its endpoint and
  its credential for it.
- How the watcher itself is watched: a machine that is down cannot say so. A host that is not heard from might be
  reported by the person's other machine or by this computer.
