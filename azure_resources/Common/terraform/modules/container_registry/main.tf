# Resource group for azure container registry
resource "azurerm_container_registry" "acr" {
  count               = var.create_new_acr ? 1 : 0
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  admin_enabled       = var.admin_enabled
  tags                = var.tags
}
