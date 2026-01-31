# Terraform Variables
# File: variables.tf

# ============================================
# GENERAL VARIABLES
# ============================================
variable "prefix" {
  description = "Prefix for all resource names"
  type        = string
  default     = "workshop"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "eastus"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "Development"
    Project     = "Workshop"
    ManagedBy   = "Terraform"
  }
}

# ============================================
# NETWORK VARIABLES
# ============================================
variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_address_prefix" {
  description = "Address prefix for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}

# ============================================
# VM VARIABLES
# ============================================
variable "vm_size" {
  description = "Size of the virtual machine"
  type        = string
  default     = "Standard_B1s"

  validation {
    condition = contains([
      "Standard_B1s",
      "Standard_B1ms",
      "Standard_B2s",
      "Standard_B2ms",
      "Standard_D2s_v3"
    ], var.vm_size)
    error_message = "VM size must be one of the allowed sizes."
  }
}

variable "admin_username" {
  description = "Administrator username for the VM"
  type        = string
  default     = "azureuser"
}

variable "admin_password" {
  description = "Administrator password for the VM"
  type        = string
  sensitive   = true
}

# ============================================
# OPTIONAL: AUTHENTICATION VARIABLES
# ============================================
# Uncomment if not using Azure CLI authentication

# variable "subscription_id" {
#   description = "Azure subscription ID"
#   type        = string
# }

# variable "tenant_id" {
#   description = "Azure tenant ID"
#   type        = string
# }

# variable "client_id" {
#   description = "Azure service principal client ID"
#   type        = string
# }

# variable "client_secret" {
#   description = "Azure service principal client secret"
#   type        = string
#   sensitive   = true
# }
