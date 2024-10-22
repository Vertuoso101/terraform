provider "azurerm" {


  features {}

  subscription_id = "${ARM_SUBSCRIPTION_ID}"
  client_id       = "${ARM_CLIENT_ID}"
  client_secret   = "${ARM_CLIENT_SECRET}"
  tenant_id       = "${ARM_TENANT_ID}"

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
    client_secret        = "${ARM_CLIENT_SECRET}"
    subscription_id      = "${ARM_SUBSCRIPTION_ID}"
    tenant_id            = "${ARM_TENANT_ID}"
  }
}