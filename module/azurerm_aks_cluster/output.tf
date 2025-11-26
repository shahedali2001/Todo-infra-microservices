output "client_certificates" {
  value = { for k, v in azurerm_kubernetes_cluster.aks_cluster : k => v.kube_config[0].client_certificate }
}

output "kube_configs" {
  value = { for k, v in azurerm_kubernetes_cluster.aks_cluster : k => v.kube_config_raw }
}

