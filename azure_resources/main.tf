# Azure key vault
module "key_vault" {
  source                                  = "../common/terraform/modules/key_vault"
  location                                = var.location
  resource_group_key_vault_name           = var.resource_group_key_vault_name
  key_vault_name                          = var.key_vault_name
  sku_name                                = var.sku_name
  key_vault_public_network_access_enabled = var.key_vault_public_network_access_enabled
  key_vault_access_policies               = var.key_vault_access_policies
  network_subnet_name                     = var.network_subnet_name
  network_resource_group_name             = var.network_resource_group_name
  network_virtual_network_name            = var.network_virtual_network_name
  tags                                    = var.tags
}

# Azure Recovery Services Vault
module "recovery_vault" {
  source                             = "../common/terraform/modules/recovery_service_vault"
  location                           = var.location
  resource_group_recovery_vault_name = var.resource_group_recovery_vault_name
  recovery_vault_name                = var.recovery_vault_name
  recovery_vault_sku                 = var.recovery_vault_sku
  recovery_vault_soft_delete_enabled = var.recovery_vault_soft_delete_enabled
  vm_backup_policies                 = var.vm_backup_policies        # backup custom policy
  vm_backup_daily_retention          = var.vm_backup_daily_retention # backup custom policy
  tags                               = var.tags
}

# -
# - Log Analytics Workspace
# -
module "law-posh-weu-01" {
  source                = "../common/terraform/modules/log_analytics"
  law_name              = var.law_name
  law_diag_name         = var.law_diag_name
  location              = var.location
  resource_group_name   = var.resource_group_opndevops_name
  law_sku               = var.law_sku
  law_retention_in_days = var.law_retention_in_days
  tags                  = var.tags
}

# Azure Container Registry
module "azure_container_registry" {
  source              = "../common/terraform/modules/container_registry"
  create_new_acr      = var.create_new_acr
  name                = var.acr_name
  location            = var.location
  resource_group_name = var.resource_group_opndevops_name
  admin_enabled       = var.admin_enabled
  tags                = var.tags
}

module "data_collection_endpoint" {
  source                        = "../common/terraform/modules/data_collection_endpoint"
  location                      = var.location
  resource_group_name           = var.resource_group_opndevops_name
  data_collection_endpoint_name = var.data_collection_endpoint_name
  tags                          = var.tags
}

module "monitor_alert_rule" {
  source                                  = "../common/terraform/modules/monitor_alert_rules"
  location                                = var.location
  resource_group_monitor_alert_rules_name = var.resource_group_opndevops_name
  vms_id = [
    #data.azurerm_virtual_machine.confluence_vm.id,
    #data.azurerm_virtual_machine.coverity_vm.id,
    data.azurerm_virtual_machine.gitlab_vm.id,
    data.azurerm_virtual_machine.jenkins_vm.id,
    data.azurerm_virtual_machine.jfrog_vm.id,
    data.azurerm_virtual_machine.polarion_vm.id,
    #data.azurerm_virtual_machine.jira_vm.id
  ]
}
