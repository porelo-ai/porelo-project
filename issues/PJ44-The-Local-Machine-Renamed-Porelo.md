# PJ44 — The local machine renamed Porelo

**Status:** Analyzed.
**Size:** S - the checkouts, the local files and tools the agents use on this machine; nothing of it is committed.

**What must be true.** On the machine the agents work on, the checkouts, the local rules, the channel and its tools,
the hand-over directory and the VM accounts carry the new name, and nothing installed still runs Sokar.

Step 6 of [PJ41](README.md#pj41).

## Plan

1. **The checkouts' directories** renamed to the new repository names, after every agent has finished its commit in
   the window and stopped.
2. **`.AGENTS.md`** in every checkout: the Local Shared Area and each agent's own part, with the new paths.
3. **The channel and its tools:** the file and its copies, and `sokar-channel-read`, `-post` and `-wait`, renamed;
   the agents' memories and settings that name the old paths corrected.
4. **The hand-over directory and the split Maven repository** moved to the new names.
5. **The VM accounts:** Sokar removed, Porelo installed afresh in each, as [PJ41](README.md#pj41) decides.

**Checked:** every agent starts in its renamed checkout and reads the channel under the new tool name; a search of
the local files for `sokar` finds nothing but history.
