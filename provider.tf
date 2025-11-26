terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.50.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
  subscription_id = "2c6da294-c904-4801-bffd-cd7f0b236e3d"
}