output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.arg.name
}

output "resource_group_location" {
  description = "The location of the resource group"
  value       = azurerm_resource_group.arg.location
}

output "container_app_ids" {
  description = "The ID of the container app"
  value       = azurerm_container_app.ca[*].id
}
