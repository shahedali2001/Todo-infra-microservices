resource "azurerm_mssql_server" "mssqlserver" {
  for_each = var.mssql_servers

  name                         = each.value.name
  resource_group_name          = each.value.resource_group_name
  location                     = each.value.location
  version                      = each.value.version
  administrator_login          = each.value.administrator_login
  administrator_login_password = each.value.administrator_login_password

  tags = each.value.tags
}

resource "azurerm_mssql_database" "mssqldb" {
  for_each = var.mssql_databases

  name         = each.value.name
  server_id    = azurerm_mssql_server.mssqlserver[each.value.server_key].id
  collation    = each.value.collation
  license_type = each.value.license_type
  max_size_gb  = each.value.max_size_gb
  sku_name     = each.value.sku_name
  enclave_type = each.value.enclave_type

  tags = each.value.tags

  lifecycle {
    # prevent_destroy = each.value.prevent_destroy
  }
}

