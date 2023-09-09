resource "azurerm_resource_group" "srg" {
  name = var.storage_resource_group
  location = var.location
}

resource "azurerm_storage_account" "statestorage" {
  name = var.storage_account_name
  resource_group_name = azurerm_resource_group.srg.name
  location = var.location
  account_tier = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "statecontainer" {
  name = var.storage_container_name
  storage_account_name = azurerm_storage_account.statestorage.name
  container_access_type = "private" 
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_container_registry" "acr" {
  name = var.container_registry_name
  resource_group_name = var.resource_group_name
  location = var.location
  sku = "Basic"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  kubernetes_version  = var.kubernetes_version
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.cluster_name
  node_resource_group = var.node_resource_group

  default_node_pool {
    name                = "system"
    node_count          = var.system_node_count
    vm_size             = "Standard_DS2_v2"
    type                = "VirtualMachineScaleSets"
    enable_auto_scaling = true
    max_count           = 2
    min_count           = 1
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    load_balancer_sku = "standard"
    network_plugin    = "kubenet" # azure (CNI)
  }
}

resource "azurerm_role_assignment" "aksrole" {
  scope = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

resource "azurerm_role_assignment" "agentpoolrole" {
  scope = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id = azurerm_resource_group.aks.node_resource_group.kubelet_identity[0].object_id
}