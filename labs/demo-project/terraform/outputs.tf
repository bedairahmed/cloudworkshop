# ============================================================
# Outputs
# "What do we need to know after deployment?"
# ============================================================

output "resource_group_name" {
  description = "Resource group name"
  value       = azurerm_resource_group.main.name
}

output "app_url" {
  description = "Web application URL"
  value       = "https://${azurerm_linux_web_app.main.default_hostname}"
}

output "acr_login_server" {
  description = "ACR login server"
  value       = azurerm_container_registry.main.login_server
}

output "acr_name" {
  description = "ACR name"
  value       = azurerm_container_registry.main.name
}

output "app_service_name" {
  description = "App Service name"
  value       = azurerm_linux_web_app.main.name
}
