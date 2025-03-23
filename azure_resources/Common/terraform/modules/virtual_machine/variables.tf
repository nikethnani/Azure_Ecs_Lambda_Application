#############################
#      Resource Group       #
#############################
variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Virtual Machine. Changing this forces a new resource to be created"
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

#############################
#     Network Inteface      #
#############################

variable "network_interface_name" {
  type        = string
  description = "The name of the Network Interface. Changing this forces a new resource to be created."
}

variable "ip_configuration_name" {
  type        = string
  description = "A name used for this IP Configuration."
  default     = "internal"
}

variable "virtual_network_subnet_id" {
  type        = string
  description = "The ID of the Subnet where this Network Interface should be located in."
}

variable "private_ip_address_allocation" {
  type        = string
  description = "The allocation method used for the Private IP Address. Possible values are Dynamic and Static."
  default     = "Static"
  validation {
    condition     = contains(["Dynamic", "Static"], var.private_ip_address_allocation)
    error_message = "The operating_system must be one of the following: Dynamic, Static."
  }
}

variable "private_ip_address" {
  type        = string
  description = "The Static IP Address which should be used."
  # validation {
  #   condition     = can(regex("^10\\.115\\.[0-9]\\.[0-9]{1,3}$", var.private_ip_address))
  #   error_message = "Invalid private IP address format. Please use a valid private IP address in the format 10.115.x.xx."
  # }
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

variable "vm_size" {
  type        = string
  description = "The SKU which should be used for this Virtual Machine, such as Standard_B2ms."
  default     = "Standard_B2ms"
}

variable "admin_username" {
  type        = string
  sensitive   = true
  description = "The username of the local administrator used for the Virtual Machine and SSH. Changing this forces a new resource to be created."
}
###*******  USED JUST FOR WINDOWS VM  *******###
variable "windows_admin_password" {
  sensitive   = true
  type        = string
  description = "The Password which should be used for the local-administrator on this Virtual Machine. Changing this forces a new resource to be created."
  default     = ""
}

variable "windows_license_type" {
  type        = string
  description = "license_type - (Optional) Specifies the type of on-premise license (also known as Azure Hybrid Use Benefit) which should be used for this Virtual Machine. Possible values are None, Windows_Client and Windows_Server."
  default     = "Windows_Server"
}
variable "windows_source_image_id" {
  type        = string
  description = "The ID of the Image which this Virtual Machine should be created from. Changing this forces a new resource to be created. Possible Image ID types include."
  default     = "/subscriptions/58da50e6-050c-44c6-ab12-e2b4f0ccacad/resourceGroups/RG-POG-WEU-OS_IMAGES-PRD-01/providers/Microsoft.Compute/galleries/acg_pog_weu_OSimages_prd_01/images/Windows_2022_DCT_AzureEdition/versions/1.0.0"
}

variable "trusted_launch" {
  type        = bool
  description = "Specifies if vTPM (virtual Trusted Platform Module) and Trusted Launch is enabled for the Virtual Machine. Changing this forces a new resource to be created."
  default     = true
}
#----------------------------------------------#

variable "ssh_public_key" {
  type        = string
  description = "The Public Key which should be used for authentication, which needs to be at least 2048-bit and in ssh-rsa format. Changing this forces a new resource to be created."
  default     = ""
}

variable "os_disk_caching" {
  type        = string
  description = "The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite."
  default     = "ReadWrite"
  validation {
    condition     = contains(["None", "ReadOnly", "ReadWrite"], var.os_disk_caching)
    error_message = "Invalid access mode. Possible values are: \nNone, \nReadOnly, \nReadWrite."
  }
}

variable "os_disk_size" {
  type        = number
  description = "The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from."
  default     = 500
}

variable "os_disk_stg_type" {
  type        = string
  description = "he Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard_LRS, StandardSSD_LRS, Premium_LRS, StandardSSD_ZRS and Premium_ZRS. Changing this forces a new resource to be created."
  default     = "Standard_LRS"
  validation {
    condition = can(
      regex("^(Standard_LRS|StandardSSD_LRS|Premium_LRS|StandardSSD_ZRS|Premium_ZRS)$", var.os_disk_stg_type)
    )
    error_message = "Invalid storage account type. Possible values are:\nStandard_LRS\nStandardSSD_LRS\nPremium_LRS\nStandardSSD_ZRS\nPremium_ZRS."
  }
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
#      Aditional Disk       #
#############################
variable "data_disks" {
  type = list(object({
    disk_name            = string
    size                 = number
    storage_account_type = string
    create_option        = string
  }))
  description = "List of data disks configurations for the virtual machine."
  default     = []
}

variable "aditional_disk_caching" {
  type        = string
  description = "Specifies the caching requirements for this Data Disk. Possible values include None, ReadOnly and ReadWrite."
  validation {
    condition     = contains(["None", "ReadOnly", "ReadWrite"], var.aditional_disk_caching)
    error_message = "Invalid access mode. Allowed values are: None, ReadOnly, or ReadWrite."
  }
  default = "ReadWrite"
}

#############################
#      Recovery Vault       #
#############################
variable "recovery_resource_group" {
  type        = string
  description = "The name of the Recovery Services Vault resource group."
}

variable "recovery_vault_name" {
  type        = string
  description = "Specifies the name of the Recovery Services Vault to use. "
}

variable "recovery_vault_vm_policy_id" {
  type        = string
  description = "Specifies the id of the backup policy to use."
}
