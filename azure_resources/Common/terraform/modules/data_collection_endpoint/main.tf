# Deploy the Azure data collection endpoint for monitoring linux virtual machines.
resource "azurerm_monitor_data_collection_endpoint" "dce" {
  name                          = var.data_collection_endpoint_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  public_network_access_enabled = true
  tags                          = var.tags
}
