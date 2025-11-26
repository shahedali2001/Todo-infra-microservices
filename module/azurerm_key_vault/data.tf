data "azurerm_resource_group" "rg" {
  for_each = var.key_vaults
  name     = each.value.resource_group_name
}
data "azurerm_client_config" "current" {}
