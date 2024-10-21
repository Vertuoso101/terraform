resource "azurerm_virtual_network" "test_virtual_network" {
  for_each = {for vnet in var.vnets : vnet.name => vnet}
  name                = each.value.name
  address_space       = each.value.vnet_range
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "test_subnet" {
  for_each = {for sub in var.subnets : sub.name => sub}
  name                 = each.value.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.test_virtual_network[each.value.vnet].name
  address_prefixes     = each.value.subnet_range
}

