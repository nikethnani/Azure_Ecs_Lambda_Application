resource "azurerm_postgresql_server" "aps" {
  name                = var.postgresql_server_name
  location            = var.location
  resource_group_name = var.resource_group_name

  administrator_login          = data.azurerm_key_vault_secret.pg_usr.value
  administrator_login_password = data.azurerm_key_vault_secret.pg_pwd.value
  version                      = var.postgresql_version
  sku_name                     = var.postgresql_sku_name
  storage_mb                   = var.postgresql_storage_mb

  backup_retention_days        = 30
  geo_redundant_backup_enabled = var.postgresql_geo_redundant_backup_enabled

  public_network_access_enabled = false
  ssl_enforcement_enabled       = true

  tags = var.tags
}

resource "azurerm_postgresql_database" "apd" {
  name                = var.postgresql_database_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.aps.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}

resource "azurerm_postgresql_firewall_rule" "apfr" {
  name                = var.postgresql_firewall_rule.name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.aps.name
  start_ip_address    = var.postgresql_firewall_rule.start_ip_address
  end_ip_address      = var.postgresql_firewall_rule.end_ip_address
}
