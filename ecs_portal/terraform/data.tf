data "azurerm_client_config" "current" {}

# data "azurerm_subnet" "as" {
#   name                 = var.network_subnet_name
#   resource_group_name  = var.network_resource_group_name
#   virtual_network_name = var.network_virtual_network_name
# }

locals {
  # Automatically set account tier for BlockBlobStorage/FileStorage if not specified.
  #   Not correcting incompatible type if specified to prevent user misunderstanding.
  account_tier   = var.account_kind == "BlockBlobStorage" || var.account_kind == "FileStorage" ? "Premium" : "Standard"
  is_hns_enabled = var.account_kind == "BlockBlobStorage" ? true : false
}
