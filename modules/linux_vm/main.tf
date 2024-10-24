resource "azurerm_network_interface" "nic" {
  for_each = { for vm in var.linux_vms : vm.name => vm }
  name                = "${each.value.name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id[each.value.name]
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id         = azurerm_public_ip.linux_pip[each.key].id
  }
}

resource "azurerm_public_ip" "linux_pip" {
  for_each = { for vm in var.linux_vms : vm.name => vm }

  name                = "${each.key}-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
}

resource "azurerm_network_security_group" "linux_nsg" {
  for_each = {for vm in var.linux_vms : vm.name => vm}
  name                = "${each.key}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "allow_ssh"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  
  security_rule {
    name                       = "allow-jenkins"
    priority                   = 400
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "linux_nic_pip_association" {
  for_each = {for vm in var.linux_vms : vm.name => vm}

  network_interface_id      = azurerm_network_interface.nic[each.key].id
  network_security_group_id  = azurerm_network_security_group.linux_nsg[each.key].id
}

resource "tls_private_key" "ssh_key" {
  for_each = { for vm in var.linux_vms : vm.name => vm }
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "ssh_private_key" {
  for_each = { for vm in var.linux_vms : vm.name => vm }

  content  = tls_private_key.ssh_key[each.key].private_key_pem
  filename = "${path.module}/${each.key}_private_key.pem"
}

resource "azurerm_linux_virtual_machine" "vm_linux" {
  for_each = { for vm in var.linux_vms : vm.name => vm }

  name                = each.value.name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = each.value.size
  admin_username      = each.value.admin_user
  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id,
  ]

  admin_ssh_key {
    username   = each.value.admin_user
    public_key = tls_private_key.ssh_key[each.key].public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = {
    environment = each.value.environment
  }
}

