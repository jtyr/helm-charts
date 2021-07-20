#!/bin/bash

BASE_DIR=$(dirname "$0")

VERSION=$(grep -Po '(?<=^appVersion: )(v\d+.\d+\.\d+)' $BASE_DIR/../Chart.yaml)

CRDS='
monitoring.coreos.com_podmonitors.yaml
monitoring.coreos.com_probes.yaml
monitoring.coreos.com_servicemonitors.yaml
monitoring.grafana.com_grafana-agents.yaml
monitoring.grafana.com_prometheus-instances.yaml
'
#monitoring.grafana.com_logs-instances.yaml
#monitoring.grafana.com_pod-logs.yaml

for CRD in $CRDS; do
    curl -o $BASE_DIR/$CRD https://raw.githubusercontent.com/grafana/agent/$VERSION/production/operator/crds/$CRD
done
