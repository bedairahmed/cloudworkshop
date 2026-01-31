# Lab 0: Setup Your Environment

## Objective

Set up your development environment with Git and VS Code, then clone this workshop repository.

---

## Part 1: Install Git

### Check if Git is Installed

Open your terminal and run:

```bash
git --version
```

### Install Git (if needed)

| Platform | Installation |
|----------|--------------|
| **Windows** | Download from https://git-scm.com/download/win |
| **Mac** | Run `brew install git` or download from https://git-scm.com/download/mac |
| **Linux** | Run `sudo apt install git` (Ubuntu/Debian) |

---

## Part 2: Install VS Code

### Download VS Code

1. Go to https://code.visualstudio.com/
2. Download for your operating system
3. Run the installer
4. Launch VS Code

### Recommended Extensions

Open VS Code and install these extensions (click Extensions icon in sidebar or press `Ctrl+Shift+X`):

| Extension | Description |
|-----------|-------------|
| **Azure Account** | Sign in to Azure |
| **Azure App Service** | Deploy web apps |
| **Azure Resources** | Browse Azure resources |
| **Docker** | Container support |
| **GitLens** | Enhanced Git features |
| **Markdown Preview** | Preview .md files |

To install, search for the extension name and click **Install**.

---

## Part 3: Clone the Repository

### Option A: Clone using Terminal

1. Open terminal (or VS Code terminal with `` Ctrl+` ``)

2. Navigate to your workspace:
   ```bash
   # Windows
   cd C:\Users\YourName\Documents

   # Mac/Linux
   cd ~/Documents
   ```

3. Clone the repository:
   ```bash
   git clone https://github.com/bedairahmed/cloudworkshop.git
   ```

4. Navigate into the folder:
   ```bash
   cd cloudworkshop
   ```

### Option B: Clone using VS Code

1. Open VS Code
2. Press `Ctrl+Shift+P` (or `Cmd+Shift+P` on Mac)
3. Type **Git: Clone** and select it
4. Paste the repository URL:
   ```
   https://github.com/bedairahmed/cloudworkshop.git
   ```
5. Choose a folder to save the repository
6. Click **Open** when prompted

---

## Part 4: Open Repository in VS Code

If you cloned via terminal:

1. Open VS Code
2. Click **File** > **Open Folder**
3. Select the `cloudworkshop` folder
4. Click **Open**

Or from terminal:

```bash
code cloudworkshop
```

---

## Repository Structure

```
cloudworkshop/
├── README.md
├── labs/
│   ├── 00-clone-repo.md        (You are here)
│   ├── 01-azure-login.md
│   ├── 02-create-vm.md
│   └── 03-create-app-service.md
└── resources/
    ├── images/
    └── cheatsheets/
        ├── git-cheatsheet.md
        ├── docker-cheatsheet.md
        └── azure-cli-cheatsheet.md
```

---

## VS Code Tips

| Shortcut | Action |
|----------|--------|
| `` Ctrl+` `` | Open/close terminal |
| `Ctrl+Shift+P` | Command palette |
| `Ctrl+Shift+E` | File explorer |
| `Ctrl+Shift+G` | Source control (Git) |
| `Ctrl+Shift+X` | Extensions |
| `Ctrl+P` | Quick open file |

---

## Verification

You have successfully completed this lab when you can:

- [ ] Git is installed and working
- [ ] VS Code is installed
- [ ] Repository is cloned
- [ ] Repository is open in VS Code
- [ ] You can see the lab files in the explorer

---

## Next Lab

[Lab 1: Azure Portal Login](01-azure-login.md)