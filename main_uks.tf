######

module "resource-group-uks" {
  source   = "./modules/resource-group"
  name     = "${var.uks_prefix}-${var.resource_group_name}-rg"
  location = var.uksloc
}

module "virtual-network-uks" {
  source                        = "./modules/virtual-network"
  virtual_network_name          = "${var.uks_prefix}-${var.virtual_network_name}-vnet"
  resource_group_name           = module.resource-group-uks.rg_name
  location                      = var.uksloc
  virtual_network_address_space = [var.uks_vnet_cidr]
  subnet_name                   = "${var.uks_prefix}-${var.virtual_network_name}-snet"
  subnet_address_prefix         = cidrsubnet(var.uks_vnet_cidr, 8, 0)
  depends_on                    = [module.resource-group-uks]
}

module "network-interface-uks" {
  source = "./modules/network-interface"
  # providers = {
  #   azurerm = azurerm.uksouth
  # }
  count               = var.vm_count
  vmname              = format("${var.ukw_prefix}${var.vmname}%02d", count.index + 1)
  location            = var.uksloc
  resource_group_name = module.resource-group-uks.rg_name
  subnet_id           = module.virtual-network-uks.subnet_id
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