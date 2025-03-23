variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created"
  default     = "westeurope"
}

variable "resource_group_recovery_vault_name" {
  type        = string
  description = "The name of the resource group in which to create the Recovery Service Vault. Changing this forces a new resource to be created"
  default     = ""
}

variable "vm_backup_policies" {
  type = list(object({
    name        = string
    policy_type = string
  }))
  default = []
}

variable "recovery_vault_name" {
  type        = string
  description = "The name of the Recovery Service Vault. Changing this forces a new resource to be created"
  default     = ""
}

variable "recovery_vault_sku" {
  type        = string
  description = "The Name of the SKU used for this Recovery Service Vault. Possible values are Standard and RS0"
  default     = "Standard"
  validation {
    condition     = contains(["RS0", "Standard"], var.recovery_vault_sku)
    error_message = "The recovery_vault_sku must be one of the following: Standard, RS0."
  }
}

variable "recovery_vault_soft_delete_enabled" {
  type        = bool
  description = "Is soft delete enable for this Vault?"
  default     = true
}

variable "recovery_vault_identity_type" {
  description = "Azure Recovery Vault identity type. Possible values include: `null`, `SystemAssigned`. Default to `SystemAssigned`."
  type        = string
  default     = "SystemAssigned"
}

variable "recovery_vault_storage_mode_type" {
  description = "The storage type of the Recovery Services Vault. Possible values are `GeoRedundant`, `LocallyRedundant` and `ZoneRedundant`. Defaults to `GeoRedundant`."
  type        = string
  default     = "GeoRedundant"
}

variable "recovery_vault_cross_region_restore_enabled" {
  description = "Is cross region restore enabled for this Vault? Only can be `true`, when `storage_mode_type` is `GeoRedundant`. Defaults to `false`."
  type        = bool
  default     = false
}

variable "recovery_vault_public_network_access_enabled" {
  type        = bool
  description = "Is it enabled to access the vault from public networks"
  default     = true
}

variable "recovery_vault_immutability" {
  description = "Immutability Settings of vault, possible values include: Locked, Unlocked and Disabled"
  type        = string
  default     = null
}

variable "recovery_vault_classic_vmware_replication_enabled" {
  type        = bool
  description = "Whether to enable the Classic experience for VMware replication. If set to false VMware machines will be protected using the new stateless ASR replication appliance. Changing this forces a new resource to be created."
  default     = null
}

variable "vm_backup_policy_name" {
  description = "The name of the resources to create."
  type        = string
  default     = ""
}

variable "vm_backup_policy_timezone" {
  description = "Specifies the timezone for VM backup schedules. Defaults to `UTC`."
  type        = string
  default     = "UTC"
}

variable "vm_backup_policy" {
  description = "Configures the Policy backup frequency, times & days as documented in the backup block below."
  type = object({
    frequency = string
    time      = string
  })
  default = {
    frequency = "Daily"
    time      = "23:00"
  }
}

variable "vm_backup_daily_retention" {
  description = "Configures the policy daily retention. Required when backup frequency is Daily. Must be between 7 and 9999."
  type = object({
    count = number
  })
  default = null
}

variable "vm_backup_weekly_retention" {
  description = "Map to configure the weekly VM backup policy retention according to https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_policy_vm#retention_weekly"
  type = object({
    count    = number,
    weekdays = list(string),
  })
  default = null
}

variable "vm_backup_monthly_retention" {
  description = "Map to configure the monthly VM backup policy retention according to https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_policy_vm#retention_monthly"
  type = object({
    count    = number,
    weekdays = list(string),
    weeks    = list(string),
  })
  default = null
}

variable "vm_backup_yearly_retention" {
  description = "Map to configure the yearly VM backup policy retention according to https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_policy_vm#retention_yearly"
  type = object({
    count    = number,
    weekdays = list(string),
    weeks    = list(string),
    months   = list(string),
  })
  default = null
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources created."
  default     = {}
}
