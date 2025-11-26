variable "key_vaults" {
  description = "Map of Key Vault configurations"
  type = map(object({
    name                        = string
    location                    = string
    resource_group_name         = string
    enabled_for_disk_encryption = bool
    soft_delete_retention_days  = number
    purge_protection_enabled    = bool
    sku_name                    = string
    access_policy = object({
      key_permissions     = list(string)
      secret_permissions  = list(string)
      storage_permissions = list(string)
    })
    tags = optional(map(string), {})
  }))
}
