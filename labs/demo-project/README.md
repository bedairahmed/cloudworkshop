# 🚀 Cloud Workshop — Azure DevOps Demo

![Azure DevOps](https://img.shields.io/badge/Azure_DevOps-0078D7?style=for-the-badge&logo=azuredevops&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)

> **Day 2 Demo** — A complete DevOps workflow: Code → Container → Infrastructure → Pipeline → Deploy

---

## 📋 What This Demonstrates

| Topic | Component | What Students See |
|-------|-----------|-------------------|
| **Application** | `app/` | A Python Flask web app with UI |
| **Containerization** | `app/Dockerfile` | How apps get packaged into Docker images |
| **Infrastructure as Code** | `terraform/` | Cloud resources defined as code |
| **Environment Management** | `terraform/envs/` | Same code, different configs for dev/staging/prod |
| **CI/CD Pipeline** | `azure-pipelines.yml` | Automated build → test → deploy workflow |

---

## 📁 Project Structure

```
demo-project-1/
├── app/                            # Web Application
│   ├── app.py                      # Flask backend & API routes
│   ├── requirements.txt            # Python dependencies
│   ├── Dockerfile                  # Container definition
│   ├── docker-compose.yml          # Local development
│   ├── .dockerignore               # Docker build exclusions
│   ├── templates/                  # HTML templates
│   │   ├── index.html              # Main page
│   │   └── 404.html                # Error page
│   ├── static/                     # Frontend assets
│   │   ├── css/style.css           # Styles
│   │   └── js/main.js              # JavaScript
│   └── tests/                      # Unit tests
│       └── test_app.py             # Pytest tests
├── terraform/                      # Infrastructure as Code
│   ├── providers.tf                # Azure provider config
│   ├── main.tf                     # Resource definitions
│   ├── variables.tf                # Input variables
│   ├── outputs.tf                  # Output values
│   └── envs/                       # Per-environment configs
│       ├── dev.tfvars              # Development
│       ├── staging.tfvars          # Staging
│       └── prod.tfvars             # Production
├── azure-pipelines.yml             # Azure DevOps CI/CD pipeline
├── .gitignore                      # Git exclusions
└── README.md                       # This file
```

---

## 🚀 Quick Start

### Run Locally

```bash
cd app
pip install -r requirements.txt
python app.py
# → http://localhost:8080
```

### Run with Docker

```bash
cd app
docker build -t workshop-app .
docker run -p 8080:8080 -e APP_ENV=dev workshop-app
# → http://localhost:8080
```

### Run with Docker Compose

```bash
cd app
docker compose up
# → http://localhost:8080
```

### Run Tests

```bash
cd app
pip install pytest
python -m pytest tests/ -v
```

---

## 🔧 Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `APP_VERSION` | `1.0.0` | Shown in UI |
| `APP_ENV` | `local` | `dev`, `staging`, `prod` |
| `APP_PORT` | `8080` | Listening port |
| `APP_NAME` | `Cloud Workshop` | App title |

---

## 🔄 Pipeline Stages

```
┌──────────┐    ┌──────────┐    ┌────────────┐    ┌─────────────┐    ┌─────────────┐
│  BUILD   │───▶│  TEST    │───▶│ DEPLOY DEV │───▶│DEPLOY STAGE │───▶│ DEPLOY PROD │
│          │    │          │    │            │    │             │    │             │
│ Docker   │    │ Pytest   │    │ Automatic  │    │ Automatic   │    │ Manual Gate │
│ Push ACR │    │ TF Valid │    │            │    │             │    │ ⚠️ Approval  │
└──────────┘    └──────────┘    └────────────┘    └─────────────┘    └─────────────┘
```

---

## 📞 Instructor

**Ahmed Bedair** — Senior Cloud Architect

---

<div align="center">

**Madina Lab — Cloud Application Architecture Workshop**

</div>
