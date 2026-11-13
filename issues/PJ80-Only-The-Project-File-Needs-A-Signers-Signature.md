# PJ80 — Only the project file needs a signer's signature

```json
{
  "$schema": "issue-1.json",
  "id": "PJ80",
  "title": "Only the project file needs a signer's signature",
  "state": "Accepted",
  "size": "-",
  "priority": "Low",
  "rank": 5,
  "blockedBy": [],
  "covers": "A follow applies a new `main` when every commit that changes the project file, or another file deciding what the machines do, is signed by a key in `signers`; other commits need no signature, so developers change the rest of the project's repository on their own and the project admin signs changes to the project file."
}
```

**What must be true.** A machine reading a project applies a new `main` when every commit that changes the project
file - or another file that decides what happens on the machines - is signed by the key of one of the project's
admins; every other commit needs no signature. A developer changes everything else in the project's repository on their own; a change to the
project file is made by the project admin, signed, and reviewed by a developer.

## Why

A developer's change, brought in by a pull request on the host's local forge, approved and merged there by the project
admin, leaves the developer's commit on top. The approval on the forge is a click there, not a signature in Git, and the
local forge refuses a push straight to `main`, also the project admin's. So a check of the top commit alone would refuse
a change the project admin approved.

What the signature protects is the project file: the security class, what may leave (`egress`), which agents run.
Who may sign is the admin role in the organization, not a list in the file. The plans, issues and documents in the
project's repository need no such protection.

## What the code does

Built otherwise, as an accepted risk (`porelo`, `doc/decisions.md`, "A project's own file is judged by its newest change
alone"): `ProjectFile.newestChange` finds the newest commit on the first-parent line that changed `project.yml`, and
that commit must be signed by the key of a project admin who is one now. Another file on top changes nothing, so a
developer's merged change is applied. An unsigned change leaves the file refused until an admin signs it anew with
`porelo project sign`. **So this issue's promise is not kept:** an older commit that changed the file is not judged, and
no file the project file names is protected, so a developer's unsigned commit can change a snippet file that runs while
the image is built.

## The rule

1. From the new tip back to the commit in force, along the first parent, every commit is compared with its first
   parent.
2. Where the project file - or another protected file - is changed, deleted or renamed, that commit must be signed by
   a project admin's key as the admins stood before that change.
3. One such commit without a valid signature refuses the whole new `main`; the commit in force stays, and the refusal
   names the commit and the file.

Every such commit, not only the last: otherwise an unsigned commit could change the project file and a later signed
one, touching another line, would carry it through.

## Developers as admins

A project admin may give a developer the role `admin`. That is the same rule with a longer list and lets them change
the project file alone - which includes opening a guarded project's `egress`. It is the project admin's choice per
project, not the default.

## To be checked

- Which files besides the project file decide what happens on the machines (an image's definition, a script the
  project file names); each is protected the same way, or the protection is bypassed through the file it points to.
- What the interface says on a pull request that changes the project file: that it needs the project admin's
  signature.
