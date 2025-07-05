output "vm_name" {
  value       = azurerm_windows_virtual_machine.main.name
  description = "The name of the Windows virtual machine."
}

output "vm_id" {
  value       = azurerm_windows_virtual_machine.main.id
  description = "The ID of the Windows virtual machine."
}

output "vm_public_ip" {
  value       = azurerm_windows_virtual_machine.main.public_ip_address
  description = "The public IP address of the Windows virtual machine."
}

output "admin_username" {
  value       = azurerm_windows_virtual_machine.main.admin_username
  description = "The administrator username for the Windows virtual machine."
}

output "admin_password" {
  value       = azurerm_windows_virtual_machine.main.admin_password
  description = "The administrator password for the Windows virtual machine."
  sensitive   = true
}
