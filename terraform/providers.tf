terraform {
  required_version = ">=1.0"
  backend "azurerm" {
    resource_group_name  = var.storage_resource_group
    storage_account_name = var.storage_account_name
    container_name       = var.storage_container_name
    key                  = "terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}