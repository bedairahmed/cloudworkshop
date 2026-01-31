# Helm Cheatsheet

## What is Helm?

Helm is the package manager for Kubernetes. It allows you to define, install, and upgrade complex Kubernetes applications using reusable packages called "charts". Think of Helm as the apt/yum/brew for Kubernetes.

---

## Why Use Helm?

- **Package Management** - Install complex apps with a single command
- **Templating** - Generate Kubernetes manifests dynamically
- **Versioning** - Track and rollback application versions
- **Reusability** - Share and reuse application configurations
- **Dependencies** - Manage application dependencies
- **Configuration** - Customize deployments with values files
- **Release Management** - Track what's deployed in your cluster

---

## Key Concepts

| Concept | Description |
|---------|-------------|
| **Chart** | Package containing Kubernetes resource definitions |
| **Repository** | Location where charts are stored and shared |
| **Release** | Instance of a chart running in the cluster |
| **Values** | Configuration options to customize a chart |
| **Template** | Kubernetes manifest with Go templating |

---

## Installation

### Windows

```powershell
# Using winget
winget install Helm.Helm

# Using Chocolatey
choco install kubernetes-helm

# Using Scoop
scoop install helm
```

### Mac

```bash
# Using Homebrew
brew install helm
```

### Linux

```bash
# Using script
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Using apt (Debian/Ubuntu)
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm
```

### Verify Installation

```bash
helm version
```

---

## Repository Management

```bash
# Add a repository
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add stable https://charts.helm.sh/stable
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

# List repositories
helm repo list

# Update repositories
helm repo update

# Search repository
helm search repo nginx
helm search repo bitnami/nginx

# Search Artifact Hub (public charts)
helm search hub wordpress

# Remove repository
helm repo remove bitnami
```

---

## Chart Operations

### Searching & Inspecting

```bash
# Search for charts
helm search repo mysql
helm search repo mysql --versions    # Show all versions

# Show chart information
helm show chart bitnami/nginx
helm show readme bitnami/nginx
helm show values bitnami/nginx       # Show default values
helm show all bitnami/nginx          # Show everything

# Download chart without installing
helm pull bitnami/nginx
helm pull bitnami/nginx --untar      # Extract to directory
helm pull bitnami/nginx --version 15.0.0
```

### Installing Charts

```bash
# Install a chart
helm install my-release bitnami/nginx

# Install with custom name
helm install my-nginx bitnami/nginx

# Install in specific namespace
helm install my-nginx bitnami/nginx --namespace my-namespace

# Install and create namespace
helm install my-nginx bitnami/nginx --namespace my-namespace --create-namespace

# Install with custom values file
helm install my-nginx bitnami/nginx -f values.yaml

# Install with inline values
helm install my-nginx bitnami/nginx --set replicaCount=3
helm install my-nginx bitnami/nginx --set service.type=LoadBalancer

# Install with multiple value overrides
helm install my-nginx bitnami/nginx \
  --set replicaCount=3 \
  --set service.type=LoadBalancer \
  --set resources.requests.memory=256Mi

# Install specific version
helm install my-nginx bitnami/nginx --version 15.0.0

# Dry run (preview)
helm install my-nginx bitnami/nginx --dry-run

# Generate YAML without installing
helm template my-nginx bitnami/nginx > output.yaml

# Wait for resources to be ready
helm install my-nginx bitnami/nginx --wait --timeout 5m
```

### Managing Releases

```bash
# List releases
helm list
helm list -A                         # All namespaces
helm list -n my-namespace            # Specific namespace

# Get release status
helm status my-nginx

# Get release history
helm history my-nginx

# Get values used in release
helm get values my-nginx
helm get values my-nginx --all       # Include defaults

# Get manifest (generated YAML)
helm get manifest my-nginx

# Get all release information
helm get all my-nginx
```

### Upgrading

```bash
# Upgrade release
helm upgrade my-nginx bitnami/nginx

# Upgrade with new values
helm upgrade my-nginx bitnami/nginx -f new-values.yaml

# Upgrade with set values
helm upgrade my-nginx bitnami/nginx --set replicaCount=5

# Install or upgrade (if not exists)
helm upgrade --install my-nginx bitnami/nginx

# Reuse previous values
helm upgrade my-nginx bitnami/nginx --reuse-values

# Reset values to chart defaults
helm upgrade my-nginx bitnami/nginx --reset-values

# Dry run upgrade
helm upgrade my-nginx bitnami/nginx --dry-run
```

### Rollback

```bash
# Rollback to previous revision
helm rollback my-nginx

# Rollback to specific revision
helm rollback my-nginx 2

# Rollback with dry run
helm rollback my-nginx 2 --dry-run
```

### Uninstalling

```bash
# Uninstall release
helm uninstall my-nginx

# Uninstall from specific namespace
helm uninstall my-nginx -n my-namespace

# Uninstall and keep history
helm uninstall my-nginx --keep-history

# Dry run uninstall
helm uninstall my-nginx --dry-run
```

---

## Creating Charts

### Create New Chart

```bash
# Create chart scaffold
helm create mychart

# Chart structure
mychart/
├── Chart.yaml          # Chart metadata
├── values.yaml         # Default values
├── charts/             # Dependencies
├── templates/          # Kubernetes manifests
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── ingress.yaml
│   ├── _helpers.tpl    # Template helpers
│   ├── hpa.yaml
│   ├── serviceaccount.yaml
│   └── NOTES.txt       # Post-install notes
└── .helmignore         # Files to ignore
```

### Chart.yaml

```yaml
apiVersion: v2
name: mychart
description: A Helm chart for my application
type: application
version: 0.1.0           # Chart version
appVersion: "1.0.0"      # Application version

dependencies:
  - name: postgresql
    version: "12.x.x"
    repository: "https://charts.bitnami.com/bitnami"
    condition: postgresql.enabled

maintainers:
  - name: John Doe
    email: john@example.com

keywords:
  - app
  - web
```

### values.yaml

```yaml
# Default values for mychart

replicaCount: 1

image:
  repository: nginx
  tag: "1.25"
  pullPolicy: IfNotPresent

service:
  type: ClusterIP
  port: 80

ingress:
  enabled: false
  className: nginx
  hosts:
    - host: chart-example.local
      paths:
        - path: /
          pathType: Prefix

resources:
  requests:
    cpu: 100m
    memory: 128Mi
  limits:
    cpu: 200m
    memory: 256Mi

autoscaling:
  enabled: false
  minReplicas: 1
  maxReplicas: 10
  targetCPUUtilization: 80

postgresql:
  enabled: true
  auth:
    postgresPassword: "secretpassword"
```

### Template Example (deployment.yaml)

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "mychart.fullname" . }}
  labels:
    {{- include "mychart.labels" . | nindent 4 }}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      {{- include "mychart.selectorLabels" . | nindent 6 }}
  template:
    metadata:
      labels:
        {{- include "mychart.selectorLabels" . | nindent 8 }}
    spec:
      containers:
        - name: {{ .Chart.Name }}
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
          imagePullPolicy: {{ .Values.image.pullPolicy }}
          ports:
            - containerPort: 80
          {{- if .Values.resources }}
          resources:
            {{- toYaml .Values.resources | nindent 12 }}
          {{- end }}
```

### Template Helpers (_helpers.tpl)

```yaml
{{/*
Create a default fully qualified app name.
*/}}
{{- define "mychart.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "mychart.labels" -}}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
app.kubernetes.io/name: {{ include "mychart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
```

---

## Chart Development

```bash
# Lint chart
helm lint mychart/

# Package chart
helm package mychart/

# Install from local directory
helm install my-release ./mychart

# Install from package
helm install my-release mychart-0.1.0.tgz

# Template (render without installing)
helm template my-release ./mychart
helm template my-release ./mychart -f custom-values.yaml

# Debug template rendering
helm template my-release ./mychart --debug

# Update dependencies
helm dependency update mychart/

# List dependencies
helm dependency list mychart/
```

---

## Templating Syntax

### Built-in Objects

```yaml
# Release info
{{ .Release.Name }}
{{ .Release.Namespace }}
{{ .Release.IsInstall }}
{{ .Release.IsUpgrade }}

# Chart info
{{ .Chart.Name }}
{{ .Chart.Version }}
{{ .Chart.AppVersion }}

# Values
{{ .Values.replicaCount }}
{{ .Values.image.repository }}

# Capabilities
{{ .Capabilities.KubeVersion }}
{{ .Capabilities.APIVersions.Has "networking.k8s.io/v1" }}
```

### Common Functions

```yaml
# Default value
{{ .Values.name | default "default-name" }}

# Quote strings
{{ .Values.name | quote }}

# Indent
{{ .Values.config | toYaml | indent 4 }}
{{ .Values.config | toYaml | nindent 4 }}

# Conditionals
{{- if .Values.ingress.enabled }}
...
{{- end }}

{{- if and .Values.feature1 .Values.feature2 }}
...
{{- end }}

# Loops
{{- range .Values.hosts }}
- {{ . | quote }}
{{- end }}

{{- range $key, $value := .Values.env }}
- name: {{ $key }}
  value: {{ $value | quote }}
{{- end }}

# Include template
{{ include "mychart.fullname" . }}

# Required value
{{ required "A valid .Values.image.repository is required!" .Values.image.repository }}
```

---

## Quick Reference

| Command | Description |
|---------|-------------|
| `helm repo add <n> <url>` | Add repository |
| `helm repo update` | Update repositories |
| `helm search repo <term>` | Search charts |
| `helm install <n> <chart>` | Install chart |
| `helm upgrade <n> <chart>` | Upgrade release |
| `helm rollback <n> <rev>` | Rollback release |
| `helm uninstall <n>` | Uninstall release |
| `helm list` | List releases |
| `helm status <n>` | Release status |
| `helm history <n>` | Release history |
| `helm show values <chart>` | Show default values |
| `helm template <n> <chart>` | Render templates |
| `helm create <name>` | Create new chart |
| `helm lint <chart>` | Lint chart |
| `helm package <chart>` | Package chart |

---

## Resources

- [Helm Documentation](https://helm.sh/docs/)
- [Artifact Hub](https://artifacthub.io/) - Public chart repository
- [Helm Best Practices](https://helm.sh/docs/chart_best_practices/)
- [Chart Template Guide](https://helm.sh/docs/chart_template_guide/)