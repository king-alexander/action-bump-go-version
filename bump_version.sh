#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail

VERSION_FILE=v2/pkg/catalog/config/constants.go

old_version=$(sed -n "s/^Version = \"\(.*\)\"$/\1/p" $VERSION_FILE)
# Comment out periods so they are interpreted as periods and don't
# just match any character
old_version_regex=${old_version//\./\\\.}

git fetch --tags
new_version=$(git tag --sort=-v:refname --list "v[0-9]*" | head -n 1)
echo Changing version from "$old_version" to "$new_version"
# A temp file is used to provide compatability with macOS development
# as a result of macOS using the BSD version of sed
tmp_file=/tmp/version.$$
sed "s/$old_version_regex/$new_version/" $VERSION_FILE > $tmp_file
mv $tmp_file $VERSION_FILE
git add $VERSION_FILE
git commit -m"Bump version from $old_version to $new_version"
git push --follow-tags
