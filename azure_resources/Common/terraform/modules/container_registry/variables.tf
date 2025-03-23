variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created"
  default     = "westeurope"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the container registry. Changing this forces a new resource to be created"
  default     = ""
}

variable "name" {
  type        = string
  description = "The name of the container registry to be created. The value will be randomly generated if blank."
  default     = ""
}

variable "sku" {
  type        = string
  description = "The Name of the SKU used for this Azure Container Registry. Possible values are standard and premium"
  default     = "Premium"
  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku)
    error_message = "The SKU name of the container registry. Possible values are Basic, Standard and Premium"
  }
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

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources created."
  default     = {}
}
