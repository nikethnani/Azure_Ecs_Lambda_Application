output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.arg.name
}

output "azurerm_recovery_vault_name" {
  description = "The name of the Recovery Service Vault, used for performing operations on key and secrets."
  value       = azurerm_recovery_services_vault.arsv.name
}

output "azurerm_recovery_vault_id" {
  description = "The id of the Recovery Service Vault, used for performing operations on key and secrets."
  value       = azurerm_recovery_services_vault.arsv.id
}
