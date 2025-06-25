{{/*
차트 이름 확장.
*/}}
{{- define "kubeadm-cluster-setup.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
앱 이름.
*/}}
{{- define "kubeadm-cluster-setup.fullname" -}}
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

{{/*
차트 이름, 버젼.
*/}}
{{- define "kubeadm-cluster-setup.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "kubeadm-cluster-setup.labels" -}}
helm.sh/chart: {{ include "kubeadm-cluster-setup.chart" . }}
{{ include "kubeadm-cluster-setup.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "kubeadm-cluster-setup.selectorLabels" -}}
app.kubernetes.io/name: {{ include "kubeadm-cluster-setup.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
