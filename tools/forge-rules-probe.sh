#!/usr/bin/env bash
#
# Probes the forge's rules: makes a throwaway public repository in porelo-ai, checks that the organisation's
# ruleset and fork approval hold for it, and removes everything it made again.
#
#   forge-rules-probe.sh OWNER_TOKEN_FILE OTHER_TOKEN_FILE
#
# OWNER_TOKEN_FILE  a classic token of the operator's account: repo, workflow, delete_repo, admin:org
# OTHER_TOKEN_FILE  a classic token of a second GitHub account: public_repo, delete_repo
#
# Tokens are read from the files only; they never appear on a command line or in the output.
# Nothing is rented. The one workflow in the probe repository only echoes.
set -euo pipefail

ORG=porelo-ai
REPO=forge-rules-probe-$(date -u +%Y%m%d%H%M%S)
API=https://api.github.com

[ $# -eq 2 ] || { echo "usage: $0 OWNER_TOKEN_FILE OTHER_TOKEN_FILE" >&2; exit 2; }
OWNER_FILE=$1
OTHER_FILE=$2
for f in "$OWNER_FILE" "$OTHER_FILE"; do
    [ -r "$f" ] || { echo "cannot read $f" >&2; exit 2; }
done
command -v jq >/dev/null || { echo "jq is needed" >&2; exit 2; }

WORK=$(mktemp -d)
chmod 700 "$WORK"
PASS=0
FAIL=0

# curl reads the Authorization header from a file, so the token is never an argument.
header() {
    printf 'Authorization: Bearer %s\n' "$(tr -d '\n' <"$1")" >"$WORK/h"
    chmod 600 "$WORK/h"
}
gh_api() { # token-file method path [json] - prints the body; a status of 400 or more is shown on stderr
    header "$1"
    local code
    if [ $# -ge 4 ]; then
        code=$(curl -sS -o "$WORK/body" -w '%{http_code}' -H @"$WORK/h" -H 'Accept: application/vnd.github+json' -X "$2" "$API$3" -d "$4")
    else
        code=$(curl -sS -o "$WORK/body" -w '%{http_code}' -H @"$WORK/h" -H 'Accept: application/vnd.github+json' -X "$2" "$API$3")
    fi
    rm -f "$WORK/h"
    if [ "$code" -ge 400 ]; then
        echo "  ($2 $3: HTTP $code: $(jq -r '.message // empty' "$WORK/body" 2>/dev/null) $(jq -c '.errors // empty' "$WORK/body" 2>/dev/null))" >&2
    fi
    cat "$WORK/body"
}
gh_code() { # like gh_api, prints only the HTTP status
    header "$1"
    if [ $# -ge 4 ]; then
        curl -sS -o /dev/null -w '%{http_code}' -H @"$WORK/h" -X "$2" "$API$3" -d "$4"
    else
        curl -sS -o /dev/null -w '%{http_code}' -H @"$WORK/h" -X "$2" "$API$3"
    fi
    rm -f "$WORK/h"
}
check() { # name condition-result(0/1) detail
    if [ "$2" = 0 ]; then
        echo "PASS  $1"
        PASS=$((PASS + 1))
    else
        echo "FAIL  $1 - $3"
        FAIL=$((FAIL + 1))
    fi
}
put_file() { # token-file owner/repo path content message [sha]
    local body
    body=$(jq -n --arg m "$5" --arg c "$(printf '%s' "$4" | base64 -w0)" --arg s "${6:-}" \
        '{message:$m, content:$c} + (if $s == "" then {} else {sha:$s} end)')
    gh_api "$1" PUT "/repos/$2/contents/$3" "$body" >/dev/null
}

OWNER=$(gh_api "$OWNER_FILE" GET /user | jq -r .login)
OTHER=$(gh_api "$OTHER_FILE" GET /user | jq -r .login)
echo "owner account: $OWNER, second account: $OTHER, probe repository: $ORG/$REPO"
[ "$OWNER" != "$OTHER" ] || { echo "the two tokens belong to the same account" >&2; exit 2; }

cleanup() {
    set +e
    echo "-- cleaning up"
    gh_code "$OTHER_FILE" DELETE "/repos/$OTHER/$REPO" >/dev/null
    gh_code "$OWNER_FILE" DELETE "/repos/$ORG/$REPO/collaborators/$OTHER" >/dev/null
    code=$(gh_code "$OWNER_FILE" DELETE "/repos/$ORG/$REPO")
    case "$code" in
        204 | 404) echo "probe repository removed" ;;
        *) echo "COULD NOT REMOVE $ORG/$REPO (HTTP $code): delete it by hand" ;;
    esac
    rm -rf "$WORK"
    echo "-- result: $PASS passed, $FAIL failed"
}
trap cleanup EXIT

echo "-- 1. the organisation's settings"
gh_api "$OWNER_FILE" GET "/orgs/$ORG/rulesets" >"$WORK/rulesets.json"
for id in $(jq -r 'if type == "array" then .[].id else empty end' "$WORK/rulesets.json"); do
    gh_api "$OWNER_FILE" GET "/orgs/$ORG/rulesets/$id" >"$WORK/rs.json"
    echo "ruleset $id: $(jq -r '.name + ", " + .enforcement' "$WORK/rs.json")"
    echo "  bypass: $(jq -c '[.bypass_actors[] | {actor_type, actor_id, bypass_mode}]' "$WORK/rs.json")"
    echo "  rules:  $(jq -c '[.rules[].type]' "$WORK/rs.json")"
    others=$(jq '[.bypass_actors[] | select(.actor_type != "OrganizationAdmin" and .actor_type != "RepositoryRole")] | length' "$WORK/rs.json")
    check "ruleset $id: no app, team or deploy key may bypass" "$([ "$others" = 0 ] && echo 0 || echo 1)" \
        "bypass actors other than the admin role: $(jq -c '.bypass_actors' "$WORK/rs.json")"
done
policy=$(gh_api "$OWNER_FILE" GET "/orgs/$ORG/actions/permissions/fork-pr-contributor-approval" | jq -r '.approval_policy // "unreadable"')
check "fork pull requests need approval for all external contributors" \
    "$([ "$policy" = all_external_contributors ] && echo 0 || echo 1)" "policy is '$policy'"

echo "-- 2. the probe repository"
gh_api "$OWNER_FILE" POST "/orgs/$ORG/repos" \
    "$(jq -n --arg n "$REPO" '{name:$n, private:false, auto_init:true, description:"Forge rules probe, removed by its script"}')" >/dev/null
sleep 3
put_file "$OWNER_FILE" "$ORG/$REPO" .github/CODEOWNERS "/.github/ @$OWNER
" "Name the code owner"
put_file "$OWNER_FILE" "$ORG/$REPO" .github/workflows/probe.yml 'name: Probe
on: pull_request
permissions:
    contents: read
jobs:
    probe:
        runs-on: ubuntu-latest
        timeout-minutes: 2
        steps:
            - run: echo probe
' "Add a workflow that only echoes"
put_file "$OWNER_FILE" "$ORG/$REPO" notes.txt "one
" "Add a file to push over"
rules=$(gh_api "$OWNER_FILE" GET "/repos/$ORG/$REPO/rules/branches/main" | jq -c '[.[].type]')
echo "rules on main: $rules"
for r in deletion non_fast_forward pull_request; do
    check "main of the new repository carries '$r'" "$(echo "$rules" | jq -e --arg r "$r" 'index($r) != null' >/dev/null && echo 0 || echo 1)" "rules are $rules"
done

echo "-- 3. a fork's pull request by the second account (an outside contributor)"
gh_api "$OTHER_FILE" POST "/repos/$ORG/$REPO/forks" '{}' >/dev/null
for _ in $(seq 30); do
    [ "$(gh_code "$OTHER_FILE" GET "/repos/$OTHER/$REPO/contents/notes.txt")" = 200 ] && break
    sleep 2
done
# A file under .github/, which the code owner covers; the base's workflow runs for the request.
put_file "$OTHER_FILE" "$OTHER/$REPO" .github/probe-note.txt "changed by a fork
" "Change a file the code owner covers, from a fork"
pr=$(gh_api "$OTHER_FILE" POST "/repos/$ORG/$REPO/pulls" \
    "$(jq -n --arg h "$OTHER:main" '{title:"Forge rules probe from a fork", head:$h, base:"main"}')" | jq -r .number)
[ "$pr" != null ] || { check "the second account can open a pull request from its fork" 1 "see the HTTP line above"; pr=; }
[ -n "$pr" ] && echo "pull request #$pr opened; waiting 30 s for its workflow"
[ -n "$pr" ] && sleep 30
state=$(gh_api "$OWNER_FILE" GET "/repos/$ORG/$REPO/actions/runs?event=pull_request" | jq -r '[(.workflow_runs // [])[] | .conclusion // .status] | join(",")')
check "the fork's workflow waits for approval" "$(echo "$state" | grep -q action_required && echo 0 || echo 1)" "runs: '$state'"
reviewers=$(gh_api "$OWNER_FILE" GET "/repos/$ORG/$REPO/pulls/$pr/requested_reviewers" | jq -r '[(.users // [])[].login] | join(",")')
check "the code owner's review is requested" "$(echo ",$reviewers," | grep -q ",$OWNER," && echo 0 || echo 1)" "requested: '$reviewers'"
[ -n "$pr" ] && gh_api "$OTHER_FILE" PATCH "/repos/$ORG/$REPO/pulls/$pr" '{"state":"closed"}' >/dev/null

echo "-- 4. pushes by the second account with write access"
gh_api "$OWNER_FILE" PUT "/repos/$ORG/$REPO/collaborators/$OTHER" '{"permission":"push"}' >/dev/null
sleep 2
inv=$(gh_api "$OTHER_FILE" GET /user/repository_invitations | jq -r --arg r "$ORG/$REPO" '.[] | select(.repository.full_name == $r) | .id')
[ -n "$inv" ] && gh_code "$OTHER_FILE" PATCH "/user/repository_invitations/$inv" >/dev/null
# git takes the second account's token through an askpass helper that reads the file.
cat >"$WORK/askpass" <<EOF
#!/bin/sh
case "\$1" in
    Username*) echo "$OTHER" ;;
    *) tr -d '\n' <"$OTHER_FILE" ;;
esac
EOF
chmod 700 "$WORK/askpass"
export GIT_ASKPASS="$WORK/askpass" GIT_TERMINAL_PROMPT=0
git -c credential.helper= clone -q "https://github.com/$ORG/$REPO.git" "$WORK/clone"
cd "$WORK/clone"
git -c user.name="$OTHER" -c user.email="$OTHER@users.noreply.github.com" commit -q --allow-empty -m "Probe a direct push"
if git -c credential.helper= push -q origin HEAD:main 2>"$WORK/push.err"; then
    check "a direct push to main by another account is refused" 1 "it was accepted"
else
    check "a direct push to main by another account is refused" 0 ""
    sed 's/^/    /' "$WORK/push.err" | head -4
fi
if git -c credential.helper= push -q --force origin HEAD~2:main 2>"$WORK/force.err"; then
    check "a force push to main by another account is refused" 1 "it was accepted"
else
    check "a force push to main by another account is refused" 0 ""
    sed 's/^/    /' "$WORK/force.err" | head -4
fi
cd /
