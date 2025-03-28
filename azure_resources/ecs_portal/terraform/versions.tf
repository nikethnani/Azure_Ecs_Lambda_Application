terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.79.0"
    }
    azapi = {
      source = "Azure/azapi"
    }
  }
  required_version = ">= 0.13"
}

provider "azapi" {
}

provider "azurerm" {
  features {}
}
