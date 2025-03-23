# common
location = "westeurope"
tags = {
  Application = "OPnDevOps",
  Division    = "POSH",
  Environment = "DEV",
  Owner       = "pascal.zembra@plasticomnium.com",
  Service     = "Storage"
}

# Network
network_subnet_name          = "snet-posh-weu-infra-dev-01"
network_resource_group_name  = "RG-POSH-WEU-NETWORK-PRD-01"
network_virtual_network_name = "vnet-posh-weu-infra-dev-01"

# key vault
resource_group_key_vault_name           = "RG-POSH-WEU-KEYVAULT-DEV-01"
key_vault_name                          = "kvposhweukeyvaultdev"
sku_name                                = "standard"
key_vault_public_network_access_enabled = true

# key vault access policy
key_vault_access_policies = [
  {
    key_permissions         = ["Get", "List"],
    secret_permissions      = ["Get", "List"]
    certificate_permissions = ["Get", "List"]
  }
]

# recovery_service_vault
resource_group_recovery_vault_name = "RG-POSH-WEU-BACKUP-DEV-01"
recovery_vault_name                = "bvaultposhweubackupdev01"
recovery_vault_sku                 = "Standard"
recovery_vault_soft_delete_enabled = true

# backup custom policy
vm_backup_policies = [
  {
    name        = "EnhancedCustomPolicy7days"
    policy_type = "V2"
  },
]
vm_backup_daily_retention = {
  count = 7
}

# OPN_DevOps
resource_group_opndevops_name = "RG-POSH-WEU-OPnDevOps-DEV-01"

# log_analytics
law_name      = "law-posh-weu-opndevops-dev-01"
law_diag_name = "lawdiag-posh-weu-opndevops-dev-01"

# azure container registry
acr_name       = "opndevopsimages"
create_new_acr = true
admin_enabled  = true

# Log Analytic
log_analytics_workspace_name                = "law-posh-weu-opndevops-dev-01"
vm_count                                    = 1
log_analytics_workspace_resource_group_name = "RG-POSH-WEU-OPnDevOps-DEV-01"
data_collection_endpoint_name               = "devops-toolchain-dce"
resource_group_name                         = "RG-POSH-WEU-OPnDevOps-DEV-01"

# VM name
polarion_vm   = "SX07WEULD0001"
jenkins_vm    = "SX07WEULD0002"
confluence_vm = "SX07WEULD0003"
gitlab_vm     = "SX07WEULD0004"
jfrog_vm      = "SX07WEULD0006"
coverity_vm   = "SX07WEULD0007"
jira_vm       = "SX07WEULD0009"
