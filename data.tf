data "azurerm_key_vault" "keyvault" {
  name                = "zaidSecs"
  resource_group_name = "test"
}

data "azurerm_key_vault_secret" "subscriptionid" {
  name         = "subscriptionid"
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "tenantid" {
  name         = "tenantid"
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "clientsecret" {
  name         = "clientsecret"
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "clientid" {
  name         = "clientid"
  key_vault_id = data.azurerm_key_vault.keyvault.id
}
