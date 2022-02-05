provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "wsb_zal_01"
  location = "eastus"
  tags = {
    environment = "test"
    source      = "Terraform"
  }

}

resource "azurerm_virtual_network" "vn" {
  name                = "wsb-zal-network"
  address_space       = ["10.0.0.0/22"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vn.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "public_ip" {
  name                = "wsb-zal-public-ip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "ni" {
  name                = "wsb-nic"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"

    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
}

resource "tls_private_key" "example_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

output "tls_private_key" {
  value     = tls_private_key.example_ssh.private_key_pem
  sensitive = true
}

output "ip_addr" {
    value = azurerm_public_ip.public_ip.ip_address
    description = "Adres ip Maszyny"
  }

resource "azurerm_linux_virtual_machine" "vm" {
  name                  = "myVM"
  location              = "eastus"
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.ni.id]
  size                  = "Standard_B1ls"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = "vm"
  admin_username                  = "testuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "testuser"
    public_key = tls_private_key.example_ssh.public_key_openssh
  }

  tags = {
    environment = "test"
  }
}