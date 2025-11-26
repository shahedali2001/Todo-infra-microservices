output "vnet_ids" {
  description = "IDs of the created Virtual Networks"
  value       = { for k, v in azurerm_virtual_network.vnet : k => v.id }
}

output "vnet_locations" {
  description = "Locations of the created Virtual Networks"
  value       = { for k, v in azurerm_virtual_network.vnet : k => v.location }
}
output "vnet_subnets" {
  description = "Map of subnet names to IDs"
  value       = { for s, subnet in azurerm_subnet.subnets : s => subnet.id }
}
