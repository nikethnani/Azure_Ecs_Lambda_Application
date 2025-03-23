# Resource group for azure key vault
resource "azurerm_resource_group" "arg" {
  name     = var.resource_group_key_vault_name
  location = var.location
  tags     = var.tags
}

# Azure key vault
resource "azurerm_key_vault" "akv" {
  name                            = var.key_vault_name
  location                        = azurerm_resource_group.arg.location
  resource_group_name             = azurerm_resource_group.arg.name
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  sku_name                        = var.sku_name
  enabled_for_deployment          = var.key_vault_enabled_for_deployment
  enabled_for_disk_encryption     = var.key_vault_enabled_for_disk_encryption
  enabled_for_template_deployment = var.key_vault_enabled_for_template_deployment
  enable_rbac_authorization       = var.key_vault_enable_rbac_authorization
  purge_protection_enabled        = var.key_vault_purge_protection_enabled
  public_network_access_enabled   = var.key_vault_public_network_access_enabled
  soft_delete_retention_days      = var.key_vault_soft_delete_retention_days

  dynamic "network_acls" {
    for_each = var.key_vault_network_acls != null ? [true] : []
    content {
      bypass                     = var.key_vault_network_acls.bypass
      default_action             = var.key_vault_network_acls.default_action
      ip_rules                   = var.key_vault_network_acls.ip_rules
      virtual_network_subnet_ids = [data.azurerm_subnet.as.id]
    }
  }

  dynamic "contact" {
    for_each = var.key_vault_certificate_contacts
    content {
      email = contact.value.email
      name  = contact.value.name
      phone = contact.value.phone
    }
  }

  tags = var.tags
}

resource "azurerm_key_vault_access_policy" "akvap" {
  count        = length(var.key_vault_access_policies)
  key_vault_id = azurerm_key_vault.akv.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_client_config.current.object_id

  secret_permissions      = var.key_vault_access_policies[count.index].secret_permissions
  key_permissions         = var.key_vault_access_policies[count.index].key_permissions
  certificate_permissions = var.key_vault_access_policies[count.index].certificate_permissions
}
