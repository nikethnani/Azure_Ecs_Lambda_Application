variable "location" {
  description = "Specifies the supported Azure location to MySQL server resource"
  type        = string
}

variable "container_registry_name" {
  description = "Container registry name"
  type        = string
}

variable "container_registry_resource_group_name" {
  description = "name of the resource group of the container registry"
  type        = string
}

variable "container_app_resource_group_name" {
  description = "name of the resource group to create the resource"
  type        = string
}

variable "key_vault_resource_group_name" {
  description = "The name of the resource group where the Key Vault is located"
  type        = string
}

variable "tags" {
  description = "tags to be applied to resources"
  type        = map(string)
}

variable "law_name" {
  description = "log analytic workspace name"
}

variable "law_retention_in_days" {
  description = "Workspace data retention in days ( 30 to 730 )"
  default     = 30
}

variable "law_sku" {
  description = "Specifies the Sku of the Log Analytics Workspace"
  default     = "PerGB2018"
}

variable "container_app_environment_name" {
  description = "Container app environment name"
  type        = string
}

variable "container_app_revision_mode" {
  description = "Specifies the revision mode of the container app"
  type        = string
  default     = "Single"
}

variable "container_app_template" {
  description = "Specifies the container app template"
  type        = map(any)
}

variable "container_app_env_vars" {
  description = "Specifies the container app environment variables"
  type        = set(string)
}

variable "app_env_key_vault_name" {
  description = "Specifies the key vault name"
  type        = string
}
