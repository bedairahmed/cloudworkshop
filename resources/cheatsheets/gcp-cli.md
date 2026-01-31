# Google Cloud CLI (gcloud) Cheatsheet

## What is Google Cloud CLI?

Google Cloud CLI (gcloud) is a command-line tool for managing Google Cloud Platform (GCP) resources. It allows you to create, configure, and manage GCP services like Compute Engine, Cloud Storage, Kubernetes Engine, and more directly from your terminal.

---

## Why Use gcloud?

- **Automation** - Script deployments and infrastructure management
- **Speed** - Execute tasks faster than using the Console
- **CI/CD Integration** - Perfect for pipelines and DevOps workflows
- **Consistency** - Reproducible commands for infrastructure
- **Multi-Project** - Easily switch between GCP projects

---

## Installation

### Windows

```powershell
# Download and run installer from
# https://cloud.google.com/sdk/docs/install

# Or using winget
winget install Google.CloudSDK
```

### Mac

```bash
# Using Homebrew
brew install --cask google-cloud-sdk

# Or download from
# https://cloud.google.com/sdk/docs/install
```

### Linux (Ubuntu/Debian)

```bash
# Add Cloud SDK repo
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# Import Google Cloud public key
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

# Install
sudo apt-get update && sudo apt-get install google-cloud-cli
```

### Docker

```bash
docker run -it gcr.io/google.com/cloudsdktool/google-cloud-cli:latest gcloud version
```

### Verify Installation

```bash
gcloud --version
```

---

## Initial Setup

```bash
# Initialize gcloud (first time setup)
gcloud init

# Authenticate
gcloud auth login

# Authenticate for application default credentials
gcloud auth application-default login

# List authenticated accounts
gcloud auth list

# Set active account
gcloud config set account user@example.com

# Revoke credentials
gcloud auth revoke
```

---

## Configuration

```bash
# View current configuration
gcloud config list

# Set default project
gcloud config set project PROJECT_ID

# Set default region
gcloud config set compute/region us-central1

# Set default zone
gcloud config set compute/zone us-central1-a

# Unset a property
gcloud config unset compute/zone

# Create a new configuration
gcloud config configurations create my-config

# List configurations
gcloud config configurations list

# Switch configuration
gcloud config configurations activate my-config
```

---

## Key Concepts

| Concept | Description |
|---------|-------------|
| **Project** | Container for all GCP resources and billing |
| **Region** | Geographic area containing zones |
| **Zone** | Deployment area within a region |
| **Service Account** | Identity for applications/services |
| **IAM** | Identity and Access Management |

---

## Projects

```bash
# List all projects
gcloud projects list

# Create a new project
gcloud projects create PROJECT_ID --name="Project Name"

# Set current project
gcloud config set project PROJECT_ID

# Describe a project
gcloud projects describe PROJECT_ID

# Delete a project
gcloud projects delete PROJECT_ID
```

---

## Compute Engine (VMs)

```bash
# List all instances
gcloud compute instances list

# Create a VM instance
gcloud compute instances create my-vm \
  --zone=us-central1-a \
  --machine-type=e2-micro \
  --image-family=ubuntu-2204-lts \
  --image-project=ubuntu-os-cloud

# Create with specific disk size
gcloud compute instances create my-vm \
  --zone=us-central1-a \
  --machine-type=e2-small \
  --boot-disk-size=50GB \
  --image-family=debian-11 \
  --image-project=debian-cloud

# Describe an instance
gcloud compute instances describe my-vm --zone=us-central1-a

# Start an instance
gcloud compute instances start my-vm --zone=us-central1-a

# Stop an instance
gcloud compute instances stop my-vm --zone=us-central1-a

# Delete an instance
gcloud compute instances delete my-vm --zone=us-central1-a

# SSH into an instance
gcloud compute ssh my-vm --zone=us-central1-a

# SSH with specific user
gcloud compute ssh user@my-vm --zone=us-central1-a

# List machine types
gcloud compute machine-types list --filter="zone:us-central1-a"

# List available images
gcloud compute images list
```

---

## Cloud Storage

```bash
# List buckets
gcloud storage buckets list

# Create a bucket
gcloud storage buckets create gs://my-unique-bucket-name --location=us-central1

# Delete a bucket
gcloud storage buckets delete gs://my-bucket-name

# Upload a file
gcloud storage cp local-file.txt gs://my-bucket-name/

# Upload a folder recursively
gcloud storage cp -r ./my-folder gs://my-bucket-name/

# Download a file
gcloud storage cp gs://my-bucket-name/file.txt ./local-file.txt

# List objects in bucket
gcloud storage ls gs://my-bucket-name/

# Delete an object
gcloud storage rm gs://my-bucket-name/file.txt

# Sync local folder with bucket
gcloud storage rsync ./local-folder gs://my-bucket-name/folder
```

---

## Google Kubernetes Engine (GKE)

```bash
# Create a GKE cluster
gcloud container clusters create my-cluster \
  --zone=us-central1-a \
  --num-nodes=3 \
  --machine-type=e2-medium

# Create autopilot cluster
gcloud container clusters create-auto my-autopilot-cluster \
  --region=us-central1

# List clusters
gcloud container clusters list

# Get credentials for kubectl
gcloud container clusters get-credentials my-cluster --zone=us-central1-a

# Describe a cluster
gcloud container clusters describe my-cluster --zone=us-central1-a

# Resize cluster
gcloud container clusters resize my-cluster --zone=us-central1-a --num-nodes=5

# Delete a cluster
gcloud container clusters delete my-cluster --zone=us-central1-a
```

---

## Cloud Run

```bash
# Deploy a container
gcloud run deploy my-service \
  --image=gcr.io/my-project/my-image \
  --region=us-central1 \
  --platform=managed \
  --allow-unauthenticated

# Deploy from source code
gcloud run deploy my-service \
  --source=. \
  --region=us-central1

# List services
gcloud run services list

# Describe a service
gcloud run services describe my-service --region=us-central1

# Get service URL
gcloud run services describe my-service --region=us-central1 --format='value(status.url)'

# Delete a service
gcloud run services delete my-service --region=us-central1
```

---

## Cloud Functions

```bash
# Deploy a function (HTTP trigger)
gcloud functions deploy my-function \
  --runtime=python311 \
  --trigger-http \
  --allow-unauthenticated \
  --entry-point=main

# Deploy with Pub/Sub trigger
gcloud functions deploy my-function \
  --runtime=nodejs20 \
  --trigger-topic=my-topic \
  --entry-point=handler

# List functions
gcloud functions list

# Describe a function
gcloud functions describe my-function

# View function logs
gcloud functions logs read my-function

# Delete a function
gcloud functions delete my-function
```

---

## IAM & Service Accounts

```bash
# List service accounts
gcloud iam service-accounts list

# Create a service account
gcloud iam service-accounts create my-sa \
  --display-name="My Service Account"

# Create and download key
gcloud iam service-accounts keys create key.json \
  --iam-account=my-sa@PROJECT_ID.iam.gserviceaccount.com

# Add IAM policy binding
gcloud projects add-iam-policy-binding PROJECT_ID \
  --member="serviceAccount:my-sa@PROJECT_ID.iam.gserviceaccount.com" \
  --role="roles/storage.admin"

# List IAM policies
gcloud projects get-iam-policy PROJECT_ID
```

---

## Networking

```bash
# List VPC networks
gcloud compute networks list

# Create a VPC network
gcloud compute networks create my-vpc --subnet-mode=auto

# Create a custom subnet
gcloud compute networks subnets create my-subnet \
  --network=my-vpc \
  --region=us-central1 \
  --range=10.0.0.0/24

# List firewall rules
gcloud compute firewall-rules list

# Create firewall rule
gcloud compute firewall-rules create allow-ssh \
  --network=my-vpc \
  --allow=tcp:22 \
  --source-ranges=0.0.0.0/0

# Reserve static IP
gcloud compute addresses create my-static-ip --region=us-central1
```

---

## Cloud SQL

```bash
# Create a Cloud SQL instance
gcloud sql instances create my-instance \
  --database-version=MYSQL_8_0 \
  --tier=db-f1-micro \
  --region=us-central1

# List instances
gcloud sql instances list

# Create a database
gcloud sql databases create my-database --instance=my-instance

# Connect to instance
gcloud sql connect my-instance --user=root

# Delete instance
gcloud sql instances delete my-instance
```

---

## Useful Commands

```bash
# Get help
gcloud help
gcloud compute instances create --help

# Interactive mode
gcloud interactive

# Format output
gcloud compute instances list --format="table(name,zone,status)"
gcloud compute instances list --format=json
gcloud compute instances list --format=yaml

# Filter results
gcloud compute instances list --filter="status=RUNNING"
gcloud compute instances list --filter="zone:us-central1-a"

# Enable APIs
gcloud services enable compute.googleapis.com
gcloud services enable container.googleapis.com

# List enabled APIs
gcloud services list --enabled
```

---

## Quick Reference

| Command | Description |
|---------|-------------|
| `gcloud init` | Initialize gcloud |
| `gcloud auth login` | Authenticate |
| `gcloud config set project` | Set project |
| `gcloud projects list` | List projects |
| `gcloud compute instances list` | List VMs |
| `gcloud compute instances create` | Create VM |
| `gcloud compute ssh` | SSH to VM |
| `gcloud storage cp` | Copy to/from bucket |
| `gcloud container clusters create` | Create GKE cluster |
| `gcloud run deploy` | Deploy to Cloud Run |

---

## Resources

- [gcloud CLI Documentation](https://cloud.google.com/sdk/gcloud)
- [gcloud Reference](https://cloud.google.com/sdk/gcloud/reference)
- [GCP Quickstarts](https://cloud.google.com/docs/quickstarts)