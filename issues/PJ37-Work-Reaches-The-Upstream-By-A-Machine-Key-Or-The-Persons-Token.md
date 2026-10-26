# PJ37 — Work reaches the upstream by a machine key or the person's own token

**Status:** Analyzed for sprint 5, which builds nothing of its own here: its three credentials are built where [PJ61](README.md#pj61)'s table places them; the rest waits for its sprint.

**What must be true.** A machine fetches a project's repositories and passes approved work on either with keys of
its own (a deploy key per machine and repository) or with the person's own token, and the two are equal choices,
made per project: the token is not only for where no machine key may be added - as in most larger organisations,
where only an administrator may - but for anybody who prefers one credential they are responsible for anyway over a
key per repository and machine. The gate uses its credential on the host for the immediate Git destination, never
in a task, and the person is told plainly what each way costs. Migration from the central forge and the gathered
push to it use separate credentials.

## The shape proposed

- **Chosen per project, as equals:** the machine's own keys, where the person may add them (or, where they may
  not, a request for an administrator - the interface makes the key and shows the text and the link to send - and
  the machine waits for it); or the person's own token, over HTTPS, used only by the gate on the host for the
  upstreams the project names, kept in that machine's vault, never in a task.
- **The token as narrow as the forge allows:** where the forge has fine-grained tokens (GitHub), only the
  repositories the project names and only the right to read and write their contents, with an expiry; the person is
  shown which of these the token they deposit for the gate has.
- **One gate token serves every repository of the project** and a new machine at once, where keys are made and
  added again for every repository on every new machine ([PJ39](README.md#pj39)'s host is set up again often).
- **The migration credential** lets the host's forge import repositories from the central forge. It is separate
  from the gate's credential for the host's forge and from the central token for the gathered push.
- **The gathered push's central token** is the person's fine-grained token, limited to the project's repositories
  with `Contents` and `Workflows` read and write and an expiry. The push asks for it hidden and stores it nowhere
  ([PJ61](README.md#pj61)); it is neither a gate credential in the vault nor the migration credential.
- **Where the forge has no narrower token, it reaches every repository the person can,** not only this one (a Bitbucket Data Center
  personal token knows read or write, not one repository): said plainly when it is chosen, with an expiry where
  the forge allows one.
- **The gate's credential on a remote or rented machine, for the time of the work:** the person deposits their own
  token or key there with a duration (`--for`, as the remote vault's passphrase is kept), and the machine forgets it
  when the time is up, when the person takes it back, and at `porelo clear` - whichever comes first; until then the interface shows
  that it is there and until when.
- **On the person's own machine** approved work goes back to the checkout and the person pushes with their own
  rights, so there the gap is the fetch alone.
- Spans `porelo` (the gate, the vault) and `porelo-frontend` (the way to a project, [F72](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f72)'s Bitbucket Data Center).

## Sprint 5

Sprint 5 proves the three credentials of one project, porelo-message-sluice, on the rented host; none is built in this
repository:

- **The migration credential** is the operator's read-only token in the drive's `forge-central.token`, with which the
  host's forge imports the repositories: built in porelo-host and used in sprint 4.
- **The gate's credential for the host's forge** is a forge token in the account's vault, used by the gate on the host
  for the push of `porelo/<task>` and by the build reader, never in a task: porelo-host's sprint-5 part in
  [PJ61](README.md#pj61)'s table.
- **The gathered push's central token** is the operator's fine-grained token, asked for hidden and stored nowhere:
  porelo-buildtools [BT06](https://github.com/porelo-ai/porelo-buildtools/blob/main/issues/README.md#bt06).

Left for later sprints, and placed then: the machine's own deploy keys and the request to an administrator, a person's
token deposited on a rented machine for a time (`--for`), the forge without narrower tokens, and the way to a project in
porelo-frontend.
