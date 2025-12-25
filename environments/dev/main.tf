module "res" {
  source = "../../azurerm_resource_group"
  rg_name = "argres"
  rg_location = "East US"
}

module "stg" {
  depends_on = [ module.res ]
  source = "../../azurerm_storage_account"
  stg_name = "argstgrestorg"
  rg_name = "argres"
  stg_location = "East US"
  act = "Standard"
  art = "LRS"
}

module "vnet" {
  depends_on = [ module.res ]
  source = "../../azurerm_virtual_network"
  vnet_name = "vnetabhi"
  vnet_location = "East US"
  rg_name = "argres"
  vnet_addspace = ["10.0.0.0/16"]
}

module "mysubnet" {
  depends_on = [ module.vnet ]
  source = "../../azurerm_subnet"
  sub_name = "todosub"
  rg_name = "argres"
  vnet_name = "vnetabhi"
}

# module "pip" {
#   depends_on = [ module.res ]
#   source = "../../azurerm_public_ip"
#   pip_name = "pip_abhi"
#   pip_rgname = "argres"
#   pip_location = "South India"
#   pip_allmet = "Static"
# }

module "lvm" {
  depends_on = [ module.vnet ]
  source = "../../azurerm_virtual_machine"
  nic_name = "todonic"
  nic_location = "East US"
  nic_rg_name = "argres"
  pip_name = "pip_abhi"
  pip_rgname = "argres"
  pip_location = "East US"
  pip_allmet = "Static"
  vm_name = "todovm"
  vm_location = "East US"
  vm_rgname = "argres"
  # Error is here.
  vm_size = "Standard_F2"
  image_publisher = "Canonical"
  image_offer = "0001-com-ubuntu-server-jammy"
  image_sku = "22_04-lts"
  image_version = "latest"
}