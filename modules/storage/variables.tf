
variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "subnet_id" {
  type =  map(string)
}

variable "storages" {
  type = list(object({
    name = string
    tier = string
    replication = string
    environment = string
  }))
}
