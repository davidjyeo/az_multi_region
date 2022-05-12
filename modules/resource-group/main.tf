terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
  features {}
  alias = "uksouth"
}

provider "azurerm" {
  features {}
  alias = "ukwest"
}

resource "azurerm_resource_group" "rg" {
  name     = var.name
  location = var.location

  lifecycle {
    create_before_destroy = true
  }
}
