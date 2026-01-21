#!/usr/bin/env bash

# Fail on any error
set -o errexit
set -o nounset
set -o pipefail

# Location of this script
SCRIPT_DIR=$(dirname "$0")

# Source common functions
# shellcheck disable=SC1091
source "$SCRIPT_DIR/common.sh"

function main() {
    # Check input parameters
    if [[ -z $GITHUB_REF ]]; then
        msg_error 'Variable GITHUB_REF is not defined'
    elif [[ -z $GITHUB_SHA ]]; then
        msg_error 'Variable GITHUB_SHA is not defined'
    fi

    # List all changed files (ignore deleted files)
    if [[ $GITHUB_REF == 'refs/heads/main' ]]; then
        CHANGED_FILES=$(git diff --name-only --diff-filter=d HEAD^)
    else
        CHANGED_FILES=$(git diff --name-only --diff-filter=d origin/main "$GITHUB_SHA")
    fi

    msg_info 'Changed files'
    echo "$CHANGED_FILES"

    CHANGED_DIRS=$(echo "$CHANGED_FILES" | { grep '^charts/' || test $? = 1; } | cut -d'/' -f2 | sort -u)

    msg_info 'Changed directories:'
    echo "$CHANGED_DIRS"

    CHANGED_CHARTS=$(echo "$CHANGED_DIRS" | jq -R . | jq -sc)

    msg_info "List of charts: $CHANGED_CHARTS"

    if [[ -n ${CI:-} ]]; then
        echo "charts=$CHANGED_CHARTS" >> "$GITHUB_OUTPUT"
    fi
}

main "$@"
