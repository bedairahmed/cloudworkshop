# ☁️ Cloud Application Architecture Workshop

![Azure](https://img.shields.io/badge/Azure-0078D4?style=for-the-badge&logo=microsoftazure&logoColor=white)
![GCP](https://img.shields.io/badge/GCP-4285F4?style=for-the-badge&logo=googlecloud&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)

> **Foundations Workshop** — Understanding how cloud systems are designed before tools and vendors

Welcome to the **Madina Lab Cloud Application Architecture Workshop**! This hands-on workshop provides a solid foundation in cloud concepts, application architecture, and modern deployment workflows.

---

## 📋 Workshop Overview

### What You'll Learn

- ☁️ **Cloud Fundamentals** — Service models (IaaS, PaaS, SaaS) and core concepts
- 🧱 **Building Blocks** — Compute, Storage, Networking, and Security
- 🏗️ **Application Architecture** — How modern applications are designed
- 🚀 **Deployment Concepts** — CI/CD, containers, and infrastructure as code
- 🔧 **Hands-On Labs** — Practical exercises to reinforce concepts

### Two-Day Journey

| Day | Focus | Topics |
|-----|-------|--------|
| **Day 1** | Foundations | Cloud Fundamentals, Building Blocks, Architecture Principles |
| **Day 2** | Delivery | Development Workflow, Tools, Deployment Pipelines |

---

## 🎯 Prerequisites

Before starting the workshop, ensure you have:

- [ ] **Azure Account** — Student credentials will be provided
- [ ] **Git** installed — [Download Git](https://git-scm.com/downloads)
- [ ] **VS Code** installed — [Download VS Code](https://code.visualstudio.com/)
- [ ] Basic understanding of command line

### Recommended VS Code Extensions

- Azure Account
- Azure App Service
- Azure Resources
- Docker
- GitLens
- HashiCorp Terraform
- YAML

---

## 📁 Repository Structure

```
cloudworkshop/
│
├── 📄 README.md                    # This file
│
├── 📂 labs/                        # Hands-on lab exercises
│   ├── 00-clone-repo.md            # Setup: Clone repository
│   ├── 01-azure-login.md           # Lab 1: Azure Portal login
│   ├── 02-create-vm.md             # Lab 2: Create Virtual Machine
│   └── 03-create-app-service.md    # Lab 3: Create App Service
│
├── 📂 resources/                   # Learning resources
│   ├── 📂 cheatsheets/             # Quick reference guides
│   │   ├── ansible.md
│   │   ├── azure-cli.md
│   │   ├── docker.md
│   │   ├── gcp-cli.md
│   │   ├── git.md
│   │   ├── github.md
│   │   ├── helm.md
│   │   ├── kubernetes.md
│   │   ├── linux.md
│   │   ├── pipelines.md
│   │   ├── powershell.md
│   │   ├── python.md
│   │   ├── readme-guide.md
│   │   ├── terraform.md
│   │   ├── vscode.md
│   │   └── yaml.md
│   │
│   ├── 📂 images/                  # Workshop images
│   │
│   └── 📂 samples/                 # Sample code
│       ├── 📂 docker/              # Docker examples
│       │   ├── Dockerfile
│       │   ├── docker-compose.yml
│       │   └── ...
│       └── 📂 terraform/           # Terraform examples
│           ├── main.tf
│           ├── variables.tf
│           └── ...
│
└── 📄 azure-pipeline.yml           # CI/CD pipeline example
```

---

## 🚀 Getting Started

### Step 1: Clone the Repository

```bash
git clone https://github.com/bedairahmed/cloudworkshop.git
cd cloudworkshop
```

Or open in VS Code:
1. Press `Ctrl+Shift+P` (or `Cmd+Shift+P` on Mac)
2. Type "Git: Clone"
3. Paste the repository URL

### Step 2: Complete the Labs

Follow the labs in order:

| Lab | Title | Description |
|-----|-------|-------------|
| 00 | [Clone Repository](labs/00-clone-repo.md) | Setup your environment |
| 01 | [Azure Login](labs/01-azure-login.md) | Access Azure Portal |
| 02 | [Create VM](labs/02-create-vm.md) | Deploy a Virtual Machine |
| 03 | [Create App Service](labs/03-create-app-service.md) | Deploy a Web Application |

---

## 📚 Cheatsheets

Quick reference guides for all the tools covered in this workshop:

### Cloud & Infrastructure
| Cheatsheet | Description |
|------------|-------------|
| [Azure CLI](resources/cheatsheets/azure-cli.md) | Azure command-line interface |
| [GCP CLI](resources/cheatsheets/gcp-cli.md) | Google Cloud CLI (gcloud) |
| [Terraform](resources/cheatsheets/terraform.md) | Infrastructure as Code |

### Containers & Orchestration
| Cheatsheet | Description |
|------------|-------------|
| [Docker](resources/cheatsheets/docker.md) | Container platform |
| [Kubernetes](resources/cheatsheets/kubernetes.md) | Container orchestration |
| [Helm](resources/cheatsheets/helm.md) | Kubernetes package manager |

### Development & DevOps
| Cheatsheet | Description |
|------------|-------------|
| [Git](resources/cheatsheets/git.md) | Version control |
| [GitHub](resources/cheatsheets/github.md) | GitHub platform & Actions |
| [Pipelines](resources/cheatsheets/pipelines.md) | CI/CD (GitHub Actions, Azure DevOps) |
| [VS Code](resources/cheatsheets/vscode.md) | Code editor & shortcuts |

### Scripting & Automation
| Cheatsheet | Description |
|------------|-------------|
| [Linux](resources/cheatsheets/linux.md) | Linux commands |
| [PowerShell](resources/cheatsheets/powershell.md) | PowerShell scripting |
| [Python](resources/cheatsheets/python.md) | Python programming |
| [YAML](resources/cheatsheets/yaml.md) | YAML syntax |
| [Ansible](resources/cheatsheets/ansible.md) | Configuration management |

---

## 🔐 Student Access

### Azure Portal

- **URL:** https://portal.azure.com
- **Username:** `studentXX@ml.cloud-people.net` (provided by instructor)
- **Password:** Provided during workshop

### Important Guidelines

- ✅ Use the **workshop-students-rg** resource group
- ✅ Deploy resources in **East US** region
- ✅ Use **B-series VMs** only (B1s, B1ms, B2s)
- ✅ Use **Free tier** App Service (F1)
- ⚠️ Delete resources after labs to avoid charges
- ❌ Do not create resources outside the assigned resource group

---

## 🏗️ Core Cloud Concepts

### Cloud Service Models

```
┌─────────────────────────────────────────────────────────────────┐
│                        YOU MANAGE                                │
├─────────────────┬─────────────────┬─────────────────┬───────────┤
│   On-Premises   │      IaaS       │      PaaS       │   SaaS    │
├─────────────────┼─────────────────┼─────────────────┼───────────┤
│  Applications   │  Applications   │  Applications   │           │
│  Data           │  Data           │  Data           │           │
│  Runtime        │  Runtime        │                 │           │
│  Middleware     │  Middleware     │                 │           │
│  OS             │  OS             │                 │           │
├─────────────────┼─────────────────┼─────────────────┤  PROVIDER │
│  Virtualization │                 │                 │  MANAGES  │
│  Servers        │    PROVIDER     │    PROVIDER     │           │
│  Storage        │    MANAGES      │    MANAGES      │           │
│  Networking     │                 │                 │           │
└─────────────────┴─────────────────┴─────────────────┴───────────┘
```

### The Four Building Blocks

| Block | Description | Examples |
|-------|-------------|----------|
| **Compute** | Run applications | VMs, Containers, Serverless |
| **Storage** | Store data | Blob, Databases, File shares |
| **Networking** | Connect resources | VNets, Load Balancers, DNS |
| **Security** | Protect resources | IAM, Firewalls, Encryption |

---

## 🛠️ Sample Code

### Terraform (Azure)

```bash
cd resources/samples/terraform

# Initialize Terraform
terraform init

# Preview changes
terraform plan

# Apply changes
terraform apply

# Clean up
terraform destroy
```

### Docker

```bash
cd resources/samples/docker

# Build image
docker build -t myapp .

# Run container
docker run -p 3000:3000 myapp

# Docker Compose
docker compose up -d
```

---

## 📞 Contact & Support

### Workshop Instructor

**Ahmed Bedair**  
Senior Cloud Architect

- 📧 Email: abedair@gmail.com
- 💼 LinkedIn: [linkedin.com/in/ahmedbedair](https://linkedin.com/in/ahmedbedair)
- 🐙 GitHub: [github.com/bedairahmed](https://github.com/bedairahmed)

### Workshop Location

**Madina Lab**  
Cloud Application Architecture Workshop

### Need Help?

- 🙋 Raise your hand during the workshop
- 💬 Post questions in the workshop chat
- 📧 Email the instructor for follow-up questions

---

## 📝 Feedback

Your feedback helps improve future workshops! Please complete the survey at the end of the session.

---

## 📜 License

This workshop material is provided for educational purposes as part of the Madina Lab training program.

---

<div align="center">

**Made with ❤️ for Madina Lab**

*Cloud Application Architecture Foundations Workshop*

</div>