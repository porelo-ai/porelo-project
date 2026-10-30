# PJ80 — Only the project file needs a signer's signature

**Status:** Accepted (operator, 2026-10-30).

**What must be true.** A machine following a project applies a new `main` when every commit that changes the project
file - or another file that decides what happens on the machines - is signed by a key in `signers`; every other commit
needs no signature. A developer changes everything else in the project's repository on their own; a change to the
project file is made by the project admin, signed, and reviewed by a developer.

## Why

Today a follow checks only the top commit of the fetched `main` against `signers`. A developer's change, brought in by a
pull request on the host's local forge, approved and merged there by the project admin, leaves the developer's commit
on top. Every machine refuses it (`not_signed`, or `unknown_key` when signed with the developer's own key), so a change
the project admin approved is applied nowhere. The approval on the forge is a click there, not a signature in Git, and
the local forge refuses a push straight to `main`, also the project admin's. The only way around is by hand: the
project admin puts an empty signed commit on top of the developer's branch before merging.

What the signature protects is the project file: the security class, what may leave (`egress`), which agents run,
`signers` itself. The plans, issues and documents in the project's repository need no such protection.

## The rule

1. From the new tip back to the commit in force, along the first parent, every commit is compared with its first
   parent.
2. Where the project file - or another protected file - is changed, deleted or renamed, that commit must be signed by
   a key in `signers` as the list stood before that change, as a change to `signers` is checked today.
3. One such commit without a valid signature refuses the whole new `main`; the commit in force stays, and the refusal
   names the commit and the file.

Every such commit, not only the last: otherwise an unsigned commit could change the project file and a later signed
one, touching another line, would carry it through.

## Developers in `signers`

A project admin may still list developers in `signers`. That is the same rule with a longer list and lets them change
the project file alone - which includes opening a guarded project's `egress`. It is the project admin's choice per
project, not the default.

## To be checked

- Which files besides the project file decide what happens on the machines (an image's definition, a script the
  project file names); each is protected the same way, or the protection is bypassed through the file it points to.
- The access repository, followed beside the project's: whether its file keeps today's check of the top commit.
- What the interface says on a pull request that changes the project file: that it needs the project admin's
  signature.
