variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "subnet_id" {
  type = map(string)
}


variable "windows_vms" {
  description = "List of windows virtual machines to create"
  type = list(object({
    name       = string
    size       = string
    subnet =  string
    environment = string
  }))
}