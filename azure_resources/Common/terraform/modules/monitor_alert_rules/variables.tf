variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created"
  default     = "westeurope"
}

variable "resource_group_monitor_alert_rules_name" {
  type        = string
  description = "The name of the resource group in which to create the Monitor alert rules. Changing this forces a new resource to be created"
  default     = ""
}

variable "email_address" {
  type        = string
  description = "The email admin to send the email notification"
  default     = "anhhd14@fpt.com"
}

variable "vms_id" {
  type = set(string)
  description = "The id of the Virtual Machine. Changing this forces a new resource to be created."
  default = []
}

variable "severity_mem" {
  type        = number
  description = "The value of severity for alert rule memory. Level 0 is Critical, level 1 is Error, level 2 is Warning, level 3 is Informational, level 4 is Verbose"
  default     = 3
}

variable "threshold_mem" {
  type        = number
  description = "The value of threshold for alert rule memory, unit megabyte"
  default     = 1000000000
}

variable "severity_cpu" {
  type        = number
  description = "The value of severity for alert rule CPU. Level 0 is Critical, level 1 is Error, level 2 is Warning, level 3 is Informational, level 4 is Verbose"
  default     = 3
}

variable "threshold_cpu" {
  type        = number
  description = "The value of threshold for alert rule CPU, unit percentage"
  default     = 80
}

variable "severity_data_iops" {
  type        = number
  description = "The value of severity for alert rule data disk IOPS.  Level 0 is Critical, level 1 is Error, level 2 is Warning, level 3 is Informational, level 4 is Verbose"
  default     = 3
}

variable "threshold_data_iops" {
  type        = number
  description = "The value of threshold for alert rule data disk IOPS, unit percentage"
  default     = 95
}

variable "severity_os_iops" {
  type        = number
  description = "The value of severity for alert rule OS disk IOPS.  Level 0 is Critical, level 1 is Error, level 2 is Warning, level 3 is Informational, level 4 is Verbose"
  default     = 3
}

variable "threshold_os_iops" {
  type        = number
  description = "The value of threshold for alert rule OS disk IOPS, unit percentage"
  default     = 95
}

variable "severity_net_in" {
  type        = number
  description = "The value of severity for alert rule network in total.  Level 0 is Critical, level 1 is Error, level 2 is Warning, level 3 is Informational, level 4 is Verbose"
  default     = 3
}

variable "threshold_net_in" {
  type        = number
  description = "The value of threshold for alert rule network in total, unit megabyte"
  default     = 500000000000
}

variable "severity_net_out" {
  type        = number
  description = "The value of severity for alert rule network out total.  Level 0 is Critical, level 1 is Error, level 2 is Warning, level 3 is Informational, level 4 is Verbose"
  default     = 3
}

variable "threshold_net_out" {
  type        = number
  description = "The value of threshold for alert rule network out total, unit megabyte"
  default     = 200000000000
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources created."
  default     = {}
}
