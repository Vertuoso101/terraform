provider "azurerm" {


  features {}

  subscription_id = data.azurerm_key_vault_secret.subscriptionid.value
  client_id       = data.azurerm_key_vault_secret.clientid.value
  client_secret   = data.azurerm_key_vault_secret.clientsecret.value
  tenant_id       = data.azurerm_key_vault_secret.tenantid.value

}

terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "test"          
    storage_account_name = "testzaaid"                             
    container_name       = "zaid"                              
    key                  = "terraform.tfstate"             
    client_secret        = data.azurerm_key_vault_secret.clientsecret.value
    subscription_id      = data.azurerm_key_vault_secret.subscriptionid.value 
    tenant_id            = data.azurerm_key_vault_secret.tenantid.value

  }
}