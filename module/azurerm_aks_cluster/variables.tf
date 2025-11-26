variable "aks_cluster" {
  type = map(object({
    # Basic cluster info
    name                = string
    location            = string
    resource_group_name = string
    dns_prefix          = string
    vm_size             = string
    node_count          = number
    type                = string
    tags                = map(string)

    # Identity aur Access Control
    aad_admin_group_object_ids   = optional(list(string), [])
    enable_azure_rbac            = optional(bool, false)
    enable_oidc_issuer           = optional(bool, false)
    enable_workload_identity     = optional(bool, false)
    assign_identity              = optional(string, null)

    # Node aur Control Plane Configuration
    control_plane_count          = optional(number, 3)
    control_plane_vm_size        = optional(string, "Standard_DS3_v2")
    enable_cluster_autoscaler    = optional(bool, false)
    enable_ahub                  = optional(bool, false)
    enable_ai_toolchain_operator = optional(bool, false)
    enable_kaito                 = optional(bool, false)
    disable_nfs_driver           = optional(bool, false)
    disable_smb_driver           = optional(bool, false)

    # SSH aur Authentication
    generate_ssh_keys            = optional(bool, true)
    ssh_key_value                = optional(string, null)

    # Networking aur Subnetting
    vnet_ids                     = optional(list(string), [])
    vnet_subnet_id               = optional(string, null)
    pod_cidr                     = optional(string, "10.244.0.0/16")
    load_balancer_count          = optional(number, 1)

    # Preview features
    ca_profile                    = optional(string, null)
    gateway_id                    = optional(string, null)

    # Operation settings
    no_wait                       = optional(bool, false)
  }))
  description = "Map of AKS clusters with full configuration"
}
