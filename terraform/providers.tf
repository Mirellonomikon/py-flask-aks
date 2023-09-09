terraform {
  required_version = ">=1.0"
  backend "azurerm" {
    resource_group_name  = "rg_terraform"
    storage_account_name = "stterrastate"
    container_name       = "statecontainer"
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