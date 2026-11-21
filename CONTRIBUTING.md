# Contributing

Changes here follow the project's guide, [Contributing to Porelo](https://porelo-ai.github.io/porelo-project/contributing/):
how a change starts as a GitHub issue, what a commit carries, and what a change must satisfy. The rules are kept there
and in the shared block of [`AGENTS.md`](AGENTS.md), not here.

## In this repository

- **There is no build and no product code**: `project.yml`, the requirements not yet placed in a repository, and this
  repository's chapter of the documentation, all of it Markdown and YAML.
- **A requirement is an issue in this repository's [GitHub Issues](https://github.com/porelo-ai/porelo-project/issues)**,
  on the project board [porelo-ai/1](https://github.com/orgs/porelo-ai/projects/1). Once it is clear which repository
  builds it, it moves there as an issue of that repository.
- **The documents' checks** (`check-shared`, `check-citations`, `check-doc-site`) run on the exact commit before it is
  handed over, as the guide says.
- **`project.yml` is what machines follow**, verified by its signature, so a change to it is a change to what every
  machine following the project does. Its keys are documented in
  [The project file](https://porelo-ai.github.io/core/project-file/), not here.
