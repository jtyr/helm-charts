{{- /*
Creates a default fully qualified app name. The name is truncates at 63 chars
because some Kubernetes name fields are limited to this (by the DNS naming
spec). If release name contains the chart name, it will be used as the full
name.
*/}}
{{- define "libchart.v1.fullname" }}
  {{- if .Values.fullnameOverride }}
    {{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
  {{- else }}
    {{- $name := default .Chart.Name .Values.nameOverride }}
    {{- if contains $name .Release.Name }}
      {{- .Release.Name | trunc 63 | trimSuffix "-" }}
    {{- else }}
      {{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
    {{- end }}
  {{- end }}
{{- end }}

{{- /* Expand the name of the chart */}}
{{- define "libchart.v1.name" }}
  {{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- /* Create chart name and version as used by the chart label */}}
{{- define "libchart.v1.chart" }}
  {{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- /* Create the name of the service account to use */}}
{{- define "libchart.v1.serviceAccountName" }}
  {{- default (include "libchart.v1.fullname" .) .Values.libchart.serviceAccount.name }}
{{- end }}
