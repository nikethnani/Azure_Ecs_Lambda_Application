resource "azurerm_resource_group" "arg" {
  name     = var.container_app_resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_log_analytics_workspace" "law" {
  name                = var.law_name
  location            = azurerm_resource_group.arg.location
  resource_group_name = azurerm_resource_group.arg.name
  sku                 = var.law_sku
  retention_in_days   = var.law_retention_in_days
}

resource "azurerm_container_app_environment" "cae" {
  name                       = var.container_app_environment_name
  location                   = azurerm_resource_group.arg.location
  resource_group_name        = azurerm_resource_group.arg.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id
}

resource "azurerm_container_app" "ca" {
  for_each                     = var.container_app_template
  name                         = each.key
  container_app_environment_id = azurerm_container_app_environment.cae.id
  resource_group_name          = azurerm_resource_group.arg.name
  revision_mode                = var.container_app_revision_mode

  template {
    container {
      name   = each.value.container.name
      image  = "${data.azurerm_container_registry.acr.login_server}/${each.value.container.image}:latest"
      cpu    = each.value.container.cpu
      memory = each.value.container.memory

      dynamic "env" {
        for_each = var.container_app_env_vars
        content {
          name  = env.value
          value = data.azurerm_key_vault_secret.app_env_vars[env.value].value
        }
      }
    }
  }
}
