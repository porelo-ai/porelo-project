# The project

Sokar is developed as one project over several repositories. This chapter comes from the project's
own repository, [sokar-project](https://github.com/sokar-ai/sokar-project): it defines the project
in `project.yml` and holds the requirements that belong to the project as a whole rather than to
one of its repositories. It holds no product code.

What the project file can carry, and what a project is, is described in the core chapter:
[The project file](https://sokar-ai.github.io/core/project-file/).

## The MVP

The first version Sokar aims at: one person, one machine, one agent. Sokar is installed, work is
started, the agent works safely, its result is reviewed and pushed - smoothly, from the interface as
much as from the command line, for someone who has never used Sokar.

1. **The standard pair is Claude Code with Anthropic, signed in with a Claude subscription** - the
   browser login the interface runs in its login terminal, so no key is typed anywhere. An Anthropic
   API key, Pi, Oh My Pi and the other providers work, and are polished after it.
2. **Messages over the local Matrix homeserver are part of it:** tasks of a project talk in the
   project's room on the machine's own homeserver. A central homeserver for several machines comes
   after it.
3. **A project from a repository a person already has is part of it**, so nobody writes a
   `project.yml` by hand to begin; so is work without a project.
4. **A rented machine set up from the interface behaves like a local one.** The same steps, the same
   result; that a machine is remote changes nothing for the person.
5. **The person using it is new to Sokar:** anything that needs Sokar's own words, a terminal where
   the interface should do, or a step not said, is a defect of the MVP.

## Pages

- [Agents and providers compared](agents-and-providers.md): every agent and provider set beside
  each other, which of them can be brokered at all, what that costs, and which to build next.
- [Decisions](decisions.md): the choices the project as a whole is built on, and the risks it
  accepts.
