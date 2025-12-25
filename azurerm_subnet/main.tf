resource "azurerm_subnet" "mysubnet" {
  name = var.sub_name
  resource_group_name = var.rg_name
  virtual_network_name = var.vnet_name
  address_prefixes = ["10.0.0.0/24"]
}