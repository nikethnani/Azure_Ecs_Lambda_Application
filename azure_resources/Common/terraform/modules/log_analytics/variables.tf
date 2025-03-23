variable "location" {
  description = "(Required) location where this resource has to be created"
  default     = "westeurope"
}

variable "law_name" {
  description = "log analytic workspace name"
}

variable "law_diag_name" {
  description = "log analytic diagnostic setting name"
}

variable "law_solution_names" {
  default = [
    "Security", "SecurityInsights", "AgentHealthAssessment", "AzureActivity", "SecurityCenterFree", "DnsAnalytics", "ADAssessment", "AntiMalware", "SQLAssessment", "SQLAdvancedThreatProtection", "AzureAutomation", "ChangeTracking", "Updates", "VMInsights"
  ]
}

variable "law_retention_in_days" {
  description = "Workspace data retention in days ( 30 to 730 )"
  default     = 30
}

variable "law_sku" {
  description = "Specifies the Sku of the Log Analytics Workspace"
  default     = "PerGB2018"
}

variable "resource_group_name" {
  description = "Resource group name"
}

variable "tags" {
}
