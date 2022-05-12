# outputs.tf file of virtual-machine module
output "rg_name" {
  description = "id of the fileshare"
  value       = azurerm_resource_group.rg.name
}