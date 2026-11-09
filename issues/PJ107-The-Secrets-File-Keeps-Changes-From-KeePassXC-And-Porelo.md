# PJ107 — The secrets file keeps changes from KeePassXC and Porelo

**Status:** Backlog (operator, 2026-11-09).
**Size:** L - the part of [PJ51](README.md#pj51) not built in 0.6; [PJ51](README.md#pj51) built the file and its unlock (porelo-host HO37, porelo-frontend
F198, F199). KeePassXC on Windows and macOS stays porelo-frontend F200, and HO35 builds on HO37.

**What must be true.** When the person changes the secrets file in KeePassXC while Porelo writes to it, both changes are
kept; and the wizard asks how the person works (one file on a shared drive, or one per machine) before it writes one.

## Why

Today the last writer wins: an entry the person adds in KeePassXC while Porelo stores a token is lost without a word.
