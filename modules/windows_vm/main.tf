data "azurerm_key_vault" "keyvault" {
  name                = "zaidSecs"
  resource_group_name = "test"
}

data "azurerm_key_vault_secret" "adminUser" {
  name         = "adminUser"
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "adminPassword" {
  name         = "adminPassword"
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

resource "azurerm_network_interface" "windows_nic" {
  for_each = {for vm in var.windows_vms : vm.name => vm}
  name                = "${each.value.name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name


  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id[each.value.name]
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id         = azurerm_public_ip.windows_pip[each.key].id
  }
}

resource "azurerm_public_ip" "windows_pip" {
  for_each = { for vm in var.windows_vms : vm.name => vm }

  name                = "${each.key}-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
}

resource "azurerm_network_security_group" "windows_nsg" {
  for_each = {for vm in var.windows_vms : vm.name => vm}
  name                = "${each.key}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "allow_rdp"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389" 
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

resource "azurerm_network_interface_security_group_association" "windows_nic_pip_association" {
  for_each = {for vm in var.windows_vms : vm.name => vm}

  network_interface_id      = azurerm_network_interface.windows_nic[each.key].id
  network_security_group_id  = azurerm_network_security_group.windows_nsg[each.key].id
}

resource "azurerm_windows_virtual_machine" "vm_windows" {
  for_each = {for vm in var.windows_vms : vm.name => vm} 
  name                  = each.value.name
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = each.value.size
  admin_username        = data.azurerm_key_vault_secret.adminUser.value
  admin_password        = data.azurerm_key_vault_secret.adminPassword.value
  network_interface_ids = [azurerm_network_interface.windows_nic[each.key].id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  tags = {
    environment = each.value.environment
  }
}
