# Git Cheatsheet

## What is Git?

Git is a distributed version control system that tracks changes in source code during software development. It enables multiple developers to collaborate on projects while maintaining a complete history of all changes. Git is the foundation of modern DevOps and is essential for any cloud or infrastructure work.

---

## Why Use Git?

- **Version Control** - Track every change made to your code
- **Collaboration** - Multiple developers can work on the same project
- **Branching** - Work on features independently without affecting main code
- **Backup** - Your code is stored remotely on platforms like GitHub, GitLab
- **CI/CD Integration** - Automate builds and deployments on code changes

---

## Installation

### Windows

```powershell
# Using winget
winget install Git.Git

# Or download from
# https://git-scm.com/download/win
```

### Mac

```bash
# Using Homebrew
brew install git

# Or download from
# https://git-scm.com/download/mac
```

### Linux (Ubuntu/Debian)

```bash
sudo apt update
sudo apt install git -y
```

### Verify Installation

```bash
git --version
```

---

## Initial Configuration

```bash
# Set your identity (required for commits)
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Set for current repo only (omit --global)
git config user.name "Your Name"
git config user.email "your.email@example.com"

# Set default branch name to 'main'
git config --global init.defaultBranch main

# View all configuration
git config --list

# View specific setting
git config user.name
```

---

## Key Concepts

| Concept | Description |
|---------|-------------|
| **Repository (Repo)** | A folder containing your project and Git history |
| **Commit** | A snapshot of changes at a specific point in time |
| **Branch** | An independent line of development |
| **Remote** | A repository hosted on a server (GitHub, GitLab, etc.) |
| **Clone** | Create a local copy of a remote repository |
| **Push** | Upload local commits to remote repository |
| **Pull** | Download and merge changes from remote |
| **Merge** | Combine changes from different branches |
| **Staging Area** | Where you prepare files before committing |

---

## Essential Commands

### Create & Clone Repositories

```bash
# Initialize a new repository
git init

# Clone an existing repository
git clone https://github.com/username/repo.git

# Clone to a specific folder
git clone https://github.com/username/repo.git my-folder

# Clone a specific branch
git clone -b branch-name https://github.com/username/repo.git
```

### Daily Workflow

```bash
# Check status of files
git status

# Add files to staging area
git add filename.txt          # Add specific file
git add .                     # Add all files
git add *.js                  # Add all .js files
git add folder/               # Add entire folder

# Commit changes
git commit -m "Your commit message"

# Add and commit in one step (tracked files only)
git commit -am "Your commit message"

# View commit history
git log                       # Full details
git log --oneline             # Compact view
git log --oneline --graph     # Visual branch graph
git log -n 5                  # Last 5 commits
```

### Branches

```bash
# List branches
git branch                    # Local branches
git branch -r                 # Remote branches
git branch -a                 # All branches

# Create a new branch
git branch feature-name

# Switch to a branch
git checkout branch-name
git switch branch-name        # Modern alternative

# Create and switch to new branch
git checkout -b feature-name
git switch -c feature-name    # Modern alternative

# Delete a branch
git branch -d branch-name     # Safe delete (must be merged)
git branch -D branch-name     # Force delete

# Rename current branch
git branch -m new-name
```

### Remote Operations

```bash
# View remotes
git remote -v

# Add a remote
git remote add origin https://github.com/username/repo.git

# Change remote URL
git remote set-url origin https://github.com/username/new-repo.git

# Remove a remote
git remote remove origin

# Push to remote
git push origin main          # Push to specific branch
git push -u origin main       # Set upstream (first time)
git push                      # After upstream is set

# Pull from remote (fetch + merge)
git pull origin main
git pull                      # From tracked branch

# Fetch without merging
git fetch origin
git fetch --all               # Fetch all remotes
```

### Merging

```bash
# Merge a branch into current branch
git merge feature-name

# Merge with commit message
git merge feature-name -m "Merge feature into main"

# Abort a merge (if conflicts)
git merge --abort
```

### Undoing Changes

```bash
# Discard changes in working directory
git checkout -- filename.txt
git restore filename.txt      # Modern alternative

# Unstage a file (keep changes)
git reset HEAD filename.txt
git restore --staged filename.txt  # Modern alternative

# Undo last commit (keep changes staged)
git reset --soft HEAD~1

# Undo last commit (keep changes unstaged)
git reset HEAD~1

# Undo last commit (discard changes) ⚠️
git reset --hard HEAD~1

# Revert a commit (creates new commit)
git revert commit-hash
```

### Stashing

```bash
# Save changes temporarily
git stash

# Save with a message
git stash save "work in progress"

# List stashes
git stash list

# Apply most recent stash
git stash pop                 # Apply and remove from stash
git stash apply               # Apply and keep in stash

# Apply specific stash
git stash pop stash@{2}

# Delete a stash
git stash drop stash@{0}

# Clear all stashes
git stash clear
```

### Viewing Differences

```bash
# Show unstaged changes
git diff

# Show staged changes
git diff --staged

# Show changes between branches
git diff main..feature-branch

# Show changes in a commit
git show commit-hash
```

---

## .gitignore

Create a `.gitignore` file to exclude files from tracking:

```bash
# Example .gitignore

# Dependencies
node_modules/
vendor/

# Build outputs
dist/
build/
*.exe

# Environment files
.env
.env.local

# IDE files
.vscode/
.idea/

# OS files
.DS_Store
Thumbs.db

# Logs
*.log

# Terraform
.terraform/
*.tfstate
*.tfstate.backup
```

---

## Common Workflows

### Feature Branch Workflow

```bash
# 1. Create feature branch
git checkout -b feature/new-feature

# 2. Make changes and commit
git add .
git commit -m "Add new feature"

# 3. Push feature branch
git push -u origin feature/new-feature

# 4. Create Pull Request on GitHub/GitLab

# 5. After merge, clean up
git checkout main
git pull
git branch -d feature/new-feature
```

### Sync Fork with Upstream

```bash
# Add upstream remote
git remote add upstream https://github.com/original/repo.git

# Fetch upstream changes
git fetch upstream

# Merge upstream into local main
git checkout main
git merge upstream/main

# Push to your fork
git push origin main
```

---

## Quick Reference

| Command | Description |
|---------|-------------|
| `git init` | Initialize new repository |
| `git clone <url>` | Clone a repository |
| `git status` | Check file status |
| `git add .` | Stage all changes |
| `git commit -m "msg"` | Commit with message |
| `git push` | Push to remote |
| `git pull` | Pull from remote |
| `git branch` | List branches |
| `git checkout -b <name>` | Create & switch branch |
| `git merge <branch>` | Merge branch |
| `git log --oneline` | View commit history |
| `git stash` | Stash changes |
| `git diff` | View changes |

---

## Resources

- [Official Git Documentation](https://git-scm.com/doc)
- [GitHub Docs](https://docs.github.com)
- [Git Cheat Sheet by GitHub](https://education.github.com/git-cheat-sheet-education.pdf)