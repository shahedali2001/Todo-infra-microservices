variable "vnets" {
  description = "Map of virtual networks to create"
  type = map(object({
    vnet_name                     = string
    location                      = string
    resource_group_name            = string
    address_space                  = list(string)
    dns_servers                    = optional(list(string), [])   # default empty list

    flow_timeout_in_minutes        = optional(number, 4)
    private_endpoint_vnet_policies = optional(string, "Disabled") # must be "Basic" or "Disabled"
    edge_zone                      = optional(string, null)
    bgp_community                  = optional(string, null)
    tags                           = optional(map(string), {})

    ddos_protection_plan = optional(object({
      id     = string
      enable = bool
    }), null)

    encryption = optional(object({
      enforcement = string
    }), null)

    ip_address_pool = optional(object({
      id                     = string
      number_of_ip_addresses = number
    }), null)

    subnets = list(object({
      name             = string
      address_prefixes = list(string)
    }))
  }))
  default = {}
}

