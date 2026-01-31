# CI/CD Pipelines Cheatsheet

## What are CI/CD Pipelines?

CI/CD (Continuous Integration/Continuous Delivery) pipelines automate the process of building, testing, and deploying software. They enable teams to deliver code changes frequently and reliably, catching bugs early and reducing manual deployment errors.

---

## Why Use CI/CD?

- **Automation** - Automate build, test, and deploy processes
- **Faster Delivery** - Ship features and fixes quickly
- **Quality** - Catch bugs early with automated testing
- **Consistency** - Same process every time
- **Reliability** - Reduce human error in deployments
- **Collaboration** - Teams can integrate code frequently

---

## Key Concepts

| Concept | Description |
|---------|-------------|
| **CI (Continuous Integration)** | Automatically build and test code on every commit |
| **CD (Continuous Delivery)** | Automatically prepare code for release |
| **CD (Continuous Deployment)** | Automatically deploy to production |
| **Pipeline** | Series of automated steps |
| **Stage** | Group of related jobs |
| **Job** | Individual task in a pipeline |
| **Artifact** | Files produced by a pipeline |
| **Runner/Agent** | Machine that executes jobs |

---

## GitHub Actions

### Basic Workflow (.github/workflows/ci.yml)

```yaml
name: CI Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Run tests
        run: npm test
      
      - name: Build
        run: npm run build
```

### Multi-Job Pipeline

```yaml
name: CI/CD Pipeline

on:
  push:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run tests
        run: npm test

  build:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Build application
        run: npm run build
      - name: Upload artifact
        uses: actions/upload-artifact@v4
        with:
          name: build
          path: dist/

  deploy:
    needs: build
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    steps:
      - name: Download artifact
        uses: actions/download-artifact@v4
        with:
          name: build
      - name: Deploy to production
        run: echo "Deploying..."
```

### Deploy to Azure

```yaml
name: Deploy to Azure

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v4
      
      - name: Login to Azure
        uses: azure/login@v1
        with:
          creds: ${{ secrets.AZURE_CREDENTIALS }}
      
      - name: Deploy to Azure Web App
        uses: azure/webapps-deploy@v2
        with:
          app-name: 'my-webapp'
          package: '.'
```

### Docker Build and Push

```yaml
name: Docker Build

on:
  push:
    branches: [main]

jobs:
  docker:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v4
      
      - name: Login to Docker Hub
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}
      
      - name: Build and push
        uses: docker/build-push-action@v5
        with:
          context: .
          push: true
          tags: user/app:latest
```

---

## Azure DevOps Pipelines

### Basic Pipeline (azure-pipelines.yml)

```yaml
trigger:
  - main
  - develop

pool:
  vmImage: 'ubuntu-latest'

stages:
  - stage: Build
    jobs:
      - job: BuildJob
        steps:
          - task: NodeTool@0
            inputs:
              versionSpec: '20.x'
            displayName: 'Install Node.js'
          
          - script: |
              npm ci
              npm run build
            displayName: 'Build application'
          
          - task: PublishBuildArtifacts@1
            inputs:
              pathToPublish: 'dist'
              artifactName: 'drop'

  - stage: Deploy
    dependsOn: Build
    condition: succeeded()
    jobs:
      - deployment: DeployJob
        environment: 'production'
        strategy:
          runOnce:
            deploy:
              steps:
                - script: echo "Deploying..."
```

### Multi-Stage with Approval

```yaml
trigger:
  - main

stages:
  - stage: Build
    jobs:
      - job: Build
        pool:
          vmImage: 'ubuntu-latest'
        steps:
          - script: echo "Building..."

  - stage: DeployDev
    dependsOn: Build
    jobs:
      - deployment: Deploy
        environment: 'development'
        strategy:
          runOnce:
            deploy:
              steps:
                - script: echo "Deploying to Dev"

  - stage: DeployProd
    dependsOn: DeployDev
    jobs:
      - deployment: Deploy
        environment: 'production'  # Requires approval
        strategy:
          runOnce:
            deploy:
              steps:
                - script: echo "Deploying to Prod"
```

---

## GitLab CI/CD

### Basic Pipeline (.gitlab-ci.yml)

```yaml
stages:
  - build
  - test
  - deploy

variables:
  NODE_VERSION: "20"

build:
  stage: build
  image: node:${NODE_VERSION}
  script:
    - npm ci
    - npm run build
  artifacts:
    paths:
      - dist/
    expire_in: 1 hour

test:
  stage: test
  image: node:${NODE_VERSION}
  script:
    - npm ci
    - npm test
  coverage: '/Coverage: \d+\.\d+%/'

deploy_staging:
  stage: deploy
  script:
    - echo "Deploying to staging"
  environment:
    name: staging
    url: https://staging.example.com
  only:
    - develop

deploy_production:
  stage: deploy
  script:
    - echo "Deploying to production"
  environment:
    name: production
    url: https://example.com
  only:
    - main
  when: manual
```

### Docker Build in GitLab

```yaml
stages:
  - build
  - deploy

build_image:
  stage: build
  image: docker:24
  services:
    - docker:24-dind
  variables:
    DOCKER_TLS_CERTDIR: "/certs"
  script:
    - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
    - docker build -t $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA .
    - docker push $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA
```

---

## Jenkins Pipeline

### Declarative Pipeline (Jenkinsfile)

```groovy
pipeline {
    agent any
    
    environment {
        NODE_VERSION = '20'
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Install') {
            steps {
                sh 'npm ci'
            }
        }
        
        stage('Test') {
            steps {
                sh 'npm test'
            }
            post {
                always {
                    junit 'test-results/*.xml'
                }
            }
        }
        
        stage('Build') {
            steps {
                sh 'npm run build'
            }
        }
        
        stage('Deploy') {
            when {
                branch 'main'
            }
            steps {
                sh 'echo "Deploying..."'
            }
        }
    }
    
    post {
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
```

---

## Google Cloud Build

### cloudbuild.yaml

```yaml
steps:
  # Install dependencies
  - name: 'node:20'
    entrypoint: npm
    args: ['ci']

  # Run tests
  - name: 'node:20'
    entrypoint: npm
    args: ['test']

  # Build Docker image
  - name: 'gcr.io/cloud-builders/docker'
    args: ['build', '-t', 'gcr.io/$PROJECT_ID/my-app:$COMMIT_SHA', '.']

  # Push to Container Registry
  - name: 'gcr.io/cloud-builders/docker'
    args: ['push', 'gcr.io/$PROJECT_ID/my-app:$COMMIT_SHA']

  # Deploy to Cloud Run
  - name: 'gcr.io/cloud-builders/gcloud'
    args:
      - 'run'
      - 'deploy'
      - 'my-service'
      - '--image=gcr.io/$PROJECT_ID/my-app:$COMMIT_SHA'
      - '--region=us-central1'
      - '--platform=managed'

images:
  - 'gcr.io/$PROJECT_ID/my-app:$COMMIT_SHA'
```

---

## Common Pipeline Patterns

### Environment Variables & Secrets

```yaml
# GitHub Actions
env:
  NODE_ENV: production
  API_URL: ${{ secrets.API_URL }}

# Azure DevOps
variables:
  - name: NODE_ENV
    value: production
  - group: my-variable-group  # From Library

# GitLab CI
variables:
  NODE_ENV: production
  API_URL: $API_URL  # From CI/CD Settings
```

### Matrix Builds (Multiple Versions)

```yaml
# GitHub Actions
jobs:
  test:
    strategy:
      matrix:
        node-version: [18, 20, 22]
        os: [ubuntu-latest, windows-latest]
    runs-on: ${{ matrix.os }}
    steps:
      - uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node-version }}
```

### Caching Dependencies

```yaml
# GitHub Actions
- uses: actions/cache@v4
  with:
    path: ~/.npm
    key: ${{ runner.os }}-npm-${{ hashFiles('**/package-lock.json') }}
    restore-keys: |
      ${{ runner.os }}-npm-

# GitLab CI
cache:
  key: ${CI_COMMIT_REF_SLUG}
  paths:
    - node_modules/
```

---

## Quick Reference

| Platform | Config File | Trigger Syntax |
|----------|-------------|----------------|
| GitHub Actions | `.github/workflows/*.yml` | `on: push, pull_request` |
| Azure DevOps | `azure-pipelines.yml` | `trigger: [main]` |
| GitLab CI | `.gitlab-ci.yml` | `only: [main]` |
| Jenkins | `Jenkinsfile` | `when { branch 'main' }` |
| Cloud Build | `cloudbuild.yaml` | Cloud Build Triggers |

---

## Resources

- [GitHub Actions Docs](https://docs.github.com/en/actions)
- [Azure Pipelines Docs](https://docs.microsoft.com/en-us/azure/devops/pipelines/)
- [GitLab CI Docs](https://docs.gitlab.com/ee/ci/)
- [Jenkins Pipeline Docs](https://www.jenkins.io/doc/book/pipeline/)