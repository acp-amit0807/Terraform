terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.57.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.3"
    }
  }
  backend "azurerm" {
    resource_group_name = "rg-learningTerraform-dev" 
    storage_account_name = "stgnjunl0zsh" # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "tfstate"      # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "observablity-dev"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

