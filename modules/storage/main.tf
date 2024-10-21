resource "azurerm_storage_account" "test_storage" {
  for_each = {for storage in var.storages : storage.name => storage}  
  name                     = each.key
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = each.value.tier
  account_replication_type = each.value.replication

  tags = {
    environment = each.value.environment
  }
}

resource "azurerm_storage_account_network_rules" "test_storage_rules" {
  for_each =    {for storage in var.storages : storage.name => storage}

  storage_account_id = azurerm_storage_account.test_storage[each.key].id
  default_action             = "Allow"
  ip_rules                   = ["105.67.0.249"]
  bypass                     = ["Metrics"]
}