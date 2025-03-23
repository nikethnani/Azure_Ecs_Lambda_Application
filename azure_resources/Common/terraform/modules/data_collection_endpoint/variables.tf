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

variable "data_collection_endpoint_name" {
  type        = string
  description = "Data collection endpoint name"
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
