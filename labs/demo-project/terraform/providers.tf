# ============================================================
# Provider Configuration
# "Which cloud are we talking to?"
# ============================================================

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  # Remote backend — stores state in Azure Storage (uncomment for real use)
  # backend "azurerm" {
  #   resource_group_name  = "rg-terraform-state"
  #   storage_account_name = "stterraformstate"
  #   container_name       = "tfstate"
  #   key                  = "demo-project.tfstate"
  # }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}
