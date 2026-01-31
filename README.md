# ☁️ Cloud Application Architecture Workshop

![Azure](https://img.shields.io/badge/Azure-0078D4?style=for-the-badge&logo=microsoftazure&logoColor=white)
![GCP](https://img.shields.io/badge/GCP-4285F4?style=for-the-badge&logo=googlecloud&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)

> **Foundations Workshop** — Understanding how cloud systems are designed before tools and vendors

Welcome to the **Madina Lab Cloud Application Architecture Workshop**! This hands-on workshop provides a solid foundation in cloud concepts, application architecture, and modern deployment workflows.

---

## 📋 Workshop Overview

This workshop focuses on **how the pieces connect** — not tool mastery. By the end, you'll have a solid foundation to continue your cloud learning journey with confidence.

### What You'll Learn

- ☁️ Understand **cloud concepts** and core building blocks
- 🏗️ Learn how **applications are architected** for the cloud
- 🔧 Explore modern **deployment concepts** and workflows
- 🧪 Complete **hands-on labs** to reinforce concepts
- 🚀 Build a **foundation** for Azure & GCP workshops

---

## 📅 Your Two-Day Journey

### Day 1: Foundations
*Cloud & Application Basics*

| Section | Topics |
|---------|--------|
| **Cloud Fundamentals** | Why cloud? Scalability, cost efficiency, speed & agility, reliability |
| **Service Models** | IaaS, PaaS, SaaS — Understanding the shared responsibility model |
| **Core Building Blocks** | Compute, Storage & Data, Networking, Security |
| **Application Architecture** | How modern applications are designed and structured |
| **Architecture Principles** | Stateless vs stateful, three-tier architecture, environments |

### Day 2: Delivery
*Tools & Deployment Concepts*

| Section | Topics |
|---------|--------|
| **Development Workflow** | Git, version control, branching strategies |
| **Containerization** | Docker, images, containers, registries |
| **Infrastructure as Code** | Terraform, declarative infrastructure |
| **CI/CD Pipelines** | Automated build, test, and deploy workflows |
| **Hands-On Labs** | Practical exercises with Azure |

---

## 🧱 Core Cloud Building Blocks

| Block | Description | What It Does |
|-------|-------------|--------------|
| **Compute** | Run applications and workloads | VMs, containers, serverless |
| **Storage & Data** | Store and manage data | Databases, object storage, file systems |
| **Networking** | Connect users, apps, and services | Virtual networks, load balancing, routing |
| **Security** | Control access and protect resources | Identity management, authentication, authorization |

---

## 🎯 Prerequisites

Before starting the workshop, ensure you have:

- [ ] **Smartphone** — For Microsoft Authenticator setup
- [ ] **Git** installed — [Download Git](https://git-scm.com/downloads)
- [ ] **VS Code** installed — [Download VS Code](https://code.visualstudio.com/)
- [ ] Basic understanding of command line

> 💡 Azure student credentials will be provided during the workshop

---

## 🔐 Student Access

### Azure Portal

| | |
|---|---|
| **URL** | https://portal.azure.com |
| **Username** | `studentXX@ml.cloud-people.net` (provided by instructor) |
| **Password** | Provided during workshop |
| **Resource Group** | `workshop-students-rg` |
| **Region** | East US |

### Important Guidelines

- ✅ Always create resources in `workshop-students-rg`
- ✅ Deploy resources in **East US** region only
- ✅ Use **B-series VMs** (B1s, B1ms, B2s)
- ✅ Use **Free tier** App Service (F1)
- ⚠️ Delete resources after labs
- ❌ Do not create resources outside your assigned resource group

---

## 🧪 Hands-On Labs

| Lab | Title | Description |
|-----|-------|-------------|
| 00 | [Clone Repository](labs/00-clone-repo.md) | Setup your environment |
| 01 | [Azure Login](labs/01-azure-login.md) | Access Azure Portal & setup MFA |
| 02 | [Create VM](labs/02-create-vm.md) | Deploy a Virtual Machine |
| 03 | [Create App Service](labs/03-create-app-service.md) | Deploy a Web Application |

---

## 📚 Quick Reference Cheatsheets

### Cloud & Infrastructure
- [Azure CLI](resources/cheatsheets/azure-cli.md) — Azure command-line interface
- [GCP CLI](resources/cheatsheets/gcp-cli.md) — Google Cloud CLI (gcloud)
- [Terraform](resources/cheatsheets/terraform.md) — Infrastructure as Code

### Containers & Orchestration
- [Docker](resources/cheatsheets/docker.md) — Container platform
- [Kubernetes](resources/cheatsheets/kubernetes.md) — Container orchestration
- [Helm](resources/cheatsheets/helm.md) — Kubernetes package manager

### Development & DevOps
- [Git](resources/cheatsheets/git.md) — Version control
- [GitHub](resources/cheatsheets/github.md) — GitHub platform & Actions
- [Pipelines](resources/cheatsheets/pipelines.md) — CI/CD pipelines
- [VS Code](resources/cheatsheets/vscode.md) — Code editor & shortcuts

### Scripting & Automation
- [Linux](resources/cheatsheets/linux.md) — Linux commands
- [PowerShell](resources/cheatsheets/powershell.md) — PowerShell scripting
- [Python](resources/cheatsheets/python.md) — Python programming
- [YAML](resources/cheatsheets/yaml.md) — YAML syntax
- [Ansible](resources/cheatsheets/ansible.md) — Configuration management

### Guides
- [README Guide](resources/cheatsheets/readme-guide.md) — How to write good README files

---

## 📂 Sample Code

Ready-to-use examples for reference and practice:

- [Docker Samples](resources/samples/docker/) — Dockerfiles & Compose examples
- [Terraform Samples](resources/samples/terraform/) — Azure infrastructure examples
- [Pipeline Samples](resources/samples/pipelines/) — CI/CD workflow examples

---

## 📁 Repository Structure

```
cloudworkshop/
├── README.md                       # This file
├── labs/                           # Hands-on lab exercises
│   ├── 00-clone-repo.md
│   ├── 01-azure-login.md
│   ├── 02-create-vm.md
│   
└── resources/
    ├── cheatsheets/                # Quick reference guides
    ├── images/                     # Workshop images
    └── samples/                    # Sample code
        ├── docker/
        ├── terraform/
        └── pipelines/
```

---

## 📞 Contact & Support

### Workshop Instructor

**Ahmed Bedair**  
Senior Cloud Architect

| | |
|---|---|
| 📧 Email | abedair@gmail.com |
| 💼 LinkedIn | [linkedin.com/in/ahmedbedair](https://linkedin.com/in/ahmedbedair) |
| 🐙 GitHub | [github.com/bedairahmed](https://github.com/bedairahmed) |

### Need Help During the Workshop?

- 🙋 Raise your hand
- 💬 Post in the workshop chat
- 📧 Email for follow-up questions

---

## 💡 Remember

> *This workshop is a starting point — not the finish line.*

By the end, you'll have a solid foundation to **continue your cloud learning journey with confidence.**

---

<div align="center">

**Made with ❤️ for Madina Lab**

*Cloud Application Architecture Foundations Workshop*

</div>