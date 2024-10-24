resource_group_name = "test_resource_group"
location            = "West Europe"
storage = "testzaaid"
container = "zaid"
key = "terraform.tfstate"
rg = "test"
vnets = [
  {
    name       = "vnet1"
    vnet_range = ["10.0.0.0/16"]
  }
]

subnets = [
  { name = "subnet1", subnet_range = ["10.0.1.0/24"], vnet = "vnet1" },
  { name = "subnet2", subnet_range = ["10.0.2.0/24"], vnet = "vnet1" }
]

/* windows_vms = [
  {
    name           = "1dev-windows"
    size           = "Standard_DS1_v2"
    environment    = "dev"
    subnet         = "subnet2"
  }
]
 */
windows_vms = []

linux_vms = [
  {
    name        = "1dev-linux"
    admin_user  = "azureuser"
    size        = "Standard_DS1_v2"
    subnet      = "subnet1"
    environment = "dev"
  },
  {
    name        = "2dev-linux"
    admin_user  = "azureuser"
    size        = "Standard_DS1_v2"
    subnet      = "subnet1"
    environment = "dev"
  }
]

/* storages = [{
  name        = "123zaidstorage"
  tier        = "Standard"
  replication = "LRS"
  environment = "dev"
  },
  {
    name        = "1234zaidstorage"
    tier        = "Standard"
    replication = "LRS"
    environment = "dev"
  }
] */

storages = []

/* containers = [{
  name    = "123zaidstorage-test1"
  storage = "123zaidstorage"
  },
  {
    name    = "1234zaidstorage-test1"
    storage = "1234zaidstorage"
  }
] */

containers = []

/* blobs = [{
  name      = "123zaidstorage-test1-zaid1"
  container = "123zaidstorage-test1"
  storage   = "123zaidstorage"
  },
  {
    name      = "1234zaidstorage-test1-zaid1"
    container = "1234zaidstorage-test1"
    storage   = "1234zaidstorage"
  }
] */

blobs = []

dbs =[]

/* dbs = [{
  name              = "zaidtest"
  offer_type        = "Standard"
  kind              = "MongoDB"
  consistency_level = "Session"
  geo_location      = "West Europe"
  failover_priority = 0
}] */

clusters = []

/* clusters = [
  {
    name          = "akscluster1"
    version       = "1.29.0"
    dns_prefix    = "aks-test-1"
    identity_type = "SystemAssigned"
  }
] */

node_pools =[]

/* node_pools = [
  {
    cluster_name         = "akscluster1"
    name                 = "nodepool1"
    vm_size              = "Standard_DS2_v2"
    auto_scaling_enabled = true
    node_count           = 1
    min_count            = 1
    max_count            = 2
  }
] */
