# Create Virtual Network
resource "azurerm_virtual_network" "bastion_vnet" {
  for_each            = var.bastion_hosts
  name                = each.value.vnet_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = each.value.address_space
}

# Create Bastion Subnet
resource "azurerm_subnet" "bastion_subnet" {
  for_each             = var.bastion_hosts
  name                 = "AzureBastionSubnet"
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = azurerm_virtual_network.bastion_vnet[each.key].name
  address_prefixes     = [each.value.subnet_prefix]
}

resource "azurerm_bastion_host" "bastion" {
  for_each            = var.bastion_hosts
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                 = "${each.key}-ipconfig"
    subnet_id            = azurerm_subnet.bastion_subnet[each.key].id
    public_ip_address_id = var.public_ip_ids[each.value.public_ip_key]
  }

  copy_paste_enabled        = try(each.value.copy_paste_enabled, null)
  file_copy_enabled         = try(each.value.file_copy_enabled, null)
  sku                       = try(each.value.sku, null)
  ip_connect_enabled        = try(each.value.ip_connect_enabled, null)
  kerberos_enabled          = try(each.value.kerberos_enabled, null)
  scale_units               = try(each.value.scale_units, null)
  shareable_link_enabled    = try(each.value.shareable_link_enabled, null)
  tunneling_enabled         = try(each.value.tunneling_enabled, null)
  session_recording_enabled = try(each.value.session_recording_enabled, null)
  virtual_network_id        = try(each.value.virtual_network_id, null)
  tags                      = try(each.value.tags, null)
  zones                     = try(each.value.zones, null)
}
