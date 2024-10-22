variable "subscription_id" {
  type = string
  default = ""
}

variable "client_id" {
  type = string
  default = ""
}

variable "client_secret" {
  type = string
  default = ""
}

variable "tenant_id" {
  type = string
  default = ""
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "rg" {
  type = string
  
}

variable "storage" {
  type = string
  
}

variable "container" {
  type = string
}

variable "key" {
  type = string
  
}


variable "windows_vms" {
  description = "List of windows virtual machines to create"
  type = list(object({
    name           = string
    size           = string
    subnet         = string
    environment    = string
  }))
}

variable "linux_vms" {
  description = "List of linux virtual machines to create"
  type = list(object({
    name        = string
    size        = string
    admin_user  = string
    subnet      = string
    environment = string
  }))
}

variable "vnets" {
  type = list(object({
    name       = string
    vnet_range = list(string)
  }))
}
variable "subnets" {
  type = list(object({
    vnet         = string
    name         = string
    subnet_range = list(string)
  }))
}

variable "storages" {
  type = list(object({
    name        = string
    tier        = string
    replication = string
    environment = string
  }))
}

variable "containers" {
  type = list(object({
    name    = string
    storage = string
  }))
}

variable "blobs" {
  type = list(object({
    name      = string
    container = string
    storage   = string
  }))
}

variable "dbs" {
  type = list(object({
    name              = string
    offer_type        = string
    kind              = string
    consistency_level = string
    geo_location      = string
    failover_priority = number
  }))
}

variable "clusters" {
  description = "a list of aks clusters that we want to create"
  type = list(object({
    name          = string
    version       = string
    dns_prefix    = string
    identity_type = string
  }))
}

variable "node_pools" {
  description = "A list of AKS node pools for clusters"
  type = list(object({
    cluster_name         = string
    name                 = string
    vm_size              = string
    auto_scaling_enabled = bool
    node_count           = number
    min_count            = number
    max_count            = number
  }))
}
