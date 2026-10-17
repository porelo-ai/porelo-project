# Decisions

The choices the project as a whole is built on, each with why it holds and, for an accepted risk, the exposure, why
it stays and what would change the answer.

| Subject | What holds | Link |
|---|---|---|
| The old name keeps its addresses and holds nothing new | `sokar-ai` keeps only its profile, `org.fuin.sokar` stays at Maven Central without a relocation, released changelog entries keep the old name | [entry](#the-old-name-keeps-its-addresses-and-holds-nothing-new) |
| Porelo is installed afresh | nothing of a machine that ran Sokar is read, kept or migrated | [entry](#porelo-is-installed-afresh) |
| The RPM repository indexes one folder deep | `porelo-dist-rpm` has the *YUM Metadata Folder Depth* 1 | [entry](#the-rpm-repository-indexes-one-folder-deep) |
| Work not yet mirrored is lost with a failed machine | the host keeps no backup of the local forge; a person who wants one mirrors it with means of their own | [entry](#work-not-yet-mirrored-is-lost-with-a-failed-machine) |

## Work not yet mirrored is lost with a failed machine

The host the agents work on is set up from nothing and given back with nothing kept on it: the code is in the
forge, the person's own settings on a drive the person mounts, and a short list of chosen data is copied off it.
The local forge is not backed up. **The exposure:** what was merged on the local forge but not yet mirrored to the
central one, and every branch not yet merged, is lost when the machine fails or is given back too early. **Why it
stays:** a backup of the forge would be a second copy of the code with its own schedule, target and restore to keep
working, for a loss bounded by the time between two mirror runs, and the agents can build the work again. A person
who wants it covered mirrors the local forge elsewhere with means of their own, of which Porelo knows nothing. **What
would change the answer:** a loss that costs more than the work since the last mirror run can be redone in, or
mirror runs so far apart that a failed machine regularly takes more than a working day with it.

## The old name keeps its addresses and holds nothing new

The product was called Sokar before it was called Porelo. The organisation `sokar-ai` stays and keeps only its
profile (`.github`), which says where Porelo is: the forge redirects every transferred repository's old address only
while no repository of that name exists there, and a kept organisation cannot be taken by somebody else, so no
repository is made in it again. The artifacts under `org.fuin.sokar` stay at Maven Central as they were released,
without a relocation. Released changelog entries keep the name they were
released under; every repository's test that refuses the old name excepts them.

## Porelo is installed afresh

A machine that ran Sokar gets Porelo as a new install: no state, command, path, setting or vault of Sokar is read,
kept running or migrated, and no `sokar` command remains. Projects are set up again and credentials entered again.
Nothing has to carry two names, and a test refusing the old name can hold everywhere outside the released history.

## The RPM repository indexes one folder deep

`porelo-dist-rpm` at Artifactory has the *YUM Metadata Folder Depth* 1, so each channel (`snapshots`, `releases`)
is indexed in its own folder. A YUM repository made by hand starts at 0 and indexes beside the channel instead of in
it.
