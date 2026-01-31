# Kubernetes Cheatsheet

## What is Kubernetes?

Kubernetes (K8s) is an open-source container orchestration platform that automates deployment, scaling, and management of containerized applications. Originally developed by Google, it's now maintained by the Cloud Native Computing Foundation (CNCF).

---

## Why Use Kubernetes?

- **Container Orchestration** - Manage thousands of containers across multiple hosts
- **Auto-Scaling** - Scale applications based on demand
- **Self-Healing** - Automatically restart failed containers
- **Load Balancing** - Distribute traffic across containers
- **Rolling Updates** - Deploy new versions with zero downtime
- **Service Discovery** - Automatic DNS and networking between services
- **Secrets Management** - Securely store sensitive data

---

## Key Concepts

| Concept | Description |
|---------|-------------|
| **Cluster** | Set of nodes running containerized applications |
| **Node** | Worker machine (VM or physical) in the cluster |
| **Pod** | Smallest deployable unit, contains one or more containers |
| **Deployment** | Manages ReplicaSets and provides declarative updates |
| **Service** | Exposes Pods to network traffic |
| **Namespace** | Virtual cluster for resource isolation |
| **ConfigMap** | Store non-sensitive configuration data |
| **Secret** | Store sensitive data (passwords, tokens) |
| **Ingress** | Manage external HTTP/HTTPS access to services |
| **PersistentVolume** | Storage resource in the cluster |

---

## Installation

### kubectl (CLI Tool)

#### Windows

```powershell
# Using winget
winget install Kubernetes.kubectl

# Or using Chocolatey
choco install kubernetes-cli
```

#### Mac

```bash
# Using Homebrew
brew install kubectl
```

#### Linux

```bash
# Download latest
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# Install
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
```

### Verify Installation

```bash
kubectl version --client
```

### Configure Cluster Access

```bash
# Azure AKS
az aks get-credentials --resource-group myRG --name myAKSCluster

# GCP GKE
gcloud container clusters get-credentials my-cluster --zone us-central1-a

# AWS EKS
aws eks update-kubeconfig --name my-cluster --region us-east-1

# View current context
kubectl config current-context

# List all contexts
kubectl config get-contexts

# Switch context
kubectl config use-context my-cluster-context
```

---

## Essential Commands

### Cluster Information

```bash
# Cluster info
kubectl cluster-info

# View nodes
kubectl get nodes
kubectl get nodes -o wide

# View all resources
kubectl get all
kubectl get all -A                    # All namespaces
kubectl get all -n my-namespace       # Specific namespace

# API resources
kubectl api-resources
```

### Namespaces

```bash
# List namespaces
kubectl get namespaces
kubectl get ns

# Create namespace
kubectl create namespace my-namespace

# Set default namespace
kubectl config set-context --current --namespace=my-namespace

# Delete namespace
kubectl delete namespace my-namespace
```

### Pods

```bash
# List pods
kubectl get pods
kubectl get pods -o wide              # More details
kubectl get pods -A                   # All namespaces
kubectl get pods -l app=nginx         # Filter by label
kubectl get pods --watch              # Watch changes

# Create pod
kubectl run nginx --image=nginx

# Describe pod
kubectl describe pod nginx

# Delete pod
kubectl delete pod nginx

# Pod logs
kubectl logs nginx
kubectl logs -f nginx                 # Follow logs
kubectl logs nginx -c container-name  # Specific container
kubectl logs --previous nginx         # Previous instance

# Execute command in pod
kubectl exec nginx -- ls /etc/nginx
kubectl exec -it nginx -- /bin/bash   # Interactive shell

# Copy files
kubectl cp file.txt nginx:/tmp/
kubectl cp nginx:/tmp/file.txt ./

# Port forward
kubectl port-forward pod/nginx 8080:80
```

### Deployments

```bash
# List deployments
kubectl get deployments
kubectl get deploy

# Create deployment
kubectl create deployment nginx --image=nginx

# Create with replicas
kubectl create deployment nginx --image=nginx --replicas=3

# Describe deployment
kubectl describe deployment nginx

# Scale deployment
kubectl scale deployment nginx --replicas=5

# Autoscale
kubectl autoscale deployment nginx --min=2 --max=10 --cpu-percent=80

# Update image
kubectl set image deployment/nginx nginx=nginx:1.25

# Rollout status
kubectl rollout status deployment/nginx

# Rollout history
kubectl rollout history deployment/nginx

# Rollback
kubectl rollout undo deployment/nginx
kubectl rollout undo deployment/nginx --to-revision=2

# Restart deployment
kubectl rollout restart deployment/nginx

# Delete deployment
kubectl delete deployment nginx
```

### Services

```bash
# List services
kubectl get services
kubectl get svc

# Expose deployment as service
kubectl expose deployment nginx --port=80 --type=ClusterIP
kubectl expose deployment nginx --port=80 --type=NodePort
kubectl expose deployment nginx --port=80 --type=LoadBalancer

# Describe service
kubectl describe service nginx

# Delete service
kubectl delete service nginx
```

### ConfigMaps & Secrets

```bash
# Create ConfigMap
kubectl create configmap my-config --from-literal=key1=value1
kubectl create configmap my-config --from-file=config.properties

# List ConfigMaps
kubectl get configmaps

# Describe ConfigMap
kubectl describe configmap my-config

# Create Secret
kubectl create secret generic my-secret --from-literal=password=mysecret
kubectl create secret generic my-secret --from-file=./credentials

# List Secrets
kubectl get secrets

# View Secret (base64 encoded)
kubectl get secret my-secret -o yaml
```

---

## YAML Manifests

### Pod

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
  labels:
    app: nginx
spec:
  containers:
    - name: nginx
      image: nginx:1.25
      ports:
        - containerPort: 80
      resources:
        requests:
          memory: "64Mi"
          cpu: "250m"
        limits:
          memory: "128Mi"
          cpu: "500m"
```

### Deployment

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx
          image: nginx:1.25
          ports:
            - containerPort: 80
          env:
            - name: ENV_VAR
              value: "production"
            - name: SECRET_VAR
              valueFrom:
                secretKeyRef:
                  name: my-secret
                  key: password
          resources:
            requests:
              memory: "64Mi"
              cpu: "250m"
            limits:
              memory: "128Mi"
              cpu: "500m"
          livenessProbe:
            httpGet:
              path: /healthz
              port: 80
            initialDelaySeconds: 30
            periodSeconds: 10
          readinessProbe:
            httpGet:
              path: /ready
              port: 80
            initialDelaySeconds: 5
            periodSeconds: 5
```

### Service

```yaml
# ClusterIP (internal)
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  selector:
    app: nginx
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: ClusterIP

---
# LoadBalancer (external)
apiVersion: v1
kind: Service
metadata:
  name: nginx-lb
spec:
  selector:
    app: nginx
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: LoadBalancer

---
# NodePort
apiVersion: v1
kind: Service
metadata:
  name: nginx-nodeport
spec:
  selector:
    app: nginx
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
      nodePort: 30080
  type: NodePort
```

### Ingress

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: nginx-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  ingressClassName: nginx
  rules:
    - host: myapp.example.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: nginx-service
                port:
                  number: 80
  tls:
    - hosts:
        - myapp.example.com
      secretName: tls-secret
```

### ConfigMap

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  DATABASE_URL: "postgres://db:5432/mydb"
  LOG_LEVEL: "info"
  config.json: |
    {
      "key": "value",
      "enabled": true
    }
```

### Secret

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: app-secret
type: Opaque
data:
  # Base64 encoded values
  username: YWRtaW4=          # admin
  password: cGFzc3dvcmQxMjM=  # password123
```

### PersistentVolumeClaim

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
  storageClassName: standard
```

---

## Apply & Delete

```bash
# Apply manifest
kubectl apply -f deployment.yaml

# Apply all files in directory
kubectl apply -f ./manifests/

# Apply from URL
kubectl apply -f https://example.com/manifest.yaml

# Delete using manifest
kubectl delete -f deployment.yaml

# Delete all resources with label
kubectl delete all -l app=nginx

# Dry run (preview)
kubectl apply -f deployment.yaml --dry-run=client
kubectl apply -f deployment.yaml --dry-run=server
```

---

## Debugging

```bash
# Describe resource (shows events)
kubectl describe pod nginx

# Get pod events
kubectl get events --sort-by=.metadata.creationTimestamp

# Check pod logs
kubectl logs nginx
kubectl logs nginx --previous       # Crashed container

# Interactive shell
kubectl exec -it nginx -- /bin/sh

# Run debug container
kubectl debug nginx -it --image=busybox

# Check resource usage
kubectl top nodes
kubectl top pods

# Get YAML of existing resource
kubectl get deployment nginx -o yaml
```

---

## Quick Reference

| Command | Description |
|---------|-------------|
| `kubectl get pods` | List pods |
| `kubectl get all` | List all resources |
| `kubectl describe pod <n>` | Pod details |
| `kubectl logs <pod>` | View logs |
| `kubectl exec -it <pod> -- sh` | Shell into pod |
| `kubectl apply -f <file>` | Apply manifest |
| `kubectl delete -f <file>` | Delete resources |
| `kubectl scale deploy <n> --replicas=3` | Scale |
| `kubectl rollout restart deploy <n>` | Restart |
| `kubectl port-forward <pod> 8080:80` | Port forward |

---

## Resources

- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
- [Kubernetes Patterns](https://k8spatterns.io/)
- [CKAD Exercises](https://github.com/dgkanatsios/CKAD-exercises)