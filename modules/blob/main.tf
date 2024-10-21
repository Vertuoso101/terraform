resource "azurerm_storage_container" "test_container" {
  for_each = {for container in var.containers : container.name => container}  
  name                  = each.key
  storage_account_name  = each.value.storage
  container_access_type = "container"
}

resource "azurerm_storage_blob" "test_blob" {
  for_each = {for blob in var.blobs : blob.name => blob}
  name                   = each.key
  storage_account_name   = each.value.storage
  storage_container_name = each.value.container
  type                   = "Block"
}