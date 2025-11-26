variable "acr_registries" {
  description = "Map of Azure Container Registries to create"
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    sku                 = optional(string, "Basic") # Basic, Standard, Premium
    admin_enabled       = optional(bool, false)
    tags                = optional(map(string), {})
  }))
  default = {}
}
