#!/usr/bin/env bash
# Checks porelo-project's stories against every repository's issue index on main: each head by the schema, each
# issue in its index, each story's text and stories/README.md as `stories index` writes them. A fault fails it.
#
# Usage: stories-check.sh ROOT, with this repository checked out as ROOT/porelo-project.
set -euo pipefail

root=$(cd "$1" && pwd)
project="$root/porelo-project"
tool="$root/stories-tool"
organization="porelo-ai"
: "${JAVA_HOME:?a JDK}"
export JAVA_HOME PATH="$JAVA_HOME/bin:$PATH"

# Lists the organization's public repositories, without this one, the archived and .github.
list_repositories() {
    local page=1 answer
    while [ -n "$page" ]; do
        answer=$(printf 'header = "Authorization: Bearer %s"\n' "${GITHUB_TOKEN:-}" \
            | curl -fsS -m 30 -K - \
                "https://api.github.com/orgs/$organization/repos?type=public&per_page=100&page=$page")
        python3 -I -c '
import json, sys
for repository in json.load(sys.stdin):
    if not repository["archived"] and repository["name"] not in (".github", "porelo-project"):
        print(repository["name"])' <<<"$answer"
        # A page that is not full is the last.
        if [ "$(python3 -I -c 'import json, sys; print(len(json.load(sys.stdin)))' <<<"$answer")" = 100 ]; then
            page=$((page + 1))
        else
            page=""
        fi
    done
}

# The checkouts beside porelo-project are where `stories check` reads the issue indexes.
clone_repositories() {
    list_repositories | (cd "$root" && xargs -P 6 -I '{}' \
        git clone -q --filter=blob:none "https://github.com/$organization/{}.git" '{}')
}

# Built from porelo-buildtools' main, in a tree of its own: a fix to the tool shows at the next run.
fetch_tool() {
    local source="$root/stories-tool-source"
    git -C "$root/porelo-buildtools" worktree add -q --detach "$source" main
    (cd "$source" \
        && ./mvnw -q -B -ntp -s settings.xml -pl release -am -DskipTests -Dspotless.check.skip=true install \
        && ./mvnw -q -B -ntp -s settings.xml -pl release dependency:copy-dependencies \
            -DincludeScope=runtime "-DoutputDirectory=$tool")
    cp "$source"/release/target/porelo-release-*.jar "$tool/"
    rm -f "$tool"/porelo-release-*-sources.jar "$tool"/porelo-release-*-javadoc.jar
}

clone_repositories
fetch_tool
cd "$project"
java -cp "$tool/*" org.fuin.porelo.release.Main stories check stories
