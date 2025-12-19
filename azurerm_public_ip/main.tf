resource "azurerm_public_ip" "pip" {
  name                = var.pip_name
  resource_group_name = var.pip_rgname
  location            = var.pip_location
  allocation_method   = var.pip_allmet
  sku                 = "Standard"
}