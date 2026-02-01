# ============================================================
# Main Resource Definitions
# "What cloud resources do we want?"
#
#   1. Resource Group     — Container for all resources
#   2. Container Registry — Stores our Docker images
#   3. App Service Plan   — The compute (CPU/RAM)
#   4. App Service        — The web app
# ============================================================

locals {
  region_short = {
    "eastus"        = "eus"
    "eastus2"       = "eus2"
    "westus"        = "wus"
    "canadacentral" = "cc"
  }

  region_abbr = lookup(local.region_short, var.region, "eus")
  name_prefix = "${var.project}-${var.environment}-${local.region_abbr}"

  common_tags = merge(var.tags, {
    project     = var.project
    environment = var.environment
    managed_by  = "terraform"
  })
}

# ---- 1. Resource Group ----

resource "azurerm_resource_group" "main" {
  name     = "rg-${local.name_prefix}"
  location = var.region
  tags     = local.common_tags
}

# ---- 2. Azure Container Registry ----

resource "azurerm_container_registry" "main" {
  name                = "acr${var.project}${var.environment}${local.region_abbr}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = var.acr_sku
  admin_enabled       = var.acr_admin_enabled
  tags                = local.common_tags
}

# ---- 3. App Service Plan ----

resource "azurerm_service_plan" "main" {
  name                = "asp-${local.name_prefix}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  os_type             = "Linux"
  sku_name            = var.app_service_sku
  tags                = local.common_tags
}

# ---- 4. App Service (Web App) ----

resource "azurerm_linux_web_app" "main" {
  name                = "app-${local.name_prefix}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  service_plan_id     = azurerm_service_plan.main.id
  tags                = local.common_tags

  site_config {
    always_on = var.always_on

    application_stack {
      docker_registry_url      = "https://${azurerm_container_registry.main.login_server}"
      docker_registry_username = azurerm_container_registry.main.admin_username
      docker_registry_password = azurerm_container_registry.main.admin_password
      docker_image_name        = "${var.project}-app:${var.app_version}"
    }

    health_check_path = "/health"
  }

  app_settings = {
    "APP_VERSION"                    = var.app_version
    "APP_ENV"                        = var.environment
    "APP_PORT"                       = tostring(var.app_port)
    "WEBSITES_PORT"                  = tostring(var.app_port)
    "DOCKER_REGISTRY_SERVER_URL"     = "https://${azurerm_container_registry.main.login_server}"
    "DOCKER_REGISTRY_SERVER_USERNAME" = azurerm_container_registry.main.admin_username
    "DOCKER_REGISTRY_SERVER_PASSWORD" = azurerm_container_registry.main.admin_password
  }
}
