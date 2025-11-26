variable "mssql_servers" {
  description = "Configuration for SQL Servers"
  type = map(object({
    name                         = string
    resource_group_name          = string
    location                     = string
    version                      = string
    administrator_login          = string
    administrator_login_password = string
    tags                         = map(string)
  }))
}

variable "mssql_databases" {
  description = "Configuration for SQL Databases"
  type = map(object({
    name             = string
    server_key       = string   # Reference key to link with the corresponding server in mssql_servers
    collation        = string
    license_type     = string
    max_size_gb      = number
    sku_name         = string
    enclave_type     = string
    prevent_destroy  = bool
    tags             = map(string)
  }))
}
