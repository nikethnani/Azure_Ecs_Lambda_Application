variable "location" {
  type = string
}

variable "environment" {
  type = string
}

variable "tags" {
  type        = map(any)
  description = "Azure resource tags"
  default = {
  }
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
  type        = string
  description = "The name of the resource group in which to create the resources"
}

variable "law_name" {
  type        = string
  description = "The name of the Log Analytics Workspace"
}

variable "law_sku" {
  type        = string
  description = "The SKU of the Log Analytics Workspace"
}

variable "law_retention_in_days" {
  type        = number
  description = "The retention period of the Log Analytics Workspace in days"
}

variable "container_app_environment_name" {
  type        = string
  description = "The name of the container app environment"
}

variable "container_vault_resource_group_name" {
  type        = string
  description = "The name of the container key vault resource group name"
}

variable "container_app_revision_mode" {
  type        = string
  description = "The revision mode of the container app"
}

variable "container_app_template" {
  type        = map(any)
  description = "The container app template"
}

variable "container_app_env_vars" {
  description = "Specifies the container app environment variables"
  type        = set(string)
}

variable "app_env_key_vault_name" {
  description = "Specifies the key vault name"
  type        = string
}

variable "key_vault_resource_group_name" {
  description = "Specifies the key vault resource group name"
  type        = string
}

variable "storage_account_name" {
  type        = string
  description = "The name of the storage account"
}

variable "account_kind" {
  type        = string
  description = "The kind of the storage account"
}

variable "replication_type" {
  type        = string
  description = "The replication type of the storage account"
}

variable "access_tier" {
  type        = string
  description = "The access tier of the storage account"
  default     = null
}

variable "blob_cors" {
  type        = map(any)
  description = "The CORS rule of the storage account"
}

variable "default_network_rule" {
  type        = string
  description = "The default network rule action of the storage account"
}

variable "traffic_bypass" {
  type        = list(string)
  description = "The traffic bypass of the storage account"
}

variable "pg_credential_key_vault_name" {
  type        = string
  description = "The name of the Key Vault to store the PostgreSQL credentials"
}

variable "postgres_username" {
  type        = string
  description = "The username of the PostgreSQL server"
}

variable "postgres_password" {
  type        = string
  description = "The password of the PostgreSQL server"
}

variable "postgresql_server_name" {
  type        = string
  description = "The name of the PostgreSQL server"
}

variable "postgresql_version" {
  type        = string
  description = "The version of the PostgreSQL server"
}

variable "postgresql_sku_name" {
  type        = string
  description = "The SKU name of the PostgreSQL server"
}

variable "postgresql_storage_mb" {
  type        = number
  description = "The storage capacity of the PostgreSQL server in MB"
}

variable "postgresql_geo_redundant_backup_enabled" {
  type        = bool
  description = "Enable Geo-Redundant Backups for the PostgreSQL server"
}

variable "postgresql_database_name" {
  type        = string
  description = "The name of the PostgreSQL database"
}

variable "postgresql_firewall_rule" {
  type = object({
    name             = string
    start_ip_address = string
    end_ip_address   = string
  })
  description = "The configuration of the PostgreSQL firewall rule"
}
