resource "azurerm_network_interface" "nic" {
  name                = var.nic_name
  location            = var.nic_location
  resource_group_name = var.nic_rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.mysubnet_id.id
    private_ip_address_allocation = "Dynamic"
  }
}

data "azurerm_subnet" "mysubnet_id" {
  name                 = var.sub_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.rg_name
}