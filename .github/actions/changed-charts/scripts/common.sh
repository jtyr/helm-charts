# shellcheck shell=bash

function msg_debug() {
    msg 'D' "$@"
}

function msg_info() {
    msg 'I' "$@"
}

function msg_warn() {
    msg 'W' "$@"
}

function msg_error() {
    msg 'E' "$@"
}

function msg() {
    TYPE=$1
    TEXT=$2
    EXIT=${3:-}

    # Set the TYPE and GH_TYPE
    if [[ ${TYPE^^} == 'D' ]]; then
        GH_TYPE='debug'
    elif [[ ${TYPE^^} == 'I' ]]; then
        GH_TYPE='notice'
    elif [[ ${TYPE^^} == 'W' ]]; then
        GH_TYPE='warning'
    elif [[ ${TYPE^^} == 'E' ]]; then
        GH_TYPE='error'
        # Default exit value for errors is 1
        EXIT=${3:-1}
    else
        TYPE='I'
        GH_TYPE='notice'
    fi

    if [[ -n ${CI:-} ]]; then
        # Display the message on the GitHub Workflow run level
        echo "::${GH_TYPE}::$TEXT"
    else
        # Display the message in STDERR
        echo "${TYPE^^}: $TEXT" 1>&2
    fi

    # Exit if needed
    if [[ -n $EXIT ]]; then
        exit "$EXIT"
    fi
}
