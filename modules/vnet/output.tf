
output "subnet_ids" {
  value = merge(
    { for vm in var.linux_vms : vm.name => azurerm_subnet.test_subnet[vm.subnet].id },
    { for vm in var.windows_vms : vm.name => azurerm_subnet.test_subnet[vm.subnet].id }
  )
}