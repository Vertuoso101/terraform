variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "dbs" {
  type = list(object({
    name = string
    offer_type = string
    kind = string
    consistency_level = string
    geo_location = string
    failover_priority = number
  }))
}