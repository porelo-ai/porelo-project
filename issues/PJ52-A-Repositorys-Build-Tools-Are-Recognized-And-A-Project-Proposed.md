# PJ52 — A repository's build tools are recognized and a project proposed

**Status:** Estimated; blocked by `porelo` [B192](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b192),
and by an agent for `porelo-ecosystems`, which does not exist yet.
**Size:** XL - three repositories, one of them new with an agent still to come; splits into the issues under *Plan*.

**What must be true.** A developer whose checkout needs more than the default image - another JDK, Flutter, native
toolchains - or more than the project `default` allows - a private package repository, more memory - gets drafts
proposed from what the checkout and the person's own tool settings say, each value shown with the file it came from.
The tools go into a `.porelo.yml` the repository never receives; the rules go into a `project.yml` the person
commits in a project repository of their own. Nothing takes effect before the person has seen it.

## Why

`default`'s rules are fixed ([PJ14](README.md#pj14)), and its image comes from a checkout's `porelo.yml` or local
`.porelo.yml` once `porelo` [B192](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b192) is built.
Most of what both files must say is already written down elsewhere: a Maven project names its Java release in the
pom and its Maven version in `.mvn/wrapper/maven-wrapper.properties`, a Flutter project its SDK in `pubspec.yaml`, a
workflow its tool versions in `setup-java`, `setup-python` or `setup-node`; a company's mirror and the credentials it
needs sit in the person's `~/.m2/settings.xml`. Copying that by hand is slow, and the place where a host is forgotten
and the first build fails behind the firewall.

## The shape proposed

- **Two drafts, split as [B192](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b192) splits them.**
  - **Tools** - `base_image`, `snippet`, `env` - go into a `.porelo.yml`: in the checkout for the project `default`
    (kept out of git by the person's `.git/info/exclude`), or under
    `~/.config/porelo/projects/<project>/<repository>/` for a followed project. A repository with its own
    `porelo.yml` gets no tools draft; its file wins.
  - **Rules** - egress hosts, the private repositories and their credentials (`porelo`
    [B219](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b219)), memory - go into a draft
    `project.yml` naming the checkout under `repositories`, for a project repository of the person's own. Only that
    draft needs leaving `default`.
- **One plugin per build tool, all in one repository, `porelo-ecosystems`, a Maven submodule each**: Maven first,
  then Gradle, npm, pip and Flutter; each is small, and they share the parsing of sources and the test fixtures.
  `porelo` holds the interface, the merge and `project init`; core knows no build tool by name.
- **A plugin is a native executable of its own, found at run time and spoken to over varlink**, as an agent and a
  build reader are: `porelo` names no build tool, an ecosystem is added by installing its package, and each plugin
  carries its own libraries. No container or sandbox is put around it: it runs once, at the person's own command, on
  a machine whose tool settings earlier tools read freely. The interface library may carry its own license
  ([PJ33](README.md#pj33)).
- **A plugin never runs the project's code**: no build tool, no wrapper, no build script, no Maven core extension,
  no plugin of the project's. It reads files and the models built from them; running any of these would run what a
  forge can write on the host.
- **A plugin reaches no network**: `porelo` starts it without one, which a process of its own allows. What lies outside the checkout is read from the
  person's local caches only - a parent pom or an imported BOM from `~/.m2/repository` or its `<relativePath>`, a
  Gradle version catalog from Gradle's cache. A value that sits in something not found there is named as unknown,
  with where it is set (for example "Java release: set in parent `org.fuin.porelo:porelo-parent`, not in the local
  repository"), never guessed; building the project once fills the cache.
- **Files a forge can write are parsed hardened**: XML without DTDs, external entities or fetching, and with limits
  on size and expansion, so a hostile pom can read no other file and exhaust nothing.
- **The Maven plugin builds the effective model with MIMA** (`eu.maveniverse.maven.mima`): Maven's own model
  builder, offline, against the local repository and the person's `settings.xml`, so parents, properties, profiles
  and imported BOMs are merged as Maven merges them, and no inheritance of Porelo's own is written. It resolves no
  dependency tree: a draft needs the repositories, not the artifacts in them. A missing parent is the model builder's
  error, turned into an unknown value naming it. A checkout with `.mvn/extensions.xml` is named as such, its
  extensions never loaded, and the model it would change marked as not trusted.
- **Gradle has no model without running its scripts**, so its plugin reads only files:
  `gradle/wrapper/gradle-wrapper.properties`, `gradle/libs.versions.toml`, toolchain declarations written as
  literals, and names more values unknown than Maven's.
- **Two methods to start with:**
  - **`detect`** answers what the plugin recognized - a tool and its version, the system packages it needs, the
    egress hosts, a memory size, the credentials a repository needs by id only (a Maven `<server>`) - every value with
    the file and line it came from, and what it saw but could not place.
  - **`configure`** writes the tool's own settings for a task - Maven's `settings.xml`, an `.npmrc`, a `pip.conf` - so
    that the tool reaches a private repository through the host's broker, with no credential in the task ([B219](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b219)).
- **Everything proposed is pinned**, as the shared rules require of every build: the base image by digest, every
  download by its digest. A plugin reaches no network, so the digests come from a catalog of known versions the
  plugins ship, or are resolved by core on the host.
- **Core merges the answers**: `porelo project init <checkout>` writes the tools draft and, when anything needs a
  rule, the `project.yml` draft, each value's source as a comment, and names where two plugins disagree (one base
  image for a Java and a Node build) instead of choosing silently.
- **The drafts are shown at once, before the first task, when a repository lands in `default`**: the command line's
  `task start` and the interface alike, so both behave the same. Taking the tools draft is a trust decision, since the
  image is built outside the task's firewall: it is asked at a terminal, never taken by `--yes`, and without a terminal
  the start goes on as today and names `porelo project init` in one line.
- **A repository added in the interface has no checkout**: neither the interface nor `porelo` clones one for
  `default`, so it lives only in Porelo's mirror. The plugins read the mirror's default branch, exported read-only,
  and its tools draft goes to `~/.config/porelo/projects/default/<repository>/.porelo.yml`, which the image's choice
  reads for such a repository after [B192](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b192)'s own sources.
- **The person's own files are those of the machine's account where `porelod` runs**, not of the desktop the
  interface runs on; the drafts name the machine they were read on.
- **Asked once**: a repository that already has a configuration - its `porelo.yml`, a `.porelo.yml`, or a followed
  project naming it - is never asked about, and one whose drafts were declined is not asked again either; the
  daemon keeps which of the three a repository is. `porelo project init` shows the drafts whenever asked.
- **How the command line shows them**, and the interface the same content:

      myapp is new in the project default. What it needs, read from its files without network:

      Tools: for .porelo.yml in this checkout, kept out of git
        base image  eclipse-temurin:25-jdk@sha256:3f1c…  pom.xml:31  maven.compiler.release 25
        maven       3.9.11, through the wrapper          .mvn/wrapper/maven-wrapper.properties:3
        packages    build-essential zlib1g-dev           pom.xml:88  native-maven-plugin
        unknown     Node's version                       package.json names no engines

      Rules: need a project of your own, default cannot take them
        egress      nexus.corp.example                   ~/.m2/settings.xml:12  mirror of *      yours
        egress   !  repo.example.org                     pom.xml:54  <repository>           from the checkout
        credential  corp-nexus                           ~/.m2/settings.xml:20  not in the vault
        memory      16g                                  23 modules

      Without the rules, this task cannot reach nexus.corp.example and its build will fail.

        1  take the tools, start in default
        2  take the tools and write the project.yml draft to a directory, then start
        3  start with the default image
        d  show where every value came from
      Which? [3]

  - Every value names its file and line; the person's own files are marked `yours`, the checkout's `from the
    checkout` with a `!`, since anybody who can push wrote them.
  - Tools and rules stay apart, and what leaving out the rules costs is said.
  - The default changes nothing; 1 and 2 show the `.porelo.yml` before it is written; each credential id is then
    offered for `vault put`, read without echo.
- **A host from the checkout is marked as such**: a pom is written by whoever can push to the repository, so a
  repository host it names is shown apart from one the person's own `settings.xml` names, and never accepted without
  the person seeing it.
- **Credentials are never copied into a draft**: for each id a plugin names, the person is offered to store the
  credential in the Porelo-Vault, where the broker reads it.

## What Porelo's own repositories show

Every Porelo repository but `porelo-project` already has a hand-written `porelo.yml` in [B192](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b192)'s format. Together they
are the reference set the plugins are measured against:

| What the file installs | Where | Where a plugin reads it |
|---|---|---|
| GraalVM 25, `JAVA_HOME` | every one | the parent's `maven.compiler.release`; `porelo-machines`' pin for the exact build and digest |
| `build-essential`, `zlib1g-dev` | the repositories building native executables | `native-maven-plugin` or a `-Pnative` profile |
| `rpm`, `dpkg-dev` | the repositories building packages | the packaging plugins in the poms |
| `shfmt` | the Maven repositories with scripts | Spotless's `shfmt` step, `porelo-parent`'s `shfmt.version` |
| Flutter 3.47.0, its Linux engine, GTK and `clang`/`cmake`/`ninja` | `porelo-frontend` | `pubspec.yaml`'s `environment.flutter`, a `linux/` directory |
| Python 3.13, the hashed wheels of `build/requirements.txt` | `porelo-ai.github.io` | `setup-python` in the workflow, `requirements.txt` |
| Node 22 | `porelo-pi` | the pom's `pin.node.version` and `pin.node.sha256` |
| Only a JDK; Gradle and the IDEs through the wrapper | `porelo-intellij` | `gradle/wrapper`, the Gradle toolchain |
| The Ansible tools' image | `porelo-host` | `galaxy.yml`, the collection's manifest |

What no plugin can know, and the reference set shows too: a binary copied from another image (`porelo-message-matrix`'s
homeserver), a repository's own switches (`PI_TREE_DIRECT`, `HOST_TOOLS_IN_IMAGE`, `MATRIX_TEST_TUWUNEL`), and what a
task cannot run at all (`porelo-host`'s Molecule scenario needs KVM). A draft names such gaps as unplaced, never guesses.

## Plan

The split, from `porelo`'s share as its agent read it in the code; `porelo-ecosystems`' sizes are estimates until
its agent reads them.

- **`porelo`, three issues, M, L and M** ([B219](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b219)'s broker, which `configure` needs, is its own issue, and its image-build
  part is [B223](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b223)):
  - **the contract**, [B220](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b220): `ecosystems/api` with an `Ecosystem1` varlink contract (`detect`, `configure`), discovery as
    `InstalledAgents` does it for agents, and a stub, as `builds/api` and `builds/stub` are for build readers;
  - **`porelo project init <checkout>`**, [B221](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b221), L, since nothing exports a mirror's tree or writes a whole `project.yml` today and `task start` asks at a terminal too: the merge, each value's source as a comment, disagreements named, the tools
    draft through [B192](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b192)'s reader and a new `project.yml` writer, since `EgressEdit` edits only `egress`;
  - **`configure` at the task start**, [B222](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b222): beside `placeAgentFiles` and after [B219](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b219)'s relay, placing the plugin's files
    with `TaskRunner.place` from [B219](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b219)'s variables.
- **`porelo-ecosystems`, new**, one issue each:
  - **a spike first**: MIMA's static runtime in a native image, its size, its model API, and offline mode refusing
    to fetch;
  - **Maven**, M to L, after the spike and `porelo`'s contract;
  - **Gradle, npm, pip, Flutter**, S to M each.
- **`porelo-frontend`, M**, `porelo-frontend` [F142](https://github.com/porelo-ai/porelo-frontend/blob/main/issues/README.md#f142), read in its code: the drafts asked for and shown in one dialog on `StartWork`, the one
  path into every task; the client and its models, the mock daemon, scenarios for taking, declining, a refusal and an
  older daemon. It needs [B221](https://github.com/porelo-ai/porelo/blob/main/issues/base/README.md#b221) to serve the drafts structured over the daemon: whether to ask, as a field the
  interface does not derive; the drafts as lists of key, value, file, line and origin (yours, the checkout's, the
  machine's), the disagreements, the cost of leaving out the rules, both files' text and each credential's store
  command; and the choice taken back, written on the machine. An older daemon's `MethodNotFound` is "this machine
  cannot propose", and the start goes on as today.


- Run on each Porelo repository with its `porelo.yml` set aside, the tools draft installs the same tools at the same
  versions as that file, or names what it left out; every difference is listed, and none is a tool installed at
  another version.
- A checkout whose pom names a repository host gets a `project.yml` draft that lists that host marked as coming from
  the checkout, with the pom's path and line; a `settings.xml` mirror is marked as the person's.
- A `settings.xml` with a `<server>` password produces drafts and an output in which the password appears nowhere;
  seen to fail first with a plugin that copies it.
- A `settings.xml` mirror of `*` leaves Maven Central out of the draft's egress.
- A pom declaring an external entity that names a local file yields a draft without that file's content, and one
  with nested entity expansion is refused with its name; both seen to fail first with the parser's defaults.
- A checkout with `.mvn/extensions.xml` gets a draft naming it and its model as not trusted, and the extension's
  code is never loaded; with the network cut, no detection reaches out, and a parent only on a remote repository is
  named unknown.
- A checkout whose Java release is set only in a parent pom missing from `~/.m2/repository` gets a draft naming that
  value unknown and the parent's coordinates; with the parent in the local repository, the draft names the release.
- The checkout's tracked files are byte for byte unchanged after `project init`.

## To be checked

- Where the pinned versions and digests come from without a second copy: `porelo-machines` already holds the
  GraalVM's, and the shared rules allow no repository to keep a copy of another's helper.
- How `porelo` matches a checkout to an entry under `repositories` (its `origin` against `upstream`, or otherwise),
  so the draft names the repository in a way the next task start recognizes.
