provider "azurerm" {
  features {}
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
    client_secret        = ""
    subscription_id      = ""
    tenant_id            = ""
  }
}