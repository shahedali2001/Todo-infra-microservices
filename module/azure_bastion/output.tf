output "bastion_ids" {
  description = "List of all Bastion Host IDs"
  value       = [for b in azurerm_bastion_host.bastion : b.id]
}

output "bastion_map" {
  description = "Map of Bastion Host IDs keyed by name"
  value       = { for k, b in azurerm_bastion_host.bastion : k => b.id }
}
