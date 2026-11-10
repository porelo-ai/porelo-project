#!/usr/bin/env bash
# Holds a pull request's commits to the shared rule on commit messages; one from outside also carries its author's
# Signed-off-by: on each commit. porelo-project has no Maven build, so porelo-release is built from porelo-buildtools'
# main, as stories-check.sh does.
#
# Usage: commits-check.sh ROOT RANGE [--outside], with this repository checked out as ROOT/porelo-project.
set -euo pipefail

root=$(cd "$1" && pwd)
range=$2
outside=${3:-}
tool="$root/commits-tool"
: "${JAVA_HOME:?a JDK}"
export JAVA_HOME PATH="$JAVA_HOME/bin:$PATH"

git clone -q --filter=blob:none https://github.com/porelo-ai/porelo-buildtools.git "$root/porelo-buildtools"
(cd "$root/porelo-buildtools" \
    && ./mvnw -q -B -ntp -s settings.xml -pl release -am -DskipTests -Dspotless.check.skip=true install \
    && ./mvnw -q -B -ntp -s settings.xml -pl release dependency:copy-dependencies \
        -DincludeScope=runtime "-DoutputDirectory=$tool")
cp "$root"/porelo-buildtools/release/target/porelo-release-*.jar "$tool/"
rm -f "$tool"/porelo-release-*-sources.jar "$tool"/porelo-release-*-javadoc.jar

cd "$root/porelo-project"
java -cp "$tool/*" org.fuin.porelo.release.Main check-commits "$range" ${outside:+"$outside"}
