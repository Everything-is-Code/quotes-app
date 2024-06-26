apiVersion: v1
kind: ConfigMap
metadata:
  annotations:
      helm.sh/hook: pre-install
      argocd.argoproj.io/sync-wave: "1"
  name: {{ .Values.configmap.environmentVariables.name }}
  namespace: {{ .Values.namespace }}
data:
  VITE_BACKEND_URL: "{{ .Values.wildcard_hostname }}/quote"
binaryData: {}
immutable: false
