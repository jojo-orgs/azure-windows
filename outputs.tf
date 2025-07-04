output "vm_name" {
  value       = [for vm in azurerm_windows_virtual_machine.main : vm.name]
  description = "The name of the Windows virtual machine."
}

output "vm_id" {
  value       = [for vm in azurerm_windows_virtual_machine.main : vm.id]
  description = "The ID of the Windows virtual machine."
}

output "vm_public_ip" {
  value       = [for vm in azurerm_windows_virtual_machine.main : vm.public_ip_address]
  description = "The public IP address of the Windows virtual machine."
}

output "admin_username" {
  value       = [for vm in azurerm_windows_virtual_machine.main : vm.admin_username]
  description = "The administrator username for the Windows virtual machine."
}

output "admin_password" {
  value       = [for vm in azurerm_windows_virtual_machine.main : vm.admin_password]
  description = "The administrator password for the Windows virtual machine."
  sensitive   = true
}
