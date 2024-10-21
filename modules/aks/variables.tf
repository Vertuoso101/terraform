
variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}


variable "clusters" {
  description = "a list of aks clusters that we want to create"
  type = list(object({
    name = string
    version = string
    dns_prefix = string
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