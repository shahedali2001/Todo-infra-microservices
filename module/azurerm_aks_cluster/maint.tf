# AKS Cluster
resource "azurerm_kubernetes_cluster" "aks_cluster" {
  for_each = var.aks_cluster

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  dns_prefix          = each.value.dns_prefix
  kubernetes_version  = "1.32.9"

  default_node_pool {
    name       = "default"
    node_count = each.value.node_count
    vm_size    = each.value.vm_size
    min_count  = each.value.enable_cluster_autoscaler ? 1 : null
    max_count  = each.value.enable_cluster_autoscaler ? 5 : null
    # enable_auto_scaling = each.value.enable_cluster_autoscaler
  }

  identity {
    type = each.value.type
  }

  # # Azure AD integration
  # dynamic "aad_profile" {
  #   for_each = length(each.value.aad_admin_group_object_ids) > 0 ? [1] : []
  #   content {
  #     managed                = true
  #     admin_group_object_ids = each.value.aad_admin_group_object_ids
  #   }
  # }

  # Azure RBAC & Workload Identity
  # azure_rbac_enabled       = lookup(each.value, "enable_azure_rbac", false)
  # enable_oidc_issuer       = lookup(each.value, "enable_oidc_issuer", false)
  # enable_workload_identity = lookup(each.value, "enable_workload_identity", false)

  # Networking
  network_profile {
    network_plugin = "azure"
    # pod_cidr          = lookup(each.value, "pod_cidr", "10.244.0.0/16")
    load_balancer_sku = "standard"
  }

  # SSH keys (only for ServicePrincipal identity)
  dynamic "linux_profile" {
    for_each = (lookup(each.value, "ssh_key_value", null) != null && each.value.type == "ServicePrincipal") ? [1] : []
    content {
      admin_username = "azureuser"
      ssh_key {
        key_data = each.value.ssh_key_value
      }
    }
  }

  # Tags
  tags = each.value.tags

  # Optional no_wait
  lifecycle {
    ignore_changes = [
      # ignore fields that might be auto-managed
    ]
  }

  #   # Optional feature flags (example for AHUB/AI Toolchain/Kaito)
  #   dynamic "addon_profile" {
  #     for_each = (each.value.enable_ahub || each.value.enable_ai_toolchain_operator || each.value.enable_kaito) ? [1] : []
  #     content {
  #       # Fill according to the features enabled
  #     }
  #   }
}
