resource "azurerm_linux_virtual_machine" "vm_linux" {
  name = var.vm_name
  resource_group_name = var.vm_rgname
  location = var.vm_location
  size = var.vm_size
  admin_username = "todoappadmin"
  admin_password = "admin@todoapp1"
  disable_password_authentication = false
  network_interface_ids = [ 
    data.azurerm_network_interface.nicid.id ]

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

data "azurerm_network_interface" "nicid" {
  name                = var.nic_name
  resource_group_name = var.vm_rgname
}