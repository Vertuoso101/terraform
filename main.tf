

resource "azurerm_resource_group" "terraform_test_rg" {
  name     = var.resource_group_name
  location = var.location
}


module "vnet" {
  source              = "./modules/vnet"
  vnets               = var.vnets
  subnets             = var.subnets
  windows_vms         = var.windows_vms
  linux_vms           = var.linux_vms
  location            = azurerm_resource_group.terraform_test_rg.location
  resource_group_name = azurerm_resource_group.terraform_test_rg.name
}

locals {
  subnet_ids = module.vnet.subnet_ids
}

module "linux" {
  source              = "./modules/linux_vm"
  linux_vms           = var.linux_vms
  subnet_id           = module.vnet.subnet_ids
  resource_group_name = azurerm_resource_group.terraform_test_rg.name
  location            = var.location
}

module "windows" {
  source              = "./modules/windows_vm"
  windows_vms         = var.windows_vms
  subnet_id           = module.vnet.subnet_ids
  resource_group_name = azurerm_resource_group.terraform_test_rg.name
  location            = var.location
}

module "storage" {
  source              = "./modules/storage"
  location            = var.location
  resource_group_name = azurerm_resource_group.terraform_test_rg.name
  storages            = var.storages
  subnet_id           = module.vnet.subnet_ids

}

module "blob" {
  source     = "./modules/blob"
  blobs      = var.blobs
  containers = var.containers
}

module "cosmos_db" {
  source              = "./modules/cosmosdb"
  dbs                 = var.dbs
  location            = var.location
  resource_group_name = var.resource_group_name
}

module "aks" {
  source              = "./modules/aks"
  resource_group_name = azurerm_resource_group.terraform_test_rg.name
  clusters            = var.clusters
  location            = var.location
  node_pools          = var.node_pools
}




