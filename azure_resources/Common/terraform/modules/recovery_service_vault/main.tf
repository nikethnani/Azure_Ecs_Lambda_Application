# Resource group for azure recovery service vault
resource "azurerm_resource_group" "arg" {
  name     = var.resource_group_recovery_vault_name
  location = var.location
  tags     = var.tags
}

# Azure recovery service vault
resource "azurerm_recovery_services_vault" "arsv" {
  name                               = var.recovery_vault_name
  location                           = azurerm_resource_group.arg.location
  resource_group_name                = azurerm_resource_group.arg.name
  sku                                = var.recovery_vault_sku
  storage_mode_type                  = var.recovery_vault_storage_mode_type
  cross_region_restore_enabled       = var.recovery_vault_cross_region_restore_enabled
  soft_delete_enabled                = var.recovery_vault_soft_delete_enabled
  public_network_access_enabled      = var.recovery_vault_public_network_access_enabled
  immutability                       = var.recovery_vault_immutability
  classic_vmware_replication_enabled = var.recovery_vault_classic_vmware_replication_enabled

  dynamic "identity" {
    for_each = toset(var.recovery_vault_identity_type != null ? ["_"] : [])
    content {
      type = var.recovery_vault_identity_type
    }
  }

  monitoring {
    alerts_for_all_job_failures_enabled            = true
    alerts_for_critical_operation_failures_enabled = true
  }

  tags = var.tags
}

resource "azurerm_backup_policy_vm" "name" {
  count                          = length(var.vm_backup_policies)
  name                           = var.vm_backup_policies[count.index].name
  resource_group_name            = azurerm_resource_group.arg.name
  recovery_vault_name            = azurerm_recovery_services_vault.arsv.name
  policy_type                    = var.vm_backup_policies[count.index].policy_type
  instant_restore_retention_days = 7

  timezone = var.vm_backup_policy_timezone

  backup {
    frequency = var.vm_backup_policy.frequency
    time      = var.vm_backup_policy.time
  }

  dynamic "retention_daily" {
    for_each = var.vm_backup_policy == null ? {} : tomap(var.vm_backup_daily_retention)
    content {
      count = var.vm_backup_daily_retention.count
    }
  }

  dynamic "retention_weekly" {
    for_each = var.vm_backup_weekly_retention == null ? {} : tomap(var.vm_backup_weekly_retention)
    content {
      count    = var.vm_backup_weekly_retention.count
      weekdays = var.vm_backup_weekly_retention.weekdays
    }
  }

  dynamic "retention_monthly" {
    for_each = var.vm_backup_monthly_retention == null ? {} : tomap(var.vm_backup_monthly_retention)
    content {
      count    = var.vm_backup_monthly_retention.count
      weekdays = var.vm_backup_monthly_retention.weekdays
      weeks    = var.vm_backup_monthly_retention.weeks
    }
  }

  dynamic "retention_yearly" {
    for_each = var.vm_backup_yearly_retention == null ? {} : tomap(var.vm_backup_yearly_retention)
    content {
      count    = var.vm_backup_yearly_retention.count
      weekdays = var.vm_backup_yearly_retention.weekdays
      weeks    = var.vm_backup_yearly_retention.weeks
      months   = var.vm_backup_yearly_retention.months
    }
  }
}
