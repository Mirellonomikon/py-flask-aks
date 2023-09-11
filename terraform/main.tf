resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_container_registry" "acr" {
  name                = var.container_registry_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"
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

# give acrpull role to kubernetes service (managed identity) for the container registry
resource "azurerm_role_assignment" "acr_role" {
  scope                = azurerm_container_registry.acr.object_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

data "azurerm_user_assigned_identity" "aks_node_identity" {
  name                = "aks-cluster-agentpool" # Assuming this is the name of the managed identity
  resource_group_name = var.node_resource_group
}

# give acrpull role to aks-cluster-agentpool (managed identity) for the container registry
resource "azurerm_role_assignment" "acragentpool_role" {
  scope                = azurerm_container_registry.acr.object_id
  role_definition_name = "AcrPull"
  principal_id         = data.azurerm_user_assigned_identity.aks_node_identity.id
}