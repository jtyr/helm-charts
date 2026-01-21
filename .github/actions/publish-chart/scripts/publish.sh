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
    if [[ -z $REGISTRY ]]; then
        msg_error 'Variable REGISTRY is not defined.'
    fi

    # Get chart name from the current working directory path
    NAME=$(basename "$PWD")

    msg_info 'Chart name: $NAME'

    # Get the chart version from the Chart.yaml file
    VERSION=$(yq e '.version' "$CHART_PATH/$CHART_NAME/Chart.yaml")

    msg_info "Version: $CHART_VERSION"

    # Create temporal directory to store the packages Helm chart
    TMP_DIR=$(mktemp -d)

    msg_info 'Packaging chart'
    helm package --destination "$TMP_DIR"

    msg_info 'Pushing chart'
    helm push "$TMP_DIR/$NAME-$VERSION.tar.gz" "oci://$REGISTRY/jtyr/helm"
}

main "$@"
