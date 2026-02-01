# ============================================================
# Input Variables
# "What can change between environments?"
# ============================================================

variable "project" {
  description = "Project name — used in resource naming"
  type        = string
  default     = "workshop"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "region" {
  description = "Azure region to deploy resources"
  type        = string
  default     = "eastus"
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "tags" {
  description = "Tags applied to all resources"
  type        = map(string)
  default     = {}
}

# ----- App Service -----

variable "app_service_sku" {
  description = "App Service Plan SKU (F1=Free, B1=Basic, S1=Standard)"
  type        = string
  default     = "F1"
}

variable "app_version" {
  description = "Application version to deploy"
  type        = string
  default     = "latest"
}

variable "app_port" {
  description = "Port the application listens on"
  type        = number
  default     = 8080
}

variable "always_on" {
  description = "Keep app always running (not on Free tier)"
  type        = bool
  default     = false
}

# ----- Container Registry -----

variable "acr_sku" {
  description = "ACR SKU (Basic, Standard, Premium)"
  type        = string
  default     = "Basic"
}

variable "acr_admin_enabled" {
  description = "Enable admin user for ACR"
  type        = bool
  default     = true
}

# ----- Scaling -----

variable "min_instance_count" {
  description = "Minimum app instances"
  type        = number
  default     = 1
}

variable "max_instance_count" {
  description = "Maximum app instances"
  type        = number
  default     = 1
}
