output "ssh_public_keys" {
  value = { for vm in var.linux_vms : vm.name => tls_private_key.ssh_key[vm.name].public_key_openssh }
}