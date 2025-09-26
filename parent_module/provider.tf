terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "RG_terraform_hitesh_init"
    storage_account_name = "hiteshstginit"
    container_name       = "hiteshinitcontainer"
    key                  = "terraform.tfstate"
  }

}



provider "azurerm" {
  features {}
  subscription_id = "bfa25a35-e77a-47a6-8d20-5557ab211ef7"
}