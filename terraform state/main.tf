resource "azurerm_resource_group" "srg" {
  name     = var.storage_resource_group
  location = var.location
}

resource "azurerm_storage_account" "statestorage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.srg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "statecontainer" {
  name                  = var.storage_container_name
  storage_account_name  = azurerm_storage_account.statestorage.name
  container_access_type = "private"
}