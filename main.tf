locals {
  common_tags = {
    Project     = "todo-infra-microservices"
    ManagedBy   = "terraform"
    Environment = "production"
  }
}

module "azurerm_resource_group" {
  source  = "./module/azurerm_resource_group"
  rg_name = var.rg_name
}
module "azurerm_aks_cluster" {
  source      = "./module/azurerm_aks_cluster"
  aks_cluster = var.aks_cluster
  depends_on  = [module.azurerm_resource_group]

}
module "azurerm_container_registry" {
  source         = "./module/azurerm_acr"
  acr_registries = var.acr_registries
  depends_on     = [module.azurerm_resource_group]

}
module "azurerm_key_vault" {
  source     = "./module/azurerm_key_vault"
  key_vaults = var.key_vaults
  depends_on = [module.azurerm_resource_group]

}
module "azurerm_bastion" {
  source        = "./module/azure_bastion"
  bastion_hosts = var.bastion_hosts
  public_ip_ids = module.azurerm_public_ip.public_ip_ids
  depends_on    = [module.azurerm_resource_group, module.azurerm_public_ip]

}
module "azurerm_mssql_database" {
  source          = "./module/azurerm_mssqlserver_database"
  mssql_servers   = var.mssql_servers
  mssql_databases = var.mssql_databases
  depends_on      = [module.azurerm_resource_group]

}
module "azurerm_virtual_Network" {
  source     = "./module/azurerm_virtual_Network"
  vnets      = var.vnets
  depends_on = [module.azurerm_resource_group]

}

module "application_gateway" {
  source               = "./module/azurem_application_gateway"
  application_gateways = var.application_gateways
  public_ip_ids        = module.azurerm_public_ip.public_ip_ids
  depends_on           = [module.azurerm_public_ip, module.azurerm_virtual_Network]
}
module "azurerm_public_ip" {
  source = "./module/azurerm_public_ip"
  pips   = var.pips
  depends_on = [ module.azurerm_resource_group ]
}
