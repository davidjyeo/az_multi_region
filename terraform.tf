terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      configuration_aliases = [azurerm.uksouth, azurerm.ukwest]
    }
  }
}

provider "azurerm" {
  features {}
  # alias = "uksouth"
}

# provider "azurerm" {
#   features {}
#   alias = "ukwest"
# }

data "azurerm_client_config" "current" {}
data "azurerm_subscription" "current" {}

# locals{
#   prod = "${var.environment == "PROD" ? "east" : ""}"
#   prod2 = "${var.environment == "PROD2" ? "west2" : ""}"
#   nonprod = "${var.environment != "PROD" && var.environment != "PROD2" ? "west" : ""}"
#   region = "${coalesce(local.prod,local.prod2, local.nonprod)}"
# }