# Common
location    = "westeurope"
environment = "dev"
tags = {
  Application = "OPnDevOps",
  Division    = "POSH",
  Environment = "DEV",
  Owner       = "govardhana.s@opmobility.com",
  Service     = "Compute"

}

# Container App
container_registry_name                = "opndevopsimages"
container_registry_resource_group_name = "RG-POSH-WEU-OPnPORTAL-DEV-01"
container_app_resource_group_name      = "RG-POSH-WEU-OPnPORTAL-DEV-01"
container_app_environment_name         = "cae-posh-weu-portal-dev-01"
container_app_revision_mode            = "Single"
container_app_template = {
  be-ca-posh-weu-portal-dev-01 = {
    name   = "portal-be"
    image  = "opmobility-be"
    cpu    = 0.5
    memory = 1.5
  }
  fe-ca-posh-weu-portal-dev-01 = {
    name   = "portal-fe"
    image  = "opmobility-fe"
    cpu    = 0.5
    memory = 1.5
  }
}
container_app_env_vars        = ["DBHOSTNAME", "DBPORT", "DBNAME", "DBUSERNAME", "DBPASSWORD", "CLIENTID", "CLIENTSECRET", "TENANTID"]
app_env_key_vault_name        = "kvposhweuportaldev01"
key_vault_resource_group_name = "RG-POSH-WEU-KEYVAULT-DEV-01"

# Log Analytics Workspace
law_name              = "law-posh-weu-portal-dev-01"
law_sku               = "PerGB2018"
law_retention_in_days = 30

# Storage Account
storage_account_name = "stposhweuportaldev01"
account_kind         = "BlockBlobStorage"
replication_type     = "LRS"
blob_cors = {
  cors_rule = {
    allowed_headers    = ["*"]
    allowed_methods    = ["GET"]
    allowed_origins    = ["*"]
    exposed_headers    = ["*"]
    max_age_in_seconds = 3600
  }
}
default_network_rule = "Deny"
traffic_bypass       = ["AzureServices"]

# Postgres Database
pg_credential_key_vault_name            = "kv-posh-weu-portal-dev-01"
postgres_username                       = "DB_USERNAME"
postgres_password                       = "DB_PASSWORD"
postgresql_server_name                  = "ps-posh-weu-portal-dev-01"
postgresql_version                      = "11"
postgresql_sku_name                     = "GP_Gen5_4"
postgresql_storage_mb                   = 51200
postgresql_geo_redundant_backup_enabled = false
postgresql_database_name                = "db-posh-weu-portal-dev-01"
postgresql_firewall_rule = {
  name             = "AllowPortalBE"
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

# azure container registry
acr_name       = "opndevopsimages"
create_new_acr = true
admin_enabled  = true
