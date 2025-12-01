data "azurerm_subnet" "datasubnet" {
  for_each = var.application_gateways
  name                 = each.value.gateway_ip_configuration.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}


# data "azurerm_public_ip" "datapip" {
#   for_each            = var.application_gateways
#   name                = each.value.public_ip_name
#   resource_group_name = each.value.resource_group_name
# }