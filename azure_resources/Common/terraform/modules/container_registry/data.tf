data "azurerm_client_config" "current" {}

data "azurerm_container_registry" "acr" {
  name                = "opndevopsimages"
  resource_group_name = "RG-POSH-WEU-OPnDevOps-DEV-01"
}
