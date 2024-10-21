provider "azurerm" {


  features {}

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id

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
    client_secret        =  "e6v8Q~W5n3bdqodf2O1c9K3J7caj.qwFqyy.db4d"
    subscription_id      = "56547eac-ec4c-45fb-a21d-e1b0362b3cbb"  
    tenant_id            = "efdcb83a-0641-4cd5-ba9a-f16252e85ec6"  
  }
}