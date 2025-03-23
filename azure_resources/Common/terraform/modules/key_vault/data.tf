data "azurerm_client_config" "current" {}

data "azurerm_subnet" "as" {
  name                 = var.network_subnet_name
  resource_group_name  = var.network_resource_group_name
  virtual_network_name = var.network_virtual_network_name
}
