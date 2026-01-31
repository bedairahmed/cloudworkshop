# Azure CLI Cheatsheet

## What is Azure CLI?

Azure CLI (Command-Line Interface) is a cross-platform tool that allows you to manage Azure resources from the terminal. It provides a consistent way to interact with Azure services, automate tasks, and integrate with scripts and CI/CD pipelines.

---

## Why Use Azure CLI?

- **Automation** - Script repetitive tasks and deployments
- **Speed** - Faster than navigating the Azure Portal for many tasks
- **CI/CD Integration** - Perfect for pipelines and DevOps workflows
- **Cross-Platform** - Works on Windows, Mac, and Linux
- **Consistency** - Same commands work everywhere

---

## Installation

### Windows

```powershell
# Using winget
winget install Microsoft.AzureCLI

# Or download MSI from
# https://aka.ms/installazurecliwindows
```

### Mac

```bash
# Using Homebrew
brew update && brew install azure-cli
```

### Linux (Ubuntu/Debian)

```bash
# Install dependencies
sudo apt-get update
sudo apt-get install ca-certificates curl apt-transport-https lsb-release gnupg

# Add Microsoft signing key
curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null

# Add repository
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | sudo tee /etc/apt/sources.list.d/azure-cli.list

# Install
sudo apt-get update
sudo apt-get install azure-cli
```

### Docker

```bash
docker run -it mcr.microsoft.com/azure-cli
```

### Verify Installation

```bash
az --version
```

---

## Authentication

```bash
# Interactive login (opens browser)
az login

# Login with device code (for remote/headless)
az login --use-device-code

# Login with service principal
az login --service-principal \
  --username <app-id> \
  --password <password-or-cert> \
  --tenant <tenant-id>

# Login to specific tenant
az login --tenant <tenant-id>

# Check current login status
az account show

# List all subscriptions
az account list --output table

# Set active subscription
az account set --subscription "Subscription Name"
az account set --subscription <subscription-id>

# Logout
az logout
```

---

## Key Concepts

| Concept | Description |
|---------|-------------|
| **Subscription** | Billing container for Azure resources |
| **Resource Group** | Logical container for related resources |
| **Resource** | Any Azure service (VM, Storage, etc.) |
| **Location/Region** | Geographic location of resources |
| **Tags** | Key-value pairs for organizing resources |

---

## Output Formats

```bash
# Set default output format
az configure --defaults output=table

# Specify output per command
az group list --output table    # Table format
az group list --output json     # JSON format (default)
az group list --output yaml     # YAML format
az group list --output tsv      # Tab-separated values

# Query specific fields (JMESPath)
az group list --query "[].name" --output tsv
az vm list --query "[].{Name:name, RG:resourceGroup}" --output table
```

---

## Resource Groups

```bash
# List all resource groups
az group list --output table

# Create a resource group
az group create --name myResourceGroup --location eastus

# Create with tags
az group create --name myResourceGroup --location eastus \
  --tags Environment=Dev Project=Workshop

# Show resource group details
az group show --name myResourceGroup

# Delete a resource group (and all resources in it)
az group delete --name myResourceGroup --yes --no-wait

# List resources in a group
az resource list --resource-group myResourceGroup --output table
```

---

## Virtual Machines

```bash
# List all VMs
az vm list --output table

# List VMs in a resource group
az vm list --resource-group myResourceGroup --output table

# Create a Linux VM
az vm create \
  --resource-group myResourceGroup \
  --name myVM \
  --image Ubuntu2204 \
  --size Standard_B1s \
  --admin-username azureuser \
  --generate-ssh-keys

# Create a Windows VM
az vm create \
  --resource-group myResourceGroup \
  --name myWindowsVM \
  --image Win2022Datacenter \
  --size Standard_B2s \
  --admin-username azureuser \
  --admin-password 'YourPassword123!'

# Show VM details
az vm show --resource-group myResourceGroup --name myVM

# Get VM IP address
az vm show --resource-group myResourceGroup --name myVM \
  --show-details --query publicIps --output tsv

# Start a VM
az vm start --resource-group myResourceGroup --name myVM

# Stop a VM (still incurs charges)
az vm stop --resource-group myResourceGroup --name myVM

# Deallocate a VM (no charges)
az vm deallocate --resource-group myResourceGroup --name myVM

# Restart a VM
az vm restart --resource-group myResourceGroup --name myVM

# Delete a VM
az vm delete --resource-group myResourceGroup --name myVM --yes

# List available VM sizes
az vm list-sizes --location eastus --output table

# List available VM images
az vm image list --output table
az vm image list --offer Ubuntu --all --output table
```

---

## App Service (Web Apps)

```bash
# List all web apps
az webapp list --output table

# Create an App Service Plan
az appservice plan create \
  --name myAppServicePlan \
  --resource-group myResourceGroup \
  --sku F1 \
  --is-linux

# Create a Web App
az webapp create \
  --resource-group myResourceGroup \
  --plan myAppServicePlan \
  --name myUniqueWebAppName \
  --runtime "NODE:20-lts"

# List available runtimes
az webapp list-runtimes

# Deploy from GitHub
az webapp deployment source config \
  --resource-group myResourceGroup \
  --name myWebApp \
  --repo-url https://github.com/user/repo \
  --branch main \
  --manual-integration

# Deploy from local folder
az webapp up \
  --resource-group myResourceGroup \
  --name myWebApp \
  --runtime "NODE:20-lts"

# View app logs
az webapp log tail --resource-group myResourceGroup --name myWebApp

# Restart web app
az webapp restart --resource-group myResourceGroup --name myWebApp

# Delete web app
az webapp delete --resource-group myResourceGroup --name myWebApp
```

---

## Storage Accounts

```bash
# List storage accounts
az storage account list --output table

# Create a storage account
az storage account create \
  --name mystorageaccount \
  --resource-group myResourceGroup \
  --location eastus \
  --sku Standard_LRS

# Get storage account keys
az storage account keys list \
  --account-name mystorageaccount \
  --resource-group myResourceGroup

# Get connection string
az storage account show-connection-string \
  --name mystorageaccount \
  --resource-group myResourceGroup

# Create a blob container
az storage container create \
  --name mycontainer \
  --account-name mystorageaccount

# Upload a file to blob
az storage blob upload \
  --account-name mystorageaccount \
  --container-name mycontainer \
  --name myblob \
  --file ./localfile.txt

# List blobs
az storage blob list \
  --account-name mystorageaccount \
  --container-name mycontainer \
  --output table

# Download a blob
az storage blob download \
  --account-name mystorageaccount \
  --container-name mycontainer \
  --name myblob \
  --file ./downloaded.txt
```

---

## Networking

```bash
# List virtual networks
az network vnet list --output table

# Create a virtual network
az network vnet create \
  --resource-group myResourceGroup \
  --name myVNet \
  --address-prefix 10.0.0.0/16 \
  --subnet-name mySubnet \
  --subnet-prefix 10.0.1.0/24

# Create a Network Security Group
az network nsg create \
  --resource-group myResourceGroup \
  --name myNSG

# Add NSG rule (allow SSH)
az network nsg rule create \
  --resource-group myResourceGroup \
  --nsg-name myNSG \
  --name AllowSSH \
  --priority 1000 \
  --destination-port-ranges 22 \
  --access Allow \
  --protocol Tcp

# Create a public IP
az network public-ip create \
  --resource-group myResourceGroup \
  --name myPublicIP \
  --sku Standard
```

---

## Azure Container Instances (ACI)

```bash
# Create a container instance
az container create \
  --resource-group myResourceGroup \
  --name mycontainer \
  --image nginx \
  --dns-name-label mydnsname \
  --ports 80

# List containers
az container list --output table

# Show container details
az container show --resource-group myResourceGroup --name mycontainer

# View container logs
az container logs --resource-group myResourceGroup --name mycontainer

# Delete container
az container delete --resource-group myResourceGroup --name mycontainer --yes
```

---

## Azure Kubernetes Service (AKS)

```bash
# Create AKS cluster
az aks create \
  --resource-group myResourceGroup \
  --name myAKSCluster \
  --node-count 1 \
  --node-vm-size Standard_B2s \
  --generate-ssh-keys

# Get credentials for kubectl
az aks get-credentials --resource-group myResourceGroup --name myAKSCluster

# List AKS clusters
az aks list --output table

# Scale AKS cluster
az aks scale --resource-group myResourceGroup --name myAKSCluster --node-count 3

# Delete AKS cluster
az aks delete --resource-group myResourceGroup --name myAKSCluster --yes
```

---

## Useful Tips

### Set Defaults

```bash
# Set default resource group and location
az configure --defaults group=myResourceGroup location=eastus

# Now you can omit these in commands
az vm create --name myVM --image Ubuntu2204
```

### Interactive Mode

```bash
# Start interactive mode with auto-completion
az interactive
```

### Find Commands

```bash
# Search for commands
az find "create vm"
az find "storage blob"

# Get help for any command
az vm create --help
```

---

## Quick Reference

| Command | Description |
|---------|-------------|
| `az login` | Login to Azure |
| `az account list` | List subscriptions |
| `az account set -s <name>` | Set subscription |
| `az group create` | Create resource group |
| `az group delete` | Delete resource group |
| `az vm create` | Create virtual machine |
| `az vm start/stop` | Start/stop VM |
| `az webapp create` | Create web app |
| `az webapp up` | Deploy web app |
| `az storage account create` | Create storage |
| `az aks create` | Create Kubernetes cluster |

---

## Resources

- [Azure CLI Documentation](https://docs.microsoft.com/en-us/cli/azure/)
- [Azure CLI Reference](https://docs.microsoft.com/en-us/cli/azure/reference-index)
- [Azure CLI Samples](https://github.com/Azure-Samples/azure-cli-samples)