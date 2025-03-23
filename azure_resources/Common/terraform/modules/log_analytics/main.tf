# Resource group for azure recovery service vault
resource "azurerm_resource_group" "arg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}


locals {
  law_solution_name = toset(var.law_solution_names)
}

resource "azurerm_log_analytics_workspace" "law" {
  name                = var.law_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.law_sku
  retention_in_days   = var.law_retention_in_days
  tags                = merge(var.tags, {})
}

resource "azurerm_monitor_diagnostic_setting" "law" {
  name                       = var.law_diag_name
  target_resource_id         = azurerm_log_analytics_workspace.law.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id

  metric {
    category = "AllMetrics"
  }
}

resource "azurerm_log_analytics_solution" "solutions" {
  for_each              = local.law_solution_name
  solution_name         = each.key
  location              = var.location
  resource_group_name   = var.resource_group_name
  workspace_resource_id = azurerm_log_analytics_workspace.law.id
  workspace_name        = azurerm_log_analytics_workspace.law.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/${each.key}"
  }
}
