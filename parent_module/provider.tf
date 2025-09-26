terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.0"
    }
  }
}



provider "azurerm" {
  features {}
  subscription_id = "bfa25a35-e77a-47a6-8d20-5557ab211ef7"
}