# Terraform Variables File (Example)
# File: terraform.tfvars.example
#
# Copy this file to terraform.tfvars and update values:
# cp terraform.tfvars.example terraform.tfvars

# ============================================
# GENERAL SETTINGS
# ============================================
prefix      = "workshop"
environment = "dev"
location    = "eastus"

tags = {
  Environment = "Development"
  Project     = "CloudWorkshop"
  Owner       = "YourName"
  ManagedBy   = "Terraform"
}

# ============================================
# NETWORK SETTINGS
# ============================================
vnet_address_space    = "10.0.0.0/16"
subnet_address_prefix = "10.0.1.0/24"

# ============================================
# VM SETTINGS
# ============================================
vm_size        = "Standard_B1s"
admin_username = "azureuser"
admin_password = "YourSecurePassword123!"  # Change this!

# ============================================
# OPTIONAL: AZURE AUTHENTICATION
# ============================================
# Uncomment if using service principal instead of Azure CLI

# subscription_id = "00000000-0000-0000-0000-000000000000"
# tenant_id       = "00000000-0000-0000-0000-000000000000"
# client_id       = "00000000-0000-0000-0000-000000000000"
# client_secret   = "your-client-secret"
