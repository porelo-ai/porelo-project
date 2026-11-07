#!/usr/bin/env bash
# Renders every release plan from each repository's main into ROOT/plan-pages. A plan that does not
# render stops it, and the published pages stay. It holds no token that can write: the workflow's
# next job publishes what this leaves.
#
# Usage: plan-pages.sh ROOT, with this repository checked out as ROOT/porelo-project.
set -euo pipefail

root=$(cd "$1" && pwd)
project="$root/porelo-project"
tool="$root/plan-tool"
pages="$root/plan-pages"
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

clone_repositories() {
    list_repositories | (cd "$root" && xargs -P 6 -I '{}' \
        git clone -q --filter=blob:none "https://github.com/$organization/{}.git" '{}')
}

# Built from porelo-buildtools' main, in a tree of its own: an internal page needs no release of its tool, and a
# fix to the tool shows at the next run. The checkout beside the others stays on main, as the plans read it.
fetch_tool() {
    local source="$root/plan-tool-source"
    git -C "$root/porelo-buildtools" worktree add -q --detach "$source" main
    (cd "$source" \
        && ./mvnw -q -B -ntp -s settings.xml -pl release -am -DskipTests -Dspotless.check.skip=true install \
        && ./mvnw -q -B -ntp -s settings.xml -pl release dependency:copy-dependencies \
            -DincludeScope=runtime "-DoutputDirectory=$tool")
    cp "$source"/release/target/porelo-release-*.jar "$tool/"
    rm -f "$tool"/porelo-release-*-sources.jar "$tool"/porelo-release-*-javadoc.jar
}

release_tool() {
    java -cp "$tool/*" org.fuin.porelo.release.Main "$@"
}

render_plans() {
    local plan
    cd "$project"
    for plan in plan/*/plan.yml; do
        release_tool plan render "$plan" --indexes=beside
    done
}

# What a plan's check finds is said, and does not hold back the pages: they show the same states.
check_plans() {
    local plan findings="$root/plan-findings.txt"
    cd "$project"
    for plan in plan/*/plan.yml; do
        release_tool plan check "$plan" --indexes=beside >"$findings" 2>&1 && continue
        echo "::warning title=plan check::$plan has $(wc -l <"$findings") findings; see the job summary"
        {
            echo "### $plan"
            echo '```'
            cat "$findings"
            echo '```'
        } >>"${GITHUB_STEP_SUMMARY:-/dev/stderr}"
    done
}

collect_pages() {
    local plan release
    mkdir -p "$pages/plan"
    for plan in "$project"/plan/*/plan.yml; do
        release=$(basename "$(dirname "$plan")")
        mkdir -p "$pages/plan/$release"
        cp "$project/plan/$release/README.md" "$project/plan/$release/"progress-*.svg "$pages/plan/$release/"
    done
    {
        cat "$project/plan/pages-index.md"
        printf '\n# Issues by status\n\n'
        python3 -I "$project/.github/scripts/plan-status-table.py" "$root"
    } >"$pages/plan/README.md"
}

clone_repositories
fetch_tool
render_plans
check_plans
collect_pages
