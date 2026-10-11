# PJ37 — Work reaches the upstream where no machine key may be added

**Status:** Accepted.

**What must be true.** A person who may not add a key to a repository - as in most larger organisations,
where only an administrator may - still gets a machine to fetch the repository and to pass approved work on,
and is told plainly what each way costs: a key an administrator adds on request, or the person's own token
used on the host, never in a task.

## The shape proposed

- **Chosen per project, in this order:** the machine's own key, where the person may add it; else a request
  for an administrator - the interface makes the key and shows the text and the link to send - and the machine
  waits for it; else the person's own token or ssh key, used only by the gate on the host for the upstreams the
  project names, kept in that machine's vault, never in a task.
- **The person's token reaches every repository the person can,** not only this one (a Bitbucket Data Center
  personal token knows read or write, not one repository): said plainly when it is chosen, with an expiry where
  the forge allows one.
- **On a remote or rented machine, for the time of the work:** the person deposits their own token or key there
  with a duration (`--for`, as the remote vault's passphrase is kept), and the machine forgets it when the time is
  up, when the person takes it back, and at `sokar clear` - whichever comes first; until then the interface shows
  that it is there and until when.
- **On the person's own machine** approved work goes back to the checkout and the person pushes with their own
  rights, so there the gap is the fetch alone.
- Spans `sokar` (the gate, the vault) and `sokar-frontend` (the way to a project, [F72](https://github.com/sokar-ai/sokar-frontend/blob/main/issues/README.md#f72)'s Bitbucket Data Center).
