module "resource-group-ukw" {
  source = "./modules/resource-group"
  # providers = {
  #   azurerm = azurerm.ukwest
  # }
  name     = "${var.ukw_prefix}-${var.resource_group_name}-rg"
  location = var.ukwloc
}

module "virtual-network-ukw" {
  source = "./modules/virtual-network"
  # providers = {
  #   azurerm = azurerm.ukwest
  # }
  virtual_network_name          = "${var.uks_prefix}-${var.virtual_network_name}-vnet"
  resource_group_name           = module.resource-group-ukw.rg_name
  location                      = var.ukwloc
  virtual_network_address_space = [var.ukw_vnet_cidr]
  subnet_name                   = "${var.uks_prefix}-${var.virtual_network_name}-snet"
  subnet_address_prefix         = cidrsubnet(var.ukw_vnet_cidr, 8, 0)
  depends_on                    = [module.resource-group-ukw]
}

module "network-interface-ukw" {
  source = "./modules/network-interface"
  # providers = {
  #   azurerm = azurerm.ukwest
  # }
  count               = var.vm_count
  vmname              = format("${var.ukw_prefix}${var.vmname}%02d", count.index + 1)
  location            = var.ukwloc
  resource_group_name = module.resource-group-ukw.rg_name
  subnet_id           = module.virtual-network-ukw.subnet_id
}

# module "virtual-machine" {
#   source                = "./modules/virtual-machine"
#   vmname                = var.vmname
#   location              = var.location
#   resource_group_name   = var.resource_group_name
#   network_interface_ids = [module.network-interface.nic_id]
#   vm_size               = var.vm_size
#   os_disk_type          = var.os_disk_type
#   admin_usename         = var.admin_usename
#   admin_password        = var.admin_password
#   image_publisher       = var.image_publisher
#   image_offer           = var.image_offer
#   image_sku             = var.image_sku
# }

# # module "virtual-machine-extensions" {
# #   source             = "./modules/virtual-machine-extension"
# #   virtual_machine_id = module.virtual-machine.vm_id
# # }