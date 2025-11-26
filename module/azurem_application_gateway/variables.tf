variable "application_gateways" {
  description = "Map of Application Gateways with full configuration"
  
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string

    sku = object({
      name     = string
      tier     = string
      capacity = number
    })

    gateway_ip_configuration = object({
      name = string
    })

    frontend_ports = list(object({
      name = string
      port = number
    }))

    frontend_ip_configurations = list(object({
      name = string
    }))

    backend_address_pools = list(object({
      name = string
    }))

    backend_http_settings = list(object({
      name                  = string
      cookie_based_affinity = string
      path                  = string
      port                  = number
      protocol              = string
      request_timeout       = number
    }))

    http_listeners = list(object({
      name                           = string
      frontend_ip_configuration_name = string
      frontend_port_name             = string
      protocol                       = string
    }))

    request_routing_rules = list(object({
      name                       = string
      priority                   = number
      rule_type                  = string
      http_listener_name         = string
      backend_address_pool_name  = string
      backend_http_settings_name = string
    }))

    tags = map(string)
  }))
}
