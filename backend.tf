terraform {
  backend "azurerm" {
    storage_account_name = "shahedstg881"
    container_name       = "tfscontainer"
    key                  = "dev.terraform.tfstate"
    resource_group_name  = "shahed-dev-01"
    subscription_id      = "2c6da294-c904-4801-bffd-cd7f0b236e3d"
    use_azuread_auth     = true
  }
}
