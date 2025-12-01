output "public_ip_ids" {
  value = { for k, pip in azurerm_public_ip.publicip : k => pip.id }
}

