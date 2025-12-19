resource "azurerm_network_interface" "nic" {
  name                = var.nic_name
  location            = var.nic_location
  resource_group_name = var.nic_rg_name

  ip_configuration {
    public_ip_address_id          = data.azurerm_public_ip.kuch_bhi_ip.id
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.frontend_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm_linux" {
  name = var.vm_name
  resource_group_name = var.vm_rgname
  location = var.vm_location
  size = var.vm_size
  admin_username = ""
  admin_password = ""
  disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.nic.id]

os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
}

source_image_reference {
    publisher = var.image_publisher 
    offer     = var.image_offer     
    sku       = var.image_sku       
    version   = var.image_version   
}
}