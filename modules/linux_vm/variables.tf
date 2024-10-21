variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "subnet_id" {
  type = map(string)
}
variable "linux_vms" {
  description = "List of linux virtual machines to create"
  type = list(object({
    name       = string
    size       = string
    admin_user = string
    subnet = string
    environment = string
  }))
}


