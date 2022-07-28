terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
}

resource "azurecaf_name" "naming" {
    name            = lower("${var.short_loc}-demogroup")
    resource_types  = ["azurerm_resource_group",
                       "azurerm_virtual_network",
                       "azurerm_subnet",
                       "azurerm_key_vault",
                       "azurerm_public_ip",
                       "azurerm_route_table",
                       "azurerm_network_interface",
                       "azurerm_storage_account",
                       "azurerm_network_security_group",
                       "azurerm_network_security_group_rule",
                       "azurerm_linux_virtual_machine"]
    suffixes        = ["001"]
    clean_input     = true
    use_slug        = true
}