# Terraform Cheatsheet

## What is Terraform?

Terraform is an open-source Infrastructure as Code (IaC) tool created by HashiCorp. It allows you to define, provision, and manage cloud infrastructure using declarative configuration files. Terraform supports multiple cloud providers including Azure, AWS, GCP, and many others.

---

## Why Use Terraform?

- **Infrastructure as Code** - Version control your infrastructure
- **Multi-Cloud** - Use one tool for AWS, Azure, GCP, and more
- **Declarative** - Define what you want, Terraform figures out how
- **State Management** - Tracks current infrastructure state
- **Plan Before Apply** - Preview changes before execution
- **Reusability** - Modules for repeatable infrastructure patterns
- **Collaboration** - Teams can work together on infrastructure

---

## Key Concepts

| Concept | Description |
|---------|-------------|
| **Provider** | Plugin to interact with cloud platforms (Azure, AWS, GCP) |
| **Resource** | Infrastructure component (VM, network, storage) |
| **Data Source** | Query existing infrastructure |
| **Variable** | Input parameters for configurations |
| **Output** | Values exported after apply |
| **Module** | Reusable group of resources |
| **State** | Record of managed infrastructure |
| **Plan** | Preview of changes to be made |

---

## Installation

### Windows

```powershell
# Using winget
winget install HashiCorp.Terraform

# Or using Chocolatey
choco install terraform

# Or download from
# https://www.terraform.io/downloads
```

### Mac

```bash
# Using Homebrew
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

### Linux (Ubuntu/Debian)

```bash
# Add HashiCorp GPG key
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

# Add repository
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

# Install
sudo apt update && sudo apt install terraform
```

### Verify Installation

```bash
terraform --version
```

---

## Basic Workflow

```bash
# 1. Initialize working directory
terraform init

# 2. Format code
terraform fmt

# 3. Validate configuration
terraform validate

# 4. Preview changes
terraform plan

# 5. Apply changes
terraform apply

# 6. Destroy infrastructure
terraform destroy
```

---

## Essential Commands

### Initialization

```bash
# Initialize working directory
terraform init

# Reinitialize and upgrade providers
terraform init -upgrade

# Initialize with backend config
terraform init -backend-config="storage_account_name=mystorage"

# Initialize specific module
terraform init -from-module=./modules/vpc
```

### Planning

```bash
# Create execution plan
terraform plan

# Save plan to file
terraform plan -out=tfplan

# Plan for destroy
terraform plan -destroy

# Plan with variable
terraform plan -var="region=eastus"

# Plan with variable file
terraform plan -var-file="prod.tfvars"

# Target specific resource
terraform plan -target=azurerm_resource_group.main
```

### Applying

```bash
# Apply changes (with confirmation)
terraform apply

# Apply saved plan
terraform apply tfplan

# Auto-approve (skip confirmation)
terraform apply -auto-approve

# Apply with variables
terraform apply -var="instance_count=3"

# Apply targeting specific resource
terraform apply -target=azurerm_virtual_machine.main
```

### Destroying

```bash
# Destroy all infrastructure
terraform destroy

# Auto-approve destroy
terraform destroy -auto-approve

# Destroy specific resource
terraform destroy -target=azurerm_virtual_machine.main
```

### State Management

```bash
# List resources in state
terraform state list

# Show resource details
terraform state show azurerm_resource_group.main

# Remove resource from state (doesn't delete actual resource)
terraform state rm azurerm_resource_group.main

# Move resource in state
terraform state mv azurerm_resource_group.old azurerm_resource_group.new

# Pull remote state
terraform state pull

# Push state to remote
terraform state push

# Replace provider in state
terraform state replace-provider hashicorp/azurerm registry.terraform.io/hashicorp/azurerm
```

### Other Commands

```bash
# Format code
terraform fmt
terraform fmt -recursive

# Validate configuration
terraform validate

# Show outputs
terraform output
terraform output vm_ip

# Refresh state
terraform refresh

# Import existing resource
terraform import azurerm_resource_group.main /subscriptions/.../resourceGroups/myRG

# Show providers
terraform providers

# Graph (generate visual)
terraform graph | dot -Tpng > graph.png

# Console (interactive)
terraform console
```

---

## Configuration Basics

### Provider Configuration

```hcl
# Azure Provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.0"
}

provider "azurerm" {
  features {}
  subscription_id = "your-subscription-id"
}

# AWS Provider
provider "aws" {
  region = "us-east-1"
}

# GCP Provider
provider "google" {
  project = "my-project"
  region  = "us-central1"
}
```

### Resource Definition

```hcl
# Azure Resource Group
resource "azurerm_resource_group" "main" {
  name     = "my-resource-group"
  location = "eastus"

  tags = {
    Environment = "Dev"
    Project     = "Workshop"
  }
}

# Azure Virtual Network
resource "azurerm_virtual_network" "main" {
  name                = "my-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

# Azure VM
resource "azurerm_linux_virtual_machine" "main" {
  name                = "my-vm"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = "Standard_B1s"
  admin_username      = "azureuser"

  network_interface_ids = [
    azurerm_network_interface.main.id
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
```

### Variables

```hcl
# variables.tf

# String variable
variable "location" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}

# Number variable
variable "instance_count" {
  description = "Number of instances"
  type        = number
  default     = 1
}

# Boolean variable
variable "enable_monitoring" {
  description = "Enable monitoring"
  type        = bool
  default     = true
}

# List variable
variable "allowed_ports" {
  description = "Allowed ports"
  type        = list(number)
  default     = [22, 80, 443]
}

# Map variable
variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default = {
    Environment = "Dev"
    Project     = "Workshop"
  }
}

# Object variable
variable "vm_config" {
  description = "VM configuration"
  type = object({
    size     = string
    username = string
  })
  default = {
    size     = "Standard_B1s"
    username = "azureuser"
  }
}

# Sensitive variable
variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}
```

### Variable Files (terraform.tfvars)

```hcl
# terraform.tfvars
location       = "eastus"
instance_count = 3
enable_monitoring = true

tags = {
  Environment = "Production"
  Project     = "MyApp"
}
```

### Using Variables

```hcl
resource "azurerm_resource_group" "main" {
  name     = "rg-${var.environment}"
  location = var.location
  tags     = var.tags
}
```

### Outputs

```hcl
# outputs.tf

output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.main.name
}

output "vm_public_ip" {
  description = "Public IP of the VM"
  value       = azurerm_public_ip.main.ip_address
}

output "connection_string" {
  description = "Database connection string"
  value       = azurerm_mssql_server.main.fully_qualified_domain_name
  sensitive   = true
}
```

### Data Sources

```hcl
# Query existing resource group
data "azurerm_resource_group" "existing" {
  name = "existing-rg"
}

# Query existing subscription
data "azurerm_subscription" "current" {}

# Use in resources
resource "azurerm_virtual_network" "main" {
  name                = "my-vnet"
  location            = data.azurerm_resource_group.existing.location
  resource_group_name = data.azurerm_resource_group.existing.name
  address_space       = ["10.0.0.0/16"]
}
```

### Locals

```hcl
locals {
  environment = "dev"
  prefix      = "workshop"
  
  common_tags = {
    Environment = local.environment
    ManagedBy   = "Terraform"
    Project     = "CloudWorkshop"
  }
  
  resource_name = "${local.prefix}-${local.environment}"
}

resource "azurerm_resource_group" "main" {
  name     = "${local.resource_name}-rg"
  location = var.location
  tags     = local.common_tags
}
```

---

## Backend Configuration

### Azure Storage Backend

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstatestorage"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}
```

### AWS S3 Backend

```hcl
terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
```

### GCS Backend

```hcl
terraform {
  backend "gcs" {
    bucket = "my-terraform-state"
    prefix = "prod"
  }
}
```

---

## Modules

### Using a Module

```hcl
module "network" {
  source = "./modules/network"

  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  vnet_address_space  = ["10.0.0.0/16"]
  
  tags = local.common_tags
}

# Access module outputs
resource "azurerm_subnet" "main" {
  name                 = "subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = module.network.vnet_name
  address_prefixes     = ["10.0.1.0/24"]
}
```

### Module from Registry

```hcl
module "aks" {
  source  = "Azure/aks/azurerm"
  version = "7.0.0"

  resource_group_name = azurerm_resource_group.main.name
  cluster_name        = "my-aks-cluster"
  location            = var.location
}
```

### Module from GitHub

```hcl
module "vpc" {
  source = "github.com/user/terraform-modules//vpc?ref=v1.0.0"
  
  cidr_block = "10.0.0.0/16"
}
```

---

## Expressions & Functions

### Conditional Expression

```hcl
resource "azurerm_public_ip" "main" {
  count = var.create_public_ip ? 1 : 0
  
  name                = "my-public-ip"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
}
```

### For Each

```hcl
variable "subnets" {
  default = {
    web = "10.0.1.0/24"
    app = "10.0.2.0/24"
    db  = "10.0.3.0/24"
  }
}

resource "azurerm_subnet" "main" {
  for_each = var.subnets

  name                 = each.key
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [each.value]
}
```

### Count

```hcl
resource "azurerm_linux_virtual_machine" "main" {
  count = var.instance_count

  name = "vm-${count.index + 1}"
  # ... other config
}
```

### Common Functions

```hcl
# String functions
name = lower("MyResource")           # myresource
name = upper("myresource")           # MYRESOURCE
name = replace("hello-world", "-", "_")  # hello_world
name = substr("hello", 0, 3)         # hel
name = join("-", ["a", "b", "c"])    # a-b-c
name = split(",", "a,b,c")           # ["a", "b", "c"]
name = format("%s-%s", var.env, var.name)

# Collection functions
first = element(["a", "b", "c"], 0)  # a
len   = length(["a", "b", "c"])      # 3
items = concat(["a"], ["b", "c"])    # ["a", "b", "c"]
has   = contains(["a", "b"], "a")    # true
flat  = flatten([["a"], ["b"]])      # ["a", "b"]

# File functions
content = file("./script.sh")
template = templatefile("./config.tpl", { port = 8080 })

# Lookup
value = lookup(var.map, "key", "default")
```

---

## Best Practices

### File Structure

```
project/
├── main.tf           # Main resources
├── variables.tf      # Variable declarations
├── outputs.tf        # Output declarations
├── providers.tf      # Provider configuration
├── terraform.tfvars  # Variable values
├── backend.tf        # Backend configuration
└── modules/
    └── network/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

### Naming Convention

```hcl
# Use consistent naming
resource "azurerm_resource_group" "main" { }
resource "azurerm_virtual_network" "main" { }
resource "azurerm_subnet" "web" { }
resource "azurerm_subnet" "app" { }
```

---

## Quick Reference

| Command | Description |
|---------|-------------|
| `terraform init` | Initialize directory |
| `terraform plan` | Preview changes |
| `terraform apply` | Apply changes |
| `terraform destroy` | Destroy infrastructure |
| `terraform fmt` | Format code |
| `terraform validate` | Validate config |
| `terraform output` | Show outputs |
| `terraform state list` | List state resources |
| `terraform import` | Import existing resource |
| `terraform workspace` | Manage workspaces |

---

## Resources

- [Terraform Documentation](https://developer.hashicorp.com/terraform/docs)
- [Terraform Registry](https://registry.terraform.io/)
- [Azure Provider Docs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [AWS Provider Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [GCP Provider Docs](https://registry.terraform.io/providers/hashicorp/google/latest/docs)