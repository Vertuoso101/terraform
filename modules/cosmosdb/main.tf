resource "azurerm_cosmosdb_account" "db" {
  for_each = {for db in var.dbs : db.name => db}
  name                = each.key
  location            = var.location
  resource_group_name = var.resource_group_name
  offer_type          = each.value.offer_type
  kind                = each.value.kind
  consistency_policy {
    consistency_level = each.value.consistency_level
  }
  geo_location {
    location          = each.value.geo_location
    failover_priority = each.value.failover_priority
  }
}