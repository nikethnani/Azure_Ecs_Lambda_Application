data "azurerm_key_vault" "akv" {
  name                = var.pg_credential_key_vault_name
  resource_group_name = var.key_vault_resource_group_name
}

data "azurerm_key_vault_secret" "pg_usr" {
  name         = var.postgres_username
  key_vault_id = data.azurerm_key_vault.akv.id
}

data "azurerm_key_vault_secret" "pg_pwd" {
  name         = var.postgres_password
  key_vault_id = data.azurerm_key_vault.akv.id
}
