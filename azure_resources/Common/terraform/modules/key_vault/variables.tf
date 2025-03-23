variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created"
  default     = "westeurope"
}

variable "resource_group_key_vault_name" {
  type        = string
  description = "The name of the resource group in which to create the Key Vault. Changing this forces a new resource to be created"
  default     = ""
}

variable "key_vault_name" {
  type        = string
  description = "The name of the key vault to be created. The value will be randomly generated if blank."
  default     = ""
}

variable "sku_name" {
  type        = string
  description = "The Name of the SKU used for this Key Vault. Possible values are standard and premium"
  default     = "standard"
  validation {
    condition     = contains(["standard", "premium"], var.sku_name)
    error_message = "The sku_name must be one of the following: standard, premium."
  }
}

variable "key_vault_enabled_for_deployment" {
  type        = bool
  description = "Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault"
  default     = true
}

variable "key_vault_enabled_for_disk_encryption" {
  type        = bool
  description = "Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys"
  default     = true
}

variable "key_vault_enabled_for_template_deployment" {
  type        = bool
  description = "Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault"
  default     = true
}

variable "key_vault_enable_rbac_authorization" {
  type        = bool
  description = "Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions"
  default     = false
}

variable "key_vault_purge_protection_enabled" {
  type        = bool
  description = "Is Purge Protection enabled for this Key Vault?"
  default     = true
}

variable "key_vault_public_network_access_enabled" {
  type        = bool
  description = "Whether public network access is allowed for this Key Vault. Defaults to true"
  default     = true
}

variable "key_vault_soft_delete_retention_days" {
  type        = number
  description = "It can be configured to between 7 to 90 days. Once it has been set, it cannot be changed or removed. The value will be randomly generated if blank."
  default     = 7
}

variable "key_vault_network_acls" {
  type = object({
    bypass                     = string,
    default_action             = string,
    ip_rules                   = optional(list(string)),
    virtual_network_subnet_ids = optional(list(string)),
  })
  description = "Network rules to apply to key vault."
  default     = null
}

variable "key_vault_certificate_contacts" {
  description = "Contact information to send notifications triggered by certificate lifetime events"
  type = list(object({
    email = string
    name  = optional(string)
    phone = optional(string)
  }))
  default = []
}

variable "key_vault_access_policies" {
  description = "Map of access policies for an object_id (user, service principal, security group) to backend."
  type = list(object({
    certificate_permissions = list(string),
    key_permissions         = list(string),
    secret_permissions      = list(string),
  }))
  default = []
}

variable "network_subnet_name" {
  type = string
}

variable "network_resource_group_name" {
  type = string
}

variable "network_virtual_network_name" {
  type = string
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources created."
  default     = {}
}
