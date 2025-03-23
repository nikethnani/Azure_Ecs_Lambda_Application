# Azure Key Vault
output "resource_group_name_vault" {
  description = "The name of the resource group"
  value       = module.key_vault.resource_group_name
}

output "azurerm_key_vault_name" {
  description = "The name of the Key Vault, used for performing operations on keys and secrets."
  value       = module.key_vault.azurerm_key_vault_name
}

output "azurerm_key_vault_id" {
  description = "The id of the Key Vault, used for performing operations on keys and secrets."
  value       = module.key_vault.azurerm_key_vault_id
}

output "key_vault_uri" {
  description = "The URI of the Key Vault, used for performing operations on keys and secrets."
  value       = module.key_vault.key_vault_uri
}

output "resource_group_name_recovery_vault" {
  description = "The name of the resource group"
  value       = module.recovery_vault.resource_group_name
}

output "azurerm_recovery_vault_name" {
  description = "The name of the Recovery Service Vault, used for performing operations on keys and secrets."
  value       = module.recovery_vault.azurerm_recovery_vault_name
}

output "azurerm_recovery_vault_id" {
  description = "The id of the Recovery Service Vault, used for performing operations on keys and secrets."
  value       = module.recovery_vault.azurerm_recovery_vault_id
}
