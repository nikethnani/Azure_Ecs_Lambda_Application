output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.arg.name
}

output "azurerm_key_vault_name" {
  description = "The name of the Key Vault, used for performing operations on keys and secrets."
  value       = azurerm_key_vault.akv.name
}

output "azurerm_key_vault_id" {
  description = "The id of the Key Vault, used for performing operations on keys and secrets."
  value       = azurerm_key_vault.akv.id
}

output "key_vault_uri" {
  description = "The URI of the Key Vault, used for performing operations on keys and secrets."
  value       = azurerm_key_vault.akv.vault_uri
}
