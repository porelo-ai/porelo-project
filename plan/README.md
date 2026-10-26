# Release plans

Each release is planned in `<release>.yml`: its sprints, the functions the operator tests at the end of each, and the
issues each function needs. The page beside it, `<release>.md`, is rendered from the plan by
`porelo-release plan render`, with a progress bar per sprint, and is not edited by hand.

| Release | What it brings |
|---|---|
| [0.6](0.6.md) | Porelo is built in Porelo tasks |
| [0.7](0.7.md) | A developer starts in a repository they already have, led by the Porelo Wizard |
| [0.8](0.8.md) | Code reviews as SARIF, trusted by who wrote them |
| [0.9](0.9.md) | Running alone: the accounts, a machine nobody sits at, and hosts from any provider |
| [0.10](0.10.yml) | Try waiting work before approval, compare alternatives and open a limited preview |
| [0.11](0.11.yml) | Tasks, builds and transports reach only the resources that were allowed |
| [0.12](0.12.yml) | Installed packages, setup scripts and images have a verifiable origin |
| [0.13](0.13.yml) | Secrets stay with their owner and reach only the permitted consumer |
| [0.14](0.14.yml) | An unattended task keeps its limits; a kernel of its own is offered only after proof |
| [0.15](0.15.yml) | Trace what a task did, where its work came from and what was approved |
| [0.16](0.16.yml) | Manage organization rules and personal access, and take in existing projects |
| [0.17](0.17.yml) | Communicate across machines with clear trust boundaries and hand over files only as allowed |
| [0.18](0.18.yml) | Keep MCP tools inspectable and require approval when their accepted definitions change |
| [0.19](0.19.yml) | Use enterprise forges, read Jenkins builds and extend reviews to their pull requests |
| [0.20](0.20.yml) | Work on Apple silicon, Fedora and Windows, with chosen drives and a shared secrets file |

The issues themselves are in [issues/](../issues/README.md).
