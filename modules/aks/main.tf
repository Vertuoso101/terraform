resource "azurerm_kubernetes_cluster" "aks" {
  for_each = {for cluster in var.clusters: cluster.name => cluster}
  name                = each.key
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = each.value.dns_prefix
  kubernetes_version        = each.value.version
  
  default_node_pool {
    name       = "${each.key}"
    vm_size    = "Standard_D2_v2"
    node_count = 1
    min_count  = 1
    max_count  = 2
  }

  identity {
    type = each.value.identity_type
  }

}

resource "azurerm_kubernetes_cluster_node_pool" "aks_node_pool" {
  for_each = { for np in var.node_pools : "${np.cluster_name}-${np.name}" => np }

  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks[each.value.cluster_name].id
  name                  = each.value.name
  vm_size               = each.value.vm_size
  node_count            = each.value.node_count
  min_count           = each.value.min_count
  max_count           = each.value.max_count

}
