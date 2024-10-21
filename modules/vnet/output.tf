
output "subnet_ids" {
  value = merge(
    { for vm in var.linux_vms : vm.subnet => azurerm_subnet.test_subnet[vm.subnet].id },
    { for vm in var.windows_vms : vm.subnet => azurerm_subnet.test_subnet[vm.subnet].id }
  )
}