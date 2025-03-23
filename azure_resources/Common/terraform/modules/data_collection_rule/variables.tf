#############################
#      Resource Group       #
#############################
variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Virtual Machine. Changing this forces a new resource to be created"
}
variable "environment" {
  type        = string
  description = "The environment deploy"
  default     = "dev"
}

#############################
#     Shared Variables      #
#############################
variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created"
  default     = "West Europe"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources created."
  default     = {}
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "Specifies the id of the log analytic workspace to use."
}

variable "data_collection_endpoint_id" {
  type        = string
  description = "Specifies the id of data collection endpoint to use."
}

variable "custom_table_name" {
  type        = string
  description = "Custom table name for toolchains"
}

variable "file_patterns" {
  type        = list(string)
  description = "Custom file patterns for each application"
}

#############################
#     Operating System      #
#############################
variable "operating_system" {
  type        = string
  description = "Chose operating system for Virtual Machine. Possible values are RedHat and Windows"
  default     = ""
  validation {
    condition     = contains(["RedHat", "Windows"], var.operating_system)
    error_message = "The operating_system must be one of the following: RedHat, Windows."
  }
}
variable "operating_systems" {
  type = map(object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  }))
  description = "Map of operating system configurations for different platforms."
  default = {
    RedHat = {
      publisher = "RedHat"
      offer     = "RHEL"
      sku       = "92-gen2"
      version   = "9.2.2023092113"
    }
    Windows = {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2019-Datacenter"
      version   = "latest"
    }
    # Add other operating systems here with their attributes
  }
}

#############################
#      Virtual Machine      #
#############################
variable "vm_count" {
  type        = number
  description = "The number of Virtual Machine"
  default     = 1
}

variable "vm_name" {
  type        = string
  description = "The name of the Virtual Machine. Changing this forces a new resource to be created."
}

variable "vm_id" {
  description = "The id of the Virtual Machine. Changing this forces a new resource to be created."
}
