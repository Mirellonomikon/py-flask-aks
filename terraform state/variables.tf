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

variable "location" {
  type        = string
  description = "Resources location in Microsoft Azure"
}