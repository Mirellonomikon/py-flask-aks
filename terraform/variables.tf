variable "resource_group_name" {
  type        = string
  description = "Resource Group name in Microsoft Azure"
}
variable "location" {
  type        = string
  description = "Resources location in Microsoft Azure"
}
variable "cluster_name" {
  type        = string
  description = "AKS name in Microsoft Azure"
}
variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version"
}
variable "system_node_count" {
  type        = number
  description = "Number of AKS worker nodes"
}
variable "node_resource_group" {
  type        = string
  description = "Resource Group name for cluster resources in Microsoft Azure"
}

variable "storage_resource_group" {
  type        = string
  description = "Name for the storage account resource group"
}

variable "storage_account_name" {
  type        = string
  description = "Name for the storage account"
}

variable "storage_container_name" {
  type        = string
  description = "Name for the storage container"
}

variable "container_registry_name" {
  type        = string
  description = "Name for the container registry"
}