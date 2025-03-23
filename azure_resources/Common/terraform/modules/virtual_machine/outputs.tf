output "vm_id" {
  value = coalesce(
    var.operating_system == "RedHat" ? azurerm_linux_virtual_machine.vm[0].id : null,
    var.operating_system == "Windows" ? azurerm_windows_virtual_machine.vm[0].id : null
  )
}
