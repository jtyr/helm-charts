{{- /* Generate all supported Foo Controller resources */}}
{{- define "libchart.v1.foo.all" }}
  {{- template "libchart.v1.foo.bars" . }}
{{- end }}
