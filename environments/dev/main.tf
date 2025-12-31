module "res" {
  source = "../../azurerm_resource_group"
  rg_name = "argres"
  rg_location = "Central India"
}

module "stg" {
  depends_on = [ module.res ]
  source = "../../azurerm_storage_account"
  stg_name = "argstgresstorg"
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

module "mysubnet" {
  depends_on = [ module.vnet ]
  source = "../../azurerm_subnet"
  snd_name = "snd"
  sub_name = "todosub"
  rg_name = "argres"
  vnet_name = "vnetabhi"
}

module "mynic" {
  depends_on = [ module.mysubnet ]
  source = "../../azurerm_network_interface"
  nic_name = "todonic"
  nic_location = "Central India"
  nic_rg_name = "argres"
  sub_name = "todosub"
  vnet_name = "vnetabhi"
  rg_name = "argres"
}

module "pip" {
  depends_on = [ module.mysubnet ]
  source = "../../azurerm_public_ip"
  pip_name = "pip_abhi"
  pip_rgname = "argres"
  pip_location = "Central India"
  pip_allmet = "Static"
}

module "lvm" {
  depends_on = [ module.mysubnet, module.mynic]
  source = "../../azurerm_virtual_machine"
  vm_name = "todovm"
  vm_location = "Central India"
  vm_rgname = "argres"
  nic_name = "todonic"
  # Error is here.
  vm_size = "Standard_D2s_v3"
  image_publisher = "Canonical"
  image_offer = "0001-com-ubuntu-server-jammy"
  image_sku = "22_04-lts"
  image_version = "latest"
}