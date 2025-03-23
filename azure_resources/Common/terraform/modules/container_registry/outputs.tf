output "registry_url" {
  description = "The registry url"
  value       = var.create_new_acr ? azurerm_container_registry.acr[0].login_server : data.azurerm_container_registry.acr.login_server
}
