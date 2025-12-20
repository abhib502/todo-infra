module "res" {
  source = "../../azurerm_resource_group"
  rg_name = "argres"
  rg_location = "Central India"
}

module "stg" {
  depends_on = [ module.res ]
  source = "../../azurerm_storage_account"
  stg_name = "argstg"
  rg_name = "argres"
  stg_location = "Central India"
  act = "Standard"
  art = "LRS"
}

module "vnet" {
  depends_on = [ module.res ]
  source = "../../azurerm_virtual_network"
  vnet_name = "vnetabhi"
  vnet_location = "Central India"
  rg_name = "argres"
  vnet_addspace = ["10.0.0.0/16"]
}

module "pip" {
  depends_on = [ module.res ]
  source = "../../azurerm_public_ip"
  pip_name = "pip_abhi"
  pip_rgname = "argres"
  pip_location = "South India"
  pip_allmet = "Static"
}

# module "lvm" {
#   source = "../../azurerm_virtual_machine"
#   nic_name = ""
#   nic_location = ""
#   nic_rg_name = ""
#   vm_name = ""
#   vm_location = ""
#   vm_rgname = ""
#   vm_size = ""
#   image_publisher = ""
#   image_offer = ""
#   image_sku = ""
#   image_version = ""
# }