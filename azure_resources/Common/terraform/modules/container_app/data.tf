data "azurerm_container_registry" "acr" {
  name                = var.container_registry_name
  resource_group_name = var.container_registry_resource_group_name
}

data "azurerm_key_vault" "akv" {
  name                = var.app_env_key_vault_name
  resource_group_name = var.key_vault_resource_group_name
}

data "azurerm_key_vault_secret" "app_env_vars" {
  for_each     = var.container_app_env_vars
  name         = each.value
  key_vault_id = data.azurerm_key_vault.akv.id
}
