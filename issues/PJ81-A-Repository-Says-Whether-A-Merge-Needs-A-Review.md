# PJ81 — A repository says whether a merge needs a review

**Status:** Accepted (operator, 2026-10-30).

**What must be true.** The project file says for each repository whether a pull request on the host's local forge needs
another person's approval before it is merged (`review: required`, the default) or whether a person with a developer's
rights may merge their own (`review: optional`). An agent never merges, either way.

## Why

Not every project wants each person's code reviewed by a second person. Today the host's local forge asks every pull
request for one approval by someone other than its author, with no way to waive it.

## The shape proposed

```yaml
repositories:
    core:
        review: optional    # required when left out
```

- **`required`:** one approval by a person other than the author; an approval is dismissed when a commit follows it
  (today it is not, so a commit can be added after the approval and merged).
- **`optional`:** no approval needed; the author merges.
- **Either way:** only people merge - the forge's teams of owners and developers - never the teams of agents or gates;
  no push straight to `main`; fast-forward only. Every change still goes through a pull request and is on record.
- **An agent's work** reaches the forge only through the gate, where a person approves it first; with `optional` that is
  its only review by a person, with `required` the forge's approval comes on top.
- The key sits in the project file, so changing it is signed by the project admin ([PJ80](README.md#pj80)).

## To be checked

- That a person outside `signers` cannot change `review` through any other way than the project file.
- How the host applies a changed value: on the next sync, and what it says.
