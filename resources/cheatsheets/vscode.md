# VS Code Cheatsheet

## What is VS Code?

Visual Studio Code (VS Code) is a free, open-source code editor developed by Microsoft. It's lightweight yet powerful, with built-in support for JavaScript, TypeScript, and Node.js, plus a rich ecosystem of extensions for other languages and tools. It's the most popular code editor among developers.

---

## Why Use VS Code?

- **Free & Open Source** - No cost, community-driven
- **Cross-Platform** - Windows, Mac, Linux
- **Lightweight** - Fast startup and performance
- **Extensible** - Thousands of extensions
- **Integrated Terminal** - Run commands without leaving editor
- **Git Integration** - Built-in source control
- **IntelliSense** - Smart code completion
- **Debugging** - Built-in debugger for many languages

---

## Installation

### Desktop (Local)

**Windows:**
```powershell
winget install Microsoft.VisualStudioCode
```

**Mac:**
```bash
brew install --cask visual-studio-code
```

**Linux (Ubuntu/Debian):**
```bash
sudo apt install code
```

Or download from: https://code.visualstudio.com/

### Online VS Code Options

| Service | URL | Description |
|---------|-----|-------------|
| **github.dev** | Press `.` on any GitHub repo | Edit GitHub repos in browser |
| **vscode.dev** | https://vscode.dev | VS Code in browser |
| **GitHub Codespaces** | github.com/codespaces | Full dev environment in cloud |
| **Gitpod** | https://gitpod.io | Cloud development environments |
| **StackBlitz** | https://stackblitz.com | Web-based IDE for web projects |

---

## Online VS Code (github.dev & vscode.dev)

### github.dev

Access VS Code directly in your browser for any GitHub repository:

1. **Quick Access:** Press `.` (period) on any GitHub repository
2. **URL Method:** Change `github.com` to `github.dev` in any repo URL
   - `github.com/user/repo` → `github.dev/user/repo`
3. **Features:**
   - Edit files directly
   - Search across repository
   - Navigate code with Go to Definition
   - Create commits and branches
   - No installation required

### vscode.dev

Open any folder or repository in browser-based VS Code:

1. Go to https://vscode.dev
2. Open local folder or clone repository
3. Edit files with full VS Code experience

**Limitations of browser-based VS Code:**
- No terminal access
- No debugging
- Limited extension support
- No build/run capability
- For full features, use GitHub Codespaces

### GitHub Codespaces

Full cloud development environment:

```bash
# Create codespace from repository
# 1. Go to repository on GitHub
# 2. Click "Code" > "Codespaces" > "Create codespace"

# Or use GitHub CLI
gh codespace create --repo username/repo

# List codespaces
gh codespace list

# Open in browser
gh codespace code --web

# Open in VS Code desktop
gh codespace code

# Stop codespace
gh codespace stop

# Delete codespace
gh codespace delete
```

---

## Keyboard Shortcuts

### Essential Shortcuts

| Action | Windows/Linux | Mac |
|--------|---------------|-----|
| Command Palette | `Ctrl+Shift+P` | `Cmd+Shift+P` |
| Quick Open File | `Ctrl+P` | `Cmd+P` |
| Toggle Terminal | `` Ctrl+` `` | `` Cmd+` `` |
| Toggle Sidebar | `Ctrl+B` | `Cmd+B` |
| Save | `Ctrl+S` | `Cmd+S` |
| Save All | `Ctrl+K S` | `Cmd+Option+S` |
| Close Editor | `Ctrl+W` | `Cmd+W` |
| New File | `Ctrl+N` | `Cmd+N` |

### Navigation

| Action | Windows/Linux | Mac |
|--------|---------------|-----|
| Go to Line | `Ctrl+G` | `Cmd+G` |
| Go to Symbol | `Ctrl+Shift+O` | `Cmd+Shift+O` |
| Go to Definition | `F12` | `F12` |
| Peek Definition | `Alt+F12` | `Option+F12` |
| Go Back | `Alt+←` | `Ctrl+-` |
| Go Forward | `Alt+→` | `Ctrl+Shift+-` |
| Search in Files | `Ctrl+Shift+F` | `Cmd+Shift+F` |
| Replace in Files | `Ctrl+Shift+H` | `Cmd+Shift+H` |

### Editing

| Action | Windows/Linux | Mac |
|--------|---------------|-----|
| Cut Line | `Ctrl+X` | `Cmd+X` |
| Copy Line | `Ctrl+C` | `Cmd+C` |
| Move Line Up/Down | `Alt+↑/↓` | `Option+↑/↓` |
| Copy Line Up/Down | `Shift+Alt+↑/↓` | `Shift+Option+↑/↓` |
| Delete Line | `Ctrl+Shift+K` | `Cmd+Shift+K` |
| Comment Line | `Ctrl+/` | `Cmd+/` |
| Block Comment | `Shift+Alt+A` | `Shift+Option+A` |
| Format Document | `Shift+Alt+F` | `Shift+Option+F` |
| Rename Symbol | `F2` | `F2` |
| Select All Occurrences | `Ctrl+Shift+L` | `Cmd+Shift+L` |

### Multi-Cursor

| Action | Windows/Linux | Mac |
|--------|---------------|-----|
| Add Cursor | `Alt+Click` | `Option+Click` |
| Add Cursor Above | `Ctrl+Alt+↑` | `Cmd+Option+↑` |
| Add Cursor Below | `Ctrl+Alt+↓` | `Cmd+Option+↓` |
| Select Next Occurrence | `Ctrl+D` | `Cmd+D` |
| Select All Occurrences | `Ctrl+Shift+L` | `Cmd+Shift+L` |

### View

| Action | Windows/Linux | Mac |
|--------|---------------|-----|
| Zoom In | `Ctrl+=` | `Cmd+=` |
| Zoom Out | `Ctrl+-` | `Cmd+-` |
| Reset Zoom | `Ctrl+0` | `Cmd+0` |
| Split Editor | `Ctrl+\` | `Cmd+\` |
| Toggle Full Screen | `F11` | `Ctrl+Cmd+F` |
| Toggle Zen Mode | `Ctrl+K Z` | `Cmd+K Z` |

---

## Command Palette Commands

Press `Ctrl+Shift+P` (or `Cmd+Shift+P` on Mac) and type:

```
# Files
> New File
> Save All
> Close All Editors

# Editor
> Format Document
> Change Language Mode
> Toggle Word Wrap
> Transform to Uppercase
> Transform to Lowercase
> Sort Lines Ascending

# View
> Toggle Minimap
> Toggle Breadcrumbs
> Toggle Zen Mode

# Git
> Git: Clone
> Git: Commit
> Git: Push
> Git: Pull
> Git: Checkout to...

# Extensions
> Extensions: Install Extensions
> Extensions: Show Installed Extensions
> Extensions: Disable All Extensions

# Settings
> Preferences: Open Settings
> Preferences: Open Keyboard Shortcuts
> Preferences: Color Theme
> Preferences: File Icon Theme
```

---

## Settings

### User Settings (settings.json)

Press `Ctrl+,` then click the `{}` icon, or use Command Palette > "Preferences: Open Settings (JSON)"

```json
{
  // Editor
  "editor.fontSize": 14,
  "editor.fontFamily": "'Fira Code', Consolas, monospace",
  "editor.fontLigatures": true,
  "editor.tabSize": 2,
  "editor.wordWrap": "on",
  "editor.minimap.enabled": false,
  "editor.formatOnSave": true,
  "editor.formatOnPaste": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.bracketPairColorization.enabled": true,
  "editor.guides.bracketPairs": true,
  "editor.linkedEditing": true,
  "editor.suggestSelection": "first",
  "editor.inlineSuggest.enabled": true,
  
  // Files
  "files.autoSave": "onFocusChange",
  "files.trimTrailingWhitespace": true,
  "files.insertFinalNewline": true,
  "files.exclude": {
    "**/.git": true,
    "**/node_modules": true
  },
  
  // Terminal
  "terminal.integrated.fontSize": 13,
  "terminal.integrated.defaultProfile.windows": "Git Bash",
  
  // Workbench
  "workbench.colorTheme": "One Dark Pro",
  "workbench.iconTheme": "material-icon-theme",
  "workbench.startupEditor": "none",
  
  // Git
  "git.autofetch": true,
  "git.confirmSync": false,
  "git.enableSmartCommit": true,
  
  // Language specific
  "[javascript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[python]": {
    "editor.defaultFormatter": "ms-python.black-formatter"
  },
  "[markdown]": {
    "editor.wordWrap": "on"
  }
}
```

### Workspace Settings

Create `.vscode/settings.json` in your project:

```json
{
  "editor.tabSize": 4,
  "files.exclude": {
    "**/build": true
  },
  "python.defaultInterpreterPath": "./venv/bin/python"
}
```

---

## Essential Extensions

### General Development

| Extension | Description |
|-----------|-------------|
| **Prettier** | Code formatter |
| **ESLint** | JavaScript linter |
| **GitLens** | Enhanced Git |
| **Live Server** | Local development server |
| **Path Intellisense** | Autocomplete filenames |
| **Auto Rename Tag** | Rename HTML/XML tags |
| **Bracket Pair Colorizer** | Color matching brackets |

### Cloud & DevOps

| Extension | Description |
|-----------|-------------|
| **Azure Account** | Azure authentication |
| **Azure App Service** | Deploy to Azure |
| **Azure Functions** | Serverless development |
| **Docker** | Container support |
| **Kubernetes** | K8s cluster management |
| **HashiCorp Terraform** | Terraform support |
| **YAML** | YAML language support |

### Languages

| Extension | Description |
|-----------|-------------|
| **Python** | Python support |
| **Go** | Go support |
| **C/C++** | C/C++ support |
| **Java Extension Pack** | Java support |
| **Rust Analyzer** | Rust support |

### Themes & Icons

| Extension | Description |
|-----------|-------------|
| **One Dark Pro** | Popular dark theme |
| **Dracula** | Dark theme |
| **Material Icon Theme** | File icons |
| **vscode-icons** | File icons |

### Install Extensions via CLI

```bash
# Install extension
code --install-extension ms-python.python
code --install-extension esbenp.prettier-vscode
code --install-extension hashicorp.terraform

# List installed extensions
code --list-extensions

# Uninstall extension
code --uninstall-extension extension-id
```

---

## Integrated Terminal

### Basic Usage

```bash
# Toggle terminal: Ctrl+`
# New terminal: Ctrl+Shift+`
# Split terminal: Ctrl+Shift+5

# Kill terminal: Click trash icon or type 'exit'
```

### Terminal Profiles

Add to settings.json:

```json
{
  "terminal.integrated.profiles.windows": {
    "Git Bash": {
      "path": "C:\\Program Files\\Git\\bin\\bash.exe"
    },
    "PowerShell": {
      "source": "PowerShell"
    },
    "Command Prompt": {
      "path": "cmd.exe"
    }
  },
  "terminal.integrated.defaultProfile.windows": "Git Bash"
}
```

---

## Git Integration

### Built-in Git Features

- **Source Control Panel** (`Ctrl+Shift+G`)
- Stage/unstage changes
- Write commit messages
- Push/pull/sync
- View diffs
- Branch management

### Common Operations

```
1. Stage changes: Click + next to file
2. Commit: Enter message + Ctrl+Enter
3. Push: Click "..." > Push
4. Pull: Click "..." > Pull
5. Create branch: Click branch name in status bar
```

---

## Debugging

### launch.json

Create `.vscode/launch.json`:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "node",
      "request": "launch",
      "name": "Launch Node",
      "program": "${workspaceFolder}/index.js"
    },
    {
      "type": "python",
      "request": "launch",
      "name": "Launch Python",
      "program": "${file}",
      "console": "integratedTerminal"
    }
  ]
}
```

### Debug Shortcuts

| Action | Shortcut |
|--------|----------|
| Start Debugging | `F5` |
| Stop Debugging | `Shift+F5` |
| Restart | `Ctrl+Shift+F5` |
| Step Over | `F10` |
| Step Into | `F11` |
| Step Out | `Shift+F11` |
| Toggle Breakpoint | `F9` |

---

## Snippets

### Create Custom Snippets

File > Preferences > Configure User Snippets

```json
{
  "Console Log": {
    "prefix": "clg",
    "body": "console.log($1);",
    "description": "Console log"
  },
  "React Component": {
    "prefix": "rfc",
    "body": [
      "import React from 'react';",
      "",
      "const ${1:Component} = () => {",
      "  return (",
      "    <div>",
      "      $0",
      "    </div>",
      "  );",
      "};",
      "",
      "export default ${1:Component};"
    ],
    "description": "React functional component"
  }
}
```

---

## Quick Reference

| Feature | Shortcut |
|---------|----------|
| Command Palette | `Ctrl+Shift+P` |
| Quick Open | `Ctrl+P` |
| Terminal | `` Ctrl+` `` |
| Search | `Ctrl+Shift+F` |
| Source Control | `Ctrl+Shift+G` |
| Extensions | `Ctrl+Shift+X` |
| Settings | `Ctrl+,` |
| Keyboard Shortcuts | `Ctrl+K Ctrl+S` |

---

## Resources

- [VS Code Documentation](https://code.visualstudio.com/docs)
- [VS Code Keyboard Shortcuts PDF](https://code.visualstudio.com/shortcuts/keyboard-shortcuts-windows.pdf)
- [VS Code Marketplace](https://marketplace.visualstudio.com/vscode)
- [VS Code Tips & Tricks](https://code.visualstudio.com/docs/getstarted/tips-and-tricks)