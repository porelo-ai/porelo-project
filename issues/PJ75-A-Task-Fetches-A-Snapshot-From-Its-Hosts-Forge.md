# PJ75 — A task fetches a snapshot from its host's forge

**Status:** Idea.

**What must be true.** A task on a host with a local forge fetches a snapshot from the forge's package registry by the
name its project declares, without the person putting a credential into the project; and it still reaches nothing else
on the host.

## Why

The host's forge makes its organization and repositories private, and a task gets no forge token, so a task reaching
the registry by its declared name is refused with `401`. Two ways are open, to be weighed: the organization made
public on the forge, reachable only through the VPN and from the host's tasks; or a read-only registry credential
given to the task through the Porelo-Vault.
