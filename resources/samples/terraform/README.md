# Azure Terraform Sample

This Terraform configuration creates a basic Azure infrastructure including:

- **Resource Group** - Container for all resources
- **Virtual Network (VNet)** - Network with address space 10.0.0.0/16
- **Subnet** - Subnet with address space 10.0.1.0/24
- **Network Security Group (NSG)** - Firewall rules for SSH, HTTP, HTTPS
- **Public IP** - Static public IP address
- **Network Interface** - NIC for the VM
- **Linux Virtual Machine** - Ubuntu 22.04 LTS VM

## Architecture

```
┌─────────────────────────────────────────────────────┐
│                  Resource Group                      │
│  ┌───────────────────────────────────────────────┐  │
│  │              Virtual Network                   │  │
│  │  ┌─────────────────────────────────────────┐  │  │
│  │  │               Subnet                     │  │  │
│  │  │  ┌─────────────┐    ┌───────────────┐   │  │  │
│  │  │  │     VM      │────│      NIC      │   │  │  │
│  │  │  │  (Ubuntu)   │    │               │   │  │  │
│  │  │  └─────────────┘    └───────────────┘   │  │  │
│  │  │                            │            │  │  │
│  │  └────────────────────────────│────────────┘  │  │
│  │                               │               │  │
│  └───────────────────────────────│───────────────┘  │
│                                  │                  │
│  ┌───────────┐    ┌──────────────┴───────────────┐  │
│  │    NSG    │    │         Public IP            │  │
│  │ (SSH,HTTP)│    │                              │  │
│  └───────────┘    └──────────────────────────────┘  │
│                                  │                  │
└──────────────────────────────────│──────────────────┘
                                   │
                              Internet
```

## Prerequisites

1. **Terraform** installed (v1.0+)
2. **Azure CLI** installed and logged in
3. **Azure Subscription** with Contributor access

## Quick Start

### 1. Clone and Navigate

```bash
cd terraform-azure
```

### 2. Configure Variables

```bash
# Copy example variables file
cp terraform.tfvars.example terraform.tfvars

# Edit with your values
nano terraform.tfvars
```

### 3. Login to Azure

```bash
az login
az account set --subscription "Your Subscription Name"
```

### 4. Initialize Terraform

```bash
terraform init
```

### 5. Plan the Deployment

```bash
terraform plan
```

### 6. Apply the Configuration

```bash
terraform apply
```

Type `yes` when prompted.

### 7. Get Outputs

```bash
terraform output
terraform output vm_public_ip
terraform output ssh_connection
```

### 8. Connect to VM

```bash
ssh azureuser@<public-ip>
```

## Clean Up

To destroy all resources:

```bash
terraform destroy
```

Type `yes` when prompted.

## Files

| File | Description |
|------|-------------|
| `providers.tf` | Terraform and Azure provider configuration |
| `main.tf` | Main resource definitions |
| `variables.tf` | Variable declarations |
| `outputs.tf` | Output definitions |
| `terraform.tfvars.example` | Example variable values |

## Customization

### Change VM Size

Edit `terraform.tfvars`:

```hcl
vm_size = "Standard_B2s"
```

Allowed sizes: `Standard_B1s`, `Standard_B1ms`, `Standard_B2s`, `Standard_B2ms`, `Standard_D2s_v3`

### Change Location

```hcl
location = "westus2"
```

### Add More Subnets

Add to `main.tf`:

```hcl
resource "azurerm_subnet" "database" {
  name                 = "${var.prefix}-${var.environment}-db-subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}
```

## Remote State (Optional)

To use Azure Storage for state:

1. Create storage account:

```bash
az group create --name tfstate-rg --location eastus
az storage account create --name tfstatestorage --resource-group tfstate-rg --sku Standard_LRS
az storage container create --name tfstate --account-name tfstatestorage
```

2. Uncomment backend in `providers.tf`:

```hcl
backend "azurerm" {
  resource_group_name  = "tfstate-rg"
  storage_account_name = "tfstatestorage"
  container_name       = "tfstate"
  key                  = "workshop.terraform.tfstate"
}
```

3. Reinitialize:

```bash
terraform init -reconfigure
```

## Troubleshooting

### Error: "Authorization failed"

```bash
az login
az account set --subscription "Your Subscription"
```

### Error: "VM size not available"

Check available sizes in your region:

```bash
az vm list-sizes --location eastus --output table
```

### Error: "Quota exceeded"

Request quota increase or use smaller VM size.

## Resources

- [Terraform Azure Provider Docs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Azure VM Sizes](https://docs.microsoft.com/en-us/azure/virtual-machines/sizes)
- [Terraform Best Practices](https://www.terraform.io/docs/cloud/guides/recommended-practices/)
