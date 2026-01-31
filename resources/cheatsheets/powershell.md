# PowerShell Cheatsheet

## What is PowerShell?

PowerShell is a cross-platform task automation solution consisting of a command-line shell, a scripting language, and a configuration management framework. Developed by Microsoft, it's built on .NET and is the primary shell for Windows administration, Azure management, and DevOps automation.

---

## Why Use PowerShell?

- **Cross-Platform** - Works on Windows, Mac, Linux
- **Object-Oriented** - Commands return objects, not text
- **Azure Integration** - Native Azure management modules
- **Windows Administration** - Best tool for Windows servers
- **Scripting** - Powerful automation capabilities
- **Remote Management** - Manage servers remotely
- **Consistency** - Verb-Noun naming convention

---

## Installation

### Windows

PowerShell 5.1 is built into Windows. For PowerShell 7+:

```powershell
# Using winget
winget install Microsoft.PowerShell

# Or download from
# https://github.com/PowerShell/PowerShell/releases
```

### Mac

```bash
brew install powershell/tap/powershell
```

### Linux (Ubuntu/Debian)

```bash
# Download and install
wget https://github.com/PowerShell/PowerShell/releases/download/v7.4.0/powershell_7.4.0-1.deb_amd64.deb
sudo dpkg -i powershell_7.4.0-1.deb_amd64.deb
sudo apt-get install -f
```

### Verify Installation

```powershell
$PSVersionTable
pwsh --version
```

---

## PowerShell Basics

### Command Structure (Verb-Noun)

```powershell
# PowerShell uses Verb-Noun naming
Get-Process          # Get processes
Stop-Process         # Stop a process
New-Item             # Create new item
Remove-Item          # Remove item
Set-Location         # Change directory

# Common verbs
# Get, Set, New, Remove, Start, Stop, Restart, 
# Import, Export, Add, Clear, Copy, Move
```

### Getting Help

```powershell
# Get help for command
Get-Help Get-Process
Get-Help Get-Process -Examples
Get-Help Get-Process -Full
Get-Help Get-Process -Online

# Update help files
Update-Help

# Find commands
Get-Command *process*
Get-Command -Verb Get
Get-Command -Noun Service

# Get command aliases
Get-Alias
Get-Alias ls
```

### Common Aliases

| Alias | Command | Description |
|-------|---------|-------------|
| `ls`, `dir` | Get-ChildItem | List files |
| `cd` | Set-Location | Change directory |
| `pwd` | Get-Location | Current directory |
| `cp` | Copy-Item | Copy files |
| `mv` | Move-Item | Move files |
| `rm`, `del` | Remove-Item | Delete files |
| `cat`, `type` | Get-Content | View file |
| `echo` | Write-Output | Print output |
| `cls`, `clear` | Clear-Host | Clear screen |
| `ps` | Get-Process | List processes |
| `kill` | Stop-Process | Kill process |
| `man` | Get-Help | Get help |

---

## Navigation & File Operations

### Directory Navigation

```powershell
# Current location
Get-Location
pwd

# Change directory
Set-Location C:\Users
cd C:\Users
cd ~                         # Home directory
cd ..                        # Parent directory
cd -                         # Previous directory (PS 7+)

# List files
Get-ChildItem
ls
dir
Get-ChildItem -Force         # Include hidden
Get-ChildItem -Recurse       # Recursive
Get-ChildItem *.txt          # Filter by extension
Get-ChildItem -File          # Files only
Get-ChildItem -Directory     # Directories only
```

### File Operations

```powershell
# Create files
New-Item -ItemType File -Name "file.txt"
New-Item file.txt -ItemType File
"Hello World" | Out-File file.txt
Set-Content file.txt "Hello World"

# Create directories
New-Item -ItemType Directory -Name "folder"
mkdir folder

# Copy files
Copy-Item file.txt copy.txt
Copy-Item file.txt -Destination C:\Backup\
Copy-Item -Path folder -Destination backup -Recurse

# Move/Rename
Move-Item file.txt newname.txt
Move-Item file.txt C:\Backup\
Rename-Item file.txt newname.txt

# Delete files
Remove-Item file.txt
Remove-Item folder -Recurse
Remove-Item *.tmp
rm file.txt

# Check if exists
Test-Path file.txt
Test-Path C:\folder
```

### File Content

```powershell
# Read file
Get-Content file.txt
Get-Content file.txt -Head 10      # First 10 lines
Get-Content file.txt -Tail 10      # Last 10 lines
Get-Content file.txt -Wait         # Follow (like tail -f)

# Write file
Set-Content file.txt "New content"
Add-Content file.txt "Append line"
"Text" | Out-File file.txt
"Text" | Out-File file.txt -Append

# Read as single string
Get-Content file.txt -Raw
```

---

## Variables & Data Types

### Variables

```powershell
# Create variables
$name = "John"
$age = 30
$price = 19.99
$isActive = $true
$items = @("apple", "banana", "orange")

# Display variable
$name
Write-Output $name
Write-Host "Name: $name"

# Variable types
$name.GetType()

# Special variables
$null                        # Null value
$true, $false               # Boolean
$HOME                       # Home directory
$PWD                        # Current directory
$PSVersionTable             # PowerShell version
$env:PATH                   # Environment variable
$?                          # Last command success
$LASTEXITCODE              # Last exit code
```

### Strings

```powershell
# String creation
$single = 'Single quotes - literal'
$double = "Double quotes - $name interpolation"
$here = @"
Multi-line
string here
"@

# String operations
$text = "Hello World"
$text.ToUpper()              # HELLO WORLD
$text.ToLower()              # hello world
$text.Length                 # 11
$text.Replace("World", "PowerShell")
$text.Split(" ")             # Array: Hello, World
$text.Contains("World")      # True
$text.StartsWith("Hello")    # True
$text.Substring(0, 5)        # Hello
$text.Trim()                 # Remove whitespace

# String formatting
"Name: {0}, Age: {1}" -f $name, $age
"{0:C}" -f 19.99             # Currency: $19.99
"{0:N2}" -f 1234.5           # Number: 1,234.50
"{0:P}" -f 0.25              # Percent: 25.00%
```

### Arrays

```powershell
# Create array
$fruits = @("apple", "banana", "orange")
$numbers = 1, 2, 3, 4, 5
$empty = @()

# Access elements
$fruits[0]                   # First element
$fruits[-1]                  # Last element
$fruits[0..2]                # Range

# Array operations
$fruits.Count                # Length
$fruits += "grape"           # Add element
$fruits -contains "apple"    # Check if contains
$fruits | ForEach-Object { $_.ToUpper() }

# Create range
$range = 1..10               # 1 to 10
```

### Hash Tables (Dictionaries)

```powershell
# Create hash table
$person = @{
    Name = "John"
    Age = 30
    City = "New York"
}

# Access values
$person["Name"]
$person.Name

# Add/modify
$person["Email"] = "john@example.com"
$person.Phone = "555-1234"

# Remove
$person.Remove("Phone")

# Iterate
$person.Keys
$person.Values
$person.GetEnumerator() | ForEach-Object {
    Write-Host "$($_.Key): $($_.Value)"
}
```

---

## Control Flow

### Conditionals

```powershell
# If/ElseIf/Else
$age = 18
if ($age -lt 13) {
    Write-Host "Child"
} elseif ($age -lt 20) {
    Write-Host "Teenager"
} else {
    Write-Host "Adult"
}

# Comparison operators
-eq          # Equal
-ne          # Not equal
-gt          # Greater than
-ge          # Greater or equal
-lt          # Less than
-le          # Less or equal
-like        # Wildcard match
-notlike     # Not wildcard match
-match       # Regex match
-contains    # Array contains
-in          # Value in array

# Logical operators
-and         # AND
-or          # OR
-not, !      # NOT

# Examples
if ($name -eq "John" -and $age -gt 18) { }
if ($name -like "J*") { }
if ($value -in @(1, 2, 3)) { }

# Ternary (PS 7+)
$status = $age -ge 18 ? "Adult" : "Minor"

# Switch
switch ($day) {
    "Monday"    { Write-Host "Start of week" }
    "Friday"    { Write-Host "End of week" }
    default     { Write-Host "Regular day" }
}
```

### Loops

```powershell
# ForEach-Object (pipeline)
1..5 | ForEach-Object { Write-Host $_ }
Get-ChildItem | ForEach-Object { $_.Name }

# foreach statement
foreach ($fruit in $fruits) {
    Write-Host $fruit
}

# for loop
for ($i = 0; $i -lt 5; $i++) {
    Write-Host $i
}

# while loop
$count = 0
while ($count -lt 5) {
    Write-Host $count
    $count++
}

# do-while
do {
    Write-Host $count
    $count++
} while ($count -lt 5)

# Loop control
break                        # Exit loop
continue                     # Next iteration
```

---

## Functions

```powershell
# Basic function
function Say-Hello {
    Write-Host "Hello, World!"
}
Say-Hello

# Function with parameters
function Say-Hello {
    param (
        [string]$Name = "World"
    )
    Write-Host "Hello, $Name!"
}
Say-Hello -Name "John"

# Advanced function
function Get-Square {
    param (
        [Parameter(Mandatory=$true)]
        [int]$Number
    )
    return $Number * $Number
}
$result = Get-Square -Number 5

# Function with multiple parameters
function New-User {
    param (
        [Parameter(Mandatory)]
        [string]$Username,
        
        [Parameter(Mandatory)]
        [string]$Email,
        
        [string]$Role = "User",
        
        [switch]$Active
    )
    
    Write-Host "Creating user: $Username"
    Write-Host "Email: $Email"
    Write-Host "Role: $Role"
    Write-Host "Active: $Active"
}

New-User -Username "john" -Email "john@example.com" -Active
```

---

## Pipeline & Objects

### Pipeline Basics

```powershell
# Pipeline passes objects between commands
Get-Process | Where-Object { $_.CPU -gt 10 }
Get-ChildItem | Sort-Object Length -Descending
Get-Service | Select-Object Name, Status

# Common pipeline commands
Where-Object    # Filter objects
Select-Object   # Select properties
Sort-Object     # Sort objects
ForEach-Object  # Process each object
Group-Object    # Group objects
Measure-Object  # Calculate statistics
```

### Filtering with Where-Object

```powershell
# Filter processes
Get-Process | Where-Object { $_.CPU -gt 10 }
Get-Process | Where-Object CPU -gt 10        # Simplified
Get-Process | ? CPU -gt 10                   # Using alias

# Multiple conditions
Get-Process | Where-Object { 
    $_.CPU -gt 10 -and $_.WorkingSet -gt 100MB 
}

# Filter files
Get-ChildItem | Where-Object { $_.Length -gt 1MB }
Get-ChildItem | Where-Object Extension -eq ".txt"
```

### Selecting with Select-Object

```powershell
# Select properties
Get-Process | Select-Object Name, CPU, WorkingSet
Get-Process | Select-Object -First 5
Get-Process | Select-Object -Last 5
Get-Process | Select-Object -Property *      # All properties

# Create calculated property
Get-Process | Select-Object Name, @{
    Name = "MemoryMB"
    Expression = { [math]::Round($_.WorkingSet / 1MB, 2) }
}
```

### Sorting

```powershell
Get-Process | Sort-Object CPU -Descending
Get-ChildItem | Sort-Object Length
Get-ChildItem | Sort-Object LastWriteTime -Descending
```

---

## Process & Service Management

### Processes

```powershell
# List processes
Get-Process
Get-Process -Name notepad
Get-Process | Where-Object CPU -gt 10
Get-Process | Sort-Object CPU -Descending | Select-Object -First 10

# Start process
Start-Process notepad
Start-Process "C:\Program Files\app.exe"
Start-Process notepad -Wait              # Wait for exit
Start-Process cmd -ArgumentList "/c dir"

# Stop process
Stop-Process -Name notepad
Stop-Process -Id 1234
Get-Process notepad | Stop-Process
```

### Services

```powershell
# List services
Get-Service
Get-Service -Name wuauserv
Get-Service | Where-Object Status -eq "Running"
Get-Service | Where-Object Status -eq "Stopped"

# Service control
Start-Service -Name wuauserv
Stop-Service -Name wuauserv
Restart-Service -Name wuauserv
Set-Service -Name wuauserv -StartupType Automatic
```

---

## Remote Management

### PowerShell Remoting

```powershell
# Enable remoting (run as admin)
Enable-PSRemoting -Force

# Run command on remote computer
Invoke-Command -ComputerName Server01 -ScriptBlock {
    Get-Process
}

# Interactive session
Enter-PSSession -ComputerName Server01
Exit-PSSession

# Run on multiple computers
$computers = @("Server01", "Server02", "Server03")
Invoke-Command -ComputerName $computers -ScriptBlock {
    Get-Service -Name wuauserv
}

# Using credentials
$cred = Get-Credential
Invoke-Command -ComputerName Server01 -Credential $cred -ScriptBlock {
    Get-Process
}
```

### SSH Remoting (PS 7+)

```powershell
# Connect via SSH
Enter-PSSession -HostName user@server -SSHTransport

# Run command via SSH
Invoke-Command -HostName user@server -SSHTransport -ScriptBlock {
    Get-Process
}
```

---

## Azure PowerShell

### Installation

```powershell
# Install Azure module
Install-Module -Name Az -AllowClobber -Scope CurrentUser

# Update module
Update-Module -Name Az

# Import module
Import-Module Az
```

### Authentication

```powershell
# Interactive login
Connect-AzAccount

# Service principal
$credential = Get-Credential
Connect-AzAccount -ServicePrincipal -Credential $credential -Tenant "tenant-id"

# Check context
Get-AzContext

# List subscriptions
Get-AzSubscription

# Set subscription
Set-AzContext -SubscriptionId "subscription-id"
```

### Common Azure Commands

```powershell
# Resource Groups
Get-AzResourceGroup
New-AzResourceGroup -Name "myRG" -Location "eastus"
Remove-AzResourceGroup -Name "myRG"

# Virtual Machines
Get-AzVM
New-AzVM -ResourceGroupName "myRG" -Name "myVM" -Location "eastus"
Start-AzVM -ResourceGroupName "myRG" -Name "myVM"
Stop-AzVM -ResourceGroupName "myRG" -Name "myVM"
Remove-AzVM -ResourceGroupName "myRG" -Name "myVM"

# Storage
Get-AzStorageAccount
New-AzStorageAccount -ResourceGroupName "myRG" -Name "mystorageacct" `
    -Location "eastus" -SkuName "Standard_LRS"

# Web Apps
Get-AzWebApp
New-AzWebApp -ResourceGroupName "myRG" -Name "mywebapp" `
    -Location "eastus" -AppServicePlan "myplan"
```

---

## Error Handling

```powershell
# Try/Catch/Finally
try {
    Get-Content "nonexistent.txt" -ErrorAction Stop
} catch {
    Write-Host "Error: $($_.Exception.Message)"
} finally {
    Write-Host "Cleanup code here"
}

# Error action preference
$ErrorActionPreference = "Stop"      # Stop on all errors
$ErrorActionPreference = "Continue"  # Continue (default)
$ErrorActionPreference = "SilentlyContinue"  # Suppress errors

# Per-command error action
Get-Content file.txt -ErrorAction SilentlyContinue
Get-Content file.txt -ErrorAction Stop

# Check for errors
if ($?) {
    Write-Host "Last command succeeded"
} else {
    Write-Host "Last command failed"
}
```

---

## Script Basics

### Script File (.ps1)

```powershell
# myscript.ps1
param (
    [Parameter(Mandatory)]
    [string]$Name,
    
    [int]$Count = 1
)

for ($i = 0; $i -lt $Count; $i++) {
    Write-Host "Hello, $Name!"
}
```

### Run Script

```powershell
# Execution policy (run as admin)
Get-ExecutionPolicy
Set-ExecutionPolicy RemoteSigned

# Run script
.\myscript.ps1 -Name "John" -Count 3
& "C:\Scripts\myscript.ps1"

# Dot sourcing (import functions)
. .\functions.ps1
```

---

## Quick Reference

| Command | Description |
|---------|-------------|
| `Get-Help cmd` | Get help |
| `Get-Command *keyword*` | Find commands |
| `Get-ChildItem` / `ls` | List files |
| `Set-Location` / `cd` | Change directory |
| `Get-Content` / `cat` | Read file |
| `Set-Content` | Write file |
| `Copy-Item` / `cp` | Copy files |
| `Move-Item` / `mv` | Move files |
| `Remove-Item` / `rm` | Delete files |
| `Get-Process` / `ps` | List processes |
| `Stop-Process` / `kill` | Kill process |
| `Get-Service` | List services |
| `Start-Service` | Start service |
| `Where-Object` / `?` | Filter objects |
| `Select-Object` | Select properties |
| `ForEach-Object` / `%` | Process each |
| `Sort-Object` | Sort objects |
| `Measure-Object` | Calculate stats |

---

## Resources

- [PowerShell Documentation](https://docs.microsoft.com/en-us/powershell/)
- [PowerShell Gallery](https://www.powershellgallery.com/)
- [Azure PowerShell Docs](https://docs.microsoft.com/en-us/powershell/azure/)
- [PowerShell GitHub](https://github.com/PowerShell/PowerShell)