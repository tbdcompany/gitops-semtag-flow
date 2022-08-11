#!/usr/bin/env bash

PRD_REGEX="^prd$"
FORPRD_REGEX="^promote\/prd$"
GA_SEMVER_REGEX="^v[0-9]\+\.[0-9]\+\.[0-9]\+$"

print_exit () {
	echo $2
	exit $1
}

git tag --no-contains HEAD | grep -q $PRD_REGEX       || print_exit 0 "Production tag already exists on commit, exiting early."
git tag --contains HEAD    | grep -q $FORPRD_REGEX    || print_exit 0 "Production request promotion tag not specified, exiting early."
git tag --contains HEAD    | grep -q $GA_SEMVER_REGEX || print_exit 1 "Missing GA semver tag on the same commit, not promoting."

git tag --force prd
git push --force origin prd

