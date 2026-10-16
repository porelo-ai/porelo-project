# Decisions

The choices the project as a whole is built on, each with why it holds and, for an accepted risk, the exposure, why
it stays and what would change the answer.

| Subject | What holds | Link |
|---|---|---|
| Work not yet mirrored is lost with a failed machine | the host keeps no backup of the local forge; a person who wants one mirrors it with means of their own | [entry](#work-not-yet-mirrored-is-lost-with-a-failed-machine) |

## Work not yet mirrored is lost with a failed machine

The host the agents work on is set up from nothing and given back with nothing kept on it: the code is in the
forge, the person's own settings on a drive the person mounts, and a short list of chosen data is copied off it.
The local forge is not backed up. **The exposure:** what was merged on the local forge but not yet mirrored to the
central one, and every branch not yet merged, is lost when the machine fails or is given back too early. **Why it
stays:** a backup of the forge would be a second copy of the code with its own schedule, target and restore to keep
working, for a loss bounded by the time between two mirror runs, and the agents can build the work again. A person
who wants it covered mirrors the local forge elsewhere with means of their own, of which Sokar knows nothing. **What
would change the answer:** a loss that costs more than the work since the last mirror run can be redone in, or
mirror runs so far apart that a failed machine regularly takes more than a working day with it.
