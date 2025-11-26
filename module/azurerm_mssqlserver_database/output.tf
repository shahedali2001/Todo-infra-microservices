output "database_ids" {
  value = { for k, v in azurerm_mssql_database.mssqldb : k => v.id }
}
output "server_ids" {
  value = { for k, v in azurerm_mssql_server.mssqlserver : k => v.id }
}


