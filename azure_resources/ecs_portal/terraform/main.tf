# Azure Container App for Portal Containers
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

resource "azurerm_resource_group" "DEVRG" {
  name     = "RG-POSH-WEU-OPnPORTAL-DEV-01"
  location = "westeurope"
}

resource "azurerm_resource_group" "PORTALRG" {
  name     = "RG-POSH-WEU-OPnPORTAL-DEV-01"
  location = "westeurope"
}
}
resource "azurerm_virtual_network" "nodejs" {
  name                = "nodejs-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.DEVRG.location
  resource_group_name = azurerm_resource_group.DEVRG.name
}

resource "azurerm_subnet" "public_subnet" {
  name                 = "nodejs-public_subnet"
  resource_group_name  = azurerm_resource_group.DEVRG.name
  virtual_network_name = azurerm_virtual_network.nodejs.name
  address_prefixes     = ["10.0.1.0/24"]

}

resource "azurerm_subnet" "private_subenet" {
  name                 = "nodejs-public_subnet"
  resource_group_name  = azurerm_resource_group.DEVRG.name
  virtual_network_name = azurerm_virtual_network.nodejs.name
  address_prefixes     = ["10.0.2.0/24"]

}

resource "azurerm_network_security_group" "example" {
  name                = "Nodejs_SecurityGroup"
  location            = azurerm_resource_group.DEVRG.location
  resource_group_name = azurerm_resource_group.DEVRG.name

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Production"
  }
}