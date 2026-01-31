# GitHub Cheatsheet

## What is GitHub?

GitHub is a cloud-based platform for version control and collaboration using Git. It hosts repositories, enables code reviews through pull requests, provides issue tracking, and offers CI/CD with GitHub Actions. It's the world's largest developer platform with over 100 million developers.

---

## Why Use GitHub?

- **Collaboration** - Work with teams worldwide
- **Version Control** - Track all code changes
- **Pull Requests** - Code review workflow
- **Issues** - Bug tracking and project management
- **Actions** - Built-in CI/CD automation
- **Security** - Vulnerability scanning, secret detection
- **Open Source** - Discover and contribute to projects
- **Portfolio** - Showcase your work

---

## Key Concepts

| Concept | Description |
|---------|-------------|
| **Repository** | Project containing code and history |
| **Branch** | Independent line of development |
| **Commit** | Snapshot of changes |
| **Pull Request (PR)** | Propose and review changes |
| **Fork** | Personal copy of another's repository |
| **Clone** | Local copy of a repository |
| **Issue** | Bug report or feature request |
| **Actions** | Automated workflows (CI/CD) |

---

## Getting Started

### Create Account

1. Go to https://github.com
2. Sign up with email
3. Verify email address
4. Set up profile

### Configure Git

```bash
# Set identity
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Verify
git config --list
```

### Authentication

```bash
# HTTPS with Personal Access Token (PAT)
# 1. Go to Settings > Developer settings > Personal access tokens
# 2. Generate new token with repo permissions
# 3. Use token as password when pushing

# SSH (Recommended)
# 1. Generate SSH key
ssh-keygen -t ed25519 -C "your.email@example.com"

# 2. Add to ssh-agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# 3. Copy public key
cat ~/.ssh/id_ed25519.pub

# 4. Add to GitHub: Settings > SSH and GPG keys > New SSH key

# 5. Test connection
ssh -T git@github.com
```

---

## Repository Operations

### Create Repository

```bash
# On GitHub.com
# 1. Click "+" > New repository
# 2. Enter name, description
# 3. Choose public/private
# 4. Initialize with README (optional)

# From command line
gh repo create my-repo --public --source=. --remote=origin
```

### Clone Repository

```bash
# HTTPS
git clone https://github.com/username/repo.git

# SSH
git clone git@github.com:username/repo.git

# Clone to specific folder
git clone https://github.com/username/repo.git my-folder
```

### Fork Repository

```bash
# On GitHub.com
# 1. Go to repository
# 2. Click "Fork" button
# 3. Select your account

# Using GitHub CLI
gh repo fork username/repo

# Clone your fork
git clone https://github.com/YOUR-USERNAME/repo.git

# Add upstream remote
cd repo
git remote add upstream https://github.com/ORIGINAL-OWNER/repo.git
```

---

## Pull Requests

### Create Pull Request

```bash
# 1. Create feature branch
git checkout -b feature/my-feature

# 2. Make changes and commit
git add .
git commit -m "Add new feature"

# 3. Push branch
git push -u origin feature/my-feature

# 4. On GitHub: Click "Compare & pull request"
# 5. Fill in title and description
# 6. Select reviewers
# 7. Click "Create pull request"

# Using GitHub CLI
gh pr create --title "Add feature" --body "Description"
```

### Review Pull Request

```bash
# List PRs
gh pr list

# View PR
gh pr view 123

# Checkout PR locally
gh pr checkout 123

# Approve PR
gh pr review 123 --approve

# Request changes
gh pr review 123 --request-changes --body "Please fix..."

# Merge PR
gh pr merge 123 --squash
```

### PR Best Practices

- Write clear title and description
- Keep PRs small and focused
- Link related issues
- Add screenshots for UI changes
- Request appropriate reviewers
- Respond to feedback promptly

---

## Issues

### Create Issue

```bash
# On GitHub.com
# 1. Go to Issues tab
# 2. Click "New issue"
# 3. Fill title and description
# 4. Add labels, assignees, project

# Using GitHub CLI
gh issue create --title "Bug: Something broken" --body "Description"
```

### Issue Templates

Create `.github/ISSUE_TEMPLATE/bug_report.md`:

```markdown
---
name: Bug Report
about: Report a bug
title: '[BUG] '
labels: bug
assignees: ''
---

## Description
A clear description of the bug.

## Steps to Reproduce
1. Go to '...'
2. Click on '...'
3. See error

## Expected Behavior
What you expected to happen.

## Screenshots
If applicable, add screenshots.

## Environment
- OS: [e.g., Windows 11]
- Browser: [e.g., Chrome 120]
- Version: [e.g., 1.0.0]
```

### Manage Issues

```bash
# List issues
gh issue list

# View issue
gh issue view 123

# Close issue
gh issue close 123

# Reopen issue
gh issue reopen 123

# Add comment
gh issue comment 123 --body "Working on this"
```

---

## GitHub Actions

### Basic Workflow

Create `.github/workflows/ci.yml`:

```yaml
name: CI

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Run tests
        run: npm test
      
      - name: Build
        run: npm run build
```

### Common Triggers

```yaml
on:
  # Push to branches
  push:
    branches: [main, develop]
    paths:
      - 'src/**'
      - '!**.md'
  
  # Pull requests
  pull_request:
    branches: [main]
  
  # Scheduled
  schedule:
    - cron: '0 0 * * *'  # Daily at midnight
  
  # Manual trigger
  workflow_dispatch:
    inputs:
      environment:
        description: 'Environment'
        required: true
        default: 'staging'
  
  # On release
  release:
    types: [published]
```

### Secrets

```yaml
# Use secrets in workflow
steps:
  - name: Deploy
    env:
      API_KEY: ${{ secrets.API_KEY }}
    run: ./deploy.sh

# Add secrets:
# Settings > Secrets and variables > Actions > New repository secret
```

---

## GitHub CLI (gh)

### Installation

```bash
# Windows
winget install GitHub.cli

# Mac
brew install gh

# Linux
sudo apt install gh
```

### Authentication

```bash
# Login
gh auth login

# Check status
gh auth status

# Logout
gh auth logout
```

### Common Commands

```bash
# Repository
gh repo create
gh repo clone username/repo
gh repo view
gh repo fork

# Pull Requests
gh pr create
gh pr list
gh pr view 123
gh pr checkout 123
gh pr merge 123

# Issues
gh issue create
gh issue list
gh issue view 123
gh issue close 123

# Actions
gh run list
gh run view 123
gh run watch

# Gists
gh gist create file.txt
gh gist list
```

---

## Branch Protection

### Settings (Settings > Branches > Add rule)

- **Require pull request reviews** - Must have approval
- **Require status checks** - CI must pass
- **Require signed commits** - GPG verification
- **Include administrators** - Rules apply to admins too
- **Restrict pushes** - Only certain users can push

---

## GitHub Pages

### Enable Pages

1. Go to Settings > Pages
2. Select source branch (e.g., `main`)
3. Select folder (`/root` or `/docs`)
4. Save

### Deploy Static Site

```yaml
# .github/workflows/pages.yml
name: Deploy to Pages

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    permissions:
      pages: write
      id-token: write
    
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Pages
        uses: actions/configure-pages@v4
      
      - name: Build
        run: npm run build
      
      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: './dist'
      
      - name: Deploy to Pages
        uses: actions/deploy-pages@v4
```

---

## Special Files

| File | Purpose |
|------|---------|
| `README.md` | Project documentation |
| `LICENSE` | License information |
| `.gitignore` | Files to ignore |
| `CONTRIBUTING.md` | Contribution guidelines |
| `CODE_OF_CONDUCT.md` | Community guidelines |
| `SECURITY.md` | Security policy |
| `CODEOWNERS` | Auto-assign reviewers |
| `.github/FUNDING.yml` | Sponsorship links |

### CODEOWNERS

```
# .github/CODEOWNERS

# Default owners
* @default-owner

# Frontend team owns these
/src/frontend/ @frontend-team

# DevOps owns CI/CD
/.github/ @devops-team
/terraform/ @devops-team
```

---

## Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| `t` | File finder |
| `w` | Switch branch |
| `s` | Focus search |
| `g` + `n` | Go to notifications |
| `g` + `c` | Go to code |
| `g` + `i` | Go to issues |
| `g` + `p` | Go to pull requests |
| `.` | Open in github.dev (VS Code) |
| `?` | Show all shortcuts |

---

## Quick Reference

| Action | Command/URL |
|--------|-------------|
| Create repo | `gh repo create` |
| Clone repo | `git clone <url>` |
| Create PR | `gh pr create` |
| List PRs | `gh pr list` |
| Create issue | `gh issue create` |
| View Actions | `gh run list` |
| Open in VS Code | Press `.` on any repo |

---

## Resources

- [GitHub Documentation](https://docs.github.com)
- [GitHub Skills](https://skills.github.com/)
- [GitHub CLI Manual](https://cli.github.com/manual/)
- [GitHub Actions Marketplace](https://github.com/marketplace?type=actions)