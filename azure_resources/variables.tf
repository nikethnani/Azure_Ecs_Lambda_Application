variable "location" {
  type = string
}

variable "resource_group_key_vault_name" {
  type = string
}

variable "key_vault_name" {
  type = string
}

variable "sku_name" {
  type = string
}

variable "key_vault_public_network_access_enabled" {
  type = bool
}

variable "key_vault_access_policies" {
  type = list(object({
    certificate_permissions = list(string),
    key_permissions         = list(string),
    secret_permissions      = list(string),
  }))
}

variable "network_subnet_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "network_resource_group_name" {
  type = string
}

variable "network_virtual_network_name" {
  type = string
}

variable "resource_group_recovery_vault_name" {
  type = string
}

variable "recovery_vault_name" {
  type = string
}

variable "recovery_vault_sku" {
  type = string
}

variable "recovery_vault_soft_delete_enabled" {
  type = bool
}

variable "vm_backup_policies" {
  type = list(object({
    name        = string
    policy_type = string
  }))
  default = []
}

variable "vm_backup_daily_retention" {
  type = object({
    count = number
  })
}

variable "resource_group_opndevops_name" {
  type        = string
  description = "Azure resource group that will be used"
}

variable "cluster_version" {
  type        = string
  description = "Cluster version used as prefix for resources"
  default     = "01"
}

variable "tags" {
  type        = map(any)
  description = "Azure resource tags"
  default = {
  }
}

variable "law_name" {
  type        = string
  description = "Specifies the name of the Log Analytics Workspace"
}

variable "law_diag_name" {
  type        = string
  description = "Specifies the name of log analytic diagnostic setting"
}

variable "law_sku" {
  type        = string
  description = "Specifies the Sku of the Log Analytics Workspace"
  default     = "PerGB2018"
  validation {
    condition     = contains(["Free", "PerNode", "Premium", "Standard", "Standalone", "Unlimited", "PerGB2018"], var.law_sku)
    error_message = "Must be Free, PerNode, Premium, Standard, Standalone, Unlimited, PerGB2018."
  }
}

variable "law_retention_in_days" {
  type        = number
  description = "Workspace data retention in days ( 30 to 730 )"
  default     = 30
  validation {
    condition     = var.law_retention_in_days >= 30 && var.law_retention_in_days <= 730
    error_message = "Must be a value between 30 to 730."
  }
}

variable "traffic_bypass" {
  description = "Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None."
  type        = list(string)
  default     = ["None"]
}

variable "acr_name" {
  description = "the name of azure containter registry"
  type        = string
}

variable "admin_enabled" {
  type        = bool
  description = "Specifies whether the admin user is enabled. Defaults to false"
  default     = false
}

variable "create_new_acr" {
  description = "Set to true to create a new ACR, false to skip creation if already exists."
  type        = bool
  default     = true
}

variable "data_collection_endpoint_name" {
  type        = string
  description = "Specifies the name of data collection name"
}

variable "polarion_vm" {

}

variable "jenkins_vm" {

}

variable "confluence_vm" {

}

variable "gitlab_vm" {

}

variable "jfrog_vm" {

}

variable "coverity_vm" {

}

variable "jira_vm" {

}