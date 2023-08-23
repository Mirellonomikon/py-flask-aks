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
  client_id       = "6e2a0910-ab40-4d3b-94df-4c0a63f9cbbb"
  client_secret   = "WUF8Q~2Uc-WNSmtSU3xEekeglZuTrsO~wmgc5c.B"
  subscription_id = "9f6e1b5b-ecf2-47b0-9860-a5e1941bf68a"
  tenant_id       = "a6eb79fa-c4a9-4cce-818d-b85274d15305"
  features {}
}