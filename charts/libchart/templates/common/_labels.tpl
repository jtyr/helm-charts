{{- /* Common labels */}}
{{- define "libchart.v1.labels" -}}
helm.sh/chart: {{ include "libchart.v1.chart" . }}
{{ template "libchart.v1.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- /* Selector labels */}}
{{- define "libchart.v1.selectorLabels" -}}
app.kubernetes.io/name: {{ template "libchart.v1.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
