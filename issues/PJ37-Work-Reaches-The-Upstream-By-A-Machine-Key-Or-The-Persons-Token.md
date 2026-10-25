# PJ37 — Work reaches the upstream by a machine key or the person's own token

**Status:** Accepted; its sprint 5 part is decided in [PJ61](README.md#pj61): the operator's own token, asked for hidden at the gathered push and stored nowhere.

**What must be true.** A machine fetches a project's repositories and passes approved work on either with keys of
its own (a deploy key per machine and repository) or with the person's own token, and the two are equal choices,
made per project: the token is not only for where no machine key may be added - as in most larger organisations,
where only an administrator may - but for anybody who prefers one credential they are responsible for anyway over a
key per repository and machine. Either way it is used by the gate on the host, never in a task, and the person is
told plainly what each way costs.

## The shape proposed

- **Chosen per project, as equals:** the machine's own keys, where the person may add them (or, where they may
  not, a request for an administrator - the interface makes the key and shows the text and the link to send - and
  the machine waits for it); or the person's own token, over HTTPS, used only by the gate on the host for the
  upstreams the project names, kept in that machine's vault, never in a task.
- **The token as narrow as the forge allows:** where the forge has fine-grained tokens (GitHub), only the
  repositories the project names and only the right to read and write their contents, with an expiry; the person is
  shown which of these the token they deposit has.
- **One token serves every repository of the project** and a new machine at once, where keys are made and added
  again for every repository on every new machine ([PJ39](README.md#pj39)'s host is set up again often, and its
  gathered push to the central forge uses the token).
- **Where the forge has no narrower token, it reaches every repository the person can,** not only this one (a Bitbucket Data Center
  personal token knows read or write, not one repository): said plainly when it is chosen, with an expiry where
  the forge allows one.
- **On a remote or rented machine, for the time of the work:** the person deposits their own token or key there
  with a duration (`--for`, as the remote vault's passphrase is kept), and the machine forgets it when the time is
  up, when the person takes it back, and at `porelo clear` - whichever comes first; until then the interface shows
  that it is there and until when.
- **On the person's own machine** approved work goes back to the checkout and the person pushes with their own
  rights, so there the gap is the fetch alone.
- Spans `porelo` (the gate, the vault) and `porelo-frontend` (the way to a project, [F72](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f72)'s Bitbucket Data Center).
