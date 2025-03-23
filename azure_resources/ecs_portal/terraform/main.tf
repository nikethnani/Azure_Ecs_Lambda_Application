# Azure Container App for Portal Containers
module "container_app" {
  source                                 = "../../../common/terraform/modules/container_app"
  location                               = var.location
  container_registry_name                = var.container_registry_name
  container_registry_resource_group_name = var.container_registry_resource_group_name
  container_app_resource_group_name      = var.container_app_resource_group_name
  law_name                               = var.law_name
  law_sku                                = var.law_sku
  law_retention_in_days                  = var.law_retention_in_days
  container_app_environment_name         = var.container_app_environment_name
  container_app_revision_mode            = var.container_app_revision_mode
  container_app_template                 = var.container_app_template
  container_app_env_vars                 = var.container_app_env_vars
  app_env_key_vault_name                 = var.app_env_key_vault_name
  key_vault_resource_group_name          = var.key_vault_resource_group_name
  tags                                   = var.tags
}

# Key Vault to store toolchain's credentials
#resource "azurerm_key_vault" "akv" {
#  name                            = var.key_vault_name
#  location                        = module.container_app.resource_group_location
#  resource_group_name             = module.container_app.resource_group_name
#  tenant_id                       = data.azurerm_client_config.current.tenant_id
#  sku_name                        = var.sku_name
#  enabled_for_deployment          = var.key_vault_enabled_for_deployment
#  enabled_for_disk_encryption     = var.key_vault_enabled_for_disk_encryption
#  enabled_for_template_deployment = var.key_vault_enabled_for_template_deployment
#  enable_rbac_authorization       = var.key_vault_enable_rbac_authorization
#  purge_protection_enabled        = var.key_vault_purge_protection_enabled
#  public_network_access_enabled   = var.key_vault_public_network_access_enabled
#  soft_delete_retention_days      = var.key_vault_soft_delete_retention_days
#
#  dynamic "network_acls" {
#    for_each = var.key_vault_network_acls != null ? [true] : []
#    content {
#      bypass                     = var.key_vault_network_acls.bypass
#      default_action             = var.key_vault_network_acls.default_action
#      ip_rules                   = var.key_vault_network_acls.ip_rules
#      virtual_network_subnet_ids = [data.azurerm_subnet.as.id]
#    }
#  }
#
#  dynamic "contact" {
#    for_each = var.key_vault_certificate_contacts
#    content {
#      email = contact.value.email
#      name  = contact.value.name
#      phone = contact.value.phone
#    }
#  }
#
#  tags = var.tags
#}
#
#resource "azurerm_key_vault_access_policy" "akvap" {
#  count        = length(var.key_vault_access_policies)
#  key_vault_id = azurerm_key_vault.akv.id
#
#  tenant_id = data.azurerm_client_config.current.tenant_id
#  object_id = data.azurerm_client_config.current.object_id
#
#  secret_permissions      = var.key_vault_access_policies[count.index].secret_permissions
#  key_permissions         = var.key_vault_access_policies[count.index].key_permissions
#  certificate_permissions = var.key_vault_access_policies[count.index].certificate_permissions
#}

# Storage Account to store Portal's documents
resource "azurerm_storage_account" "sa" {
  name                     = var.storage_account_name
  location                 = var.localtion
  resource_group_name      = module.container_app.container_app_resource_group_name
  account_kind             = var.account_kind
  account_tier             = local.account_tier
  account_replication_type = var.replication_type
  access_tier              = var.access_tier
  tags                     = var.tags

  is_hns_enabled                    = local.is_hns_enabled
  sftp_enabled                      = local.is_hns_enabled == true ? true : false
  allow_nested_items_to_be_public   = false
  https_traffic_only_enabled        = false
  public_network_access_enabled     = false
  infrastructure_encryption_enabled = true
  default_to_oauth_authentication   = true

  identity {
    type = "SystemAssigned"
  }

  dynamic "blob_properties" {
    for_each = ((var.account_kind == "BlockBlobStorage" || var.account_kind == "StorageV2") ? [1] : [])
    content {
      versioning_enabled = true

      delete_retention_policy {
        days = 1
      }

      container_delete_retention_policy {
        days = 1
      }

      dynamic "cors_rule" {
        for_each = (var.blob_cors == null ? {} : var.blob_cors)
        content {
          allowed_headers    = cors_rule.value.allowed_headers
          allowed_methods    = cors_rule.value.allowed_methods
          allowed_origins    = cors_rule.value.allowed_origins
          exposed_headers    = cors_rule.value.exposed_headers
          max_age_in_seconds = cors_rule.value.max_age_in_seconds
        }
      }
    }
  }
}

# Postgres Database for Portal
module "postgres" {
  source                                  = "../../../common/terraform/modules/postgresql"
  location                                = module.container_app.location
  resource_group_name                     = module.container_app.container_app_resource_group_name
  pg_credential_key_vault_name            = var.pg_credential_key_vault_name
  key_vault_resource_group_name           = var.key_vault_resource_group_name
  postgres_username                       = var.postgres_username
  postgres_password                       = var.postgres_password
  postgresql_server_name                  = var.postgresql_server_name
  postgresql_sku_name                     = var.postgresql_sku_name
  postgresql_version                      = var.postgresql_version
  postgresql_storage_mb                   = var.postgresql_storage_mb
  postgresql_geo_redundant_backup_enabled = var.postgresql_geo_redundant_backup_enabled
  postgresql_database_name                = var.postgresql_database_name
  postgresql_firewall_rule                = var.postgresql_firewall_rule
  tags                                    = var.tags
}
