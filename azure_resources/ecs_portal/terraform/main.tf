# Azure Container App for Portal Containers
module "container_app" {
  source                                 = "../../../common/terraform/modules/container_app"
  location                               = var.location
  container_registry_name                = var.container_registry_name
  container_registry_resource_group_name = var.container_registry_resource_group_name
  container_app_resource_group_name      = var.container_app_resource_group_name
  container_app_environment_name         = var.container_app_environment_name
  container_app_revision_mode            = var.container_app_revision_mode
  container_app_template                 = var.container_app_template
  container_app_env_vars                 = var.container_app_env_vars
  app_env_key_vault_name                 = var.app_env_key_vault_name
  key_vault_resource_group_name          = var.key_vault_resource_group_name
  tags                                   = var.tags
}

module "container_app" {
  source              = "../../../common/terraform/modules/container_app"
  count               = var.create_new_acr ? 1 : 0
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  admin_enabled       = var.admin_enabled
  tags                = var.tags
}
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
