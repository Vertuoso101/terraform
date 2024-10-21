variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "vnets" {
  type = list(object({
    name   = string
    vnet_range = list(string)
  }))
}

variable "subnets" {
  type = list(object({
      vnet = string
      name  = string
      subnet_range = list(string)
    }))
}

variable "windows_vms" {
  description = "List of windows virtual machines to create"
  type = list(object({
    name       = string
    size       = string
    admin_user = string
    admin_password = string
    subnet =  string
    environment = string
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