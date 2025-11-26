variable "bastion_hosts" {
  description = "Map of bastion host configurations"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    vnet_name           = string
    subnet_prefix       = string
    address_space       = list(string)
    public_ip_key       = string
    ip_configuration    = optional(object({      # <--- make this optional
      name                 = string
      subnet_id            = string
      public_ip_address_id = string
    }))
    copy_paste_enabled        = optional(bool)
    file_copy_enabled         = optional(bool)
    sku                       = optional(string)
    ip_connect_enabled        = optional(bool)
    kerberos_enabled          = optional(bool)
    scale_units               = optional(number)
    shareable_link_enabled    = optional(bool)
    tunneling_enabled         = optional(bool)
    session_recording_enabled = optional(bool)
    virtual_network_id        = optional(string)
    tags                      = optional(map(string))
    zones                     = optional(list(string))
  }))
}
variable "public_ip_ids" {
  description = "Map of public IP IDs created outside this module"
  type        = map(string)
}