# PJ71 — Who reaches a host, and by which way

**Status:** Idea.

**What must be true.** For every way into a host it is written down who uses it, for what and over which channel:
ssh or the VPN. Every service of the host is reached by one stated way, and a second person can be given their own
access to a host and have it taken away again, without the first person's keys.

## Why

- **Two channels, no stated split.** A host is reached over its public ssh while it is set up and at the stop, and
  over the WireGuard VPN for the services afterwards. The interface also raises its own ssh forward to the room's
  homeserver. Which function takes which channel follows from how each was built, not from a rule, so a new service
  has no answer to "ssh or VPN".
- **One person only.** The VPN knows one peer, the person who set the host up (`vpn_peers` in porelo-host, filled with
  one public key). Each WireGuard peer has its own key pair; a second person needs their own pair, an address in the
  VPN and a place in the host's peer list, and nothing adds or removes one today.
- **Access beyond the VPN.** A second person may need the project's room (`porelo talk join` gives a room account),
  the local forge, or a terminal on the host; which of these, with what rights, and under which account, is not said.
- **The public ssh.** Whether ssh stays public after `up` is porelo-host
  [HO22](https://github.com/porelo-ai/porelo-host/blob/main/issues/README.md#ho22).

## Open questions

- The split itself: which functions go over ssh (setting up before the VPN exists, the stop's terminal, the
  interface's room forward) and which over the VPN (the forge, the room, the daemon, the VM pool, a task's view).
- Who may add a second person, and what that person gets: the VPN only, the room, the forge, an account on the host.
- How a person's own key pair is made and handed over: only the public key leaves their computer.
