variable "location" {
  description = "Specifies the supported Azure location to MySQL server resource"
  type        = string
}

variable "tags" {
  description = "tags to be applied to resources"
  type        = map(string)
}

variable "pg_credential_key_vault_name" {
  description = "The name of the Key Vault to store the PostgreSQL credentials"
  type        = string
}

variable "key_vault_resource_group_name" {
  description = "The name of the resource group where the Key Vault is located"
  type        = string
}

variable "postgres_username" {
  description = "The username of the PostgreSQL Server"
  type        = string
}

variable "postgres_password" {
  description = "The password of the PostgreSQL Server"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "postgresql_server_name" {
  description = "The name of the PostgreSQL Server"
  type        = string
}

variable "postgresql_version" {
  description = "The version of the PostgreSQL Server"
  type        = string
}

variable "postgresql_sku_name" {
  description = "The name of the SKU used by this PostgreSQL Server"
  type        = string
}

variable "postgresql_storage_mb" {
  description = "The storage capacity of the PostgreSQL Server (in MB)"
  type        = number
}

variable "postgresql_geo_redundant_backup_enabled" {
  description = "Enable Geo-Redundant Backups for the PostgreSQL Server"
  type        = bool
  default     = false
}

variable "postgresql_database_name" {
  description = "The name of the PostgreSQL Database"
  type        = string
}

variable "postgresql_firewall_rule" {
  description = "The configuraiton of the PostgreSQL Firewall Rule"
  type = object({
    name             = string
    start_ip_address = string
    end_ip_address   = string
  })
}
