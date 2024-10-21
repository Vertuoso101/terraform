output "kube_config" {
  description = "Kube config for the AKS clusters"
  value = { 
    for k, v in azurerm_kubernetes_cluster.aks : k => v.kube_config_raw
  }
  sensitive = true
}

output "cluster_names" {
  description = "Names of the AKS clusters"
  value = { 
    for k, v in azurerm_kubernetes_cluster.aks : k => v.name
  }
}