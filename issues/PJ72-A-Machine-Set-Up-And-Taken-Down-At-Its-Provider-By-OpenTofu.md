# PJ72 — A machine set up and taken down at its provider by OpenTofu

**Status:** Idea.

**What must be true.** An administrator rents a machine at a provider and gives it back by one OpenTofu module per
provider, whose state is kept encrypted with the administrator, so that Porelo's hosts can be had from more than one
provider and from a company's own tooling, outside the interface.

## Why

- Renting and giving back a host is today `porelo-host`'s, a Dart package of porelo-frontend, for Scaleway alone.
- porelo-project [PJ40](README.md#pj40) names OpenTofu as the planned extension "for Porelo as a product for others",
  likelier than an adapter per provider in each language, and runs on Linux, macOS and Windows; it has no issue of its
  own.
- Setting a machine up and taking it down are the `host-admin` role's ([PJ71](README.md#pj71)), and may happen entirely
  outside Porelo; a module the administrator runs keeps them there.
